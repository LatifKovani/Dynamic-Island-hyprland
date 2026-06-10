import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root

    signal closeRequested

    property bool showCondition: false
    property string iconFontFamily: ""
    property string textFontFamily: ""
    property bool appsLoaded: false

    property int highlightedIndex: -1

    focus: true
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
            highlightedIndex = -1;
            if (!appsLoaded)
                scanProcess.running = true;
            focusTimer.restart();
        }
    }

    Timer {
        id: focusTimer
        interval: 80
        repeat: false
        onTriggered: {
            root.forceActiveFocus();
            searchInputFocusTimer.restart();
        }
    }

    Timer {
        id: searchInputFocusTimer
        interval: 40
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
        highlightedIndex = -1;
        const q = query.toLowerCase().trim();
        let count = 0;
        for (let i = 0; i < allApps.count && count < 12; i++) {
            const a = allApps.get(i);
            if (!q || a.appName.toLowerCase().includes(q)) {
                shownApps.append({
                    appName: a.appName,
                    appExec: a.appExec,
                    appIcon: a.appIcon
                });
                count++;
            }
        }
    }

    function moveHighlight(delta) {
        if (shownApps.count === 0)
            return;
        let next = highlightedIndex + delta;
        if (next < 0)
            next = shownApps.count - 1;
        if (next >= shownApps.count)
            next = 0;
        highlightedIndex = next;
        resultsList.positionViewAtIndex(next, ListView.Contain);
    }

    Process {
        id: scanProcess
        command: ["python3", "-c", "import glob,os,configparser\n" + "def find_icon(name):\n" + "    if not name: return ''\n" + "    if os.path.isabs(name) and os.path.isfile(name): return name\n" + "    base=os.path.expanduser('~/.local/share/icons')\n" + "    themes=['MacTahoe','MacTahoe-dark','MacTahoe-light']\n" + "    cats=['apps/scalable','apps/32','apps/22','apps/16']\n" + "    exts=['.svg','.png','.xpm']\n" + "    for t in themes:\n" + "        for c in cats:\n" + "            for e in exts:\n" + "                p=os.path.join(base,t,c,name+e)\n" + "                if os.path.isfile(p): return p\n" + "    for b in ['/usr/share/icons/hicolor/scalable/apps','/usr/share/icons/hicolor/48x48/apps','/usr/share/pixmaps']:\n" + "        for e in exts:\n" + "            p=os.path.join(b,name+e)\n" + "            if os.path.isfile(p): return p\n" + "    return ''\n" + "apps=[]\n" + "paths=glob.glob('/usr/share/applications/*.desktop')\n" + "paths+=glob.glob(os.path.expanduser('~/.local/share/applications/*.desktop'))\n" + "paths+=glob.glob('/var/lib/flatpak/exports/share/applications/*.desktop')\n" + "paths+=glob.glob(os.path.expanduser('~/.local/share/flatpak/exports/share/applications/*.desktop'))\n" + "seen=set()\n" + "for f in paths:\n" + "    c=configparser.ConfigParser(strict=False,interpolation=None)\n" + "    try:\n" + "        c.read(f)\n" + "        if 'Desktop Entry' not in c: continue\n" + "        e=c['Desktop Entry']\n" + "        if e.get('Type')!='Application': continue\n" + "        if e.get('NoDisplay','false').lower()=='true': continue\n" + "        n=e.get('Name','')\n" + "        x=e.get('Exec','').split('%')[0].strip()\n" + "        i=e.get('Icon','')\n" + "        if n and x and n not in seen:\n" + "            seen.add(n)\n" + "            apps.append((n,x,find_icon(i)))\n" + "    except: pass\n" + "for n,x,i in sorted(apps,key=lambda a:a[0].lower()): print(n+'\\t'+x+'\\t'+i)\n"]
        stdout: SplitParser {
            onRead: data => {
                const parts = data.split('\t');
                if (parts.length >= 2) {
                    allApps.append({
                        appName: parts[0],
                        appExec: parts[1].trim(),
                        appIcon: parts.length >= 3 ? parts[2].trim() : ""
                    });
                }
            }
        }
        onExited: {
            root.appsLoaded = true;
            root.filterApps(searchInput.text);
        }
    }

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

    Keys.onPressed: event => {
        switch (event.key) {
        case Qt.Key_Down:
        case Qt.Key_Tab:
            moveHighlight(1);
            event.accepted = true;
            break;
        case Qt.Key_Up:
        case Qt.Key_Backtab:
            moveHighlight(-1);
            event.accepted = true;
            break;
        case Qt.Key_Return:
        case Qt.Key_Enter:
            if (highlightedIndex >= 0 && highlightedIndex < shownApps.count)
                root.launch(shownApps.get(highlightedIndex).appExec);
            else if (shownApps.count > 0)
                root.launch(shownApps.get(0).appExec);
            event.accepted = true;
            break;
        case Qt.Key_Escape:
            root.closeRequested();
            event.accepted = true;
            break;
        }
    }

    Column {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 8

        Column {
            width: parent.width
            spacing: 0

            Item {
                width: parent.width
                height: 34

                Text {
                    id: searchIcon
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    text: "\uf002"
                    font.family: root.iconFontFamily
                    font.pixelSize: 12
                    color: searchInput.activeFocus ? Qt.rgba(1, 1, 1, 0.55) : Qt.rgba(1, 1, 1, 0.28)
                    Behavior on color {
                        ColorAnimation {
                            duration: 120
                        }
                    }
                }

                Text {
                    anchors.left: searchIcon.right
                    anchors.leftMargin: 8
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Search apps…"
                    color: Qt.rgba(1, 1, 1, 0.28)
                    font.pixelSize: 13
                    font.family: root.textFontFamily
                    visible: searchInput.text === "" && !searchInput.activeFocus
                }

                TextInput {
                    id: searchInput
                    anchors.left: searchIcon.right
                    anchors.leftMargin: 8
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    verticalAlignment: TextInput.AlignVCenter
                    color: "white"
                    font.pixelSize: 13
                    font.family: root.textFontFamily
                    clip: true
                    onTextChanged: root.filterApps(text)
                }
            }

            Rectangle {
                width: parent.width
                height: 1
                color: Qt.rgba(1, 1, 1, 0.10)
            }
        }

        Item {
            width: parent.width
            height: parent.height - 34 - 1 - 8

            Text {
                anchors.centerIn: parent
                visible: !root.appsLoaded || shownApps.count === 0
                text: !root.appsLoaded ? "Scanning…" : "No results"
                color: Qt.rgba(1, 1, 1, 0.25)
                font.pixelSize: 12
                font.family: root.textFontFamily
            }

            ListView {
                id: resultsList
                anchors.fill: parent
                model: shownApps
                spacing: 2
                clip: true
                keyNavigationEnabled: false

                delegate: Rectangle {
                    width: ListView.view.width
                    height: 36
                    radius: 10
                    color: (index === root.highlightedIndex) ? Qt.rgba(1, 1, 1, 0.14) : "transparent"
                    Behavior on color {
                        ColorAnimation {
                            duration: 80
                        }
                    }

                    Row {
                        anchors.fill: parent
                        anchors.rightMargin: 8
                        spacing: 0

                        Rectangle {
                            width: 3
                            height: parent.height * 0.55
                            radius: 1.5
                            anchors.verticalCenter: parent.verticalCenter
                            color: "#60a5fa"
                            opacity: (index === root.highlightedIndex) ? 1 : 0
                            Behavior on opacity {
                                NumberAnimation {
                                    duration: 100
                                }
                            }
                        }

                        Item {
                            width: 7
                            height: 1
                        }

                        Item {
                            width: 22
                            height: parent.height

                            Image {
                                anchors.centerIn: parent
                                width: 20
                                height: 20
                                source: model.appIcon !== "" ? ("file://" + model.appIcon) : ""
                                visible: model.appIcon !== "" && status === Image.Ready
                                fillMode: Image.PreserveAspectFit
                                smooth: true
                                mipmap: true
                                sourceSize: Qt.size(40, 40)
                            }

                            Text {
                                anchors.centerIn: parent
                                visible: model.appIcon === "" || parent.children[0].status !== Image.Ready
                                text: "\uf11b"
                                font.family: root.iconFontFamily
                                font.pixelSize: 13
                                color: Qt.rgba(1, 1, 1, 0.30)
                            }
                        }

                        Item {
                            width: 8
                            height: 1
                        }

                        Text {
                            width: parent.width - 3 - 7 - 22 - 8
                            anchors.verticalCenter: parent.verticalCenter
                            text: model.appName
                            color: index === root.highlightedIndex ? "white" : Qt.rgba(1, 1, 1, 0.80)
                            font.pixelSize: 13
                            font.family: root.textFontFamily
                            font.weight: index === root.highlightedIndex ? Font.SemiBold : Font.Medium
                            elide: Text.ElideRight
                            Behavior on color {
                                ColorAnimation {
                                    duration: 80
                                }
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: root.launch(model.appExec)
                        onContainsMouseChanged: {
                            if (containsMouse)
                                root.highlightedIndex = index;
                        }
                    }
                }
            }
        }
    }
}
