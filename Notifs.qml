pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
    id: root

    // ── DND ───────────────────────────────────────────────────────────────────
    property bool dndEnabled: false

    // ── Notification list ─────────────────────────────────────────────────────
    readonly property var list: notifList      // all (including closed)
    readonly property var active: notifList.filter(n => !n.closed)

    property var notifList: []

    signal notificationAdded(var notif)

    // ── DBus server ───────────────────────────────────────────────────────────
    NotificationServer {
        id: server

        keepOnReload: false
        actionsSupported: true
        bodySupported: true
        bodyMarkupSupported: true
        imageSupported: true

        onNotification: function (notif) {
            // Must set tracked=true or Quickshell drops it immediately
            notif.tracked = true;

            if (root.dndEnabled) {
                notif.tracked = false;
                return;
            }

            const entry = {
                id: notif.id,
                appName: notif.appName || "",
                summary: notif.summary || "",
                body: notif.body || "",
                appIcon: notif.appIcon || "",
                urgency: notif.urgency,
                _raw: notif,
                closed: false
            };

            const idx = root.notifList.findIndex(n => n.id === notif.id);
            if (idx !== -1) {
                const updated = root.notifList.slice();
                updated[idx] = entry;
                root.notifList = updated;
            } else {
                root.notifList = root.notifList.concat([entry]);
            }

            root.notificationAdded(entry);

            notif.closed.connect(function () {
                root._markClosed(notif.id);
            });
        }
    }

    // ── Helpers ───────────────────────────────────────────────────────────────

    function _markClosed(notifId) {
        const idx = root.notifList.findIndex(n => n.id === notifId);
        if (idx === -1)
            return;
        const updated = root.notifList.slice();
        updated[idx] = Object.assign({}, updated[idx], {
            closed: true
        });
        root.notifList = updated;
    }

    function dismiss(notif) {
        if (!notif || !notif._raw)
            return;
        notif._raw.tracked = false;
    }

    function clearAll() {
        for (const n of root.notifList) {
            if (!n.closed && n._raw)
                n._raw.tracked = false;
        }
        root.notifList = [];
    }

    function invoke(notif, actionId) {
        if (!notif || !notif._raw)
            return;
        notif._raw.invokeAction(actionId || "default");
        notif._raw.tracked = false;
    }
}
