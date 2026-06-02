import QtQuick
import Quickshell
import IslandBackend

Item {
    id: root

    readonly property var userConfig: UserConfig

    property var items: []
    property var cavaLevels: []
    property string timeText: ""
    property var configSource: null
    readonly property var activeConfig: configSource || userConfig
    property string iconFontFamily: activeConfig.iconFontFamily
    property string textFontFamily: activeConfig.textFontFamily
    property string timeFontFamily: activeConfig.timeFontFamily
    property bool showCondition: false
    property bool showSecondaryText: true
    property bool recordingActive: false
    property real transitionProgress: 0
    property real minimumWidth: 220
    property real maximumWidth: minimumWidth
    property real horizontalPadding: 14
    property real hiddenLeftPadding: 18
    property real hiddenRightPadding: 18
    property real groupSpacing: 20
    property real iconSpacing: 2
    property int textPixelSize: 13
    property int iconPixelSize: 16
    property int iconBoxSize: 18
    property int batteryIconWidth: 40
    property int batteryIconHeight: 15
    property int batteryTipWidth: 3
    property int batteryTipHeight: 7
    property int batteryOuterRadius: 4
    property int batteryInnerRadius: 3
    property real iconVerticalOffset: 1
    property int recordingDotSpacing: 12
    readonly property string chargingIconGlyph: "\uf0e7"

    readonly property real clampedProgress: Math.max(0, Math.min(1, -transitionProgress))
    readonly property real textWidth: Math.max(0, width - horizontalPadding * 2)
    readonly property real centeredTimeX: horizontalPadding
    readonly property real centeredItemsX: Math.max(horizontalPadding, (width - contentRow.implicitWidth) / 2)
    readonly property real timeHiddenLeftX: -textWidth - hiddenLeftPadding
    readonly property real itemsHiddenRightX: width + hiddenRightPadding
    readonly property real timeExitDistance: Math.max(0, centeredTimeX - timeHiddenLeftX)
    readonly property real itemsEntryDistance: Math.max(0, itemsHiddenRightX - centeredItemsX)
    readonly property real dragDistance: Math.max(timeExitDistance, itemsEntryDistance)
    readonly property real itemsX: centeredItemsX + (1 - clampedProgress) * dragDistance
    readonly property real timeX: centeredTimeX - clampedProgress * dragDistance
    readonly property real visibleTimeWidth: Math.min(textWidth, Math.max(0, timeMetrics.advanceWidth))
    readonly property real timeRecordingDotX: Math.max(4, timeX + (textWidth - visibleTimeWidth) / 2 - recordingDotSpacing - timeRecordingIndicator.width)
    readonly property real preferredWidth: Math.max(minimumWidth, contentRow.implicitWidth + horizontalPadding * 2)

    anchors.fill: parent
    clip: true
    opacity: showCondition ? 1 : 0

    Behavior on opacity {
        NumberAnimation {
            duration: showCondition ? 220 : 140
            easing.type: Easing.InOutQuad
        }
    }

    TextMetrics {
        id: timeMetrics
        font.family: timeFontFamily
        font.pixelSize: root.textPixelSize + 1
        font.weight: Font.Bold
        text: timeText
    }

    Row {
        id: contentRow
        x: itemsX
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        opacity: clampedProgress
        spacing: groupSpacing

        Repeater {
            model: root.items

            delegate: Item {
                readonly property bool hasIcon: modelData.icon !== undefined && modelData.icon !== ""
                readonly property bool isCava: modelData.kind === "cava"
                readonly property bool isBattery: modelData.kind === "battery"
                // "theme" = system icon via Quickshell.iconPath (Image)
                // "glyph" = Nerd Font character (Text)
                readonly property bool isThemeIcon: hasIcon && modelData.iconKind === "theme"
                readonly property bool isGlyphIcon: hasIcon && modelData.iconKind !== "theme"
                readonly property bool hasLeadingVisual: hasIcon || isBattery
                implicitWidth: isCava ? cavaBars.implicitWidth : isBattery ? (root.batteryIconWidth + (modelData.isCharging ? 0 : 0)) : leadingVisual.width + (hasLeadingVisual ? root.iconSpacing : 0) + valueText.implicitWidth
                implicitHeight: root.height
                width: implicitWidth
                height: implicitHeight

                SwipeCavaBars {
                    id: cavaBars
                    visible: parent.isCava
                    anchors.centerIn: parent
                    levels: root.cavaLevels
                }

                Item {
                    id: leadingVisual
                    visible: !parent.isCava && parent.hasLeadingVisual
                    width: parent.isBattery ? root.batteryIconWidth : (parent.hasIcon ? root.iconBoxSize : 0)
                    height: parent.isBattery ? Math.max(root.batteryIconHeight, valueText.implicitHeight) : root.iconBoxSize
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.verticalCenter: parent.verticalCenter

                    // System theme icon
                    Image {
                        anchors.centerIn: parent
                        visible: parent.parent.isThemeIcon && !parent.parent.isBattery
                        width: root.iconBoxSize
                        height: root.iconBoxSize
                        source: (parent.parent.isThemeIcon && modelData.icon) ? Quickshell.iconPath(modelData.icon, true) : ""
                        fillMode: Image.PreserveAspectFit
                        smooth: true
                    }

                    // Nerd Font glyph icon
                    Text {
                        anchors.centerIn: parent
                        visible: parent.parent.isGlyphIcon && !parent.parent.isBattery
                        text: parent.parent.isGlyphIcon ? (modelData.icon || "") : ""
                        color: {
                            const id = modelData.id || "";
                            if (id === "cpu" || id === "ram") {
                                const txt = modelData.text || "";
                                let level = -1;
                                if (txt.endsWith("%")) {
                                    level = parseFloat(txt) / 100.0;
                                } else if (txt.indexOf("/") !== -1) {
                                    const slash = txt.indexOf("/");
                                    const used = parseFloat(txt.substring(0, slash));
                                    const total = parseFloat(txt.substring(slash + 1));
                                    if (total > 0)
                                        level = used / total;
                                }
                                if (level >= 0.70)
                                    return "#ff453a";
                                if (level >= 0.50)
                                    return "#ff9f0a";
                                if (level >= 0.30)
                                    return "#ffd60a";
                            }
                            return "white";
                        }
                    }

                    // ── macOS Tahoe battery shape ──────────────────────────────────
                    Item {
                        id: batteryShape
                        visible: parent.parent.isBattery
                        width: root.batteryIconWidth
                        height: root.batteryIconHeight
                        anchors.verticalCenter: parent.verticalCenter

                        readonly property real level: Math.max(0, Math.min(100, Number(modelData.level || 0)))
                        readonly property bool charging: modelData.isCharging || false
                        readonly property color fillColor: {
                            if (level <= 5)
                                return "#ff3b30";
                            if (level <= 25)
                                return "#ff3b30";
                            return "white";
                        }
                        // Outer body
                        Rectangle {
                            id: batteryBody
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width - root.batteryTipWidth - 1
                            height: parent.height
                            radius: root.batteryOuterRadius
                            color: Qt.rgba(1, 1, 1, 0.68)
                            border.color: Qt.rgba(1, 1, 1, 0.55)
                            border.width: 1.2

                            // Fill
                            Rectangle {
                                id: batteryFill
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.margins: 2
                                radius: root.batteryInnerRadius
                                width: Math.max(0, (parent.width - 4) * (batteryShape.level / 100.0))
                                color: batteryShape.fillColor

                                Behavior on width {
                                    NumberAnimation {
                                        duration: 300
                                        easing.type: Easing.OutCubic
                                    }
                                }
                            }

                            // Lightning bolt INSIDE battery (only when charging)
                            Text {
                                visible: batteryShape.charging
                                anchors.centerIn: parent
                                text: "\uf0e7"
                                color: {
                                    // Contrast: dark bolt on light fill, white bolt on dark/empty
                                    const lvl = batteryShape.level;
                                    return (lvl > 25) ? "#1a1a1a" : "white";
                                }
                                font.pixelSize: root.batteryIconHeight - 5
                                font.family: root.iconFontFamily
                                font.weight: Font.Bold
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                z: 2
                            }
                            // Percentage INSIDE battery (only when discharging)
                            Text {
                                visible: !batteryShape.charging
                                anchors.centerIn: parent
                                text: batteryShape.level + "%"
                                color: batteryShape.level > 25 ? "#1a1a1a" : "white"
                                font.pixelSize: root.batteryIconHeight - 5
                                font.family: root.textFontFamily
                                font.weight: Font.Bold
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                z: 2
                            }
                        }

                        // Tip nub
                        Rectangle {
                            width: root.batteryTipWidth
                            height: root.batteryTipHeight
                            radius: Math.round(root.batteryTipWidth / 2)
                            color: Qt.rgba(1, 1, 1, 0.55)
                            anchors.left: batteryBody.right
                            anchors.leftMargin: 1
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
                // REPLACE WITH:
                Text {
                    id: valueText
                    visible: !parent.isCava && !parent.isBattery
                    anchors.left: leadingVisual.right
                    anchors.leftMargin: parent.hasLeadingVisual && !parent.isBattery ? root.iconSpacing : 0
                    anchors.verticalCenter: parent.verticalCenter
                    text: modelData.text || ""
                    color: {
                        const id = modelData.id || "";
                        if (id === "cpu" || id === "ram") {
                            const txt = modelData.text || "";
                            let level = -1;
                            if (txt.endsWith("%")) {
                                level = parseFloat(txt) / 100.0;
                            } else if (txt.indexOf("/") !== -1) {
                                // RAM: "X.X/YGB"
                                const slash = txt.indexOf("/");
                                const used = parseFloat(txt.substring(0, slash));
                                const total = parseFloat(txt.substring(slash + 1));
                                if (total > 0)
                                    level = used / total;
                            }
                            if (level >= 0.70)
                                return "#ff453a";   // red
                            if (level >= 0.50)
                                return "#ff9f0a";   // orange
                            if (level >= 0.30)
                                return "#ffd60a";   // yellow
                        }
                        return "white";
                    }
                }
            }
        }
    }

    RecordingIndicator {
        id: timeRecordingIndicator
        active: root.recordingActive && root.showSecondaryText && root.timeText !== "" && root.clampedProgress < 0.001
        contentOpacity: 1 - root.clampedProgress
        x: root.timeRecordingDotX
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        visible: timeText !== "" && showSecondaryText
        x: timeX
        width: textWidth
        anchors.verticalCenter: parent.verticalCenter
        text: timeText
        color: "white"
        opacity: 1 - clampedProgress
        font.pixelSize: root.textPixelSize + 1
        font.family: timeFontFamily
        font.weight: Font.Bold
        font.letterSpacing: -0.25
        horizontalAlignment: Text.AlignHCenter
        elide: Text.ElideRight
        wrapMode: Text.NoWrap
    }
}
