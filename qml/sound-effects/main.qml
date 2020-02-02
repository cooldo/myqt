import QtQuick 2.5
import QtMultimedia 5.6

Item {
    id: window

    width: 1024
    height: 600

    MouseArea {
        anchors.fill: parent
        onClicked: {
            window.state = (window.state === "upsidedown" ? "": "upsidedown")
        }
    }

    // Play sound when the button is clicked

    // M1>>
    SoundEffect {
        id: beep
        source: "beep.wav"
    }

    Rectangle {
        id: button

        anchors.centerIn: parent

        width: 200
        height: 100

        color: "red"

        MouseArea {
            anchors.fill: parent
            onClicked: beep.play()
        }
    }
    // <<M1

    states: [
        State {
            name: "upsidedown"
            PropertyChanges { target: button; rotation: 180; }
        }
    ]

    // Play sound on a state change

    // M2>>
    SoundEffect {
        id: swosh
        source: "swosh.wav"
    }

    transitions: [
        Transition {
            ParallelAnimation {
                ScriptAction { script: swosh.play(); }
                PropertyAnimation { properties: "rotation"; duration: 200; }
            }
        }
    ]
    // <<M2
}
