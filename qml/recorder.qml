import QtQuick 2.5
import QtMultimedia 5.6

Item {
    width: 640
    height: 360
    property string myDir: "/home/gao/test/qt/"
    property int id: 0


    Camera {
        id: camera
        captureMode: Camera.CaptureVideo


        videoRecorder {
           //videoCodec: h264
           //mediaContainer: ogg
             //resolution: "640x480"
             //frameRate: 30
        }
    }

    VideoOutput {
        source: camera
        focus : visible // to receive focus and capture key events when visible
        anchors.fill: parent
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                if (id%2 == 0 ){
                    camera.videoRecorder.outputLocation= myDir+id/2
                    console.log("start recording")
                    camera.videoRecorder.record()
                    console.log("start recording location:" + camera.videoRecorder.actualLocation)
                }
                else {
                    camera.videoRecorder.stop()
                    console.log("stop recording")
                }
                id++;
            }
        }
    }
}
