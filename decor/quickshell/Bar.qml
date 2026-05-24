import Quickshell // for PanelWindow
import Quickshell.Io
import Quickshell.Wayland
import QtQuick // for Text

Scope {
  id: root
  property string time

  Variants {
    model: Quickshell.screens


    // RIGHT RECTANGLE
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
      ClockModule {}
      StatusModule {}
      Artix {} // flex
      // BackgroundEffect.blurRegion: Region { item: barWindow.contentItem }
    }
  }
}
