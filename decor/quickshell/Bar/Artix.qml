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
        id: exit
        clip: true
        property list<string> chars: ["󰤄", "", "", "󰈆"]
        property var commands: [["loginctl", "suspend"], ["loginctl", "poweroff"], ["loginctl", "reboot"], ["niri", "msg", "action", "quit"]]
        property var commandIndex: 0
        property bool expanded: false
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: artix.left
            rightMargin: 10
        }
        implicitWidth: expanded ? 180 : 45
        color: Colors.background
        radius: 18
        Process {
            id: quit
            command: exit.commands[exit.commandIndex]
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
            hoverEnabled: true
            onEntered: exit.expanded = true
            onExited: exit.expanded = false
        }
        Row {
            anchors.fill: parent

            Repeater {
                model: exit.chars.length

                delegate: Item {
                    required property int index

                    implicitWidth: 45
                    implicitHeight: parent.height

                    Text {
                        anchors.centerIn: parent
                        text: exit.chars[index]
                        font.family: Theme.font
                        font.pixelSize: Theme.fontSize
                        color: Colors.foreground
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            exit.commandIndex = index;
                            quit.running = true;
                        }
                    }
                }
            }
        }
    }
}
