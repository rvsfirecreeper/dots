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
    Process {
        id: spaceProc
        running: true
        command: ["bash", "-c", "~/.scripts/currentWorkspace.sh"]
        stdout: StdioCollector {
            onStreamFinished: root.focusedSpace = this.text
        }
    }
    Process {
        id: numProc
        running: true
        command: ["bash", "-c", "~/.scripts/numSpaces.sh"]
        stdout: StdioCollector {
            onStreamFinished: root.numSpaces = this.text
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
    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: spaceProc.running = true
    }
    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: numProc.running = true
    }
}

