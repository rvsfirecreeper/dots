import QtQuick
import Quickshell
import Quickshell.Io
import qs

Item {
    anchors.margins: 10
    anchors.fill: parent
    Rectangle {
        id: wifiStatus
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
        }
        implicitWidth: 45
        radius: 18
        color: Colors.background
        border.color: Colors.foreground
        border.width: 0
        Text {
            anchors.centerIn: parent
            text: Status.wifistatus
            font.family: Theme.font
            font.pixelSize: Theme.fontSize
            color: Colors.foreground
        }
    }
    Rectangle {
        id: artix
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: wifiStatus.left
            rightMargin: 10
        }
        implicitWidth: 45
        color: Colors.background
        radius: 18
        Text {
            anchors.centerIn: parent
            text: "\uF002"
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
                icon: "",
                command: ["systemctl", "poweroff"]
            },
            {
                icon: "",
                command: ["systemctl", "reboot"]
            },
            {
                icon: "󰈆",
                command: ["niri", "msg", "action", "quit"]
            },
            {
                icon: "󰤄",
                command: ["systemctl", "suspend"]
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
            command: []
            running: false
        }
        Behavior on implicitWidth {
            NumberAnimation {
                duration: 350   // milliseconds
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
            anchors {
                right: parent.right
                top: parent.top
                bottom: parent.bottom
            }
            width: exit.actions.length * 45
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
