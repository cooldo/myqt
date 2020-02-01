import QtQuick 2.5
import QtMultimedia 5.9

Item {
    width: 1024
    height: 600

    MediaPlayer {
        id: player
        source: "/home/gao/Videos/childhood.mp4"
        notifyInterval: 50

    }

    VideoOutput {
        anchors.fill: parent
        source: player
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log("Mouse Pressed")
            progressBar.state = (progressBar.state == "" ? "HideProgressBar":"")
        }
    }

    Rectangle {
        id: progressBar
        opacity: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 100
        height: 30
        color: "lightGray"

        Rectangle {
            //opacity: progressBar.opacity
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: player.duration>0?parent.width*player.position/player.duration:0
            color: "darkGray"
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            enabled: true

            onClicked: {
                console.log("seekable mouse pressed")
                if (player.seekable) {
                    player.seek(player.duration * mouse.x/width);
                    timer.restart()
                }
            }
        }

        states:
            State {
                name: "HideProgressBar"
                PropertyChanges { target: progressBar; opacity: 0 }
                PropertyChanges { target: mouseArea; enabled: false }
                PropertyChanges { target: timer; running:false }
            }

        transitions: [
            Transition {
                PropertyAnimation { target: progressBar; properties: "opacity"; duration: 500 }
            }
        ]
        Timer {
            id: timer
            interval: 5000
            repeat: false
            running: true
            onTriggered: {
                console.log("timer triggered")
                if ( progressBar.state == "")
                    progressBar.state = "HideProgressBar"
            }
        }
    }
/*
  mediaObject
    Connections {
        target: player
        onMediaObjectChanged: {
            if (player.mediaObject) {
                player.mediaObject.notifyInterval = 50;
            }
        }
    }
*/
    Component.onCompleted: {
        player.play();
        /*
        if (player.mediaObject) {
            player.mediaObject.notifyInterval = 50;
        }
        */
    }
}
