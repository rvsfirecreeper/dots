import QtQuick
Item {
  anchors.margins: 10
  anchors.fill: parent
  Rectangle {
    anchors {
      top: parent.top
      bottom: parent.bottom
      left: parent.left
    }
    implicitWidth: 50
    radius: 18
    color: Colors.background
    opacity: Theme.opacity
    border.color: Colors.color3
    border.width: 3
    Text {
        anchors.centerIn: parent
        property string status
        status: Status.status
        text: status
        font.family: Theme.font
        font.pixelSize: Theme.fontSize
        color: Colors.foreground
    }
  }
}
