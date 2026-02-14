import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
Scope {
  id: root
  property string time
  Variants {
    model: Quickshell.screens;

    PanelWindow {
      required property var modelData
      screen: modelData
      color: "transparent"
      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: 70
      Item {
        anchors.margins: 10
        anchors.fill: parent
        Rectangle {
          anchors.fill: parent
          radius: 18
          color: Colors.background
          opacity: Theme.opacity
          border.color: Colors.color3
          border.width: 2
          ClockModule {
            // center the bar in its parent component (the window)
            anchors.centerIn: parent
            time: Time.time
          }
        }
      }
    }
  }
}
