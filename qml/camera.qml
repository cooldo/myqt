import QtQuick 2.5
import QtMultimedia 5.6

Item {
    width: 640
    height: 360
    property string myDir: "/home/gao/test/qt/PIC_"
    property int id: 0

    Camera {
        id: camera
        imageCapture {
            onImageSaved : {
                console.log("saved path: " + path);
            }
        }
    }

    VideoOutput {
        source: camera
        focus : visible // to receive focus and capture key events when visible
        anchors.fill: parent
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                id++;
                camera.imageCapture.captureToLocation(myDir+id);
            }
        }
    }
}
