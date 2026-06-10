//-- FIX:: Icon themes for apps, are not getting the actual icon theme which i use macos tahoe but using the default of arch. Fix to use macos theme icon, maybe with absolute path or smth.
//
import QtQuick
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

    // Step 1 — claim focus at Item level
    Timer {
        id: focusTimer
        interval: 80
        repeat: false
        onTriggered: {
            root.forceActiveFocus();
            searchInputFocusTimer.restart();
        }
    }

    // Step 2 — push focus into the TextInput once compositor has granted it
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

    // ── Scan .desktop files via Python ────────────────────────────
    Process {
        id: scanProcess
        command: ["python3", "-c", "import glob,os,configparser\n" + "def find_icon(name):\n" + "    if not name: return ''\n" + "    if os.path.isabs(name) and os.path.isfile(name): return name\n" + "    themes=['hicolor','Papirus','Adwaita','breeze','gnome']\n" + "    sizes=['48x48','32x32','64x64','scalable','22x22','24x24']\n" + "    exts=['.png','.svg','.xpm']\n" + "    bases=['/usr/share/icons',os.path.expanduser('~/.local/share/icons'),'/usr/local/share/icons']\n" + "    for b in bases:\n" + "        for t in themes:\n" + "            for s in sizes:\n" + "                for e in exts:\n" + "                    p=os.path.join(b,t,s,'apps',name+e)\n" + "                    if os.path.isfile(p): return p\n" + "    for b in ['/usr/share/pixmaps','/usr/local/share/pixmaps']:\n" + "        for e in exts:\n" + "            p=os.path.join(b,name+e)\n" + "            if os.path.isfile(p): return p\n" + "    return ''\n" + "apps=[]\n" + "paths=glob.glob('/usr/share/applications/*.desktop')\n" + "paths+=glob.glob(os.path.expanduser('~/.local/share/applications/*.desktop'))\n" + "for f in paths:\n" + "    c=configparser.ConfigParser(strict=False,interpolation=None)\n" + "    try:\n" + "        c.read(f)\n" + "        if 'Desktop Entry' not in c: continue\n" + "        e=c['Desktop Entry']\n" + "        if e.get('Type')!='Application': continue\n" + "        if e.get('NoDisplay','false').lower()=='true': continue\n" + "        n=e.get('Name','')\n" + "        x=e.get('Exec','').split('%')[0].strip()\n" + "        i=e.get('Icon','')\n" + "        if n and x: apps.append((n,x,find_icon(i)))\n" + "    except: pass\n" + "for n,x,i in sorted(apps,key=lambda a:a[0].lower()): print(n+'\\t'+x+'\\t'+i)\n"]
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

    // ── Key handler ───────────────────────────────────────────────
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
            if (highlightedIndex >= 0 && highlightedIndex < shownApps.count) {
                root.launch(shownApps.get(highlightedIndex).appExec);
            } else if (shownApps.count > 0) {
                root.launch(shownApps.get(0).appExec);
            }
            event.accepted = true;
            break;
        case Qt.Key_Escape:
            root.closeRequested();
            event.accepted = true;
            break;
        }
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

            // Search input — takes all remaining width
            Rectangle {
                width: parent.width - 34 - 34 - 16
                height: 34
                radius: 17
                color: Qt.rgba(1, 1, 1, 0.09)

                // Search icon inside the field
                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.verticalCenter: parent.verticalCenter
                    text: "\uf002"   // fa-search
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
                    anchors.fill: parent
                    anchors.leftMargin: 30
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
                    anchors.leftMargin: 30
                    anchors.rightMargin: 14
                    verticalAlignment: TextInput.AlignVCenter
                    color: "white"
                    font.pixelSize: 13
                    font.family: root.textFontFamily
                    clip: true

                    onTextChanged: root.filterApps(text)
                }
            }

            // Refresh button — subtle, matches close style
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
                    text: "\uf021"   // fa-refresh
                    font.family: root.iconFontFamily
                    font.pixelSize: 13
                    color: Qt.rgba(1, 1, 1, 0.50)

                    RotationAnimator {
                        id: refreshSpin
                        target: parent
                        from: 0
                        to: 360
                        duration: 500
                        running: false
                    }
                }

                MouseArea {
                    id: refreshMouse
                    anchors.fill: parent
                    onClicked: {
                        refreshSpin.running = true;
                        allApps.clear();
                        shownApps.clear();
                        root.appsLoaded = false;
                        scanProcess.running = true;
                    }
                }
            }

            // Close button — same style as refresh, no red
            Rectangle {
                width: 34
                height: 34
                radius: 17
                color: closeMouse.pressed ? Qt.rgba(1, 1, 1, 0.16) : Qt.rgba(1, 1, 1, 0.07)
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }

                Text {
                    anchors.centerIn: parent
                    text: "\uf00d"   // fa-times
                    font.family: root.iconFontFamily
                    font.pixelSize: 13
                    color: Qt.rgba(1, 1, 1, 0.50)
                }

                MouseArea {
                    id: closeMouse
                    anchors.fill: parent
                    onClicked: root.closeRequested()
                }
            }
        }

        // ── Results list ──────────────────────────────────────────
        Item {
            width: parent.width
            height: parent.height - 34 - 8

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
                        anchors.leftMargin: 0
                        anchors.rightMargin: 8
                        spacing: 0

                        // ── Active indicator bar ──────────────────
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

                        // Gap after bar
                        Item {
                            width: 7
                            height: 1
                        }

                        // App icon
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

                        // Gap between icon and name
                        Item {
                            width: 8
                            height: 1
                        }

                        // App name
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
                        id: rowMouse
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
