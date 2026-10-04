import QtQuick

// A list of text items shown as removable chips, with a field underneath to add more.
// Bind `items` (an array of strings) and write the new array back in onEdited.
Item {
    id: root

    property string title: ""
    property string description: ""
    property var items: []
    property string placeholder: "Type a name and press Enter"
    property bool last: false
    signal edited(var items)

    function add(raw) {
        const t = raw.trim();
        if (t === "")
            return;
        const current = root.items ? root.items.slice() : [];
        for (let i = 0; i < current.length; i++)
            if (String(current[i]).toLowerCase() === t.toLowerCase())
                return;
        current.push(t);
        root.edited(current);
    }

    function removeAt(index) {
        const current = root.items ? root.items.slice() : [];
        current.splice(index, 1);
        root.edited(current);
    }

    width: parent ? parent.width : 400
    height: body.y + body.height + 16

    Column {
        id: body
        x: 18
        y: 14
        width: parent.width - 36
        spacing: 10

        Column {
            width: parent.width
            spacing: 2

            Text {
                width: parent.width
                text: root.title
                color: SettingsTheme.text
                font.pixelSize: 14
            }
            Text {
                width: parent.width
                visible: root.description !== ""
                text: root.description
                color: SettingsTheme.muted
                font.pixelSize: 12
                wrapMode: Text.WordWrap
            }
        }

        Flow {
            width: parent.width
            spacing: 6

            Repeater {
                model: root.items

                delegate: Rectangle {
                    required property var modelData
                    required property int index

                    width: chipText.implicitWidth + 40
                    height: 28
                    radius: 9
                    color: SettingsTheme.panelRaised

                    Text {
                        id: chipText
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        text: parent.modelData
                        color: SettingsTheme.text
                        font.pixelSize: 13
                    }
                    Text {
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        text: "\u00d7"
                        color: removeMouse.containsMouse ? SettingsTheme.danger : SettingsTheme.muted
                        font.pixelSize: 16
                    }
                    MouseArea {
                        id: removeMouse
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        width: 28
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.removeAt(parent.index)
                    }
                }
            }

            Text {
                visible: !root.items || root.items.length === 0
                text: "Nothing here yet"
                color: SettingsTheme.muted
                font.pixelSize: 12
            }
        }

        Rectangle {
            width: parent.width
            height: 34
            radius: 10
            color: SettingsTheme.panelRaised
            border.width: addInput.activeFocus ? 1 : 0
            border.color: SettingsTheme.accent

            TextInput {
                id: addInput
                anchors.fill: parent
                anchors.leftMargin: 12
                anchors.rightMargin: 12
                verticalAlignment: TextInput.AlignVCenter
                color: SettingsTheme.text
                selectionColor: SettingsTheme.accent
                selectedTextColor: SettingsTheme.accentText
                font.pixelSize: 13
                clip: true
                selectByMouse: true
                onAccepted: {
                    root.add(text);
                    text = "";
                }

                Text {
                    visible: addInput.text === ""
                    anchors.verticalCenter: parent.verticalCenter
                    text: root.placeholder
                    color: SettingsTheme.muted
                    font.pixelSize: 13
                }
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
