import QtQuick
import Quickshell
import Quickshell.Io
import qs

Rectangle {
    anchors {
        right: parent.right
        top: parent.top
        bottom: parent.bottom
        margins: 10
    }
    color: Theme.isPill ? "transparent" : Qt.alpha(Colors.background, Theme.opacity)
    implicitWidth: statusRow.implicitWidth + 20
    implicitHeight: parent.height
    radius: 18
    Row {
        id: statusRow
        anchors.margins: 10
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        height: parent.height
        spacing: 10
        layoutDirection: Qt.RightToLeft
        Rectangle {
            id: arch
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            implicitWidth: 45
            color: "transparent"
            radius: 18
            Text {
                anchors.centerIn: parent
                text: Status.os
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
                onEntered: arch.implicitWidth = 70
                onExited: arch.implicitWidth = 45
            }
        }
        Rectangle {
            id: wifiStatus
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            implicitWidth: 45
            radius: 18
            color: "transparent"
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
            id: exit
            property var actions: [
                {
                    icon: "󰌾",
                    command: ["bash", "-c", "qs -p ~/.config/quickshell/Lock.qml"]
                },
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
                    command: ["hyprctl", "dispatch", "hl.dsp.exit()"]
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
            }
            implicitWidth: expanded ? exit.actions.length * 45 : 45
            color: "transparent"
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
}
