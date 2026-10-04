import QtQuick

// Row of colour swatches plus a hex field. Bind `value` (a "#rrggbb" string), write back in onPicked.
SettingsRow {
    id: root

    property string value: "#000000"
    property var swatches: ["#000000", "#16181c", "#0b1220", "#1a0f24", "#0d1a14", "#220e14"]
    signal picked(string color)

    Repeater {
        model: root.swatches

        delegate: Rectangle {
            required property string modelData
            readonly property bool selected: modelData.toLowerCase() === root.value.toLowerCase()

            width: 26
            height: 26
            radius: 13
            color: modelData
            border.width: selected ? 2 : 1
            border.color: selected ? SettingsTheme.accent : SettingsTheme.track

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.picked(parent.modelData)
            }
        }
    }

    Rectangle {
        width: 86
        height: 30
        radius: 10
        color: SettingsTheme.panelRaised
        border.width: hexInput.activeFocus ? 1 : 0
        border.color: SettingsTheme.accent

        TextInput {
            id: hexInput
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            verticalAlignment: TextInput.AlignVCenter
            color: SettingsTheme.text
            font.pixelSize: 13
            maximumLength: 7
            selectByMouse: true
            text: root.value

            Connections {
                target: root
                function onValueChanged() {
                    hexInput.text = root.value;
                }
            }

            onEditingFinished: {
                if (/^#[0-9a-fA-F]{6}$/.test(text))
                    root.picked(text.toLowerCase());
                else
                    text = root.value;
            }
        }
    }
}
