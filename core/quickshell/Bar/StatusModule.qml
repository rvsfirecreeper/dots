import QtQuick
import qs
Rectangle {
    id: root
    anchors {
        right: parent.right
        top: parent.top
        bottom: parent.bottom
        margins: 10
    }
    color: Theme.isPill ? "transparent" : Qt.alpha(Colors.background, Theme.opacity)
    implicitWidth: statusRow.implicitWidth + 20
    implicitHeight: parent.height
    radius: 18
    required property WallpaperSwitcher wallSwitcher
    Row {
        id: statusRow
        anchors.margins: 10
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        height: parent.height
        spacing: 10
        layoutDirection: Qt.RightToLeft

        LauncherButton {}
        BarIcon {
            icon: "󰸉"
            onClicked: root.wallSwitcher.visible = !root.wallSwitcher.visible
        }
        WifiIndicator {}
        PowerMenu {}
    }
}
