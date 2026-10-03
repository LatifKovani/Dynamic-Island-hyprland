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
    property string iconFontFamily: ""
    property string textFontFamily: ""
    property bool progressDragging: seekArea.pressed

    readonly property bool isPlaying: activePlayer && activePlayer.playbackState === MprisPlaybackState.Playing
    readonly property string albumText: activePlayer && activePlayer.trackAlbum ? activePlayer.trackAlbum : ""
    readonly property string sourceText: activePlayer && activePlayer.identity ? activePlayer.identity : ""
    property real dragProgress: 0

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
    opacity: showCondition ? 1 : 0

    Behavior on opacity {
        NumberAnimation {
            duration: root.showCondition ? 250 : 120
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
            font.weight: Font.SemiBold
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
        height: 28

        readonly property real shownProgress: seekArea.pressed ? root.dragProgress : root.trackProgress

        Rectangle {
            id: track
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 3
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
            text: seekArea.pressed ? root.formatUs(root.dragProgress * (root.activePlayer ? root.activePlayer.length : 0)) : root.timePlayed
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
            anchors.topMargin: -6
            anchors.bottomMargin: 8
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
            onReleased: {
                const p = root.activePlayer;
                if (p && p.canSeek && p.length > 0)
                    p.seek(Math.round(root.dragProgress * p.length) - p.position);
            }
        }
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 18
        spacing: 34

        PlayerControlButton {
            kind: "previous"
            textFontFamily: root.textFontFamily
            enabled: !!root.activePlayer
            onClicked: root.activePlayer.previous()
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
            enabled: !!root.activePlayer
            onClicked: root.activePlayer.next()
        }
    }
}
