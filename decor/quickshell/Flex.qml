import QtQuick
import Quickshell
import Quickshell.Io
Item {
  anchors.margins: 10
  anchors.fill: parent
  Rectangle {
    id: flex
    anchors {
      top: parent.top
      bottom: parent.bottom
      right: parent.right
    }
    implicitWidth: 50
    radius: 18
    color: Colors.background
    opacity: Theme.opacity
    border.color: Colors.color3
    border.width: 3
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
      onEntered: flex.implicitWidth = 70 
      onExited: flex.implicitWidth = 50 
    }
  }
}
