pragma Singleton

import Quickshell
import Quickshell.Networking
import QtQuick
import Quickshell.Io
Singleton {
    id: root
    property bool canCheck: Networking.canCheckConnectivity
    property string wifistatus: 
        ({
            [NetworkConnectivity.Full]: "󰤨",
            [NetworkConnectivity.Limited]: "󰤭",
            [NetworkConnectivity.Unknown]: "",
            [NetworkConnectivity.Portal]: "󰤩", 
            [NetworkConnectivity.None]: "󰤮" 
            
        }[Networking.connectivity] ?? "")
    
    onCanCheckChanged: {
        if (canCheck) {
            Networking.checkConnectivity()
        }   
    }
    property string os: "aa"
    Process {
        id: osProc
        running: true
        command: ["bash", "linuxbtw.sh"]
        stdout: StdioCollector {
            onStreamFinished: root.os = this.text
        }
    }
}
