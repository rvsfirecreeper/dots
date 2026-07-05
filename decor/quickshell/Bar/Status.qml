pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property string wifistatus
    property string focusedSpace
    property string numSpaces
    Process {
        id: wifiProc
        command: ["wget", "-q", "--spider", "http://example.com"]
        running: true
        onExited: (code, status) => {
            if (code == 0) {
              root.wifistatus = ""          
            }
            else {
                root.wifistatus = "󰈂"
            }
        }
    }
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            wifiProc.running = true
        }
    }
}

