import QtQuick 2.5
Rectangle {
    width: 100
    height: 50
    signal childClicked(var test)
    color: "yellow"
    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log("child clicked")
            var test=false
            childClicked(test)
        }
    }
}


