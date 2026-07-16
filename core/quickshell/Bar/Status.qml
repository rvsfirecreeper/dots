pragma Singleton

import Quickshell
import Quickshell.Networking
import QtQuick

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
}
