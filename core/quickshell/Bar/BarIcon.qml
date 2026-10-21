import QtQuick
import qs

// A single icon cell in the status row. Optionally widens on hover and emits clicked.
Rectangle {
    id: root
    property string icon
    property bool interactive: true
    signal clicked

    anchors {
        top: parent.top
        bottom: parent.bottom
    }
    implicitWidth: 45
    color: "transparent"
    radius: 18

    Text {
        anchors.centerIn: parent
        text: root.icon
        font.family: Theme.font
        font.pixelSize: Theme.fontSize
        color: Colors.foreground
    }
    Behavior on implicitWidth {
        NumberAnimation {
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }
    MouseArea {
        anchors.fill: parent
        enabled: root.interactive
        hoverEnabled: true
        onClicked: root.clicked()
        onEntered: root.implicitWidth = 70
        onExited: root.implicitWidth = 45
    }
}
