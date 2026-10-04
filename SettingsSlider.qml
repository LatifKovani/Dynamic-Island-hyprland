import QtQuick

// Title + value on top, slider underneath. Bind `value`, write back in onMoved.
Item {
    id: root

    property string title: ""
    property string description: ""
    property real from: 0
    property real to: 100
    property real stepSize: 1
    property real value: 0
    property string unit: "px"
    property bool last: false
    signal moved(real value)

    readonly property real ratio: to > from ? Math.max(0, Math.min(1, (value - from) / (to - from))) : 0

    width: parent ? parent.width : 400
    height: 78

    Text {
        x: 18
        y: 12
        text: root.title
        color: SettingsTheme.text
        font.pixelSize: 14
    }

    Text {
        anchors.right: parent.right
        anchors.rightMargin: 18
        y: 13
        text: (Math.round(root.value * 100) / 100) + (root.unit !== "" ? " " + root.unit : "")
        color: SettingsTheme.muted
        font.pixelSize: 13
    }

    Item {
        id: track
        anchors.left: parent.left
        anchors.leftMargin: 18
        anchors.right: parent.right
        anchors.rightMargin: 18
        y: 42
        height: 22

        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width
            height: 4
            radius: 2
            color: SettingsTheme.track
        }
        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width: root.ratio * parent.width
            height: 4
            radius: 2
            color: SettingsTheme.accent
        }
        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            x: root.ratio * (parent.width - width)
            width: 16
            height: 16
            radius: 8
            color: SettingsTheme.accent
            border.width: 3
            border.color: SettingsTheme.panel
        }

        MouseArea {
            anchors.fill: parent
            anchors.topMargin: -6
            anchors.bottomMargin: -6
            preventStealing: true
            cursorShape: Qt.PointingHandCursor

            function setFrom(mouseX) {
                const r = Math.max(0, Math.min(1, mouseX / track.width));
                let v = root.from + r * (root.to - root.from);
                v = Math.round(v / root.stepSize) * root.stepSize;
                v = Math.max(root.from, Math.min(root.to, v));
                if (v !== root.value)
                    root.moved(v);
            }

            onPressed: mouse => setFrom(mouse.x)
            onPositionChanged: mouse => {
                if (pressed)
                    setFrom(mouse.x);
            }
        }
    }

    Rectangle {
        visible: !root.last
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 18
        anchors.right: parent.right
        height: 1
        color: SettingsTheme.border
    }
}
