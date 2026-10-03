import QtQuick

// Transport button drawn with shapes (not font glyphs) so previous / play-pause / next
// share one centre line and one optical size, whatever font is installed.
Item {
    id: root

    signal buttonPressed
    signal clicked

    property string kind: "play"
    property string textFontFamily: ""
    readonly property bool down: controlArea.pressed
    readonly property color iconColor: controlArea.pressed ? "#888888" : "#ffffff"

    readonly property bool isPlayKind: kind === "play" || kind === "pause"

    // Every button is the same 40x40 cell, so a Row lines their centres up exactly.
    width: 40
    height: 40
    scale: controlArea.pressed ? 0.88 : 1.0
    opacity: enabled ? 1.0 : 0.45

    Behavior on scale {
        NumberAnimation {
            duration: 100
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: width / 2
        visible: root.isPlayKind
        color: controlArea.pressed ? Qt.rgba(1, 1, 1, 0.22) : Qt.rgba(1, 1, 1, 0.12)
    }

    Canvas {
        id: icon
        anchors.centerIn: parent
        width: root.isPlayKind ? 18 : 16
        height: width
        antialiasing: true

        property color fill: root.iconColor
        property string glyph: root.kind

        onWidthChanged: requestPaint()
        onFillChanged: requestPaint()
        onGlyphChanged: requestPaint()

        function tri(ctx, x0, x1, cy, half) {
            ctx.beginPath();
            ctx.moveTo(x0, cy - half);
            ctx.lineTo(x1, cy);
            ctx.lineTo(x0, cy + half);
            ctx.closePath();
            ctx.fill();
        }

        function bar(ctx, x, y, w, h, r) {
            ctx.beginPath();
            ctx.moveTo(x + r, y);
            ctx.arcTo(x + w, y, x + w, y + h, r);
            ctx.arcTo(x + w, y + h, x, y + h, r);
            ctx.arcTo(x, y + h, x, y, r);
            ctx.arcTo(x, y, x + w, y, r);
            ctx.closePath();
            ctx.fill();
        }

        onPaint: {
            const ctx = getContext("2d");
            ctx.reset();
            ctx.scale(width / 22, height / 22);
            ctx.fillStyle = fill;
            ctx.lineJoin = "round";
            const cy = 11;
            if (glyph === "pause") {
                bar(ctx, 4.5, cy - 7, 4.5, 14, 1.5);
                bar(ctx, 13, cy - 7, 4.5, 14, 1.5);
            } else if (glyph === "next") {
                tri(ctx, 3.5, 15, cy, 7.5);
                bar(ctx, 15.5, cy - 7.5, 3.2, 15, 1.2);
            } else if (glyph === "previous") {
                bar(ctx, 3.3, cy - 7.5, 3.2, 15, 1.2);
                // mirrored triangle: apex on the left
                ctx.beginPath();
                ctx.moveTo(18.5, cy - 7.5);
                ctx.lineTo(7, cy);
                ctx.lineTo(18.5, cy + 7.5);
                ctx.closePath();
                ctx.fill();
            } else {
                // play: slightly right-weighted so it looks optically centred
                tri(ctx, 5.5, 18, cy, 8);
            }
        }
    }

    MouseArea {
        id: controlArea
        anchors.fill: parent
        anchors.margins: 0
        enabled: root.enabled
        preventStealing: true
        cursorShape: Qt.PointingHandCursor

        onPressed: function (mouse) {
            root.buttonPressed();
            mouse.accepted = true;
        }
        onClicked: root.clicked()
    }
}
