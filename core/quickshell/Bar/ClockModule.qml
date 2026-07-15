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
        color: Qt.alpha(Colors.background, Theme.opacity)
        implicitWidth: text.width + 40
        border.color: Colors.color3
        border.width: 0
        Text {
            anchors.centerIn: parent
            id: text
            time: Time.time
            required property string time
            text: time
            font.family: Theme.font
            font.pixelSize: Theme.fontSize
            color: Colors.foreground
        }
    }
}
