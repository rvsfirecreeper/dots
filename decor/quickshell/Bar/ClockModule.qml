import QtQuick
import qs
Item {
  anchors.margins: 10
  anchors.fill: parent
  Rectangle {
    anchors {
      top: parent.top
      bottom: parent.bottom
      horizontalCenter: parent.horizontalCenter
    }
    implicitWidth: 100
    radius: 18
    color: Colors.background
    opacity: Theme.opacity
    border.color: Colors.color3
    border.width: 0
    Text {
        anchors.centerIn: parent
        time: Time.time
        required property string time
        text: time
        font.family: Theme.font
        font.pixelSize: Theme.fontSize
        color: Colors.foreground
    }
  }
}
