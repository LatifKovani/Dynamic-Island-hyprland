import QtQuick

SettingsPage {
    SettingsGroup {
        title: "Unlock animation"

        SettingsRow {
            title: "Unlock animation"
            description: "Plays the padlock in the island when hyprlock unlocks"
            last: true
            SettingsSwitch {
                checked: UiSettings.lockAnimation
                onToggled: v => UiSettings.lockAnimation = v
            }
        }
    }

    SettingsGroup {
        title: "Look"

        SettingsSlider {
            title: "Lock capsule width"
            from: 120
            to: 300
            stepSize: 10
            value: UiSettings.lockCapsuleWidth
            onMoved: v => UiSettings.lockCapsuleWidth = v
        }
        SettingsSlider {
            title: "Lock icon size"
            from: 12
            to: 28
            stepSize: 1
            value: UiSettings.lockIconSize
            last: true
            onMoved: v => UiSettings.lockIconSize = v
        }
    }

    SettingsGroup {
        title: "Timing"

        SettingsSlider {
            title: "Unlock start delay"
            description: "Wait before the padlock starts to open"
            from: 0
            to: 1500
            stepSize: 20
            unit: "ms"
            value: UiSettings.lockStartDelay
            onMoved: v => UiSettings.lockStartDelay = v
        }
        SettingsSlider {
            title: "Unlocked icon hold time"
            description: "How long the open padlock stays on screen"
            from: 0
            to: 2000
            stepSize: 50
            unit: "ms"
            value: UiSettings.lockHoldDuration
            onMoved: v => UiSettings.lockHoldDuration = v
        }
        SettingsSlider {
            title: "Lock fade out"
            from: 0
            to: 600
            stepSize: 10
            unit: "ms"
            value: UiSettings.lockFadeOut
            last: true
            onMoved: v => UiSettings.lockFadeOut = v
        }
    }

    SettingsGroup {
        SettingsRow {
            title: "Reset Lock Screen"
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
                    onClicked: UiSettings.resetLockScreen()
                }
            }
        }
    }
}
