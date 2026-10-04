import QtQuick
import Quickshell.Widgets
import Quickshell.Services.Mpris

// Detached music card shown to the left of the main pill (album art, track info, progress, controls).
Item {
    id: root

    property bool showCondition: false
    property var activePlayer: null
    property string artSource: ""
    property string currentTrack: ""
    property string currentArtist: ""
    property string timePlayed: "0:00"
    property string timeTotal: "0:00"
    property real trackProgress: 0
    property var cavaLevels: []
    property string iconFontFamily: ""
    property string textFontFamily: ""
    property bool progressDragging: seekArea.pressed

    readonly property bool isPlaying: activePlayer && activePlayer.playbackState === MprisPlaybackState.Playing
    readonly property string albumText: activePlayer && activePlayer.trackAlbum ? activePlayer.trackAlbum : ""
    readonly property string sourceText: activePlayer && activePlayer.identity ? activePlayer.identity : ""
    property real dragProgress: 0

    function formatSeconds(value) {
        const s = Math.max(0, Math.floor(Number(value) || 0));
        return Math.floor(s / 60) + ":" + (s % 60 < 10 ? "0" : "") + (s % 60);
    }

    // Track length in seconds. Some players (browsers) leave player.length at 0 and only
    // provide it in metadata, in microseconds.
    readonly property real trackLength: {
        const p = activePlayer;
        if (!p)
            return 0;
        const l = Number(p.length) || 0;
        if (l > 0)
            return l;
        const m = p.metadata ? Number(p.metadata["mpris:length"]) : 0;
        return m > 0 ? m / 1000000 : 0;
    }

    function seekToFraction(f) {
        const p = activePlayer;
        if (!p || trackLength <= 0) {
            console.log("[PlayerCard] seek ignored: no player or unknown length");
            return;
        }
        const target = Math.max(0, Math.min(trackLength, f * trackLength));
        console.log("[PlayerCard] seek to", target, "s  canSeek=", p.canSeek, "positionSupported=", p.positionSupported);
        if (!p.canSeek)
            return;
        // Absolute position is more reliable than a relative seek(): position is only
        // refreshed when polled, so "target - position" can be based on a stale value.
        if (p.positionSupported)
            p.position = target;
        else
            p.seek(target - p.position);
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

    // Browsers (Brave/Chrome) often report canGoPrevious = false for a single video;
    // fall back to restarting the track, like most media widgets do.
    function goPrevious() {
        const p = activePlayer;
        if (!p)
            return;
        if (p.canGoPrevious)
            p.previous();
        else if (p.canSeek && p.positionSupported)
            p.position = 0;
        else if (p.canSeek)
            p.seek(-p.position);
    }

    Timer {
        interval: 1000
        repeat: true
        running: root.showCondition && root.isPlaying && !!root.activePlayer
        onTriggered: root.activePlayer.positionChanged()
    }

    anchors.fill: parent
    opacity: showCondition ? 1 : 0

    Behavior on opacity {
        NumberAnimation {
            duration: 110
            easing.type: Easing.InOutQuad
        }
    }

    ClippingRectangle {
        id: artFrame
        x: 16
        y: 16
        width: 112
        height: 112
        radius: 16
        color: "#2a2a2a"

        Image {
            id: artImage
            anchors.fill: parent
            source: root.artSource
            sourceSize: Qt.size(256, 256)
            fillMode: Image.PreserveAspectCrop
            smooth: true
            mipmap: true
            asynchronous: true
            cache: true
        }

        Text {
            anchors.centerIn: parent
            visible: artImage.status !== Image.Ready
            text: "\uf001"
            font.family: root.iconFontFamily
            font.pixelSize: 28
            color: "white"
            opacity: 0.5
        }
    }

    Column {
        id: info
        anchors.left: artFrame.right
        anchors.leftMargin: 16
        anchors.right: parent.right
        anchors.rightMargin: 18
        anchors.top: artFrame.top
        spacing: 2

        Text {
            width: parent.width
            text: root.currentTrack
            color: "white"
            font.pixelSize: 19
            font.family: root.textFontFamily
            font.weight: Font.DemiBold
            font.letterSpacing: -0.3
            elide: Text.ElideRight
        }
        Text {
            width: parent.width
            text: root.currentArtist
            color: Qt.rgba(1, 1, 1, 0.6)
            font.pixelSize: 14
            font.family: root.textFontFamily
            elide: Text.ElideRight
        }
        Text {
            width: parent.width
            visible: text !== ""
            text: root.albumText
            color: Qt.rgba(1, 1, 1, 0.4)
            font.pixelSize: 11
            font.family: root.textFontFamily
            elide: Text.ElideRight
        }
        Text {
            width: parent.width
            visible: text !== ""
            text: root.sourceText
            color: Qt.rgba(1, 1, 1, 0.3)
            font.pixelSize: 11
            font.family: root.textFontFamily
            elide: Text.ElideRight
        }
    }

    Item {
        id: progressItem
        anchors.left: artFrame.right
        anchors.leftMargin: 16
        anchors.right: parent.right
        anchors.rightMargin: 18
        y: 112 - 14
        height: 36

        readonly property real shownProgress: seekArea.pressed ? root.dragProgress : root.trackProgress

        Row {
            id: cavaRow
            anchors.right: parent.right
            anchors.top: parent.top
            height: 12
            spacing: 3

            Repeater {
                model: 8

                delegate: Rectangle {
                    readonly property real rawLevel: root.cavaLevels && index < root.cavaLevels.length ? Number(root.cavaLevels[index]) : 0
                    readonly property real level: Math.max(0, Math.min(1, isNaN(rawLevel) ? 0 : rawLevel))

                    width: 3
                    height: 3 + 9 * level
                    radius: width / 2
                    color: root.isPlaying ? Qt.rgba(1, 1, 1, 0.85) : Qt.rgba(1, 1, 1, 0.32)
                    anchors.verticalCenter: parent.verticalCenter

                    Behavior on height {
                        NumberAnimation {
                            duration: 90
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            }
        }

        Rectangle {
            id: track
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 15
            height: 4
            radius: 2
            color: Qt.rgba(1, 1, 1, 0.18)

            Rectangle {
                width: parent.width * Math.max(0, Math.min(1, progressItem.shownProgress))
                height: parent.height
                radius: 2
                color: "white"
            }
        }

        Text {
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            text: seekArea.pressed ? root.formatSeconds(root.dragProgress * root.trackLength) : root.timePlayed
            color: Qt.rgba(1, 1, 1, 0.5)
            font.pixelSize: 11
            font.family: root.textFontFamily
        }
        Text {
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            text: root.timeTotal
            color: Qt.rgba(1, 1, 1, 0.5)
            font.pixelSize: 11
            font.family: root.textFontFamily
        }

        MouseArea {
            id: seekArea
            anchors.fill: parent
            anchors.topMargin: -10
            anchors.bottomMargin: 6
            hoverEnabled: true
            preventStealing: true
            cursorShape: Qt.PointingHandCursor

            function fraction(mx) {
                return Math.max(0, Math.min(1, mx / width));
            }
            onPressed: m => root.dragProgress = fraction(m.x)
            onPositionChanged: m => {
                if (pressed)
                    root.dragProgress = fraction(m.x);
            }
            onReleased: root.seekToFraction(root.dragProgress)
        }
    }

    Row {
        id: controls
        x: info.x + (info.width - width) / 2
        y: root.height - height - 12
        spacing: 12

        PlayerControlButton {
            kind: "previous"
            textFontFamily: root.textFontFamily
            enabled: !!root.activePlayer && (root.activePlayer.canGoPrevious || root.activePlayer.canSeek)
            onClicked: root.goPrevious()
        }
        PlayerControlButton {
            kind: root.isPlaying ? "pause" : "play"
            textFontFamily: root.textFontFamily
            enabled: !!root.activePlayer
            onClicked: root.togglePlayback()
        }
        PlayerControlButton {
            kind: "next"
            textFontFamily: root.textFontFamily
            enabled: !!root.activePlayer && root.activePlayer.canGoNext
            onClicked: {
                if (root.activePlayer && root.activePlayer.canGoNext)
                    root.activePlayer.next();
            }
        }
    }
}
