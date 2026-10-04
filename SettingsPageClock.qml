import QtQuick

SettingsPage {
    SettingsGroup {
        title: "Clock"

        SettingsRow {
            title: "24-hour clock"
            description: "Off shows 12-hour time with AM / PM"
            last: true
            SettingsSwitch {
                checked: UiSettings.clock24h
                onToggled: v => UiSettings.clock24h = v
            }
        }
    }

    SettingsGroup {
        title: "Calendar"

        SettingsSegmented {
            title: "Days in the hover calendar"
            description: "Centered on today"
            options: [
                {
                    label: "3",
                    value: 3
                },
                {
                    label: "5",
                    value: 5
                },
                {
                    label: "7",
                    value: 7
                }
            ]
            current: UiSettings.calendarDays
            last: true
            onPicked: v => UiSettings.calendarDays = v
        }
    }

    SettingsGroup {
        SettingsRow {
            title: "Reset Clock & Date"
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
                    onClicked: UiSettings.resetClockAndDate()
                }
            }
        }
    }
}
