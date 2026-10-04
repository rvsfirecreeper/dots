import QtQuick
import Quickshell.Io
import qs

BarIcon {
    icon: Status.os
    onClicked: wofi.running = true

    Process {
        id: wofi
        command: ["wofi"]
        running: false
    }
}
