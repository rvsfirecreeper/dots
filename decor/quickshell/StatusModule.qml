import QtQuick
import Quickshell
import Quickshell.Io

Item {
    anchors.fill: parent
    anchors.margins: 10
    Rectangle {
        id: wifiStatus
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }
        implicitWidth: 45
        radius: 18
        color: Colors.background
        border.color: Colors.foreground
        border.width: 0
        Process {
            id: connman
            command: ["kitty", "connmanctl"]
        }
        Text {
            anchors.centerIn: parent
            text: Status.wifistatus
            font.family: Theme.font
            font.pixelSize: Theme.fontSize
            color: Colors.foreground
        }
        Behavior on implicitWidth {
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: connman.running = true
            hoverEnabled: true
            onEntered: wifiStatus.implicitWidth = 70
            onExited: wifiStatus.implicitWidth = 45
        }
    }
    Rectangle {
        id: focusedStatus
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: wifiStatus.right
            leftMargin: 10
        }
        implicitWidth: 45
        radius: 18
        color: Colors.background
        border.color: Colors.foreground
        border.width: 0
        Text {
            anchors.centerIn: parent
            text: Status.focusedSpace
            font.family: Theme.font
            font.pixelSize: Theme.fontSize
            color: Colors.foreground
        }
    }

    Process {
        id: niriUp
        running: false
        command: ["niri", "msg", "action", "focus-workspace-up"]
    }

    Process {
        id: niriDown
        running: false
        command: ["niri", "msg", "action", "focus-workspace-down"]
    }
    Rectangle {
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: focusedStatus.right
            leftMargin: 10
        }

        implicitWidth: 45
        radius: 18
        color: Colors.background
        border.color: Colors.foreground
        border.width: 0

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: parent.implicitWidth = 70
            onExited: parent.implicitWidth = 45
        }
        Behavior on implicitWidth {
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
        Item {
            id: workUp
            anchors {
                top: parent.top
                topMargin: 5
                bottom: parent.verticalCenter
                left: parent.left
                right: parent.right
            }

            Text {
                anchors.centerIn: parent
                text: ""
                font.family: Theme.font
                font.pixelSize: Theme.fontSize
                color: Colors.foreground
            }

            MouseArea {
                anchors.fill: parent
                onClicked: niriUp.running = true
            }
        }

        Item {
            id: workDown
            anchors {
                top: parent.verticalCenter
                bottom: parent.bottom
                bottomMargin: 5
                left: parent.left
                right: parent.right
            }

            Text {
                anchors.centerIn: parent
                text: ""
                font.family: Theme.font
                font.pixelSize: Theme.fontSize
                color: Colors.foreground
            }

            MouseArea {
                anchors.fill: parent
                onClicked: niriDown.running = true
            }
        }
    }
}
