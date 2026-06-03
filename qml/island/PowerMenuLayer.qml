import QtQuick
import Quickshell.Io

Item {
    id: root

    signal closeRequested

    property string iconFontFamily: ""
    property string textFontFamily: ""
    property bool showCondition: false
    opacity: showCondition ? 1 : 0
    Behavior on opacity {
        NumberAnimation {
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }

    // Uptime process
    Process {
        id: uptimeProcess
        command: ["bash", "-c", "uptime -p | sed 's/up //'"]
        running: root.showCondition
        stdout: SplitParser {
            onRead: data => uptimeLabel.text = "Uptime: " + data.trim()
        }
    }

    // Action processes
    Process {
        id: lockProcess
        command: ["bash", "-c", "hyprlock"]
    }
    Process {
        id: suspendProcess
        command: ["bash", "-c", "systemctl suspend"]
    }
    Process {
        id: logoutProcess
        command: ["bash", "-c", "loginctl terminate-user $USER"]
    }
    Process {
        id: rebootProcess
        command: ["bash", "-c", "systemctl reboot"]
    }
    Process {
        id: shutdownProcess
        command: ["bash", "-c", "systemctl poweroff"]
    }

    Column {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 8

        Text {
            id: uptimeLabel
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Uptime: ..."
            color: Qt.rgba(1, 1, 1, 0.45)
            font.pixelSize: 11
            font.family: root.textFontFamily
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0

            Repeater {
                model: [
                    {
                        label: "Lock",
                        icon: "\uf023",
                        process: lockProcess
                    },
                    {
                        label: "Suspend",
                        icon: "\uf186",
                        process: suspendProcess
                    },
                    {
                        label: "Logout",
                        icon: "\udb80\udd68",
                        process: logoutProcess
                    },
                    {
                        label: "Reboot",
                        icon: "\udb80\udc15",
                        process: rebootProcess
                    },
                    {
                        label: "Shutdown",
                        icon: "\uf011",
                        process: shutdownProcess
                    },
                ]

                delegate: Item {
                    width: 72
                    height: 80

                    Column {
                        anchors.centerIn: parent
                        spacing: 6

                        Rectangle {
                            width: 44
                            height: 44
                            radius: 22
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: buttonMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.12) : Qt.rgba(1, 1, 1, 0.06)

                            Behavior on color {
                                ColorAnimation {
                                    duration: 150
                                }
                            }

                            Text {
                                anchors.centerIn: parent
                                text: modelData.icon
                                color: "white"
                                font.pixelSize: 18
                                font.family: root.iconFontFamily
                            }

                            MouseArea {
                                id: buttonMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: modelData.process.running = true
                            }
                        }

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: modelData.label
                            color: Qt.rgba(1, 1, 1, 0.75)
                            font.pixelSize: 11
                            font.family: root.textFontFamily
                            font.weight: Font.Medium
                        }
                    }
                }
            }
        }
    }
}
