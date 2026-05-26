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
        property var actions: [
            {
                icon: "󰤄",
                command: ["loginctl", "suspend"]
            },
            {
                icon: "",
                command: ["loginctl", "poweroff"]
            },
            {
                icon: "",
                command: ["loginctl", "reboot"]
            },
            {
                icon: "󰈆",
                command: ["niri", "msg", "action", "quit"]
            }
        ]
        clip: true
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
                model: exit.actions

                delegate: Item {
                    required property var modelData

                    implicitWidth: 45
                    implicitHeight: parent.height

                    Text {
                        anchors.centerIn: parent
                        text: modelData.icon
                        font.family: Theme.font
                        font.pixelSize: Theme.fontSize
                        color: Colors.foreground
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            quit.command = modelData.command;
                            quit.running = true;
                        }
                    }
                }
            }
        }
    }
}
