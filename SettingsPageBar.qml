import QtQuick

SettingsPage {
    SettingsGroup {
        title: "Pill"

        SettingsSlider {
            title: "Resting width"
            from: 80
            to: 220
            stepSize: 2
            value: UiSettings.restWidth
            onMoved: v => UiSettings.restWidth = v
        }
        SettingsSlider {
            title: "Resting height"
            from: 26
            to: 52
            stepSize: 1
            value: UiSettings.restHeight
            last: true
            onMoved: v => UiSettings.restHeight = v
        }
    }

    SettingsGroup {
        title: "Circles"

        SettingsRow {
            title: "Status circle"
            description: "Battery ring with the Wi-Fi icon, to the right of the pill"
            SettingsSwitch {
                checked: UiSettings.showStatusCircle
                onToggled: v => UiSettings.showStatusCircle = v
            }
        }
        SettingsRow {
            title: "Album art circle"
            description: "Shown to the left of the pill while a player is open"
            SettingsSwitch {
                checked: UiSettings.showAlbumCircle
                onToggled: v => UiSettings.showAlbumCircle = v
            }
        }
        SettingsSlider {
            title: "Circle size"
            from: 24
            to: 48
            stepSize: 1
            value: UiSettings.circleSize
            onMoved: v => UiSettings.circleSize = v
        }
        SettingsSlider {
            title: "Gap between pill and circles"
            from: 6
            to: 30
            stepSize: 1
            value: UiSettings.circleGap
            last: true
            onMoved: v => UiSettings.circleGap = v
        }
    }

    SettingsGroup {
        title: "Hover"

        SettingsRow {
            title: "Hover the pill opens the calendar"
            SettingsSwitch {
                checked: UiSettings.hoverCalendar
                onToggled: v => UiSettings.hoverCalendar = v
            }
        }
        SettingsRow {
            title: "Hover the album circle opens the player"
            SettingsSwitch {
                checked: UiSettings.hoverPlayerCard
                onToggled: v => UiSettings.hoverPlayerCard = v
            }
        }
        SettingsRow {
            title: "Hover the status circle opens the control center"
            description: "When off, the control center only opens on click"
            SettingsSwitch {
                checked: UiSettings.hoverControlCenter
                onToggled: v => UiSettings.hoverControlCenter = v
            }
        }
        SettingsSlider {
            title: "Calendar / player close delay"
            description: "How long they stay after the pointer leaves"
            from: 0
            to: 3000
            stepSize: 50
            unit: "ms"
            value: UiSettings.hoverCloseDelay
            onMoved: v => UiSettings.hoverCloseDelay = v
        }
        SettingsSlider {
            title: "Control center close delay"
            from: 0
            to: 3000
            stepSize: 50
            unit: "ms"
            value: UiSettings.controlCenterCloseDelay
            onMoved: v => UiSettings.controlCenterCloseDelay = v
        }
        SettingsSlider {
            title: "Control center open delay"
            description: "Pause before hovering the status circle opens it"
            from: 0
            to: 1000
            stepSize: 20
            unit: "ms"
            value: UiSettings.statusHoverOpenDelay
            last: true
            onMoved: v => UiSettings.statusHoverOpenDelay = v
        }
    }

    SettingsGroup {
        SettingsRow {
            title: "Reset Bar & Island"
            description: "Restore the defaults for this page"
            last: true
            Rectangle {
                width: resetLabel.implicitWidth + 28
                height: 32
                radius: 10
                color: SettingsTheme.panelRaised

                Text {
                    id: resetLabel
                    anchors.centerIn: parent
                    text: "Reset"
                    color: SettingsTheme.danger
                    font.pixelSize: 13
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: UiSettings.resetBarAndIsland()
                }
            }
        }
    }
}
