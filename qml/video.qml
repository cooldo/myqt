import QtQuick 2.7
import QtMultimedia 5.9

Item {
    width: 480
    height: 320
    property string videoSrc: "car.avi"

    VideoOutput {
        id: videOutput
        anchors.fill: parent
        source: mediaPlayer

        MediaPlayer {
            id: mediaPlayer
            source: videoSrc
            autoLoad: false
            loops: 1
            property int passess: 0
            onStopped: {
                console.log("stoped")
            }

            onPositionChanged: {
                passess++
                console.log("position changed", passess)
            }
        }

        Timer {
            running: true
            repeat: true
            interval: 5000
            onTriggered: {
               mediaPlayer.seek(0)
               console.log("seek to 0")
            }
        }
    }
    Component.onCompleted: {
        mediaPlayer.play()
    }
}
