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
    property bool isLight: false
    Process {
        id: modeQuery
        command: ["bash", "-c", "~/.scripts/walmode.sh get"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: wallpaperSwitcherWindow.isLight = text.trim() === "light"
        }
    }
    Process {
        id: modeToggle
        command: ["bash", "-c", "~/.scripts/walmode.sh toggle"]
        stdout: StdioCollector {
            onStreamFinished: wallpaperSwitcherWindow.isLight = text.trim() === "light"
        }
    }
    onVisibleChanged: if (visible) modeQuery.running = true
    Rectangle {
        anchors.fill: parent
        clip: true
        color: Qt.alpha(Colors.background, Theme.opacity)
        radius: 18
        Rectangle {
            id: modeButton
            z: 1
            anchors {
                top: parent.top
                right: parent.right
                margins: 8
            }
            width: 32
            height: 32
            radius: 16
            color: Qt.alpha(Colors.foreground, 0.15)
            Text {
                anchors.centerIn: parent
                text: wallpaperSwitcherWindow.isLight ? "󰖨" : "󰖔"
                font.family: Theme.font
                font.pixelSize: Theme.fontSize
                color: Colors.foreground
            }
            MouseArea {
                anchors.fill: parent
                onClicked: modeToggle.running = true
            }
        }
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
