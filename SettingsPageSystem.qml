import QtQuick

SettingsPage {
    SettingsGroup {
        title: "Battery"

        SettingsRow {
            title: "Low battery alerts"
            description: "Pop-ups at 25, 20, 15 and 10% while discharging"
            SettingsSwitch {
                checked: UiSettings.batteryAlerts
                onToggled: v => UiSettings.batteryAlerts = v
            }
        }
        SettingsRow {
            title: "Critical battery alert"
            description: "A pinned alert that updates live and clears when you plug in"
            last: !UiSettings.batteryCriticalAlert
            SettingsSwitch {
                checked: UiSettings.batteryCriticalAlert
                onToggled: v => UiSettings.batteryCriticalAlert = v
            }
        }
        SettingsSlider {
            visible: UiSettings.batteryCriticalAlert
            height: visible ? 78 : 0
            title: "Critical battery level"
            from: 3
            to: 25
            stepSize: 1
            unit: "%"
            value: UiSettings.batteryCriticalLevel
            last: true
            onMoved: v => UiSettings.batteryCriticalLevel = v
        }
    }

    SettingsGroup {
        SettingsRow {
            title: "Reset System"
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
                    onClicked: UiSettings.resetSystem()
                }
            }
        }
    }
}
