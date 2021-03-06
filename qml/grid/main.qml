import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: main
    visible: true
    width: 400
    height: 400

    GridSection {
        id: grid
        MouseArea {
            anchors.fill: parent
            onClicked: {
                grid.appendNewItem("2001-3-10-02:10:10")
            }
        }

        anchors.fill: parent
        columns: 10
        model: ListModel {
            ListElement { name: "2001-3-10-02:02:03"; section: "section1" }
            ListElement { name: "2001-3-10-03:10:03"; section: "section1" }
            ListElement { name: "2001-3-10-01:08:03"; section: "section1" }
            ListElement { name: "2001-3-10-01:11:03"; section: "section1" }
            ListElement { name: "2001-3-10-02:02:03"; section: "section1" }
            ListElement { name: "2001-3-10-03:02:03"; section: "section1" }
            ListElement { name: "2001-3-10-03:10:03"; section: "section1" }
            ListElement { name: "2001-3-10-01:08:03"; section: "section1" }
            ListElement { name: "2001-3-10-01:11:03"; section: "section1" }
            ListElement { name: "2001-3-10-02:02:03"; section: "section1" }
        }
        itemDelegate: Rectangle {
            property string name
            color: "black"
            property int index;
            width: 100
            height: 120
            Rectangle {
                color: "black"
                id: forImage
                anchors.top: parent.top
                width: 100
                height: 100
                Image {
                    id: snapshot
                    //anchors.fill: parent
                    anchors.fill: parent
                    anchors.margins: 10
                    source: name + ".jpg"
                }
            }

            Text {
                anchors.top: forImage.bottom
                //anchors.verticalCenter: forImage.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                text: name.split("-")[3]
                color: "gray"
                //anchors.centerIn: parent
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("gaoqiang")
                    console.log("gaoqiang, name:" + name)
                    console.log("gaoqiang, index:" + index)
                }

            }
        }
        sectionDelegate: Rectangle {
            property string name
            width: 300
            height: 20
            color: "black"
            Text {
                text: name
                color: "white"
                //anchors.centerIn: parent
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
        }
    }
}
