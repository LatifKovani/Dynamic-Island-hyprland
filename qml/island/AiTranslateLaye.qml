import QtQuick
import QtQuick.Controls

Item {
    id: aiTranslateLayer

    property string iconFontFamily: ""
    property string textFontFamily: ""
    property bool showCondition: false
    signal closeRequested()

    // ── Backend ───────────────────────────────────────────────────────────
    AiTranslateBackend {
        id: backend
    }

    // ── Tab state ─────────────────────────────────────────────────────────
    property int activeTab: 0  // 0 = AI, 1 = Translate

    // ── Visibility animation ──────────────────────────────────────────────
    opacity: showCondition ? 1 : 0
    Behavior on opacity {
        NumberAnimation { duration: 180; easing.type: Easing.InOutQuad }
    }

    // ── Root layout ───────────────────────────────────────────────────────
    anchors.fill: parent

    // ── Tab bar ───────────────────────────────────────────────────────────
    Item {
        id: tabBar
        anchors { top: parent.top; left: parent.left; right: parent.right; topMargin: 12 }
        height: 36

        // Background pill for active tab
        Rectangle {
            id: tabIndicator
            y: 2
            x: (activeTab === 0 ? tabAi.x : tabTranslate.x) + tabRow.x
            width: activeTab === 0 ? tabAi.width : tabTranslate.width
            height: 30
            radius: 10
            color: "#1e1e1e"

            Behavior on x { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
            Behavior on width { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
        }

        Row {
            id: tabRow
            anchors.centerIn: parent
            spacing: 4

            // AI tab
            Rectangle {
                id: tabAi
                width: 120; height: 30
                radius: 10
                color: "transparent"

                Row {
                    anchors.centerIn: parent
                    spacing: 6

                    Text {
                        text: "✦"
                        font.pixelSize: 12
                        color: activeTab === 0 ? "#3d7aed" : "#555555"
                        anchors.verticalCenter: parent.verticalCenter
                        Behavior on color { ColorAnimation { duration: 150 } }
                    }
                    Text {
                        text: "AI Chat"
                        font.family: aiTranslateLayer.textFontFamily
                        font.pixelSize: 13
                        font.weight: activeTab === 0 ? Font.DemiBold : Font.Normal
                        color: activeTab === 0 ? "#ffffff" : "#666666"
                        anchors.verticalCenter: parent.verticalCenter
                        Behavior on color { ColorAnimation { duration: 150 } }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: aiTranslateLayer.activeTab = 0
                }
            }

            // Translate tab
            Rectangle {
                id: tabTranslate
                width: 120; height: 30
                radius: 10
                color: "transparent"

                Row {
                    anchors.centerIn: parent
                    spacing: 6

                    Text {
                        text: "⇄"
                        font.pixelSize: 13
                        color: activeTab === 1 ? "#3d7aed" : "#555555"
                        anchors.verticalCenter: parent.verticalCenter
                        Behavior on color { ColorAnimation { duration: 150 } }
                    }
                    Text {
                        text: "Translate"
                        font.family: aiTranslateLayer.textFontFamily
                        font.pixelSize: 13
                        font.weight: activeTab === 1 ? Font.DemiBold : Font.Normal
                        color: activeTab === 1 ? "#ffffff" : "#666666"
                        anchors.verticalCenter: parent.verticalCenter
                        Behavior on color { ColorAnimation { duration: 150 } }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: aiTranslateLayer.activeTab = 1
                }
            }
        }

        // Close button
        Rectangle {
            width: 28; height: 28
            anchors { right: parent.right; rightMargin: 12; verticalCenter: parent.verticalCenter }
            radius: 8
            color: closeMa.containsMouse ? "#2a2a2a" : "transparent"
            Behavior on color { ColorAnimation { duration: 120 } }

            Text {
                anchors.centerIn: parent
                text: "✕"
                font.pixelSize: 12
                color: "#666666"
            }

            MouseArea {
                id: closeMa
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: aiTranslateLayer.closeRequested()
            }
        }
    }

    // ── Thin divider ──────────────────────────────────────────────────────
    Rectangle {
        id: tabDivider
        anchors { top: tabBar.bottom; left: parent.left; right: parent.right; topMargin: 4; leftMargin: 12; rightMargin: 12 }
        height: 1
        color: "#222222"
    }

    // ── Tab content area ──────────────────────────────────────────────────
    Item {
        id: contentArea
        anchors {
            top: tabDivider.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            topMargin: 8
            leftMargin: 12
            rightMargin: 12
            bottomMargin: 12
        }

        AiChatTab {
            id: chatTab
            anchors.fill: parent
            textFontFamily: aiTranslateLayer.textFontFamily
            backend: backend
            isActive: aiTranslateLayer.activeTab === 0
            visible: aiTranslateLayer.activeTab === 0
            opacity: visible ? 1 : 0
            Behavior on opacity { NumberAnimation { duration: 150 } }
        }

        TranslateTab {
            id: translateTab
            anchors.fill: parent
            textFontFamily: aiTranslateLayer.textFontFamily
            backend: backend
            isActive: aiTranslateLayer.activeTab === 1
            visible: aiTranslateLayer.activeTab === 1
            opacity: visible ? 1 : 0
            Behavior on opacity { NumberAnimation { duration: 150 } }
        }
    }
}
