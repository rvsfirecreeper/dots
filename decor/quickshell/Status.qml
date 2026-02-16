pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property string status

    Process {
        id: dateProc
        command: ["wget", "-q", "--spider", "http://example.com"]
        running: true
        onExited: (code, status) => {
            if (code == 0) {
              root.status = "󰖩"          
            }
            else {
                root.status = "󰈂"
            }
        }
    }
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }
}

