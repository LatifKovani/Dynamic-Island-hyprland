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
                    onClicked: UiSettings.resetControlCenter()
                }
            }
        }
    }
}
