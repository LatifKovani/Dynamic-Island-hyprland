//-- TODO: When i stop a music from spotify Album art should show spotify icon not chrome.
import QtQuick
import Quickshell.Widgets
import IslandBackend
import Quickshell.Services.Mpris

Item {
    id: root

    signal controlPressed

    readonly property var userConfig: UserConfig

    property bool showCondition: false
    property string currentArtUrl: ""
    property string preloadedArtSource: ""
    property string currentTrack: ""
    property string currentArtist: ""
    property string timePlayed: "0:00"
    property string timeTotal: "0:00"
    property real trackProgress: 0
    property var activePlayer: null
    property string iconFontFamily: userConfig.iconFontFamily
    property string textFontFamily: userConfig.textFontFamily
    property real visualizerPhase: 0

    // ── Retry state ──
    property int artRetryCount: 0
    property int artMaxRetries: 10

    // ── Crossfade state ──
    // _displayedSource: what's actually painted on screen right now (never set to "" mid-session)
    // _loadingSource:   the URL currently being fetched into artLoader
    property string _displayedSource: ""
    property string _loadingSource: ""

    readonly property var _now: new Date()
    readonly property int _todayDay: _now.getDate()
    readonly property int _todayMonth: _now.getMonth()
    readonly property int _todayYear: _now.getFullYear()
    readonly property int _todayDow: _now.getDay()
    readonly property var _shortMonths: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    readonly property var _fullDays: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    readonly property bool isPlaying: activePlayer && activePlayer.playbackState === MprisPlaybackState.Playing

    // ── Start loading a new URL (silently, into artLoader) ──
    function loadArt(url) {
        if (url === "" || url === _loadingSource || url === _displayedSource)
            return;
        artRetryCount = 0;
        artRetryTimer.stop();
        _loadingSource = url;
    }

    // ── Called when artLoader finishes — swap displayed source ──
    function _commitArt() {
        var wasEmpty = (_displayedSource === "");

        if (wasEmpty) {
            _displayedSource = _loadingSource;
            if (showCondition)
                artEntranceAnim.restart();
            // else: will fire when showCondition becomes true
        } else {
            // Track change — flip animation. Don't swap _displayedSource yet;
            // artFlipAnim swaps it at the midpoint while the card is edge-on.
            _pendingArtSource = _loadingSource;
            artFlipAnim.restart();
        }
    }

    onCurrentArtUrlChanged: {
        artRetryCount = 0;
        artRetryTimer.stop();
        if (currentArtUrl !== "")
            loadArt(currentArtUrl);
        // If URL cleared (player stopped), leave _displayedSource as-is
        // so we don't flash gray — keeps last art showing
    }

    onShowConditionChanged: {
        if (showCondition) {
            if (_displayedSource !== "") {
                // Art already ready — animate in
                artEntranceAnim.restart();
            } else if (currentArtUrl !== "") {
                // Art not yet loaded — kick off load, entrance fires in _commitArt
                loadArt(currentArtUrl);
            }
            // If no art at all yet, artWrapper stays hidden (opacity 0) — no gray flash
        }
    }

    Timer {
        id: artRetryTimer
        repeat: true
        interval: Math.min(1000 * Math.pow(1.5, artRetryCount), 8000)
        onTriggered: {
            if (currentArtUrl !== "" && _displayedSource !== currentArtUrl && artRetryCount < artMaxRetries) {
                artRetryCount++;
                _loadingSource = "";
                _loadingSource = currentArtUrl;
            } else {
                artRetryTimer.stop();
            }
        }
    }

    // ── Entrance: spring pop when art becomes visible for the first time ──
    ParallelAnimation {
        id: artEntranceAnim
        NumberAnimation {
            target: artWrapper
            property: "scale"
            from: 0.82
            to: 1.0
            duration: 380
            easing.type: Easing.OutBack
            easing.overshoot: 0.6
        }
        NumberAnimation {
            target: artWrapper
            property: "opacity"
            from: 0.0
            to: 1.0
            duration: 260
            easing.type: Easing.OutCubic
        }
    }

    // ── Track change: Y-axis card flip ──
    // Phase 1: rotate 0→90  (flip out, card goes edge-on and invisible)
    // Midpoint: swap _displayedSource while the card is edge-on (artSingle's
    // source binding picks this up automatically — no direct id reference needed)
    // Phase 2: rotate -90→0 (flip in, new art comes in from the other side)
    property real _flipAngle: 0.0
    property string _pendingArtSource: ""

    SequentialAnimation {
        id: artFlipAnim

        NumberAnimation {
            target: root
            property: "_flipAngle"
            from: 0.0
            to: 90.0
            duration: 160
            easing.type: Easing.InCubic
        }
        ScriptAction {
            script: {
                root._displayedSource = root._pendingArtSource;
                root._flipAngle = -90.0;
            }
        }
        NumberAnimation {
            target: root
            property: "_flipAngle"
            from: -90.0
            to: 0.0
            duration: 160
            easing.type: Easing.OutCubic
        }
    }

    function buildWeekRow() {
        const days = [];
        const startOffset = _todayDow;
        for (let i = 0; i < 7; i++) {
            const d = new Date(_todayYear, _todayMonth, _todayDay - startOffset + i);
            const isToday = d.getDate() === _todayDay && d.getMonth() === _todayMonth;
            const isPast = d < new Date(_todayYear, _todayMonth, _todayDay);
            const dow = d.getDay();
            days.push({
                dayNum: d.getDate(),
                dayLabel: isToday ? _fullDays[dow] : _fullDays[dow].charAt(0),
                isToday: isToday,
                isPast: isPast
            });
        }
        return days;
    }

    function visualizerLevel(index) {
        const phase = visualizerPhase + index * 0.78;
        return 0.22 + ((Math.sin(phase) + 1) * 0.5) * 0.42 + ((Math.sin(phase * 2 + index * 0.95) + 1) * 0.5) * 0.24;
    }

    function pausedVisualizerLevel(index) {
        return [0.34, 0.58, 0.82, 0.58, 0.34][index] || 0.4;
    }

    function formatUs(us) {
        const s = Math.max(0, Math.floor(us / 1000000));
        return Math.floor(s / 60) + ":" + (s % 60 < 10 ? "0" : "") + (s % 60);
    }

    function togglePlayback() {
        if (!activePlayer || !activePlayer.canControl)
            return;
        if (activePlayer.canTogglePlaying) {
            activePlayer.togglePlaying();
            return;
        }
        if (activePlayer.playbackState === MprisPlaybackState.Playing) {
            if (activePlayer.canPause)
                activePlayer.pause();
            return;
        }
        if (activePlayer.canPlay)
            activePlayer.play();
    }

    anchors.fill: parent
    anchors.margins: 12
    opacity: showCondition ? 1 : 0

    Behavior on opacity {
        NumberAnimation {
            duration: showCondition ? 300 : 100
            easing.type: Easing.InOutQuad
        }
    }

    Timer {
        interval: 64
        repeat: true
        running: showCondition && isPlaying
        onTriggered: {
            visualizerPhase += 0.18;
            if (visualizerPhase > Math.PI * 2)
                visualizerPhase -= Math.PI * 2;
        }
    }

    // ── Hidden loader — fetches art without showing gray ──
    // Sits outside the visible tree so ClippingRectangle never renders it
    Image {
        id: artLoader
        visible: false
        width: 0
        height: 0
        source: root._loadingSource
        sourceSize: Qt.size(192, 192)
        cache: false
        asynchronous: true

        onStatusChanged: {
            if (status === Image.Ready) {
                root.artRetryCount = 0;
                artRetryTimer.stop();
                root._commitArt();
            } else if (status === Image.Error) {
                if (root.artRetryCount < root.artMaxRetries && !artRetryTimer.running)
                    artRetryTimer.restart();
            }
        }
    }

    Row {
        anchors.fill: parent
        spacing: 10

        // ── Album art ────────────────────────────────────────────────
        // opacity starts at 0 and only animates in once _displayedSource is set
        // so the gray ClippingRectangle background is NEVER visible
        Item {
            id: artWrapper
            width: 96
            height: 96
            anchors.verticalCenter: parent.verticalCenter
            opacity: 0.0      // controlled entirely by artEntranceAnim
            scale: 1.0
            transformOrigin: Item.Center

            ClippingRectangle {
                id: artCard
                anchors.fill: parent
                radius: 18
                color: "#2c2c2e"

                // Y-axis flip on track change. QtQuick's 3D Rotation transform
                // applies perspective foreshortening automatically.
                transform: Rotation {
                    origin.x: artCard.width / 2
                    origin.y: artCard.height / 2
                    axis {
                        x: 0
                        y: 1
                        z: 0
                    }
                    angle: root._flipAngle
                }

                Image {
                    id: artSingle
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    source: root._displayedSource
                    sourceSize: Qt.size(192, 192)
                    smooth: true
                    mipmap: true
                    cache: false
                }

                // Music note — only when nothing has ever loaded
                Text {
                    anchors.centerIn: parent
                    visible: root._displayedSource === ""
                    text: "\uf001"
                    font.family: iconFontFamily
                    font.pixelSize: 24
                    color: Qt.rgba(1, 1, 1, 0.2)
                }
            }
        }

        // ── Track info + progress + controls ────────────────────────
        Column {
            width: 210
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8

            Row {
                width: parent.width
                spacing: 6

                Column {
                    width: 150
                    spacing: 2
                    Text {
                        text: currentTrack
                        color: "white"
                        font.pixelSize: 17
                        font.family: textFontFamily
                        font.weight: Font.SemiBold
                        font.letterSpacing: -0.3
                        width: parent.width
                        wrapMode: Text.WordWrap
                        maximumLineCount: 2
                    }
                    Text {
                        text: currentArtist
                        color: Qt.rgba(1, 1, 1, 0.45)
                        font.pixelSize: 13
                        font.family: textFontFamily
                        font.weight: Font.Regular
                        width: parent.width
                        elide: Text.ElideRight
                    }
                }

                Row {
                    height: 18
                    spacing: 3
                    anchors.verticalCenter: parent.verticalCenter
                    Repeater {
                        model: 5
                        delegate: Rectangle {
                            width: 3
                            height: isPlaying ? 4 + 14 * visualizerLevel(index) : 4 + 14 * pausedVisualizerLevel(index)
                            radius: 1.5
                            color: isPlaying ? "#b56cff" : "#5f4b72"
                            anchors.verticalCenter: parent.verticalCenter
                            Behavior on height {
                                NumberAnimation {
                                    duration: 120
                                    easing.type: Easing.InOutQuad
                                }
                            }
                            Behavior on color {
                                ColorAnimation {
                                    duration: 140
                                }
                            }
                        }
                    }
                }
            }

            // ── Seekable progress bar ────────────────────────────────
            Item {
                id: progressBarItem
                width: 160
                height: 20

                property bool isDragging: false
                property bool isHovered: false
                property real dragProgress: 0
                readonly property real displayProgress: isDragging ? dragProgress : trackProgress

                MouseArea {
                    id: seekMouseArea
                    anchors.fill: parent
                    z: -1
                    hoverEnabled: true
                    preventStealing: true
                    cursorShape: Qt.PointingHandCursor

                    onContainsMouseChanged: progressBarItem.isHovered = containsMouse

                    function fraction(mx) {
                        return Math.max(0, Math.min(1, (mx - progressTrack.x) / progressTrack.width));
                    }

                    onPressed: m => {
                        progressBarItem.isDragging = true;
                        progressBarItem.dragProgress = fraction(m.x);
                        root.controlPressed();
                    }
                    onPositionChanged: m => {
                        if (pressed)
                            progressBarItem.dragProgress = fraction(m.x);
                    }
                    onReleased: m => {
                        if (activePlayer && activePlayer.canSeek && activePlayer.length > 0) {
                            const targetUs = Math.round(progressBarItem.dragProgress * activePlayer.length);
                            activePlayer.seek(targetUs - activePlayer.position);
                        }
                        progressBarItem.isDragging = false;
                    }
                    onCanceled: {
                        progressBarItem.isDragging = false;
                    }
                }

                Text {
                    id: tL
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    text: progressBarItem.isDragging ? root.formatUs(progressBarItem.dragProgress * (activePlayer ? activePlayer.length : 0)) : timePlayed
                    color: Qt.rgba(1, 1, 1, progressBarItem.isDragging ? 0.75 : 0.4)
                    font.pixelSize: 12
                    font.family: textFontFamily
                    font.weight: Font.Medium
                    Behavior on color {
                        ColorAnimation {
                            duration: 120
                        }
                    }
                }

                Rectangle {
                    id: progressTrack
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: tL.right
                    anchors.leftMargin: 5
                    anchors.right: tR.left
                    anchors.rightMargin: 5
                    height: progressBarItem.isHovered || progressBarItem.isDragging ? 6 : 4
                    radius: height / 2
                    color: Qt.rgba(1, 1, 1, 0.12)
                    Behavior on height {
                        NumberAnimation {
                            duration: 120
                            easing.type: Easing.OutCubic
                        }
                    }

                    Rectangle {
                        height: parent.height
                        radius: parent.radius
                        color: "white"
                        width: parent.width * progressBarItem.displayProgress
                        Behavior on width {
                            enabled: !progressBarItem.isDragging
                            NumberAnimation {
                                duration: 500
                                easing.type: Easing.OutCubic
                            }
                        }
                    }

                    Rectangle {
                        id: seekKnob
                        width: 10
                        height: 10
                        radius: 5
                        color: "white"
                        anchors.verticalCenter: parent.verticalCenter
                        visible: progressBarItem.isHovered || progressBarItem.isDragging
                        x: Math.max(0, Math.min(parent.width - width, parent.width * progressBarItem.displayProgress - width / 2))
                        Behavior on x {
                            enabled: !progressBarItem.isDragging
                            NumberAnimation {
                                duration: 500
                                easing.type: Easing.OutCubic
                            }
                        }
                    }
                }

                Text {
                    id: tR
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    text: timeTotal
                    color: Qt.rgba(1, 1, 1, 0.4)
                    font.pixelSize: 12
                    font.family: textFontFamily
                    font.weight: Font.Medium
                }
            }

            // ── Playback controls ────────────────────────────────────
            Item {
                width: 160
                height: 28

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 24
                    height: 28

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "\u23ee"
                        color: prevTap.pressed ? "#888" : "white"
                        font.pixelSize: 30
                        font.family: textFontFamily
                        scale: prevTap.pressed ? 0.85 : 1.0
                        Behavior on scale {
                            NumberAnimation {
                                duration: 80
                            }
                        }
                        MouseArea {
                            id: prevTap
                            anchors.fill: parent
                            anchors.margins: -8
                            preventStealing: true
                            onPressed: root.controlPressed()
                            onClicked: {
                                if (activePlayer)
                                    activePlayer.previous();
                            }
                        }
                    }

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: isPlaying ? "\u23f8" : "\u25b6"
                        color: playTap.pressed ? "#888" : "white"
                        font.pixelSize: isPlaying ? 22 : 24
                        font.family: textFontFamily
                        scale: playTap.pressed ? 0.85 : 1.0
                        Behavior on scale {
                            NumberAnimation {
                                duration: 80
                            }
                        }
                        MouseArea {
                            id: playTap
                            anchors.fill: parent
                            anchors.margins: -8
                            preventStealing: true
                            onPressed: root.controlPressed()
                            onClicked: togglePlayback()
                        }
                    }

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "\u23ed"
                        color: nextTap.pressed ? "#888" : "white"
                        font.pixelSize: 30
                        font.family: textFontFamily
                        scale: nextTap.pressed ? 0.85 : 1.0
                        Behavior on scale {
                            NumberAnimation {
                                duration: 80
                            }
                        }
                        MouseArea {
                            id: nextTap
                            anchors.fill: parent
                            anchors.margins: -8
                            preventStealing: true
                            onPressed: root.controlPressed()
                            onClicked: {
                                if (activePlayer)
                                    activePlayer.next();
                            }
                        }
                    }
                }
            }
        }

        // ── Calendar ─────────────────────────────────────────────────
        Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 5

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0

                Item {
                    width: 65
                    height: 36
                    Text {
                        anchors.centerIn: parent
                        text: _shortMonths[_todayMonth]
                        color: "white"
                        font.pixelSize: 23
                        font.family: textFontFamily
                        font.weight: Font.Bold
                        font.letterSpacing: -0.3
                    }
                }

                Repeater {
                    model: buildWeekRow()
                    delegate: Item {
                        width: 26
                        height: 36
                        Text {
                            anchors.top: parent.top
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: modelData.dayLabel
                            color: modelData.isToday ? Qt.rgba(1, 1, 1, 0.55) : modelData.isPast ? Qt.rgba(1, 1, 1, 0.15) : Qt.rgba(1, 1, 1, 0.35)
                            font.pixelSize: modelData.isToday ? 10 : 11
                            font.family: textFontFamily
                            font.weight: Font.Medium
                            font.letterSpacing: 0.2
                        }
                        Item {
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: 22
                            height: 28

                            Text {
                                anchors.top: parent.top
                                anchors.topMargin: 2
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: modelData.dayNum
                                color: modelData.isToday ? "#1c62f5" : modelData.isPast ? Qt.rgba(1, 1, 1, 0.22) : Qt.rgba(1, 1, 1, 0.75)
                                font.pixelSize: 13
                                font.family: textFontFamily
                                font.weight: modelData.isToday ? Font.Bold : Font.Regular
                            }

                            Rectangle {
                                visible: modelData.isToday
                                width: 4
                                height: 4
                                radius: 2
                                color: "#1c62f5"
                                anchors.bottom: parent.bottom
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }
                }
            }
        }
    }
}
