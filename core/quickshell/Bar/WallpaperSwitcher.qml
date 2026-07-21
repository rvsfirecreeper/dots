import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs
PopupWindow {
    id: wallpaperSwitcherWindow
    required property QsWindow window 
    color: "transparent"
    WallpaperModel {
        id: wallpaperModel
    }
    implicitWidth: 500
    implicitHeight: 500
    anchor.window: window
    anchor.rect.x: window.width - implicitWidth - 20
    anchor.rect.y: window.height
    visible: false
    Process {
        id: wallpaperProcess

        command: [
            "fullwal.sh",
            ""
        ]
    }
    Rectangle {
        anchors.fill: parent
        clip: true
        color: Qt.alpha(Colors.background, Theme.opacity)
        radius: 18
        GridView {
            anchors.fill: parent
            anchors.margins: 20
            model: wallpaperModel.wallpapers

            cellWidth: 200
            cellHeight: 150
        
            delegate: Rectangle {
                width: 180
                height: 120
                color: "transparent"
                radius: 8

                clip: true

                Image {
                    anchors.fill: parent

                    source: "file://" + modelData
                    asynchronous: true
                    cache: true
                    sourceSize.height: 200
                    sourceSize.width: 300
                    fillMode: Image.PreserveAspectCrop
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        wallpaperProcess.command = [
                            "fullwal.sh",
                            modelData
                        ]

                        wallpaperProcess.startDetached()
                        wallpaperSwitcherWindow.visible = false
                    }
                }
            }
        }
    }
}
