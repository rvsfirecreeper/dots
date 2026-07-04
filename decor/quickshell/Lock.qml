import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pam

WlSessionLock {
    id: lock
    locked: true
    property bool authenticating: false

    WlSessionLockSurface {
        Rectangle {
            anchors.fill: parent
            color: Colors.background
            Image {
                anchors.fill: parent
                source: "/var/lib/rajlab-dotfiles/bg"
                visible: true
            }
            Rectangle {
                width: roasts.implicitWidth + 30
                height: roasts.implicitHeight + 20
                anchors {
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                    topMargin: 10
                }
                color: Colors.background
                radius: 20
                Text {
                    id: roasts
                    anchors.centerIn: parent
                    color: Colors.foreground
                    font.pixelSize: Theme.fontSize
                    font.family: Theme.font
                    text: "Press Enter to Authenticate, but first you should learn basic tech"
                }
            }
            Rectangle {
                width: 400
                height: 60
                anchors.centerIn: parent
                color: Colors.background
                border.color: Colors.color4
                radius: 20

                PamContext {
                    id: pam

                    // pam_unix will ask for a response for the password prompt
                    onPamMessage: {
                        if (this.responseRequired) {
                            this.respond(password.text);
                        }
                        lock.authenticating = true;
                        roasts.text = "Authenticating, but how is your attention span so low you're reading this?";
                    }

                    // pam_unix won't send any important messages so all we need is the completion status.
                    onCompleted: result => {
                        if (result == PamResult.Success) {
                            lock.locked = false;
                            Qt.quit();
                        } else {
                            password.text = "";
                            roasts.text = "You entered your own password incorrectly. Nice One.";
                            lock.authenticating = false
                        }
                    }
                }
                TextInput {
                    id: password

                    anchors.fill: parent
                    anchors.margins: 12
                    onTextEdited: {
                        if (!lock.authenticating) {
                            roasts.text = "Press Enter to Authenticate, but first you should learn basic tech";
                        }
                    }
                    focus: true
                    color: Colors.foreground
                    font.family: Theme.font
                    font.pixelSize: Theme.fontSize
                    echoMode: TextInput.Password
                    passwordCharacter: "•"
                    passwordMaskDelay: 300
                    onAccepted: pam.start()
                }
            }
        }
    }
}
