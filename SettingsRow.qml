import QtQuick

// One setting: title + description on the left, controls (declared as children) on the right.
Item {
    id: root

    property string title: ""
    property string description: ""
    property bool last: false
    default property alias content: slot.data

    width: parent ? parent.width : 400
    height: Math.max(58, textCol.implicitHeight + 24)

    Column {
        id: textCol
        anchors.left: parent.left
        anchors.leftMargin: 18
        anchors.right: slot.left
        anchors.rightMargin: 16
        anchors.verticalCenter: parent.verticalCenter
        spacing: 2

        Text {
            width: parent.width
            text: root.title
            color: SettingsTheme.text
            font.pixelSize: 14
            elide: Text.ElideRight
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

    Row {
        id: slot
        anchors.right: parent.right
        anchors.rightMargin: 18
        anchors.verticalCenter: parent.verticalCenter
        spacing: 6
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
