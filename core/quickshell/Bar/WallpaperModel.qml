import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root

    property string wallpaperDir: Quickshell.env("HOME") + "/dots/wallpaper"

    property var wallpapers: []

    Process {
        id: scanner

        command: [
            "bash",
            "-c",
            "find " + wallpaperDir +
            " -type f \\( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \\)"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                root.wallpapers = text.trim().split("\n")
            }
        }
    }

    Component.onCompleted: {
        scanner.running = true
    }
}
