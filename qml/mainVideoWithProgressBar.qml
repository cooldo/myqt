/*
 * Copyright (c) 2013, Juergen Bocklage-Ryannel, Johan Thelin
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of the editors nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import QtQuick 2.5
import QtMultimedia 5.9

Item {
    width: 1024
    height: 600

    MediaPlayer {
        id: player
        source: "/home/gao/Videos/childhood.mp4"
        notifyInterval: 50
    }

    VideoOutput {
        anchors.fill: parent
        source: player
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            progressBar.state = (progressBar.state === "" ? "HideProgressBar":"")
            if(progressBar.state === "") {
                progressBar.timer.restart()
            }
            console.log("Swich to:", progressBar.state)
        }
    }

    Rectangle {
        id: playButton
        width: 50
        height: width
        radius: width/2
        opacity: 0.5
        color: "black"
        anchors.centerIn: parent

        function play() {
            player.play()
            playButton.radius = playButton.width/2
            console.log("video play")
        }

        function pause() {
            player.pause()
            playButton.radius = 5
            console.log("video pause")
        }

        function stop() {
            playButton.radius = 5
            console.log("video stopped")

        }

        MouseArea {
            id: playPause
            anchors.fill: parent
            onClicked: {
                switch (player.playbackState) {
                case MediaPlayer.PlayingState:
                    console.log("current is PlayingState, change to pause")
                    playButton.pause()
                    break
                case MediaPlayer.PausedState:
                    playButton.play()
                    console.log("current is PausedState, change to play ")
                    break
                case MediaPlayer.StoppedState:
                    console.log("current is StoppedState, change to play")
                    playButton.play()
                    break
                }
                if(progressBar.state === "") {
                    progressBar.timer.restart()
                }
            }
        }
    }
    Connections {
        target: player
        onStopped: {
            playButton.stop()
            progressBar.state = ""
        }
    }

    Rectangle {
        id: progressBar
        opacity: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 100
        height: 30
        color: "lightGray"
        property alias timer: timer

        Rectangle {
            //opacity: progressBar.opacity
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: player.duration>0?parent.width*player.position/player.duration:0
            color: "darkGray"
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            enabled: true

            onClicked: {
                console.log("seekable mouse pressed")
                if (player.seekable) {
                    player.seek(player.duration * mouse.x/width);
                    timer.restart()
                }
            }
        }

        states:
            State {
                name: "HideProgressBar"
                PropertyChanges { target: progressBar; opacity: 0 }
                PropertyChanges { target: mouseArea; enabled: false }
                PropertyChanges { target: timer; running:false }
                PropertyChanges { target: playButton; opacity:0 }
            }

        transitions: [
            Transition {
                PropertyAnimation { target: progressBar; properties: "opacity"; duration: 500 }
            }
        ]
        Timer {
            id: timer
            interval: 5000
            repeat: false
            running: true
            onTriggered: {
                console.log("timer triggered")
                if ( progressBar.state == "")
                    progressBar.state = "HideProgressBar"
            }
        }
    }
    Component.onCompleted: {
        player.play();
    }
}
