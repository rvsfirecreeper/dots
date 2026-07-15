import Quickshell // for PanelWindow
import Quickshell.Io
import Quickshell.Wayland
import QtQuick // for Text
import qs.Bar
Scope {
  id: root
  property string time

  Variants {
    model: Quickshell.screens


    PanelWindow {
      id: barWindow
      required property var modelData
      screen: modelData
      color: "#00000000"
      anchors {
        top: true
        left: true
        right: true
      }
      implicitHeight: 60
      // ROOT RECTANGLE
      Rectangle {
        anchors.margins: 10
        opacity: Theme.opacity
        color: Colors.background
        anchors.fill: parent
        radius: 18
      }
      ClockModule {}
      WorkspaceModule {}
      StatusModule {} // flex
    }
  }
}
