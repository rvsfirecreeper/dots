import QtQuick
import Quickshell.Io
import Quickshell.Hyprland
import qs
Item {
    anchors.fill: parent
    anchors.margins: 10

    Rectangle {
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }
        clip: true
        width: workRow.implicitWidth + 24
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
                rightMargin: 12
                leftMargin: 12
            }
            Repeater {
                model: Hyprland.workspaces
                Rectangle {
                    width: modelData.active ? 50 : 20
                    height: workRow.height
                    color: modelData.active ? Colors.foreground : Colors.color12
                    radius: 10
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            modelData.activate()
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
