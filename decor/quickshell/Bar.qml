import Quickshell // for PanelWindow
import Quickshell.Io
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
      color: "transparent"

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: 70
      ClockModule {}
      StatusModule {}
      Flex {} // flex
      // BackgroundEffect.blurRegion: Region { item: barWindow.contentItem }
    }
  }
}
