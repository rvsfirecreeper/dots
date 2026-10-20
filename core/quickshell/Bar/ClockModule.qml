import QtQuick
import qs

Item {
    anchors.margins: 10
    anchors.fill: parent
    Rectangle {
        anchors {
            top: parent.top
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
        radius: 18
        color: Theme.isPill ? "transparent" : Qt.alpha(Colors.base, Theme.opacity)
        implicitWidth: text.width + 40
        border.color: Colors.yellow
        border.width: 0
        Text {
            anchors.centerIn: parent
            id: text
            time: Time.time
            required property string time
            text: time
            font.family: Theme.font
            font.pixelSize: Theme.fontSize
            color: Colors.text
        }
    }
}
