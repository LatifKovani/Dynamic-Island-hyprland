pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

// Persistent UI settings for Tide-island.
// Stored in ~/.config/tide-island/ui-settings.json - a separate file from the backend's
// userconfig.json, so nothing the backend manages is ever touched. Changing any property
// (from the settings window or by editing the file) takes effect immediately.
Singleton {
    id: root

    readonly property string configDir: (Quickshell.env("XDG_CONFIG_HOME") || (Quickshell.env("HOME") + "/.config")) + "/tide-island"
    readonly property string filePath: configDir + "/ui-settings.json"

    // ---- Bar & Island ----
    property alias restWidth: store.restWidth
    property alias restHeight: store.restHeight
    property alias showStatusCircle: store.showStatusCircle
    property alias showAlbumCircle: store.showAlbumCircle
    property alias circleSize: store.circleSize
    property alias circleGap: store.circleGap

    // ---- Hover behaviour ----
    property alias hoverCalendar: store.hoverCalendar
    property alias hoverPlayerCard: store.hoverPlayerCard
    property alias hoverControlCenter: store.hoverControlCenter
    property alias hoverCloseDelay: store.hoverCloseDelay
    property alias controlCenterCloseDelay: store.controlCenterCloseDelay
    property alias statusHoverOpenDelay: store.statusHoverOpenDelay

    // ---- Clock & Date ----
    property alias clock24h: store.clock24h
    property alias calendarDays: store.calendarDays

    function resetBarAndIsland() {
        store.restWidth = 124;
        store.restHeight = 34;
        store.showStatusCircle = true;
        store.showAlbumCircle = true;
        store.circleSize = 34;
        store.circleGap = 14;
        store.hoverCalendar = true;
        store.hoverPlayerCard = true;
        store.hoverControlCenter = true;
        store.hoverCloseDelay = 400;
        store.controlCenterCloseDelay = 1000;
        store.statusHoverOpenDelay = 120;
    }

    function resetClockAndDate() {
        store.clock24h = true;
        store.calendarDays = 5;
    }

    FileView {
        id: file
        path: root.filePath
        watchChanges: true
        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()
        onLoadFailed: error => {
            // first run: create the file with the defaults below
            if (error === FileViewError.FileNotFound)
                writeAdapter();
        }

        adapter: JsonAdapter {
            id: store

            property real restWidth: 124
            property real restHeight: 34
            property bool showStatusCircle: true
            property bool showAlbumCircle: true
            property real circleSize: 34
            property real circleGap: 14

            property bool hoverCalendar: true
            property bool hoverPlayerCard: true
            property bool hoverControlCenter: true
            property int hoverCloseDelay: 400
            property int controlCenterCloseDelay: 1000
            property int statusHoverOpenDelay: 120

            property bool clock24h: true
            property int calendarDays: 5
        }
    }
}
