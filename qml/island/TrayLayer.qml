import QtQuick
import QtQuick.LocalStorage
import Quickshell.Io

Item {
    id: root

    signal closeRequested

    property string iconFontFamily: ""
    property string textFontFamily: ""
    property bool showCondition: false

    opacity: showCondition ? 1 : 0
    Behavior on opacity {
        NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
    }

    // ── Pomodoro state ────────────────────────────────────────────────────
    property int  pomodoroTotal:     25 * 60
    property int  pomodoroRemaining: 25 * 60
    property bool pomodoroRunning:   false
    property string pomodoroMode:    "focus"

    function formatTime(secs) {
        const m = Math.floor(secs / 60);
        const s = secs % 60;
        return (m < 10 ? "0" : "") + m + ":" + (s < 10 ? "0" : "") + s;
    }

    Timer {
        id: countdown
        interval: 1000
        repeat: true
        running: root.pomodoroRunning
        onTriggered: {
            if (root.pomodoroRemaining > 0) {
                root.pomodoroRemaining--;
            } else {
                root.pomodoroRunning = false;
                doneNotify.running = true;
            }
        }
    }

    Process {
        id: doneNotify
        command: ["notify-send", "-u", "normal", "-t", "6000", "⏱ Pomodoro", "Session complete — time for a break!"]
        onExited: running = false
    }

    // ── Todo persistence (SQLite via LocalStorage) ────────────────────────
    ListModel { id: todoModel }

    function db() {
        return LocalStorage.openDatabaseSync("QuickshellTray", "1.0", "Tray todos", 500000);
    }

    function loadTodos() {
        db().transaction(function(tx) {
            tx.executeSql("CREATE TABLE IF NOT EXISTS todos (id INTEGER PRIMARY KEY AUTOINCREMENT, text TEXT, done INTEGER DEFAULT 0)");
            const rs = tx.executeSql("SELECT id, text, done FROM todos ORDER BY id");
            for (let i = 0; i < rs.rows.length; i++) {
                const r = rs.rows.item(i);
                todoModel.append({ dbId: r.id, itemText: r.text, done: r.done === 1 });
            }
        });
    }

    function addTodo(text) {
        const t = text.trim();
        if (!t) return;
        db().transaction(function(tx) {
            tx.executeSql("INSERT INTO todos (text, done) VALUES (?, 0)", [t]);
            const rs = tx.executeSql("SELECT last_insert_rowid() AS id");
            todoModel.append({ dbId: rs.rows.item(0).id, itemText: t, done: false });
        });
    }

    function toggleTodo(idx) {
        const item = todoModel.get(idx);
        const newDone = !item.done;
        todoModel.setProperty(idx, "done", newDone);
        db().transaction(function(tx) {
            tx.executeSql("UPDATE todos SET done = ? WHERE id = ?", [newDone ? 1 : 0, item.dbId]);
        });
    }

    function removeTodo(idx) {
        const item = todoModel.get(idx);
        db().transaction(function(tx) {
            tx.executeSql("DELETE FROM todos WHERE id = ?", [item.dbId]);
        });
        todoModel.remove(idx);
    }

    Component.onCompleted: loadTodos()

    // ── Layout ────────────────────────────────────────────────────────────
    Row {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 12

        // ── TODO LIST ─────────────────────────────────────────────────────
        Column {
            id: todoSection
            width: Math.floor((parent.width - 1 - 12) * 0.54)
            height: parent.height
            spacing: 5

            Text {
                id: todoHeader
                text: "To-Do"
                color: "white"
                font.pixelSize: 12
                font.family: root.textFontFamily
                font.weight: Font.SemiBold
                font.letterSpacing: -0.2
            }

            Row {
                id: todoInputRow
                width: parent.width
                height: 22
                spacing: 5

                Rectangle {
                    width: parent.width - 27
                    height: 22
                    radius: 7
                    color: Qt.rgba(1, 1, 1, todoInput.activeFocus ? 0.10 : 0.06)
                    Behavior on color { ColorAnimation { duration: 120 } }

                    Text {
                        anchors.fill: parent
                        anchors.leftMargin: 8
                        verticalAlignment: Text.AlignVCenter
                        text: "Add a task…"
                        color: Qt.rgba(1, 1, 1, 0.22)
                        font.pixelSize: 10
                        font.family: root.textFontFamily
                        visible: todoInput.text === "" && !todoInput.activeFocus
                    }

                    TextInput {
                        id: todoInput
                        anchors.fill: parent
                        anchors.leftMargin: 8
                        anchors.rightMargin: 6
                        verticalAlignment: TextInput.AlignVCenter
                        color: "white"
                        font.pixelSize: 10
                        font.family: root.textFontFamily
                        clip: true
                        Keys.onReturnPressed: { addTodo(text); text = ""; }
                    }
                }

                Rectangle {
                    width: 22
                    height: 22
                    radius: 7
                    color: plusMouse.pressed ? Qt.rgba(1, 1, 1, 0.18) : Qt.rgba(1, 1, 1, 0.08)
                    Behavior on color { ColorAnimation { duration: 100 } }

                    Text {
                        anchors.centerIn: parent
                        text: "+"
                        color: Qt.rgba(1, 1, 1, 0.7)
                        font.pixelSize: 15
                        font.family: root.textFontFamily
                    }

                    MouseArea {
                        id: plusMouse
                        anchors.fill: parent
                        onClicked: { addTodo(todoInput.text); todoInput.text = ""; }
                    }
                }
            }

            ListView {
                id: todoList
                width: parent.width
                height: todoSection.height
                       - todoHeader.height
                       - todoInputRow.height
                       - todoSection.spacing * 2
                clip: true
                model: todoModel
                spacing: 3

                delegate: Item {
                    width: todoList.width
                    height: 20

                    Row {
                        width: parent.width
                        height: parent.height
                        spacing: 5

                        // Checkbox
                        Rectangle {
                            width: 13
                            height: 13
                            anchors.verticalCenter: parent.verticalCenter
                            radius: 4
                            color: model.done ? Qt.rgba(181/255, 108/255, 1, 0.28) : "transparent"
                            border.color: model.done ? "#b56cff" : Qt.rgba(1, 1, 1, 0.25)
                            border.width: 1.5
                            Behavior on color { ColorAnimation { duration: 150 } }

                            Text {
                                anchors.centerIn: parent
                                text: "✓"
                                color: "#b56cff"
                                font.pixelSize: 8
                                visible: model.done
                            }

                            MouseArea {
                                anchors.fill: parent
                                anchors.margins: -4
                                onClicked: toggleTodo(index)
                            }
                        }

                        // Task text
                        Text {
                            width: parent.width - 13 - 14 - 10
                            anchors.verticalCenter: parent.verticalCenter
                            text: model.itemText
                            color: model.done ? Qt.rgba(1, 1, 1, 0.27) : Qt.rgba(1, 1, 1, 0.82)
                            font.pixelSize: 10
                            font.family: root.textFontFamily
                            font.strikeout: model.done
                            elide: Text.ElideRight
                            Behavior on color { ColorAnimation { duration: 150 } }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: toggleTodo(index)
                            }
                        }

                        // Delete ×
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "×"
                            color: Qt.rgba(1, 1, 1, 0.2)
                            font.pixelSize: 14
                            font.family: root.textFontFamily

                            MouseArea {
                                anchors.fill: parent
                                anchors.margins: -4
                                onClicked: removeTodo(index)
                            }
                        }
                    }
                }
            }
        }

        // ── DIVIDER ───────────────────────────────────────────────────────
        Rectangle {
            width: 1
            height: parent.height * 0.85
            anchors.verticalCenter: parent.verticalCenter
            color: Qt.rgba(1, 1, 1, 0.08)
        }

        // ── POMODORO ──────────────────────────────────────────────────────
        Column {
            width: Math.floor((parent.width - 1 - 12) * 0.46)
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8

            // Mode presets
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 5

                Repeater {
                    model: [
                        { label: "Focus",  secs: 25 * 60, mode: "focus" },
                        { label: "Short",  secs:  5 * 60, mode: "short" },
                        { label: "Long",   secs: 15 * 60, mode: "long"  }
                    ]

                    delegate: Rectangle {
                        width: 48
                        height: 18
                        radius: 9
                        color: pomodoroMode === modelData.mode
                               ? Qt.rgba(181/255, 108/255, 1, 0.22)
                               : Qt.rgba(1, 1, 1, 0.06)
                        border.color: pomodoroMode === modelData.mode ? "#b56cff" : "transparent"
                        border.width: 1
                        Behavior on color { ColorAnimation { duration: 150 } }

                        Text {
                            anchors.centerIn: parent
                            text: modelData.label
                            color: pomodoroMode === modelData.mode ? "#b56cff" : Qt.rgba(1, 1, 1, 0.42)
                            font.pixelSize: 9
                            font.family: root.textFontFamily
                            font.weight: Font.Medium
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (pomodoroRunning) return;
                                pomodoroMode      = modelData.mode;
                                pomodoroTotal     = modelData.secs;
                                pomodoroRemaining = modelData.secs;
                            }
                        }
                    }
                }
            }

            // Timer display
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: formatTime(pomodoroRemaining)
                color: pomodoroRunning ? "white" : Qt.rgba(1, 1, 1, 0.7)
                font.pixelSize: 32
                font.family: root.textFontFamily
                font.weight: Font.Light
                font.letterSpacing: -1
                Behavior on color { ColorAnimation { duration: 200 } }
            }

            // Start / Pause + Reset
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 7

                Rectangle {
                    width: 56
                    height: 22
                    radius: 11
                    color: pomodoroRunning ? Qt.rgba(1, 1, 1, 0.10) : "#b56cff"
                    Behavior on color { ColorAnimation { duration: 150 } }

                    Text {
                        anchors.centerIn: parent
                        text: pomodoroRunning ? "Pause" : "Start"
                        color: "white"
                        font.pixelSize: 10
                        font.family: root.textFontFamily
                        font.weight: Font.SemiBold
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: pomodoroRunning = !pomodoroRunning
                    }
                }

                Rectangle {
                    width: 40
                    height: 22
                    radius: 11
                    color: resetMouse.pressed ? Qt.rgba(1, 1, 1, 0.12) : Qt.rgba(1, 1, 1, 0.07)
                    Behavior on color { ColorAnimation { duration: 100 } }

                    Text {
                        anchors.centerIn: parent
                        text: "Reset"
                        color: Qt.rgba(1, 1, 1, 0.45)
                        font.pixelSize: 10
                        font.family: root.textFontFamily
                    }

                    MouseArea {
                        id: resetMouse
                        anchors.fill: parent
                        onClicked: {
                            pomodoroRunning   = false;
                            pomodoroRemaining = pomodoroTotal;
                        }
                    }
                }
            }
        }
    }
}
