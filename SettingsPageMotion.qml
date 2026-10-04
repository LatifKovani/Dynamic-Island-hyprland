import QtQuick

SettingsPage {
    SettingsGroup {
        title: "Animation"

        SettingsRow {
            title: "Reduce motion"
            description: "Turns off the pill morph and the fades"
            last: true
            SettingsSwitch {
                checked: UiSettings.reduceMotion
                onToggled: v => UiSettings.reduceMotion = v
            }
        }
    }

    SettingsGroup {
        title: "Timing"

        SettingsSlider {
            title: "Pill morph duration"
            description: "How long the pill takes to grow, shrink and change shape"
            from: 100
            to: 1000
            stepSize: 25
            unit: "ms"
            value: UiSettings.morphDuration
            onMoved: v => UiSettings.morphDuration = v
        }
        SettingsSlider {
            title: "Player card fade in"
            from: 0
            to: 500
            stepSize: 10
            unit: "ms"
            value: UiSettings.cardFadeIn
            onMoved: v => UiSettings.cardFadeIn = v
        }
        SettingsSlider {
            title: "Player card fade out"
            from: 0
            to: 500
            stepSize: 10
            unit: "ms"
            value: UiSettings.cardFadeOut
            onMoved: v => UiSettings.cardFadeOut = v
        }
        SettingsSlider {
            title: "Circle fade"
            description: "Album and status circles appearing and disappearing"
            from: 0
            to: 600
            stepSize: 10
            unit: "ms"
            value: UiSettings.circleFade
            last: true
            onMoved: v => UiSettings.circleFade = v
        }
    }

    SettingsGroup {
        SettingsRow {
            title: "Reset Motion"
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
                    onClicked: UiSettings.resetMotion()
                }
            }
        }
    }
}
