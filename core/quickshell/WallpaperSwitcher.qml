import QtQuick
import Quickshell
import Quickshell.Io
import qs.WallpaperSwitcher
PanelWindow {
    id: root

    implicitWidth: 840
    implicitHeight: 600
    visible: true
    color: "transparent"
    WallpaperModel {
        id: wallpaperModel
    }

    Process {
        id: wallpaperProcess

        command: [
            "fullwal.sh",
            ""
        ]
        onExited: {
            Qt.quit()
        }
    }
    Rectangle {
        anchors.fill: parent
        clip: true
        color: Colors.background
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

                        wallpaperProcess.running = true
                    }
                }
            }
        }
    }
}
