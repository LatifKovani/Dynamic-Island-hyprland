import QtQuick

Item {
    id: root

    property string pageTitle: ""

    Column {
        anchors.centerIn: parent
        spacing: 8

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: root.pageTitle
            color: SettingsTheme.text
            font.pixelSize: 18
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Nothing to configure here yet."
            color: SettingsTheme.muted
            font.pixelSize: 13
        }
    }
}
