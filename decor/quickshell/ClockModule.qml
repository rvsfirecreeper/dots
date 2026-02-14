import QtQuick

Text {
    required property string time
    text: time
    font.family: Theme.font
    font.pixelSize: Theme.fontSize
    color: Colors.foreground
}
