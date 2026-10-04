import QtQuick

// A scaled-down sketch of the control center, drawn from the same order / hidden lists
// the real panel uses. Block heights match the real ones (closed drawer).
Item {
    id: root

    property var order: []
    property var hidden: []
    property bool showHeader: true

    readonly property var known: ["connectivity", "drawer", "display", "sound", "notifications"]
    readonly property real previewScale: 0.62
    readonly property real gap: 12

    readonly property var visibleSections: {
        const out = [];
        const saved = order ? order.slice() : [];
        for (let i = 0; i < known.length; i++)
            if (saved.indexOf(known[i]) === -1)
                saved.push(known[i]);
        for (let j = 0; j < saved.length; j++) {
            const id = saved[j];
            if (known.indexOf(id) === -1 || out.indexOf(id) !== -1)
                continue;
            if (hidden && hidden.indexOf(id) !== -1)
                continue;
            out.push(id);
        }
        return out;
    }
    readonly property bool headerOn: showHeader || visibleSections.length === 0

    function heightOf(id) {
        return id === "connectivity" ? 80 : (id === "drawer" ? 20 : (id === "notifications" ? 200 : 76));
    }
    function labelOf(id) {
        switch (id) {
        case "connectivity":
            return "Wi-Fi  \u00b7  Bluetooth";
        case "drawer":
            return "Drawer";
        case "display":
            return "Display";
        case "sound":
            return "Sound";
        case "notifications":
            return "Notifications";
        }
        return id;
    }

    width: parent ? parent.width : 400
    height: col.height + 44

    Rectangle {
        id: frame
        anchors.horizontalCenter: parent.horizontalCenter
        y: 12
        width: 420 * root.previewScale
        height: col.height + 20
        radius: 22 * root.previewScale + 6
        color: "#000000"
        border.width: 1
        border.color: SettingsTheme.border

        Column {
            id: col
            x: 10
            y: 10
            width: parent.width - 20
            spacing: root.gap * root.previewScale

            Rectangle {
                visible: root.headerOn
                width: parent.width
                height: 28 * root.previewScale
                radius: 6
                color: SettingsTheme.panelRaised

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Clock  \u00b7  Battery"
                    color: SettingsTheme.muted
                    font.pixelSize: 10
                }
            }

            Repeater {
                model: root.visibleSections

                delegate: Rectangle {
                    required property var modelData

                    width: parent.width
                    height: root.heightOf(modelData) * root.previewScale
                    radius: modelData === "drawer" ? height / 2 : 9
                    color: modelData === "drawer" ? SettingsTheme.track : SettingsTheme.panelRaised

                    Text {
                        anchors.centerIn: parent
                        visible: modelData !== "drawer"
                        text: root.labelOf(modelData)
                        color: SettingsTheme.text
                        font.pixelSize: 11
                    }
                }
            }
        }
    }
}
