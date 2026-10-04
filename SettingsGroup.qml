import QtQuick

// A titled card that holds SettingsRow / SettingsSlider items.
Item {
    id: root

    property string title: ""
    default property alias rows: col.data

    width: parent ? parent.width : 400
    height: (titleText.visible ? titleText.height + 8 : 0) + card.height

    Text {
        id: titleText
        visible: text !== ""
        text: root.title
        x: 4
        color: SettingsTheme.muted
        font.pixelSize: 12
    }

    Rectangle {
        id: card
        y: titleText.visible ? titleText.height + 8 : 0
        width: parent.width
        height: col.implicitHeight
        radius: 16
        color: SettingsTheme.panel

        Column {
            id: col
            width: parent.width
        }
    }
}
