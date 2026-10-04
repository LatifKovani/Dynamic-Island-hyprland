import QtQuick
import Quickshell
import Quickshell.Wayland
import IslandBackend

// Tide-island settings. Open/close with:  qs ipc -p /usr/share/tide-island call tide toggleSettings
PanelWindow {
    id: win

    signal closeRequested

    property string currentPage: "bar"
    property string query: ""

    readonly property var pages: [
        {
            id: "bar",
            label: "Bar & Island",
            icon: "\uf2d0",
            ready: true
        },
        {
            id: "clock",
            label: "Clock & Date",
            icon: "\uf017",
            ready: true
        },
        {
            id: "appearance",
            label: "Appearance",
            icon: "\uf53f",
            ready: true
        },
        {
            id: "motion",
            label: "Motion",
            icon: "\uf0e7",
            ready: true
        },
        {
            id: "launcher",
            label: "Launcher",
            icon: "\uf002",
            ready: false
        },
        {
            id: "notifications",
            label: "Notifications",
            icon: "\uf0f3",
            ready: false
        },
        {
            id: "controlcenter",
            label: "Control Center",
            icon: "\uf1de",
            ready: false
        },
        {
            id: "lockscreen",
            label: "Lock Screen",
            icon: "\uf023",
            ready: false
        },
        {
            id: "system",
            label: "System",
            icon: "\uf013",
            ready: false
        }
    ]

    // what the search box can find: [setting title, page id]
    readonly property var searchIndex: [
        ["Resting width", "bar"],
        ["Resting height", "bar"],
        ["Pill size", "bar"],
        ["Status circle", "bar"],
        ["Battery ring / Wi-Fi circle", "bar"],
        ["Album art circle", "bar"],
        ["Circle size", "bar"],
        ["Gap between pill and circles", "bar"],
        ["Hover opens calendar", "bar"],
        ["Hover opens player", "bar"],
        ["Hover opens control center", "bar"],
        ["Close delay", "bar"],
        ["Control center open delay", "bar"],
        ["24-hour clock", "clock"],
        ["Time format AM / PM", "clock"],
        ["Calendar days", "clock"],
        ["Pill color", "appearance"],
        ["Pill opacity / transparency", "appearance"],
        ["Resting pill roundness", "appearance"],
        ["Panel corner radius", "appearance"],
        ["Reduce motion", "motion"],
        ["Pill morph duration", "motion"],
        ["Player card fade", "motion"],
        ["Circle fade", "motion"]
    ]

    readonly property var results: {
        const q = query.trim().toLowerCase();
        if (q === "")
            return [];
        return searchIndex.filter(e => e[0].toLowerCase().indexOf(q) !== -1);
    }

    function pageComponent(id) {
        switch (id) {
        case "bar":
            return barPage;
        case "clock":
            return clockPage;
        case "appearance":
            return appearancePage;
        case "motion":
            return motionPage;
        default:
            return soonPage;
        }
    }

    function pageLabel(id) {
        for (let i = 0; i < pages.length; i++)
            if (pages[i].id === id)
                return pages[i].label;
        return "";
    }

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "tide-island-settings"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    // dim + click outside to close
    Rectangle {
        anchors.fill: parent
        color: "#59000000"

        MouseArea {
            anchors.fill: parent
            onClicked: win.closeRequested()
        }
    }

    Rectangle {
        id: card
        anchors.centerIn: parent
        width: Math.min(1100, win.width - 80)
        height: Math.min(720, win.height - 120)
        radius: 28
        color: SettingsTheme.window
        border.width: 1
        border.color: SettingsTheme.border

        // swallow clicks so they don't reach the close area
        MouseArea {
            anchors.fill: parent
        }

        FocusScope {
            anchors.fill: parent
            focus: true
            Keys.onEscapePressed: win.closeRequested()

            // ---------- sidebar ----------
            Item {
                id: sidebar
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: 250

                Rectangle {
                    id: searchBox
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.margins: 16
                    height: 38
                    radius: 13
                    color: SettingsTheme.panel

                    Text {
                        id: searchIcon
                        anchors.left: parent.left
                        anchors.leftMargin: 14
                        anchors.verticalCenter: parent.verticalCenter
                        text: "\uf002"
                        font.family: UserConfig.iconFontFamily
                        font.pixelSize: 12
                        color: SettingsTheme.muted
                    }
                    TextInput {
                        id: searchInput
                        anchors.left: searchIcon.right
                        anchors.leftMargin: 10
                        anchors.right: parent.right
                        anchors.rightMargin: 12
                        anchors.verticalCenter: parent.verticalCenter
                        color: SettingsTheme.text
                        selectionColor: SettingsTheme.accent
                        selectedTextColor: SettingsTheme.accentText
                        font.pixelSize: 13
                        clip: true
                        onTextChanged: win.query = text

                        Text {
                            visible: searchInput.text === ""
                            text: "Search settings"
                            color: SettingsTheme.muted
                            font.pixelSize: 13
                        }
                    }
                }

                Column {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: searchBox.bottom
                    anchors.margins: 16
                    anchors.topMargin: 14
                    spacing: 4

                    Repeater {
                        model: win.pages

                        delegate: Rectangle {
                            required property var modelData
                            readonly property bool selected: win.query.trim() === "" && win.currentPage === modelData.id

                            width: parent.width
                            height: 42
                            radius: 14
                            color: selected ? SettingsTheme.panelRaised : (navMouse.containsMouse ? SettingsTheme.panel : "transparent")

                            Rectangle {
                                id: iconBubble
                                anchors.left: parent.left
                                anchors.leftMargin: 8
                                anchors.verticalCenter: parent.verticalCenter
                                width: 28
                                height: 28
                                radius: 14
                                color: parent.selected ? SettingsTheme.accent : SettingsTheme.panelRaised

                                Text {
                                    anchors.centerIn: parent
                                    text: parent.parent.modelData.icon
                                    font.family: UserConfig.iconFontFamily
                                    font.pixelSize: 12
                                    color: parent.parent.selected ? SettingsTheme.accentText : SettingsTheme.muted
                                }
                            }
                            Text {
                                anchors.left: iconBubble.right
                                anchors.leftMargin: 12
                                anchors.verticalCenter: parent.verticalCenter
                                text: parent.modelData.label
                                font.pixelSize: 14
                                color: parent.modelData.ready ? SettingsTheme.text : SettingsTheme.muted
                            }
                            MouseArea {
                                id: navMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    searchInput.text = "";
                                    win.currentPage = parent.modelData.id;
                                }
                            }
                        }
                    }
                }
            }

            Rectangle {
                anchors.left: sidebar.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.topMargin: 16
                anchors.bottomMargin: 16
                width: 1
                color: SettingsTheme.border
            }

            // ---------- content ----------
            Item {
                id: content
                anchors.left: sidebar.right
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.margins: 24
                anchors.leftMargin: 28

                Text {
                    id: title
                    anchors.left: parent.left
                    anchors.top: parent.top
                    text: win.query.trim() !== "" ? "Search" : win.pageLabel(win.currentPage)
                    color: SettingsTheme.text
                    font.pixelSize: 24
                    font.weight: Font.DemiBold
                }

                Loader {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: title.bottom
                    anchors.topMargin: 18
                    anchors.bottom: parent.bottom
                    visible: win.query.trim() === ""
                    sourceComponent: win.pageComponent(win.currentPage)
                }

                // search results
                Column {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: title.bottom
                    anchors.topMargin: 18
                    spacing: 6
                    visible: win.query.trim() !== ""

                    Text {
                        visible: win.results.length === 0
                        text: "No settings match \u201c" + win.query.trim() + "\u201d"
                        color: SettingsTheme.muted
                        font.pixelSize: 14
                    }

                    Repeater {
                        model: win.results

                        delegate: Rectangle {
                            required property var modelData

                            width: parent.width
                            height: 46
                            radius: 14
                            color: resultMouse.containsMouse ? SettingsTheme.panelRaised : SettingsTheme.panel

                            Text {
                                anchors.left: parent.left
                                anchors.leftMargin: 16
                                anchors.verticalCenter: parent.verticalCenter
                                text: parent.modelData[0]
                                color: SettingsTheme.text
                                font.pixelSize: 14
                            }
                            Text {
                                anchors.right: parent.right
                                anchors.rightMargin: 16
                                anchors.verticalCenter: parent.verticalCenter
                                text: win.pageLabel(parent.modelData[1])
                                color: SettingsTheme.muted
                                font.pixelSize: 12
                            }
                            MouseArea {
                                id: resultMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    win.currentPage = parent.modelData[1];
                                    searchInput.text = "";
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Component {
        id: barPage
        SettingsPageBar {}
    }
    Component {
        id: clockPage
        SettingsPageClock {}
    }
    Component {
        id: appearancePage
        SettingsPageAppearance {}
    }
    Component {
        id: motionPage
        SettingsPageMotion {}
    }
    Component {
        id: soonPage
        SettingsPagePlaceholder {
            pageTitle: win.pageLabel(win.currentPage)
        }
    }
}
