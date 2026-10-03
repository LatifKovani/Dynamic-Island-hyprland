import QtQuick
import Quickshell.Widgets

// Left-hand circle: album art of the active player. Click opens the player card.
Item {
    id: root

    signal clicked

    property string artSource: ""
    property string iconFontFamily: ""
    readonly property bool hovered: mouseArea.containsMouse

    width: 34
    height: 34
    scale: mouseArea.pressed ? 0.92 : 1.0

    Behavior on scale {
        NumberAnimation {
            duration: 100
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: width / 2
        color: "#1c1c1e"
    }

    ClippingRectangle {
        anchors.fill: parent
        anchors.margins: 2
        radius: width / 2
        color: "transparent"

        Image {
            id: art
            anchors.fill: parent
            source: root.artSource
            sourceSize: Qt.size(96, 96)
            fillMode: Image.PreserveAspectCrop
            smooth: true
            asynchronous: true
            cache: true
        }
    }

    Text {
        anchors.centerIn: parent
        visible: art.status !== Image.Ready
        text: "\uf001"
        font.family: root.iconFontFamily
        font.pixelSize: 13
        color: "white"
        opacity: 0.6
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
