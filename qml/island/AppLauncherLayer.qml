import QtQuick
import Quickshell.Io

Item {
    id: root

    signal closeRequested

    property bool showCondition: false
    property string iconFontFamily: ""
    property string textFontFamily: ""
    property bool appsLoaded: false

    // Currently keyboard-highlighted row index (-1 = none)
    property int highlightedIndex: -1

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
            // Fix 1: use forceActiveFocus on the Item, not just the TextInput,
            // so the FocusScope chain is satisfied before we drill into the input.
            focusTimer.restart();
        }
    }

    // Fix 1: two-step focus — first grab the Item's focus scope, then the input.
    Timer {
        id: focusTimer
        interval: 60
        repeat: false
        onTriggered: {
            root.forceActiveFocus();
            searchInputFocusTimer.restart();
        }
    }
    Timer {
        id: searchInputFocusTimer
        interval: 30
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

    // Fix 2: clamp highlight index within current list
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

    // ── Scan .desktop files via Python — now also reads Icon= field ──────
    Process {
        id: scanProcess
        // Fix 3: extended Python that resolves icon names → absolute paths
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

    // ── Key handler at Item level so it works regardless of which
    //    child has focus (Fix 2 lives here too) ────────────────────
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

                    // Return/Escape are handled by the parent Item's Keys.onPressed
                    // (they bubble up because TextInput only consumes keys it acts on)
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
                // Fix 2: allow keyboard scroll without mouse grab
                keyNavigationEnabled: false

                delegate: Rectangle {
                    width: ListView.view.width
                    height: 36
                    radius: 10
                    // Fix 2: highlighted row gets a distinct tint
                    color: (index === root.highlightedIndex) ? Qt.rgba(1, 1, 1, 0.18) : rowMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.10) : "transparent"
                    Behavior on color {
                        ColorAnimation {
                            duration: 80
                        }
                    }

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: 8
                        anchors.rightMargin: 8
                        spacing: 8

                        // Fix 3: app icon (shown when resolved path is non-empty)
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

                            // Fallback generic icon when no image resolved
                            Text {
                                anchors.centerIn: parent
                                visible: model.appIcon === "" || parent.children[0].status !== Image.Ready
                                text: "\uf11b"   // fa-gamepad as neutral fallback
                                font.family: root.iconFontFamily
                                font.pixelSize: 13
                                color: Qt.rgba(1, 1, 1, 0.30)
                            }
                        }

                        Text {
                            width: parent.width - 22 - 8
                            anchors.verticalCenter: parent.verticalCenter
                            text: model.appName
                            color: "white"
                            font.pixelSize: 13
                            font.family: root.textFontFamily
                            font.weight: Font.Medium
                            elide: Text.ElideRight
                        }
                    }

                    MouseArea {
                        id: rowMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: root.launch(model.appExec)
                        // Fix 2: hovering a row with the mouse syncs the highlight
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
