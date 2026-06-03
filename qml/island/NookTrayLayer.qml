import QtQuick

Item {
    id: root

    signal controlPressed

    property bool showCondition: false

    property string currentArtUrl: ""
    property string currentTrack: ""
    property string currentArtist: ""
    property string timePlayed: "0:00"
    property string timeTotal: "0:00"
    property real trackProgress: 0
    property var activePlayer: null
    property string iconFontFamily: ""
    property string textFontFamily: ""

    property string activeTab: "nook"

    anchors.fill: parent
    opacity: showCondition ? 1 : 0

    Behavior on opacity {
        NumberAnimation {
            duration: showCondition ? 300 : 100
            easing.type: Easing.InOutQuad
        }
    }

    // ── Tab bar ───────────────────────────────────────────────────
    Row {
        id: tabBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 7
        anchors.leftMargin: 14
        anchors.rightMargin: 14
        height: 22

        Rectangle {
            id: nookTab
            height: 22
            width: nookInner.implicitWidth + 18
            radius: 11
            color: activeTab === "nook" ? Qt.rgba(1, 1, 1, 0.12) : "transparent"
            Behavior on color {
                ColorAnimation {
                    duration: 150
                }
            }

            Row {
                id: nookInner
                anchors.centerIn: parent
                spacing: 5

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "\uf001"
                    font.family: root.iconFontFamily
                    font.pixelSize: 10
                    color: activeTab === "nook" ? "white" : Qt.rgba(1, 1, 1, 0.36)
                    Behavior on color {
                        ColorAnimation {
                            duration: 150
                        }
                    }
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Nook"
                    font.family: root.textFontFamily
                    font.pixelSize: 11
                    font.weight: activeTab === "nook" ? Font.SemiBold : Font.Regular
                    color: activeTab === "nook" ? "white" : Qt.rgba(1, 1, 1, 0.36)
                    Behavior on color {
                        ColorAnimation {
                            duration: 150
                        }
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                preventStealing: true
                onPressed: {
                    root.controlPressed();
                }
                onClicked: root.activeTab = "nook"
            }
        }

        Item {
            width: 6
            height: 1
        }

        Rectangle {
            id: trayTab
            height: 22
            width: trayInner.implicitWidth + 18
            radius: 11
            color: activeTab === "tray" ? Qt.rgba(1, 1, 1, 0.12) : "transparent"
            Behavior on color {
                ColorAnimation {
                    duration: 150
                }
            }

            Row {
                id: trayInner
                anchors.centerIn: parent
                spacing: 5

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "\uf0ae"
                    font.family: root.iconFontFamily
                    font.pixelSize: 10
                    color: activeTab === "tray" ? "white" : Qt.rgba(1, 1, 1, 0.36)
                    Behavior on color {
                        ColorAnimation {
                            duration: 150
                        }
                    }
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Tray"
                    font.family: root.textFontFamily
                    font.pixelSize: 11
                    font.weight: activeTab === "tray" ? Font.SemiBold : Font.Regular
                    color: activeTab === "tray" ? "white" : Qt.rgba(1, 1, 1, 0.36)
                    Behavior on color {
                        ColorAnimation {
                            duration: 150
                        }
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                preventStealing: true
                onPressed: {
                    root.controlPressed();
                }
                onClicked: root.activeTab = "tray"
            }
        }

        Item {
            width: tabBar.width - nookTab.width - 6 - trayTab.width - gearIcon.contentWidth - 28 - 14 - 14
            height: 1
        }

        Text {
            id: gearIcon
            anchors.verticalCenter: parent.verticalCenter
            text: "\uf013"
            font.family: root.iconFontFamily
            font.pixelSize: 13
            color: gearMouse.pressed ? Qt.rgba(1, 1, 1, 0.7) : Qt.rgba(1, 1, 1, 0.28)
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }

            MouseArea {
                id: gearMouse
                anchors.fill: parent
                anchors.margins: -8
                preventStealing: true
                onPressed: {
                    root.controlPressed();
                }
            }
        }
    }

    Rectangle {
        anchors.top: tabBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 14
        anchors.rightMargin: 14
        anchors.topMargin: 4
        height: 1
        color: Qt.rgba(1, 1, 1, 0.06)
    }

    // ── Content area ──────────────────────────────────────────────
    Item {
        anchors.top: tabBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.topMargin: 5

        // ── NOOK: media player ─────────────────────────────────────
        // enabled: false when the tray tab is active.
        // Both layers use anchors.fill so they fully overlap.
        // TrayLayer is declared second (higher z-order) and was
        // intercepting ALL mouse events — including the ListView/Flickable
        // grabbing presses to detect flick gestures — even at opacity 0.
        // Setting enabled: activeTab === "nook/tray" stops whichever layer
        // is invisible from consuming input meant for the other.
        ExpandedPlayerLayer {
            anchors.fill: parent
            enabled: root.activeTab === "nook"
            showCondition: root.activeTab === "nook" && root.showCondition
            currentArtUrl: root.currentArtUrl
            currentTrack: root.currentTrack
            currentArtist: root.currentArtist
            timePlayed: root.timePlayed
            timeTotal: root.timeTotal
            trackProgress: root.trackProgress
            activePlayer: root.activePlayer
            iconFontFamily: root.iconFontFamily
            textFontFamily: root.textFontFamily
            onControlPressed: root.controlPressed()
        }

        // ── TRAY: todo list + pomodoro ─────────────────────────────
        TrayLayer {
            anchors.fill: parent
            enabled: root.activeTab === "tray"
            showCondition: root.activeTab === "tray" && root.showCondition
            iconFontFamily: root.iconFontFamily
            textFontFamily: root.textFontFamily
        }
    }
}
