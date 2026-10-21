import QtQuick
import Quickshell.Io
import qs

Rectangle {
    id: root
    readonly property var actions: [
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
            icon: "󰒲",
            command: ["systemctl", "suspend"]
        },
        {
            icon: "󰌾",
            command: ["bash", "-c", "qs -p ~/.config/quickshell/Lock.qml"]
        }
    ]
    property bool expanded: false

    anchors {
        top: parent.top
        bottom: parent.bottom
    }
    clip: true
    implicitWidth: expanded ? actions.length * 45 : 45
    color: "transparent"
    radius: 18

    Process {
        id: quit
        command: []
        running: false
    }
    Behavior on implicitWidth {
        NumberAnimation {
            duration: 350
            easing.type: Easing.InOutQuad
        }
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: root.expanded = true
        onExited: root.expanded = false
    }
    Row {
        anchors {
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }
        width: root.actions.length * 45
        Repeater {
            model: root.actions

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
