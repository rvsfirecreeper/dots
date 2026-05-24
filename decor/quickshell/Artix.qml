import QtQuick
import Quickshell
import Quickshell.Io
Item {
  anchors.margins: 10
  anchors.fill: parent
  Rectangle {
    id: artix
    anchors {
      top: parent.top
      bottom: parent.bottom
      right: parent.right
    }
    implicitWidth: 45
    color: Colors.background
    radius: 18
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
      onEntered: artix.implicitWidth = 70 
      onExited: artix.implicitWidth = 45 
    }
  }
}
