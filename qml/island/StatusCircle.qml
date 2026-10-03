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
            const top = -Math.PI / 2;
            const full = Math.PI * 2;

            // The filled arc is centred on the top and widens symmetrically; the empty part is
            // therefore centred on the bottom and grows up the left and right sides as the
            // battery drains (like the iPhone concept).
            const half = Math.max(0, Math.min(1, progress)) * Math.PI;
            const fillStart = top - half;
            const fillEnd = top + half;

            // empty part: a dotted track from the end of the arc round the bottom to its start
            if (progress < 0.999) {
                const emptySpan = full - 2 * half;
                const dots = Math.max(0, Math.round(emptySpan * r / 3.2));
                ctx.fillStyle = Qt.rgba(1, 1, 1, 0.45);
                for (let i = 0; i <= dots; i++) {
                    const a = fillEnd + (dots === 0 ? 0 : emptySpan * i / dots);
                    ctx.beginPath();
                    ctx.arc(cx + r * Math.cos(a), cy + r * Math.sin(a), 0.9, 0, full);
                    ctx.fill();
                }
            }

            if (progress > 0.001) {
                ctx.lineWidth = lw;
                ctx.lineCap = "round";
                ctx.strokeStyle = arcColor;
                ctx.beginPath();
                if (progress >= 0.999)
                    ctx.arc(cx, cy, r, 0, full);
                else
                    ctx.arc(cx, cy, r, fillStart, fillEnd);
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
