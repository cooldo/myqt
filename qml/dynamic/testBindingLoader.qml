import QtQuick 2.5

Rectangle {
    width: 640
    height: 480
    id: root
    color: "black"
    Loader {
        id: loader
        source: "Button1.qml"
        onLoaded: {
            binder.target = loader.item
        }
    }

    Binding {
        id: binder
        target: null
        property: "height"
        value: root.height
    }
}
