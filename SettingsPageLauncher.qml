import QtQuick

SettingsPage {
    SettingsGroup {
        title: "Panel"

        SettingsSlider {
            title: "Launcher panel width"
            description: "The height is fixed so the panel never gets clipped"
            from: 420
            to: 900
            stepSize: 10
            value: UiSettings.launcherWidth
            last: true
            onMoved: v => UiSettings.launcherWidth = v
        }
    }

    SettingsGroup {
        title: "Results"

        SettingsRow {
            title: "Favourites section"
            description: "Show your pinned apps first when the search box is empty"
            SettingsSwitch {
                checked: UiSettings.launcherShowFavourites
                onToggled: v => UiSettings.launcherShowFavourites = v
            }
        }
        SettingsSlider {
            title: "Apps listed when browsing"
            from: 5
            to: 20
            stepSize: 1
            unit: "apps"
            value: UiSettings.launcherBrowseLimit
            onMoved: v => UiSettings.launcherBrowseLimit = v
        }
        SettingsSlider {
            title: "Search results limit"
            from: 5
            to: 30
            stepSize: 1
            unit: "apps"
            value: UiSettings.launcherSearchLimit
            last: true
            onMoved: v => UiSettings.launcherSearchLimit = v
        }
    }

    SettingsGroup {
        title: "Apps"

        SettingsChipList {
            title: "Favourite apps"
            description: "Use the name exactly as it shows in the launcher (capitals don't matter)"
            items: UiSettings.launcherFavourites
            onEdited: v => UiSettings.launcherFavourites = v
        }
        SettingsChipList {
            title: "Hidden apps"
            description: "These never appear in the launcher"
            items: UiSettings.launcherHidden
            last: true
            onEdited: v => UiSettings.launcherHidden = v
        }
    }

    SettingsGroup {
        SettingsRow {
            title: "Reset Launcher"
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
                    onClicked: UiSettings.resetLauncher()
                }
            }
        }
    }
}
