import QtQuick

SettingsPage {
    SettingsGroup {
        title: "Pill"

        SettingsColorRow {
            title: "Pill color"
            description: "Pick a swatch or type a hex value like #101820"
            value: UiSettings.pillColor
            onPicked: c => UiSettings.pillColor = c
        }
        SettingsSlider {
            title: "Pill opacity"
            from: 50
            to: 100
            stepSize: 5
            unit: "%"
            value: UiSettings.pillOpacity
            last: true
            onMoved: v => UiSettings.pillOpacity = v
        }
    }

    SettingsGroup {
        title: "Corners"

        SettingsSlider {
            title: "Resting pill roundness"
            description: "100% is a full capsule"
            from: 30
            to: 100
            stepSize: 5
            unit: "%"
            value: UiSettings.restRoundness
            onMoved: v => UiSettings.restRoundness = v
        }
        SettingsSlider {
            title: "Panel corner radius"
            description: "Control center, launcher, calendar, power menu and the other open panels"
            from: 16
            to: 48
            stepSize: 1
            value: UiSettings.panelRadius
            last: true
            onMoved: v => UiSettings.panelRadius = v
        }
    }

    SettingsGroup {
        SettingsRow {
            title: "Reset Appearance"
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
                    onClicked: UiSettings.resetAppearance()
                }
            }
        }
    }
}
