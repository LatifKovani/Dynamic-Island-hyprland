import QtQuick

SettingsPage {
    SettingsGroup {
        title: "Pop-ups"

        SettingsRow {
            title: "Show notification pop-ups"
            description: "Notifications appear in the island when they arrive"
            SettingsSwitch {
                checked: UiSettings.notifPopups
                onToggled: v => UiSettings.notifPopups = v
            }
        }
        SettingsSlider {
            title: "Pop-up duration"
            description: "How long a notification stays before the island shrinks back"
            from: 500
            to: 10000
            stepSize: 250
            unit: "ms"
            value: UiSettings.notifDuration
            onMoved: v => UiSettings.notifDuration = v
        }
        SettingsRow {
            title: "Show message text"
            description: "Off shows only the title line"
            SettingsSwitch {
                checked: UiSettings.notifShowBody
                onToggled: v => UiSettings.notifShowBody = v
            }
        }
        SettingsSlider {
            title: "Notification maximum width"
            from: 400
            to: 900
            stepSize: 10
            value: UiSettings.notifMaxWidth
            last: true
            onMoved: v => UiSettings.notifMaxWidth = v
        }
    }

    SettingsGroup {
        title: "Focus"

        SettingsRow {
            title: "Do not disturb"
            description: "Incoming notifications are dropped silently while this is on"
            last: true
            SettingsSwitch {
                checked: UiSettings.notifDnd
                onToggled: v => UiSettings.notifDnd = v
            }
        }
    }

    SettingsGroup {
        SettingsRow {
            title: "Reset Notifications"
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
                    onClicked: UiSettings.resetNotifications()
                }
            }
        }
    }
}
