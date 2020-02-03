import QtQuick 2.5
import Qt.labs.settings 1.0

Item {
    width: 400
    height: 400

    Rectangle {
        id: crazy
        objectName: 'crazy'
        width: 100
        height: 100
        x: 50
        y: 50
        color: "#53d769"
        border.color: Qt.lighter(color, 1.1)
        Settings {
            fileName: "/home/gao/test.conf"
            property alias x: crazy.x
            property alias y: crazy.y
            property alias text: input.text
        }

        Text {
            id: text
            anchors.centerIn: parent
            text: Math.round(parent.x) + '/' + Math.round(parent.y)
        }
        MouseArea {
            anchors.fill: parent
            drag.target: parent

        }

    }

    TextInput {
        id: input
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 4
        focus: true
    }
}
