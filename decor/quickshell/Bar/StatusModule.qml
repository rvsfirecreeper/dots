import QtQuick
import Quickshell.Io
import qs
Item {
    anchors.fill: parent
    anchors.margins: 10
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
        clip: true
        width: workRow.implicitWidth + 20
        radius: 18
        color: Colors.background
        border.color: Colors.foreground
        border.width: 0
        Behavior on width {
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
        Row {
            id: workRow
            spacing: 12
            anchors {
                fill: parent
                topMargin: 12
                bottomMargin: 12
                rightMargin: 10
                leftMargin: 10
            }
            Repeater {
                model: Status.numSpaces
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
