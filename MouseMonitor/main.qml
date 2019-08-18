import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5

Window {
    visible: true
    width: 500
    height: 500
    id: root
    title: qsTr("Hello World")
    Row {
        id: tools

        Button {
            id: clear
            text: "clear"
            onClicked: {
                console.log("clear")
                canvas.clear()
            }
        }
        Button {
            id: save
            text: "save"
            onClicked: {
                console.log("save")
                mouse.save()
            }
        }
    }
    Canvas {
        id: canvas
        anchors.top: tools.bottom
        width: root.width
        height: root.height
        property int lastx: 0
        property int lasty: 0
        function clear() {
            var ctx = getContext("2d")
            ctx.reset()
            canvas.requestPaint()
            mouse.reset()
        }

        onPaint:{
            if (lastx != area.mouseX || lasty != area.mouseY ) {
                var ctx = getContext("2d")
                ctx.lineWidth = 2
                ctx.strokeStyle = color.black
                ctx.beginPath()
                ctx.moveTo(lastx,lasty)
                //console.log("x=",lastx)
                //console.log("y=",lasty)
                lasty = area.mouseY
                lastx = area.mouseX
                //console.log("change to x=",lastx)
                //console.log("change to y=",lasty)
                ctx.lineTo(lastx,lasty)
                ctx.stroke()
                mouse.add(lastx, lasty)
           }
        }

        MouseArea {
            id: area
            anchors.fill: parent
            onPressed: {
                console.log("press")
                canvas.lastx = mouseX
                canvas.lasty = mouseY
                //canvas.requestPaint()
            }

            onPositionChanged: {
                canvas.requestPaint()

            }
        }

    }
}
