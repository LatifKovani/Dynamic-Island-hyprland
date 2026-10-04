import QtQuick

// Row with a set of choices on the right. options: [{label: "5 days", value: 5}, ...]
SettingsRow {
    id: root

    property var options: []
    property var current: null
    signal picked(var value)

    Repeater {
        model: root.options

        delegate: Rectangle {
            required property var modelData
            readonly property bool selected: modelData.value === root.current

            width: label.implicitWidth + 28
            height: 32
            radius: 10
            color: selected ? SettingsTheme.accent : SettingsTheme.panelRaised

            Text {
                id: label
                anchors.centerIn: parent
                text: parent.modelData.label
                color: parent.selected ? SettingsTheme.accentText : SettingsTheme.text
                font.pixelSize: 13
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.picked(parent.modelData.value)
            }
        }
    }
}
