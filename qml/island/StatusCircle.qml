import QtQuick
import IslandBackend

// Right-hand circle: ring = battery level, glyph inside = Wi-Fi state. Click opens the control center.
Item {
    id: root

    signal clicked

    property int batteryCapacity: 0
    property bool isCharging: false
    property string iconFontFamily: ""
    property bool wifiConnected: false
    readonly property bool hovered: mouseArea.containsMouse

    readonly property real level: Math.max(0, Math.min(100, batteryCapacity)) / 100
    readonly property color ringColor: isCharging ? StyleTokens.success : (batteryCapacity <= 15 ? StyleTokens.danger : "white")

    width: 34
    height: 34
    scale: mouseArea.pressed ? 0.92 : 1.0

    Behavior on scale {
        NumberAnimation {
            duration: 100
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: width / 2
        color: StyleTokens.black
    }

    Canvas {
        id: ring
        anchors.fill: parent
        antialiasing: true

        property real progress: root.level
        property color arcColor: root.ringColor

        onProgressChanged: requestPaint()
        onArcColorChanged: requestPaint()
        onWidthChanged: requestPaint()

        onPaint: {
            const ctx = getContext("2d");
            ctx.reset();
            const lw = 2.5;
            const r = (Math.min(width, height) - lw) / 2 - 1;
            const cx = width / 2;
            const cy = height / 2;
            ctx.lineWidth = lw;
            ctx.lineCap = "round";
            ctx.strokeStyle = Qt.rgba(1, 1, 1, 0.18);
            ctx.beginPath();
            ctx.arc(cx, cy, r, 0, Math.PI * 2);
            ctx.stroke();
            if (progress > 0.001) {
                ctx.strokeStyle = arcColor;
                ctx.beginPath();
                ctx.arc(cx, cy, r, -Math.PI / 2, -Math.PI / 2 + Math.PI * 2 * progress);
                ctx.stroke();
            }
        }
    }

    Text {
        anchors.centerIn: parent
        text: "\uf1eb"
        font.family: root.iconFontFamily
        font.pixelSize: 13
        color: "white"
        opacity: root.wifiConnected ? 0.95 : 0.35
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
