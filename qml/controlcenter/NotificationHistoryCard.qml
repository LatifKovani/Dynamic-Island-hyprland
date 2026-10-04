import QtQuick
import IslandBackend

Rectangle {
    id: root

    signal clearRequested
    signal dismissRequested(var notif)

    property var history: []
    property string iconFontFamily: ""
    property string textFontFamily: ""
    property color moduleColor: StyleTokens.module
    property color textPrimary: StyleTokens.textPrimary
    property color textSecondary: StyleTokens.textSecondary

    // newest first, capped so a long session can't build a huge list
    readonly property var items: history ? history.slice().reverse().slice(0, 30) : []

    radius: 24
    color: moduleColor

    Item {
        anchors.fill: parent
        anchors.margins: 12

        Text {
            id: heading
            anchors.left: parent.left
            anchors.top: parent.top
            text: "Notifications"
            color: root.textPrimary
            font.pixelSize: 13
            font.family: root.textFontFamily
            font.weight: Font.DemiBold
        }

        Text {
            anchors.right: parent.right
            anchors.verticalCenter: heading.verticalCenter
            visible: root.items.length > 0
            text: "Clear"
            color: root.textSecondary
            font.pixelSize: 12
            font.family: root.textFontFamily

            MouseArea {
                anchors.fill: parent
                anchors.margins: -8
                cursorShape: Qt.PointingHandCursor
                onClicked: root.clearRequested()
            }
        }

        Text {
            anchors.centerIn: parent
            visible: root.items.length === 0
            text: "No notifications"
            color: root.textSecondary
            font.pixelSize: 12
            font.family: root.textFontFamily
        }

        ListView {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: heading.bottom
            anchors.topMargin: 8
            anchors.bottom: parent.bottom
            clip: true
            spacing: 4
            boundsBehavior: Flickable.StopAtBounds
            model: root.items

            delegate: Item {
                required property var modelData

                width: ListView.view.width
                height: 40

                Column {
                    anchors.left: parent.left
                    anchors.right: dismissButton.left
                    anchors.rightMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 1

                    Text {
                        width: parent.width
                        text: modelData.summary !== "" ? modelData.summary : modelData.appName
                        color: root.textPrimary
                        font.pixelSize: 13
                        font.family: root.textFontFamily
                        elide: Text.ElideRight
                    }
                    Text {
                        width: parent.width
                        text: modelData.summary !== "" ? (modelData.appName + (modelData.body !== "" ? "  ·  " + modelData.body.replace(/\n/g, " ") : "")) : modelData.body.replace(/\n/g, " ")
                        color: root.textSecondary
                        font.pixelSize: 11
                        font.family: root.textFontFamily
                        elide: Text.ElideRight
                    }
                }

                Text {
                    id: dismissButton
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    text: "\u00d7"
                    color: root.textSecondary
                    font.pixelSize: 16
                    font.family: root.textFontFamily

                    MouseArea {
                        anchors.fill: parent
                        anchors.margins: -8
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.dismissRequested(modelData)
                    }
                }
            }
        }
    }
}
