import QtQuick

Item {
    id: root

    visible: false
    width: 0
    height: 0

    property bool use24h: true
    property string currentTime: "00:00"
    property string currentDateLabel: "Mon, Jan 01"

    readonly property var monthNames: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    readonly property var dayNames: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    function padTwoDigits(value) {
        return value < 10 ? "0" + value : String(value);
    }

    function formatDateLabel(now) {
        return dayNames[now.getDay()] + ", " + monthNames[now.getMonth()] + " " + padTwoDigits(now.getDate());
    }

    onUse24hChanged: clockTimer.restart()

    Timer {
        id: clockTimer

        running: true
        repeat: true
        triggeredOnStart: true
        interval: 1000

        onTriggered: {
            const now = new Date();
            root.currentTime = Qt.formatTime(now, root.use24h ? "HH:mm" : "h:mm AP");
            root.currentDateLabel = root.formatDateLabel(now);
            interval = (60 - now.getSeconds()) * 1000 - now.getMilliseconds();
        }
    }
}
