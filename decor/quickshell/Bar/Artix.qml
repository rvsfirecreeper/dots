import QtQuick
import Quickshell
import Quickshell.Io
import qs

Item {
    anchors.margins: 10
    anchors.fill: parent
    Rectangle {
        id: artix
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
        }
        implicitWidth: 45
        color: Colors.background
        radius: 18
        Text {
            anchors.centerIn: parent
            text: "\uF31F"
            font.family: Theme.font
            font.pixelSize: Theme.fontSize
            color: Colors.foreground
        }
        Process {
            id: wofi
            command: ["wofi"]
            running: false
        }
        Behavior on implicitWidth {
            NumberAnimation {
                duration: 200   // milliseconds
                easing.type: Easing.InOutQuad
            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: wofi.running = true
            hoverEnabled: true
            onEntered: artix.implicitWidth = 70
            onExited: artix.implicitWidth = 45
        }
    }
    Rectangle {
        id: suspend
        property list<string> chars: ["󰤄", "", "", "󰈆"]
        property var commands: [["loginctl", "suspend"], ["loginctl", "poweroff"], ["loginctl", "reboot"], ["niri", "msg", "action", "quit"]]
        property var commandIndex: 0
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: artix.left
            rightMargin: 10
        }
        implicitWidth: 45
        color: Colors.background
        radius: 18
        Text {
            anchors.centerIn: parent
            text: suspend.chars[suspend.commandIndex]
            font.family: Theme.font
            font.pixelSize: Theme.fontSize
            color: Colors.foreground
        }
        Process {
            id: quit
            command: suspend.commands[suspend.commandIndex]
            running: false
        }
        Behavior on implicitWidth {
            NumberAnimation {
                duration: 200   // milliseconds
                easing.type: Easing.InOutQuad
            }
        }
        MouseArea {
            anchors.fill: parent
            onWheel: wheel => {
                const len = suspend.commands.length
                if (wheel.inverted) {
                    suspend.commandIndex = (suspend.commandIndex + 1) % len;
                } else {
                    suspend.commandIndex = (suspend.commandIndex - 1 + 4) % len;
                }
            }
            onClicked: quit.running = true
            hoverEnabled: true
            onEntered: suspend.implicitWidth = 70
            onExited: suspend.implicitWidth = 45
        }
    }
}
