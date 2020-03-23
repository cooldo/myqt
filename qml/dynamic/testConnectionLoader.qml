import QtQuick 2.5

Rectangle {
    width: 640
    height: 480
    color: "black"
    Loader {
        id: loader
        source: "Button.qml"
        onLoaded: {
            connection.target = loader.item
        }
    }
    function testParent() {
        console.log("parent received")
    }
    Connections {
        id: connection
        target: null
        onChildClicked:{
            console.log("child para: "+test)
            testParent()
        }
    }
}
