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

    // ---- Weather (control center) ----
    property alias weatherEnabled: store.weatherEnabled
    property alias weatherLocation: store.weatherLocation
    property alias weatherUnits: store.weatherUnits
    property alias weatherRefreshInterval: store.weatherRefreshInterval

    // ---- Appearance ----
    property alias pillColor: store.pillColor
    property alias pillOpacity: store.pillOpacity
    property alias restRoundness: store.restRoundness
    property alias panelRadius: store.panelRadius

    // ---- Launcher ----
    property alias launcherWidth: store.launcherWidth
    property alias launcherShowFavourites: store.launcherShowFavourites
    property alias launcherBrowseLimit: store.launcherBrowseLimit
    property alias launcherSearchLimit: store.launcherSearchLimit
    property alias launcherFavourites: store.launcherFavourites
    property alias launcherHidden: store.launcherHidden

    // ---- Control center ----
    property alias ccOrder: store.ccOrder
    property alias ccHidden: store.ccHidden
    property alias ccShowHeader: store.ccShowHeader

    // ---- Notifications ----
    property alias notifPopups: store.notifPopups
    property alias notifDuration: store.notifDuration
    property alias notifShowBody: store.notifShowBody
    property alias notifMaxWidth: store.notifMaxWidth
    property alias notifDnd: store.notifDnd

    // ---- Lock Screen ----
    property alias lockAnimation: store.lockAnimation
    property alias lockCapsuleWidth: store.lockCapsuleWidth
    property alias lockIconSize: store.lockIconSize
    property alias lockStartDelay: store.lockStartDelay
    property alias lockHoldDuration: store.lockHoldDuration
    property alias lockFadeOut: store.lockFadeOut

    // ---- System ----
    property alias batteryAlerts: store.batteryAlerts
    property alias batteryCriticalAlert: store.batteryCriticalAlert
    property alias batteryCriticalLevel: store.batteryCriticalLevel

    // ---- Motion ----
    property alias reduceMotion: store.reduceMotion
    property alias morphDuration: store.morphDuration
    property alias cardFadeIn: store.cardFadeIn
    property alias cardFadeOut: store.cardFadeOut
    property alias circleFade: store.circleFade

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

    function resetWeather() {
        store.weatherEnabled = true;
        store.weatherLocation = "";
        store.weatherUnits = "metric";
        store.weatherRefreshInterval = 1800000;
    }

    function resetAppearance() {
        store.pillColor = "#000000";
        store.pillOpacity = 100;
        store.restRoundness = 100;
        store.panelRadius = 34;
    }

    function resetLauncher() {
        store.launcherWidth = 580;
        store.launcherShowFavourites = true;
        store.launcherBrowseLimit = 10;
        store.launcherSearchLimit = 14;
        store.launcherFavourites = ["Brave", "kitty", "Spotify", "Neovim", "Visual Studio Code"];
        store.launcherHidden = ["Avahi Zeroconf Browser", "Avahi SSH Server Browser", "Avahi VNC Server Browser", "Bluetooth Adapters", "A Photo Tool (Libre)"];
    }

    function resetControlCenter() {
        store.ccOrder = ["connectivity", "drawer", "display", "sound", "notifications"];
        store.ccHidden = [];
        store.ccShowHeader = true;
    }

    function resetNotifications() {
        store.notifPopups = true;
        store.notifDuration = 1250;
        store.notifShowBody = true;
        store.notifMaxWidth = 700;
        store.notifDnd = false;
    }

    function resetLockScreen() {
        store.lockAnimation = true;
        store.lockCapsuleWidth = 170;
        store.lockIconSize = 16;
        store.lockStartDelay = 420;
        store.lockHoldDuration = 600;
        store.lockFadeOut = 240;
    }

    function resetSystem() {
        store.batteryAlerts = true;
        store.batteryCriticalAlert = true;
        store.batteryCriticalLevel = 10;
    }

    function resetMotion() {
        store.reduceMotion = false;
        store.morphDuration = 400;
        store.cardFadeIn = 110;
        store.cardFadeOut = 180;
        store.circleFade = 220;
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

            property bool weatherEnabled: true
            property string weatherLocation: ""
            property string weatherUnits: "metric"
            property int weatherRefreshInterval: 1800000

            property string pillColor: "#000000"
            property int pillOpacity: 100
            property int restRoundness: 100
            property real panelRadius: 34

            property real launcherWidth: 580
            property bool launcherShowFavourites: true
            property int launcherBrowseLimit: 10
            property int launcherSearchLimit: 14
            property var launcherFavourites: ["Brave", "kitty", "Spotify", "Neovim", "Visual Studio Code"]
            property var launcherHidden: ["Avahi Zeroconf Browser", "Avahi SSH Server Browser", "Avahi VNC Server Browser", "Bluetooth Adapters", "A Photo Tool (Libre)"]

            property var ccOrder: ["connectivity", "drawer", "display", "sound", "notifications"]
            property var ccHidden: []
            property bool ccShowHeader: true

            property bool notifPopups: true
            property int notifDuration: 1250
            property bool notifShowBody: true
            property real notifMaxWidth: 700
            property bool notifDnd: false

            property bool lockAnimation: true
            property real lockCapsuleWidth: 170
            property int lockIconSize: 16
            property int lockStartDelay: 420
            property int lockHoldDuration: 600
            property int lockFadeOut: 240

            property bool batteryAlerts: true
            property bool batteryCriticalAlert: true
            property int batteryCriticalLevel: 10

            property bool reduceMotion: false
            property int morphDuration: 400
            property int cardFadeIn: 110
            property int cardFadeOut: 180
            property int circleFade: 220
        }
    }
}
