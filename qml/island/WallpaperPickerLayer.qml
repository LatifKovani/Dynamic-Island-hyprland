import QtQuick
import Quickshell.Io

Item {
    id: root

    signal closeRequested

    property bool showCondition: false
    property string iconFontFamily: ""
    property string textFontFamily: ""

    property string wallpaperDir: {
        const home = Qt.resolvedUrl("~").toString().replace("file://", "");
        return home + "/Pictures/Wallpapers";
    }

    property int transitionFps: 60
    property int transitionStep: 5

    property bool wallpapersLoaded: false
    property string activeWallpaper: ""
    property int highlightedIndex: -1
    property int selectedTransitionIndex: 0

    readonly property var transitionTypes: ["center", "simple", "left", "right", "top", "bottom", "any", "random"]

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
            filterWallpapers("");
            highlightedIndex = -1;
            if (!wallpapersLoaded)
                scanProcess.running = true;
            focusTimer.restart();
        }
    }

    Timer {
        id: focusTimer
        interval: 80
        repeat: false
        onTriggered: root.forceActiveFocus()
    }

    Keys.onPressed: event => {
        switch (event.key) {
        case Qt.Key_Escape:
            root.closeRequested();
            event.accepted = true;
            break;
        case Qt.Key_Right:
        case Qt.Key_Tab:
            moveHighlight(1);
            event.accepted = true;
            break;
        case Qt.Key_Left:
        case Qt.Key_Backtab:
            moveHighlight(-1);
            event.accepted = true;
            break;
        case Qt.Key_Down:
            moveHighlight(gridColumns);
            event.accepted = true;
            break;
        case Qt.Key_Up:
            moveHighlight(-gridColumns);
            event.accepted = true;
            break;
        case Qt.Key_Return:
        case Qt.Key_Enter:
            if (highlightedIndex >= 0 && highlightedIndex < shownWallpapers.count)
                root.applyWallpaper(shownWallpapers.get(highlightedIndex).filePath);
            else if (shownWallpapers.count > 0)
                root.applyWallpaper(shownWallpapers.get(0).filePath);
            event.accepted = true;
            break;
        }
    }

    ListModel {
        id: allWallpapers
    }
    ListModel {
        id: shownWallpapers
    }

    function filterWallpapers(query) {
        shownWallpapers.clear();
        highlightedIndex = -1;
        const q = query.toLowerCase().trim();
        for (let i = 0; i < allWallpapers.count; i++) {
            const w = allWallpapers.get(i);
            if (!q || w.fileName.toLowerCase().includes(q))
                shownWallpapers.append({
                    filePath: w.filePath,
                    fileName: w.fileName
                });
        }
    }

    function applyWallpaper(filePath) {
        applyProcess.wallpaperPath = filePath;
        applyProcess.transitionType = transitionTypes[selectedTransitionIndex];
        applyProcess.running = true;
        root.activeWallpaper = filePath;
        root.closeRequested();
    }

    function moveHighlight(delta) {
        if (shownWallpapers.count === 0)
            return;
        let next = highlightedIndex + delta;
        if (next < 0)
            next = shownWallpapers.count - 1;
        if (next >= shownWallpapers.count)
            next = 0;
        highlightedIndex = next;
        wallpaperGrid.positionViewAtIndex(next, GridView.Contain);
    }

    Process {
        id: scanProcess
        command: ["python3", "-c", "import os, sys\n" + "exts = {'.jpg','.jpeg','.png','.webp','.gif','.avif','.tiff','.bmp'}\n" + "d = os.path.expanduser('~/Pictures/Wallpapers')\n" + "if not os.path.isdir(d):\n" + "    sys.exit(0)\n" + "files = []\n" + "for f in sorted(os.listdir(d)):\n" + "    if os.path.splitext(f)[1].lower() in exts:\n" + "        files.append(os.path.join(d, f) + '\\t' + f)\n" + "for line in files:\n" + "    print(line)\n"]
        stdout: SplitParser {
            onRead: data => {
                const parts = data.split('\t');
                if (parts.length >= 2)
                    allWallpapers.append({
                        filePath: parts[0].trim(),
                        fileName: parts[1].trim()
                    });
            }
        }
        onExited: {
            root.wallpapersLoaded = true;
            root.filterWallpapers("");
        }
    }

    Process {
        id: applyProcess
        property string wallpaperPath: ""
        property string transitionType: "center"
        command: ["bash", "-c", "awww img '" + wallpaperPath.replace(/'/g, "'\\''") + "'" + " --transition-type " + transitionType + " --transition-step " + root.transitionStep + " --transition-fps " + root.transitionFps + " 2>/dev/null || true"]
        onExited: running = false
    }

    readonly property int gridColumns: 3
    readonly property real thumbSize: (width - 24 - (gridColumns + 1) * 6) / gridColumns

    // ── UI ────────────────────────────────────────────────────────────────────
    Column {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 8

        // ── Top bar ───────────────────────────────────────────────────────────
        Item {
            width: parent.width
            height: 36

            Text {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: "Wallpapers"
                color: "white"
                font.pixelSize: 14
                font.family: root.textFontFamily
                font.weight: Font.DemiBold
                opacity: 0.85
            }

            Rectangle {
                id: transitionPill
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                width: transitionLabel.implicitWidth + 20
                height: 28
                radius: 14
                color: transitionMouse.pressed ? Qt.rgba(1, 1, 1, 0.14) : transitionMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.08) : "transparent"
                Behavior on color {
                    ColorAnimation {
                        duration: 120
                    }
                }

                Text {
                    id: transitionLabel
                    anchors.centerIn: parent
                    text: root.transitionTypes[root.selectedTransitionIndex]
                    color: transitionMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.9) : Qt.rgba(1, 1, 1, 0.5)
                    font.pixelSize: 11
                    font.family: root.textFontFamily
                    font.weight: Font.Medium
                    Behavior on color {
                        ColorAnimation {
                            duration: 120
                        }
                    }
                }

                MouseArea {
                    id: transitionMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: root.selectedTransitionIndex = (root.selectedTransitionIndex + 1) % root.transitionTypes.length
                }
            }
        }

        // ── Wallpaper grid ────────────────────────────────────────────────────
        Item {
            width: parent.width
            height: parent.height - 36 - 8

            Text {
                anchors.centerIn: parent
                visible: !root.wallpapersLoaded || shownWallpapers.count === 0
                text: !root.wallpapersLoaded ? "Scanning…" : "No wallpapers found\nin ~/Pictures/Wallpapers"
                horizontalAlignment: Text.AlignHCenter
                color: Qt.rgba(1, 1, 1, 0.25)
                font.pixelSize: 12
                font.family: root.textFontFamily
                lineHeight: 1.5
            }

            GridView {
                id: wallpaperGrid
                anchors.fill: parent
                model: shownWallpapers
                cellWidth: root.thumbSize + 6
                cellHeight: root.thumbSize * 0.5625 + 6
                clip: true

                delegate: Item {
                    width: wallpaperGrid.cellWidth
                    height: wallpaperGrid.cellHeight

                    readonly property bool isHighlighted: index === root.highlightedIndex
                    readonly property bool isCurrent: model.filePath === root.activeWallpaper

                    Rectangle {
                        id: thumbContainer
                        width: root.thumbSize
                        height: root.thumbSize * 0.5625
                        radius: 8
                        color: "#1a1a1a"
                        clip: true

                        border.width: isCurrent ? 2 : (isHighlighted ? 1.5 : 0)
                        border.color: isCurrent ? "#60a5fa" : Qt.rgba(1, 1, 1, 0.5)
                        Behavior on border.color {
                            ColorAnimation {
                                duration: 80
                            }
                        }
                        Behavior on border.width {
                            NumberAnimation {
                                duration: 80
                            }
                        }

                        Image {
                            anchors.fill: parent
                            anchors.margins: isCurrent ? 2 : (isHighlighted ? 1.5 : 0)
                            source: "file://" + model.filePath
                            fillMode: Image.PreserveAspectCrop
                            asynchronous: true
                            cache: true
                            smooth: true
                            mipmap: true
                            sourceSize: Qt.size(root.thumbSize * 2, root.thumbSize * 1.125)
                            Behavior on anchors.margins {
                                NumberAnimation {
                                    duration: 80
                                }
                            }

                            Rectangle {
                                anchors.fill: parent
                                color: "#1a1a1a"
                                opacity: parent.status === Image.Ready ? 0 : 1
                                Behavior on opacity {
                                    NumberAnimation {
                                        duration: 150
                                    }
                                }
                            }
                        }

                        Rectangle {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            height: 22
                            radius: 6
                            color: Qt.rgba(0, 0, 0, 0.55)
                            visible: thumbMouse.containsMouse || isHighlighted

                            Text {
                                anchors.fill: parent
                                anchors.leftMargin: 6
                                anchors.rightMargin: 6
                                verticalAlignment: Text.AlignVCenter
                                text: model.fileName
                                color: "white"
                                font.pixelSize: 9
                                font.family: root.textFontFamily
                                elide: Text.ElideMiddle
                            }
                        }

                        Rectangle {
                            anchors.top: parent.top
                            anchors.right: parent.right
                            anchors.margins: 5
                            width: 16
                            height: 16
                            radius: 8
                            color: "#60a5fa"
                            visible: isCurrent

                            Text {
                                anchors.centerIn: parent
                                text: "\uf00c"
                                font.family: root.iconFontFamily
                                font.pixelSize: 8
                                color: "white"
                            }
                        }

                        MouseArea {
                            id: thumbMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: root.applyWallpaper(model.filePath)
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
}
