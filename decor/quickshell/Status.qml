pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property string status

    Process {
        id: dateProc
        command: ["internet.sh"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.status = this.text
        }
    }
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }
}

