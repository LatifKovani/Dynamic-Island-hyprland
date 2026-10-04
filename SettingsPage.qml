import QtQuick

// Scrollable page. Children (SettingsGroup items) are stacked vertically.
Flickable {
    id: root

    default property alias content: col.data

    contentWidth: width
    contentHeight: col.height + 32
    clip: true
    boundsBehavior: Flickable.StopAtBounds

    Column {
        id: col
        width: root.width - 12
        spacing: 22
    }
}
