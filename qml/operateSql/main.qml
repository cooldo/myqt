import QtQuick 2.5

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
        Text {
            anchors.centerIn: parent
            text: Math.round(parent.x) + '/' + Math.round(parent.y)
        }
        MouseArea {
            anchors.fill: parent
            drag.target: parent
        }
    }

    Component.onCompleted: {
        db.initDatabase();
        var obj = db.readData();
        crazy.x = obj.x
        crazy.y = obj.y
    }

    Component.onDestruction: {
        db.storeData(crazy.x,crazy.y);
    }
    SaveDB {
        id: db
    }
}
