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
        SettingsSlider {
            title: "Calendar / player close delay"
            description: "How long they stay after the pointer leaves"
            from: 0
            to: 3000
            stepSize: 50
            unit: "ms"
            value: UiSettings.hoverCloseDelay
            last: true
            onMoved: v => UiSettings.hoverCloseDelay = v
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
