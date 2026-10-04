import QtQuick

// Reorderable list of sections. Each row has up / down buttons and an on/off switch.
// sections: [{id, label, description}]   order / hidden: arrays of ids
Item {
    id: root

    property var sections: []
    property var order: []
    property var hidden: []
    property bool last: false
    signal orderEdited(var order)
    signal hiddenEdited(var hidden)

    // saved order, repaired so every known section appears exactly once
    readonly property var fullOrder: {
        const ids = sections.map(s => s.id);
        const out = [];
        const saved = order ? order : [];
        for (let i = 0; i < saved.length; i++)
            if (ids.indexOf(saved[i]) !== -1 && out.indexOf(saved[i]) === -1)
                out.push(saved[i]);
        for (let j = 0; j < ids.length; j++)
            if (out.indexOf(ids[j]) === -1)
                out.push(ids[j]);
        return out;
    }

    function info(id) {
        for (let i = 0; i < sections.length; i++)
            if (sections[i].id === id)
                return sections[i];
        return {
            id: id,
            label: id,
            description: ""
        };
    }

    function move(index, delta) {
        const target = index + delta;
        if (target < 0 || target >= fullOrder.length)
            return;
        const next = fullOrder.slice();
        const tmp = next[index];
        next[index] = next[target];
        next[target] = tmp;
        root.orderEdited(next);
    }

    function setShown(id, shown) {
        const next = (hidden ? hidden : []).filter(h => h !== id);
        if (!shown)
            next.push(id);
        root.hiddenEdited(next);
    }

    width: parent ? parent.width : 400
    height: fullOrder.length * 64

    Column {
        width: parent.width

        Repeater {
            model: root.fullOrder

            delegate: Item {
                id: row
                required property var modelData
                required property int index
                readonly property var meta: root.info(modelData)
                readonly property bool shown: !root.hidden || root.hidden.indexOf(modelData) === -1

                width: parent.width
                height: 64

                Row {
                    id: arrows
                    anchors.left: parent.left
                    anchors.leftMargin: 18
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 4

                    Repeater {
                        model: [
                            {
                                glyph: "\u2191",
                                delta: -1
                            },
                            {
                                glyph: "\u2193",
                                delta: 1
                            }
                        ]

                        delegate: Rectangle {
                            required property var modelData
                            readonly property bool usable: row.index + modelData.delta >= 0 && row.index + modelData.delta < root.fullOrder.length

                            width: 28
                            height: 28
                            radius: 9
                            color: arrowMouse.containsMouse && usable ? SettingsTheme.track : SettingsTheme.panelRaised
                            opacity: usable ? 1 : 0.35

                            Text {
                                anchors.centerIn: parent
                                text: parent.modelData.glyph
                                color: SettingsTheme.text
                                font.pixelSize: 14
                            }
                            MouseArea {
                                id: arrowMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                enabled: parent.usable
                                cursorShape: Qt.PointingHandCursor
                                onClicked: root.move(row.index, parent.modelData.delta)
                            }
                        }
                    }
                }

                Column {
                    anchors.left: arrows.right
                    anchors.leftMargin: 16
                    anchors.right: toggle.left
                    anchors.rightMargin: 16
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 2
                    opacity: row.shown ? 1 : 0.5

                    Text {
                        width: parent.width
                        text: row.meta.label
                        color: SettingsTheme.text
                        font.pixelSize: 14
                        elide: Text.ElideRight
                    }
                    Text {
                        width: parent.width
                        visible: text !== ""
                        text: row.meta.description
                        color: SettingsTheme.muted
                        font.pixelSize: 12
                        wrapMode: Text.WordWrap
                    }
                }

                SettingsSwitch {
                    id: toggle
                    anchors.right: parent.right
                    anchors.rightMargin: 18
                    anchors.verticalCenter: parent.verticalCenter
                    checked: row.shown
                    onToggled: v => root.setShown(row.modelData, v)
                }

                Rectangle {
                    visible: !(row.index === root.fullOrder.length - 1 && root.last)
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.leftMargin: 18
                    anchors.right: parent.right
                    height: 1
                    color: SettingsTheme.border
                }
            }
        }
    }
}
