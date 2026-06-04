import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import IslandBackend

Scope {
    id: shellRoot

    readonly property bool screenRecordingActive: SystemServices.screenRecordingActive
    property bool shuttingDown: false

    readonly property var userConfig: UserConfig

    // Fix 5: identify the primary screen.
    // Quickshell exposes the primary screen as Quickshell.primaryScreen when
    // available. We fall back to screens[0] for compositors that don't set it.
    readonly property var primaryScreen: Quickshell.primaryScreen ?? (Quickshell.screens.length > 0 ? Quickshell.screens[0] : null)

    function forEachWindow(callback) {
        const windows = panelVariants.instances ? panelVariants.instances : [];
        for (let index = 0; index < windows.length; index++) {
            const window = windows[index];
            if (window)
                callback(window);
        }
    }

    function showNotificationAll(appName, summary, body) {
        shellRoot.forEachWindow(window => {
            if (window && window.showNotification)
                window.showNotification(appName, summary, body);
        });
    }

    function anyOverviewOpen() {
        const windows = panelVariants.instances ? panelVariants.instances : [];
        for (let index = 0; index < windows.length; index++) {
            const window = windows[index];
            if (window && window.overviewPhase !== "closed")
                return true;
        }
        return false;
    }

    function prepareOverviewAll() {
        shellRoot.forEachWindow(window => window.prepareOverview());
    }

    function cancelPreparedOverviewAll() {
        shellRoot.forEachWindow(window => window.cancelPreparedOverview());
    }

    function openOverviewAll() {
        shellRoot.forEachWindow(window => window.openOverview());
    }

    function closeOverviewAll() {
        shellRoot.forEachWindow(window => window.closeOverview());
    }

    function toggleOverviewAll() {
        if (shellRoot.anyOverviewOpen())
            shellRoot.closeOverviewAll();
        else
            shellRoot.openOverviewAll();
    }

    IpcHandler {
        target: "tide"
        function toggleAppLauncher() {
            shellRoot.forEachWindow(window => {
                if (!window || !window.islandContainerRef)
                    return;
                const ic = window.islandContainerRef;
                if (ic.islandState === "app_launcher")
                    ic.smartRestoreState();
                else
                    ic.showAppLauncher();
            });
        }

        function togglePowerMenu() {
            shellRoot.forEachWindow(window => {
                if (!window || !window.islandContainerRef)
                    return;
                const ic = window.islandContainerRef;
                if (ic.islandState === "power_menu")
                    ic.smartRestoreState();
                else
                    ic.showPowerMenu();
            });
        }

        function toggleControlCenter() {
            shellRoot.forEachWindow(window => {
                if (window && window.islandContainerRef)
                    window.islandContainerRef.handleConfiguredClickAction("toggleControlCenter");
            });
        }

        function showLyrics() {
            shellRoot.forEachWindow(window => {
                if (window && window.islandContainerRef)
                    window.islandContainerRef.showLyricsCapsule();
            });
        }

        function showCustom() {
            shellRoot.forEachWindow(window => {
                if (window && window.islandContainerRef)
                    window.islandContainerRef.showCustomCapsule();
            });
        }

        function showClock() {
            shellRoot.forEachWindow(window => {
                if (window && window.islandContainerRef)
                    window.islandContainerRef.showTimeCapsule();
            });
        }

        function togglePlayer() {
            shellRoot.forEachWindow(window => {
                if (window && window.islandContainerRef)
                    window.islandContainerRef.handleConfiguredClickAction("toggleExpandedPlayer");
            });
        }
    }

    IpcHandler {
        target: "overview"

        function toggle() {
            shellRoot.toggleOverviewAll();
        }

        function open() {
            shellRoot.openOverviewAll();
        }

        function close() {
            shellRoot.closeOverviewAll();
        }

        function refreshWallpaperCache() {
            shellRoot.forEachWindow(window => {
                if (window && window.prewarmWallpaperCache)
                    window.prewarmWallpaperCache();
            });
        }
    }

    GlobalShortcut {
        appid: userConfig.overviewGlobalShortcutAppid
        name: userConfig.overviewGlobalShortcutName

        onPressed: shellRoot.toggleOverviewAll()
    }

    Connections {
        target: SystemServices

        function onNotificationReceived(appName, summary, body) {
            shellRoot.showNotificationAll(appName, summary, body);
        }
    }

    Component.onDestruction: {
        shuttingDown = true;
    }

    Component.onCompleted: {
        SystemServices.ensureSetupComplete(Quickshell.shellDir);
        SystemServices.requestScreenRecordingSnapshot();
    }

    // Fix 5: Only spawn a DynamicIslandWindow on the primary screen.
    // The Variants model is changed from all screens to a single-item
    // array containing only the primary screen.
    Variants {
        id: panelVariants

        // Filter: only the primary screen. If primaryScreen is null
        // (e.g. compositor hasn't reported it yet) fall back to all screens
        // so the island still appears somewhere.
        model: shellRoot.primaryScreen ? [shellRoot.primaryScreen] : Quickshell.screens

        DynamicIslandWindow {
            required property var modelData

            screen: modelData
            shellRootController: shellRoot
        }
    }
}
