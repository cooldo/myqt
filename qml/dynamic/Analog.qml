import QtQuick 2.5

Item {
    property int speed: 0

        width: 640
        height: 640
    Rectangle {
        anchors.centerIn: parent

        width: 240
        height: 240

        radius: 120
        opacity: 0
        color: "lightGray"
    }

    Rectangle {
        id: needle

        anchors.right: parent.horizontalCenter
        anchors.top: parent.verticalCenter

        width: 120
        height: 2

        color: "red"

        transformOrigin: Item.Right
        rotation: -45 + speed
    }

    Repeater {
        model: 11

        Item {
            anchors.right: parent.horizontalCenter
            anchors.top: parent.verticalCenter

            width: 140
            height: 2

            transformOrigin: Item.Right
            rotation: -45 + index*270/10

            Rectangle {
                width: 8
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 16

                color: "black"
            }

            Text {
                anchors.horizontalCenter: parent.left
                anchors.verticalCenter: parent.top

                text: index*270/10

                rotation: 45 - index*270/10
            }
        }
    }
}
