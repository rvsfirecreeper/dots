import QtQuick
import Quickshell
import Quickshell.Io
Item {
  anchors.margins: 10
  anchors.fill: parent
  Rectangle {
    id: wifiStatus
    anchors {
      top: parent.top
      bottom: parent.bottom
      left: parent.left
    }
    implicitWidth: 50
    radius: 18
    color: "#00000000"
    opacity: Theme.opacity
    border.color: "#00000000"
    border.width: 3
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
      onExited: wifiStatus.implicitWidth = 50
    }
  }
  Rectangle {
    id: focusedStatus
    anchors {
      top: parent.top
      bottom: parent.bottom
      left: parent.left
      leftMargin: 50
    }
    implicitWidth: 50
    radius: 18
    color: "#00000000"
    opacity: Theme.opacity
    border.color: "#00000000"
    border.width: 3
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

  Rectangle {
    id: workUp
    anchors {
      top: parent.top
      bottom: parent.verticalCenter
      left: focusedStatus.left
      leftMargin: 50
    }
    implicitWidth: 50
    radius: 18
    color: "#00000000"
    opacity: Theme.opacity
    border.color: "#00000000"
    border.width: 3
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
  Process {
    id: niriDown
    running: false
    command: ["niri", "msg", "action", "focus-workspace-down"]
  }
  Rectangle {
    id: workDown
    anchors {
      top: parent.verticalCenter
      bottom: parent.bottom
      left: focusedStatus.left
      leftMargin: 50
    }
    implicitWidth: 50
    radius: 18
    color: "#00000000"
    opacity: Theme.opacity
    border.color: "#00000000"
    border.width: 3
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
      hoverEnabled: true
    }
  }
}
