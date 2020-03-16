import QtQuick 2.0
import QtMultimedia 5.4
Rectangle {
    id : cameraUI

    width: 800
    height: 480

    Timer {
        id: startCapture
        interval: 12000
        running: true
        repeat: true
        onTriggered: {
            console.log("start timer")
            camera.videoRecorder.stop()
            var date=new Date();
            var Y=date.getFullYear()+'-';
            var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
            var D=date.getDate()+'-';
            var h=date.getHours()+'-';
            var m=date.getMinutes()+'-';
            var s=date.getSeconds()
            var fileName=Y+M+D+h+m+s
            //console.log(Y+M+D+h+m+s);
            camera.videoRecorder.outputLocation = fileName
            camera.videoRecorder.record()
            console.log(Y+M+D+h+m+s);
        }
    }


    Camera {
        id: camera
        captureMode: Camera.CaptureStillImage

        imageCapture {
            onImageCaptured: {
                //photoPreview.source = preview
                //stillControls.previewAvailable = true
                //cameraUI.state = "PhotoPreview"
            }
        }

        videoRecorder {
             resolution: "640x480"
             frameRate: 30
             outputLocation: "/home/gao/work/qt/untitled7/test_"
        }
        //videoRecorder.mediaContainer: "mp4"

    }

    VideoOutput {
     id: viewfinder
     //visible: cameraUI.state == "PhotoCapture" || cameraUI.state == "VideoCapture"

     x: 0
     y: 0
     //width: parent.width - stillControls.buttonsPanelWidth
     //height: parent.height
     anchors.fill: parent

     source: camera
     autoOrientation: true
    }
    MouseArea {
        anchors.fill: parent
        property bool flag: false
        onClicked: {
            //console.log("key pressed"+ camera.videoRecorder.actualLocation)
            console.log("key pressed")
            //flag = !flag
            //flag === true?  camera.videoRecorder.record() : camera.videoRecorder.stop()
            //startCapture.start()
            startCapture.restart()
        }
    }
}
