import QtQuick

SettingsPage {
    SettingsGroup {
        title: "Preview"

        SettingsLayoutPreview {
            order: UiSettings.ccOrder
            hidden: UiSettings.ccHidden
            showHeader: UiSettings.ccShowHeader
        }
    }

    SettingsGroup {
        title: "Header"

        SettingsRow {
            title: "Show clock and battery header"
            description: "The time, date and battery at the top of the panel"
            last: true
            SettingsSwitch {
                checked: UiSettings.ccShowHeader
                onToggled: v => UiSettings.ccShowHeader = v
            }
        }
    }

    SettingsGroup {
        title: "Sections (top to bottom)"

        SettingsSectionList {
            sections: [
                {
                    id: "connectivity",
                    label: "Wi-Fi and Bluetooth cards",
                    description: "Toggle and open the network / device lists"
                },
                {
                    id: "drawer",
                    label: "Battery, Night Light and Focus drawer",
                    description: "Pull-down handle. Focus and Night Light live in here"
                },
                {
                    id: "display",
                    label: "Display slider",
                    description: "Screen brightness"
                },
                {
                    id: "sound",
                    label: "Sound slider",
                    description: "Output volume"
                },
                {
                    id: "notifications",
                    label: "Notification history",
                    description: "Recent notifications, with clear and dismiss"
                }
            ]
            order: UiSettings.ccOrder
            hidden: UiSettings.ccHidden
            last: true
            onOrderEdited: o => UiSettings.ccOrder = o
            onHiddenEdited: h => UiSettings.ccHidden = h
        }
    }

    SettingsGroup {
        title: "Weather"

        SettingsRow {
            title: "Show weather in the header"
            description: "A small chip next to the date. Click it for the forecast"
            SettingsSwitch {
                checked: UiSettings.weatherEnabled
                onToggled: v => UiSettings.weatherEnabled = v
            }
        }

        SettingsSegmented {
            title: "Units"
            options: [
                {
                    label: "Metric (°C)",
                    value: "metric"
                },
                {
                    label: "Imperial (°F)",
                    value: "imperial"
                }
            ]
            current: UiSettings.weatherUnits
            onPicked: v => UiSettings.weatherUnits = v
        }

        SettingsRow {
            title: "Location"
            description: "City name. Leave empty to detect it automatically"
            last: true

            Rectangle {
                width: 180
                height: 30
                radius: 10
                color: SettingsTheme.panelRaised
                border.width: locationInput.activeFocus ? 1 : 0
                border.color: SettingsTheme.accent

                TextInput {
                    id: locationInput
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    verticalAlignment: TextInput.AlignVCenter
                    color: SettingsTheme.text
                    font.pixelSize: 13
                    selectByMouse: true
                    clip: true
                    text: UiSettings.weatherLocation

                    Connections {
                        target: UiSettings
                        function onWeatherLocationChanged() {
                            if (!locationInput.activeFocus)
                                locationInput.text = UiSettings.weatherLocation;
                        }
                    }

                    onEditingFinished: UiSettings.weatherLocation = text.trim()
                }
            }
        }
    }

    SettingsGroup {
        SettingsRow {
            title: "Reset Control Center"
            description: "Restore the default layout"
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
                    onClicked: {
                        UiSettings.resetControlCenter();
                        UiSettings.resetWeather();
                    }
                }
            }
        }
    }
}
