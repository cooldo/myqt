import QtQuick 2.5
Rectangle {
    id: root
    width: 100
    height: 50
    color: "yellow"
    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.height = 100
        }
    }
}


