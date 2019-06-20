import QtQuick 2.0
import Felgo 3.0
import "../common"

SceneBase {
    id: menuScene

  signal selectLevelPressed
    signal helpScenePressed
    // background
    Rectangle {
        id: background

        anchors.fill: parent.gameWindowAnchorItem

        //背景颜色渐变
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#4595e6" }
            GradientStop { position: 0.9; color: "#80bfff" }
            GradientStop { position: 0.95; color: "#009900" }
            GradientStop { position: 1.0; color: "#804c00" }
        }
    }

    // header
    Rectangle {
        id: header

        height: 95

        anchors.top: menuScene.gameWindowAnchorItem.top
        anchors.left: menuScene.gameWindowAnchorItem.left
        anchors.right: menuScene.gameWindowAnchorItem.right
        anchors.margins: 5

        // background color
        color: "#cce6ff"

        radius: height / 4

        // header image
        MultiResolutionImage {
            fillMode: Image.PreserveAspectFit

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            anchors.topMargin: 10

            source: "../../assets/ui/header.png"
        }
    }

    PlatformerImageButton {
        id: playButton

        image.source: "../../assets/ui/playButton.png"

        width: 150
        height: 40

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: header.bottom
        anchors.topMargin: 40

        color: "#cce6ff"

        radius: height / 4
        borderColor: "transparent"

        onClicked: {
              onClicked: selectLevelPressed()
        }
    }

    PlatformerImageButton {
        id: levelSceneButton

        image.source: "../../assets/ui/levelsButton.png"

        width: 150
        height: 40

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: playButton.bottom
        anchors.topMargin: 30

        color: "#cce6ff"

        radius: height / 4
        borderColor: "transparent"

        onClicked: {
            levelScene.state = "myLevels"
            levelScene.subState = "createdLevels"
            helpScenePressed()
        }
    }

    MultiResolutionImage {
        id: musicButton

        // show music icon
        source: "../../assets/ui/music.png"
        // reduce opacity, if music is disabled
        opacity: settings.musicEnabled ? 0.9 : 0.4

        anchors.top: header.bottom
        anchors.topMargin: 125
        anchors.left: parent.left
        anchors.leftMargin: 3

        MouseArea {
            anchors.fill: parent

            onClicked: {
                // switch between enabled and disabled
                if(settings.musicEnabled)
                    settings.musicEnabled = false
                else
                    settings.musicEnabled = true
            }
        }
    }
}
