import QtQuick
import Quickshell
import Quickshell.Io
Item {
  anchors.margins: 10
  anchors.fill: parent
  Rectangle {
    id: status
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
        text: Status.status
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
      onEntered: status.implicitWidth = 70
      onExited: status.implicitWidth = 50
    }
  }
}
