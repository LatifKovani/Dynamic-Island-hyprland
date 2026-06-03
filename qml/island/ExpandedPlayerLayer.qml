import QtQuick
import IslandBackend
import Quickshell.Services.Mpris
import Qt5Compat.GraphicalEffects

Item {
    id: root

    signal controlPressed

    readonly property var userConfig: UserConfig

    property bool showCondition: false
    property string currentArtUrl: ""
    property string currentTrack: ""
    property string currentArtist: ""
    property string timePlayed: "0:00"
    property string timeTotal: "0:00"
    property real trackProgress: 0
    property var activePlayer: null
    property string iconFontFamily: userConfig.iconFontFamily
    property string textFontFamily: userConfig.textFontFamily
    property real visualizerPhase: 0

    readonly property var _now: new Date()
    readonly property int _todayDay: _now.getDate()
    readonly property int _todayMonth: _now.getMonth()
    readonly property int _todayYear: _now.getFullYear()
    readonly property int _todayDow: _now.getDay()
    readonly property var _shortMonths: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    readonly property var _fullDays: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    readonly property bool isPlaying: activePlayer && activePlayer.playbackState === MprisPlaybackState.Playing

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

    // Format microseconds → "m:ss"  (MPRIS2 uses µs natively)
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

    Row {
        anchors.fill: parent
        spacing: 10

        // ── Album art ────────────────────────────────────────────────
        Item {
            id: artWrapper
            width: 96
            height: 96
            anchors.verticalCenter: parent.verticalCenter

            Rectangle {
                id: artSource
                anchors.fill: parent
                color: "#2c2c2e"
                visible: false
                layer.enabled: true
                layer.smooth: true

                Image {
                    anchors.fill: parent
                    source: currentArtUrl
                    fillMode: Image.PreserveAspectCrop
                    visible: source.toString() !== ""
                    sourceSize: Qt.size(192, 192)
                    smooth: true
                    mipmap: true
                }
                Text {
                    anchors.centerIn: parent
                    visible: currentArtUrl === ""
                    text: "\uf001"
                    font.family: iconFontFamily
                    font.pixelSize: 24
                    color: Qt.rgba(1, 1, 1, 0.2)
                }
            }
            Rectangle {
                id: artMask
                anchors.fill: parent
                radius: 30
                color: "white"
                visible: false
                layer.enabled: true
            }
            OpacityMask {
                anchors.fill: parent
                source: artSource
                maskSource: artMask
            }
        }

        // ── Track info + progress + controls ────────────────────────
        Column {
            width: 210
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8

            // Track name + visualizer
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
                property real dragProgress: 0
                // During scrub show drag position, otherwise real playback position
                readonly property real displayProgress: isDragging ? dragProgress : trackProgress

                Text {
                    id: tL
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    // Show drag-target time while scrubbing
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
                    anchors.right: tR.left
                    anchors.leftMargin: 5
                    anchors.rightMargin: 5
                    // Grows slightly on hover or while dragging
                    height: seekMouseArea.containsMouse || progressBarItem.isDragging ? 6 : 4
                    radius: height / 2
                    color: Qt.rgba(1, 1, 1, 0.12)
                    Behavior on height {
                        NumberAnimation {
                            duration: 120
                            easing.type: Easing.OutCubic
                        }
                    }

                    // Filled portion
                    Rectangle {
                        height: parent.height
                        radius: parent.radius
                        color: "white"
                        width: parent.width * progressBarItem.displayProgress
                        // Disable smooth animation while dragging for instant response
                        Behavior on width {
                            enabled: !progressBarItem.isDragging
                            NumberAnimation {
                                duration: 500
                                easing.type: Easing.OutCubic
                            }
                        }
                    }

                    // Seek knob — appears on hover and while dragging
                    Rectangle {
                        id: seekKnob
                        width: 10
                        height: 10
                        radius: 5
                        color: "white"
                        anchors.verticalCenter: parent.verticalCenter
                        visible: seekMouseArea.containsMouse || progressBarItem.isDragging
                        // Clamped so the knob never overflows the track ends
                        x: Math.max(0, Math.min(parent.width - width, parent.width * progressBarItem.displayProgress - width / 2))
                        Behavior on x {
                            enabled: !progressBarItem.isDragging
                            NumberAnimation {
                                duration: 500
                                easing.type: Easing.OutCubic
                            }
                        }
                        layer.enabled: true
                        layer.effect: DropShadow {
                            radius: 4
                            samples: 9
                            color: Qt.rgba(0, 0, 0, 0.45)
                            horizontalOffset: 0
                            verticalOffset: 1
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

                // Transparent overlay covering the full 160×20 item so the user
                // doesn't have to click precisely on the thin 4px track line.
                MouseArea {
                    id: seekMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    preventStealing: true
                    cursorShape: Qt.PointingHandCursor

                    // Convert mouse-X (progressBarItem coords) to a [0,1] fraction
                    function fraction(mx) {
                        return Math.max(0, Math.min(1, (mx - progressTrack.x) / progressTrack.width));
                    }

                    onPressed: m => {
                        progressBarItem.isDragging = true;
                        progressBarItem.dragProgress = fraction(m.x);
                        root.controlPressed(); // suppress capsule-level click handler
                    }

                    onPositionChanged: m => {
                        if (pressed)
                            progressBarItem.dragProgress = fraction(m.x);
                    }

                    onReleased: m => {
                        if (activePlayer && activePlayer.canSeek && activePlayer.length > 0) {
                            // MPRIS2 Seek() takes a signed delta in microseconds.
                            const targetUs = Math.round(progressBarItem.dragProgress * activePlayer.length);
                            activePlayer.seek(targetUs - activePlayer.position);
                        }
                        progressBarItem.isDragging = false;
                    }

                    onCanceled: {
                        progressBarItem.isDragging = false;
                    }
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
                            height: 22
                            Text {
                                anchors.centerIn: parent
                                text: modelData.dayNum
                                color: modelData.isToday ? "#1c62f5" : modelData.isPast ? Qt.rgba(1, 1, 1, 0.22) : Qt.rgba(1, 1, 1, 0.75)
                                font.pixelSize: 13
                                font.family: textFontFamily
                                font.weight: modelData.isToday ? Font.Bold : Font.Regular
                            }
                        }
                    }
                }
            }
        }
    }
}
