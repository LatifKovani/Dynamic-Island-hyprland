import QtQuick
import IslandBackend

// Hover state of the main pill: clock on top, a 5-day strip centred on today below.
Item {
    id: root

    property string timeText: ""
    property string heroFontFamily: ""
    property string textFontFamily: ""
    property bool showCondition: false
    property color accentColor: StyleTokens.success
    property color clockColor: "white"
    property color weekendColor: "#ff6b6b"

    readonly property int windowRadius: 2
    readonly property var dayInitials: ["S", "M", "T", "W", "T", "F", "S"]
    readonly property var dayShortNames: ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    readonly property var edgeFade: [1.0, 0.8, 0.4]
    property var days: buildDays()

    function buildDays() {
        const now = new Date();
        const list = [];
        for (let offset = -windowRadius; offset <= windowRadius; offset++) {
            const d = new Date(now.getFullYear(), now.getMonth(), now.getDate() + offset);
            const dow = d.getDay();
            list.push({
                dayNum: d.getDate(),
                label: offset === 0 ? dayShortNames[dow] : dayInitials[dow],
                isToday: offset === 0,
                isWeekend: dow === 0 || dow === 6,
                fade: edgeFade[Math.abs(offset)]
            });
        }
        return list;
    }

    anchors.fill: parent
    opacity: showCondition ? 1 : 0

    Behavior on opacity {
        NumberAnimation {
            duration: root.showCondition ? 300 : 150
            easing.type: Easing.InOutQuad
        }
    }

    Text {
        id: clockText
        anchors.top: parent.top
        anchors.topMargin: 14
        anchors.horizontalCenter: parent.horizontalCenter
        text: root.timeText
        color: root.clockColor
        font.pixelSize: 24
        font.family: root.heroFontFamily
        font.weight: Font.DemiBold
        font.letterSpacing: -0.4
        wrapMode: Text.NoWrap
    }

    Row {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 0

        Repeater {
            model: root.days

            delegate: Item {
                width: 28
                height: 44
                opacity: modelData.fade

                Rectangle {
                    visible: modelData.isToday
                    anchors.fill: parent
                    radius: width / 2
                    color: Qt.rgba(1, 1, 1, 0.08)
                }

                Text {
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: modelData.label
                    color: modelData.isWeekend ? root.weekendColor : (modelData.isToday ? Qt.rgba(1, 1, 1, 0.85) : Qt.rgba(1, 1, 1, 0.5))
                    font.pixelSize: 10
                    font.family: root.textFontFamily
                    font.weight: Font.Medium
                    font.letterSpacing: 0.4
                }

                Text {
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: modelData.dayNum
                    color: modelData.isToday ? root.accentColor : (modelData.isWeekend ? root.weekendColor : Qt.rgba(1, 1, 1, 0.85))
                    font.pixelSize: modelData.isToday ? 17 : 14
                    font.family: root.textFontFamily
                    font.weight: modelData.isToday ? Font.Bold : Font.Medium
                }
            }
        }
    }
}
