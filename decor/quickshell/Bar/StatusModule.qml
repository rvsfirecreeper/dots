import QtQuick
import Quickshell.Io
import qs
Item {
    anchors.fill: parent
    anchors.margins: 10
    // Rectangle {
    //     id: wifiStatus
    //     anchors {
    //         top: parent.top
    //         bottom: parent.bottom
    //         left: parent.left
    //     }
    //     implicitWidth: 45
    //     radius: 18
    //     color: Colors.background
    //     border.color: Colors.foreground
    //     border.width: 0
    //     Process {
    //         id: connman
    //         command: ["kitty", "connmanctl"]
    //     }
    //     Text {
    //         anchors.centerIn: parent
    //         text: Status.wifistatus
    //         font.family: Theme.font
    //         font.pixelSize: Theme.fontSize
    //         color: Colors.foreground
    //     }
    //     Behavior on implicitWidth {
    //         NumberAnimation {
    //             duration: 200
    //             easing.type: Easing.InOutQuad
    //         }
    //     }
    //     MouseArea {
    //         anchors.fill: parent
    //         onClicked: connman.running = true
    //         hoverEnabled: true
    //         onEntered: wifiStatus.implicitWidth = 70
    //         onExited: wifiStatus.implicitWidth = 45
    //     }
    // }
    Process {
        id: niriFocus
        property var selectedWorkspace: 0
        running: false
        command: ["niri", "msg", "action", "focus-workspace", selectedWorkspace.toString()]
    }

    Rectangle {
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }

        width: workRow.implicitWidth + 20
        radius: 18
        color: Colors.background
        border.color: Colors.foreground
        border.width: 0
        Row {
            id: workRow
            spacing: 8
            anchors {
                fill: parent
                topMargin: 12
                bottomMargin: 12
                rightMargin: 10
                leftMargin: 10
            }
            Repeater {
                model: 9
                Rectangle {
                    width: index + 1 == Status.focusedSpace ? 50 : 20
                    height: workRow.height
                    color: index + 1 == Status.focusedSpace ? Colors.foreground : Colors.color12
                    radius: 10
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            niriFocus.selectedWorkspace = index + 1
                            niriFocus.running = true
                        }
                    }
                    Behavior on width {
                        NumberAnimation {
                            duration: 200
                            easing.type: Easing.InOutQuad
                        }
                    }
                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            }
        }
    }
}
