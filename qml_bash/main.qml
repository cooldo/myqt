import QtQuick 2.12
import QtQuick.Controls 1.4
import Process 1.0
ApplicationWindow {
    width: 800
    height: 480
    visible: true
    Text {
        width: parent.width
        id: text
        wrapMode: Text.Wrap
    }

    Process {
        id: process
        onReadyRead: text.text = readAll();
    }

    Timer {
        interval: 1000
        repeat: true
        triggeredOnStart: true
        running: true
        onTriggered: {
            process.start("/bin/bash",["/home/gao/test/test.sh"]);
            console.log("timeup");
        }
    }
}
