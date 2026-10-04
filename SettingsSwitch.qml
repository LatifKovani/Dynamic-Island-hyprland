import QtQuick

// Toggle. Bind `checked` to the setting and write it back in onToggled.
Item {
    id: root

    property bool checked: false
    signal toggled(bool value)

    implicitWidth: 46
    implicitHeight: 26
    width: implicitWidth
    height: implicitHeight

    Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: root.checked ? SettingsTheme.accent : SettingsTheme.track

        Behavior on color {
            ColorAnimation {
                duration: 120
            }
        }

        Rectangle {
            width: 20
            height: 20
            radius: 10
            y: 3
            x: root.checked ? parent.width - width - 3 : 3
            color: root.checked ? SettingsTheme.accentText : "#cfcfcf"

            Behavior on x {
                NumberAnimation {
                    duration: 120
                    easing.type: Easing.OutQuad
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.toggled(!root.checked)
    }
}
