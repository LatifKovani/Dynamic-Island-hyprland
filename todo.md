Tide-Island TODO — ideas from caelestia-dots/shell

Notifications

Lock-based lifecycle: UI components (popup, expanded view) register a "lock" on a notification while displaying it; data object only destroyed when lock count hits 0. Prevents disappear-mid-animation bugs.
Persist notifications to disk (e.g. ~/.local/state/tide-island/notifs.json), debounced ~1s on list change. Survive shell restarts.
Group notifications by appName, with "clear all" dismissing sequentially via a timer (avoid IPC flood).
Urgency-based badge styling: critical/normal/low → different bg+icon colors on app-icon badge; fallback Material icon when no app icon/image.
Drag interactions: vertical drag past threshold = expand/collapse, horizontal drag past threshold = dismiss.

App Launcher

Fuzzy search via fuzzysort.js instead of substring match.
specialPrefix/actionPrefix pattern (e.g. @ for wallpaper/scheme picker mode, > for system actions mode) in the same input field.
Favourites/hidden apps lists, stored in config, toggleable from a settings UI.
Calculator action via qalc (libqalculate) for inline math in launcher.

Architecture

Consider splitting config into config/\*.qml singletons backed by a shell.json (JsonAdapter), so settings are user-tunable without recompiling/restarting.
