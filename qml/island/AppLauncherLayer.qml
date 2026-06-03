import QtQuick
import Quickshell.Io

Item {
    id: root

    signal closeRequested

    property bool showCondition: false
    property string iconFontFamily: ""
    property string textFontFamily: ""
    property bool appsLoaded: false

    anchors.fill: parent
    opacity: showCondition ? 1 : 0

    Behavior on opacity {
        NumberAnimation {
            duration: showCondition ? 220 : 100
            easing.type: Easing.InOutQuad
        }
    }

    onShowConditionChanged: {
        if (showCondition) {
            searchInput.text = "";
            filterApps("");
            if (!appsLoaded)
                scanProcess.running = true;
            focusTimer.restart();
        }
    }

    // Delay focus slightly so the capsule animation doesn't swallow the event
    Timer {
        id: focusTimer
        interval: 80
        repeat: false
        onTriggered: searchInput.forceActiveFocus()
    }

    ListModel {
        id: allApps
    }
    ListModel {
        id: shownApps
    }

    function filterApps(query) {
        shownApps.clear();
        const q = query.toLowerCase().trim();
        let count = 0;
        for (let i = 0; i < allApps.count && count < 12; i++) {
            const a = allApps.get(i);
            if (!q || a.appName.toLowerCase().includes(q)) {
                shownApps.append({
                    appName: a.appName,
                    appExec: a.appExec
                });
                count++;
            }
        }
    }

    // ── Scan .desktop files via Python ────────────────────────────
    Process {
        id: scanProcess
        command: ["python3", "-c", "import glob,os,configparser\n" + "apps=[]\n" + "paths=glob.glob('/usr/share/applications/*.desktop')\n" + "paths+=glob.glob(os.path.expanduser('~/.local/share/applications/*.desktop'))\n" + "for f in paths:\n" + "    c=configparser.ConfigParser(strict=False,interpolation=None)\n" + "    try:\n" + "        c.read(f)\n" + "        if 'Desktop Entry' not in c: continue\n" + "        e=c['Desktop Entry']\n" + "        if e.get('Type')!='Application': continue\n" + "        if e.get('NoDisplay','false').lower()=='true': continue\n" + "        n=e.get('Name','')\n" + "        x=e.get('Exec','').split('%')[0].strip()\n" + "        if n and x: apps.append((n,x))\n" + "    except: pass\n" + "for n,x in sorted(apps,key=lambda a:a[0].lower()): print(n+'\\t'+x)\n"]
        stdout: SplitParser {
            onRead: data => {
                const tab = data.indexOf('\t');
                if (tab > 0) {
                    allApps.append({
                        appName: data.substring(0, tab),
                        appExec: data.substring(tab + 1).trim()
                    });
                }
            }
        }
        onExited: {
            root.appsLoaded = true;
            root.filterApps(searchInput.text);
        }
    }

    // ── Launch process ────────────────────────────────────────────
    Process {
        id: launcher
        property string execCmd: ""
        command: ["bash", "-c", "setsid " + launcher.execCmd + " </dev/null >/dev/null 2>&1 &"]
        onExited: running = false
    }

    function launch(execCmd) {
        launcher.execCmd = execCmd.trim();
        launcher.running = true;
        root.closeRequested();
    }

    // ── UI ────────────────────────────────────────────────────────
    Column {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 8

        // ── Search bar ────────────────────────────────────────────
        Row {
            width: parent.width
            height: 34
            spacing: 8

            // Refresh button
            Rectangle {
                width: 34
                height: 34
                radius: 17
                color: refreshMouse.pressed ? Qt.rgba(1, 1, 1, 0.16) : Qt.rgba(1, 1, 1, 0.07)
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }

                Text {
                    anchors.centerIn: parent
                    text: "\uf021"
                    font.family: root.iconFontFamily
                    font.pixelSize: 13
                    color: Qt.rgba(1, 1, 1, 0.55)
                }

                MouseArea {
                    id: refreshMouse
                    anchors.fill: parent
                    onClicked: {
                        allApps.clear();
                        shownApps.clear();
                        root.appsLoaded = false;
                        scanProcess.running = true;
                    }
                }
            }

            // Search input
            Rectangle {
                width: parent.width - 34 - 34 - 16
                height: 34
                radius: 17
                color: Qt.rgba(1, 1, 1, 0.09)

                Text {
                    anchors.fill: parent
                    anchors.leftMargin: 14
                    verticalAlignment: Text.AlignVCenter
                    text: "Search apps…"
                    color: Qt.rgba(1, 1, 1, 0.28)
                    font.pixelSize: 13
                    font.family: root.textFontFamily
                    visible: searchInput.text === "" && !searchInput.activeFocus
                }

                TextInput {
                    id: searchInput
                    anchors.fill: parent
                    anchors.leftMargin: 14
                    anchors.rightMargin: 14
                    verticalAlignment: TextInput.AlignVCenter
                    color: "white"
                    font.pixelSize: 13
                    font.family: root.textFontFamily
                    clip: true

                    onTextChanged: root.filterApps(text)

                    Keys.onReturnPressed: {
                        if (shownApps.count > 0)
                            root.launch(shownApps.get(0).appExec);
                    }
                    Keys.onEscapePressed: root.closeRequested()
                }
            }

            // Close button
            Rectangle {
                width: 34
                height: 34
                radius: 17
                color: xMouse.pressed ? "#9e2020" : "#c03535"
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }

                Text {
                    anchors.centerIn: parent
                    text: "×"
                    color: "white"
                    font.pixelSize: 20
                    font.family: root.textFontFamily
                }

                MouseArea {
                    id: xMouse
                    anchors.fill: parent
                    onClicked: root.closeRequested()
                }
            }
        }

        // ── Results list ──────────────────────────────────────────
        Item {
            width: parent.width
            height: parent.height - 34 - 8

            // Empty / loading state
            Text {
                anchors.centerIn: parent
                visible: !root.appsLoaded || shownApps.count === 0
                text: !root.appsLoaded ? "Scanning…" : "No results"
                color: Qt.rgba(1, 1, 1, 0.25)
                font.pixelSize: 12
                font.family: root.textFontFamily
            }

            ListView {
                anchors.fill: parent
                model: shownApps
                spacing: 2
                clip: true

                delegate: Rectangle {
                    width: ListView.view.width
                    height: 36
                    radius: 10
                    color: rowMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.10) : rowMouse.pressed ? Qt.rgba(1, 1, 1, 0.15) : "transparent"
                    Behavior on color {
                        ColorAnimation {
                            duration: 80
                        }
                    }

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 12
                        text: model.appName
                        color: "white"
                        font.pixelSize: 13
                        font.family: root.textFontFamily
                        font.weight: Font.Medium
                    }

                    MouseArea {
                        id: rowMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: root.launch(model.appExec)
                    }
                }
            }
        }
    }
}
