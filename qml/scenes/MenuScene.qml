//author:yanyuping
//date:2018.6.21s

import QtQuick 2.0
import Felgo 3.0
import "../common"

SceneBase {
    id: menuScene

    opacity: 0
    visible: opacity>0

    signal selectLevelPressed  //进入关卡选择
    signal helpScenePressed //进入帮助
    signal shopPressed //进入商店
    signal exit //退出游戏

    // background
    Rectangle {
        id: background

        anchors.fill: parent.gameWindowAnchorItem

        Image {
            source: "../../assets/backgroundImage/bg1.jpg"
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
        color: "lightgreen"

        radius: height / 4

        // header image
        Image {
            fillMode: Image.PreserveAspectFit

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            anchors.topMargin: 10

            source: "../../assets/ui/Header.png"
        }
    }

    PlatformerImageButton {
        id: levelButton

        image.source: "../../assets/ui/levelsBtn.png"

        width: 150
        height: 40

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: header.bottom
        anchors.topMargin: 20

        color: "lightgreen"

        radius: height / 4
        borderColor: "transparent"

        onClicked: {
            onClicked: selectLevelPressed()
        }
    }



    PlatformerImageButton {
        id: helpButton

        image.source: "../../assets/ui/helpBtn.png"

        width: 150
        height: 40

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: levelButton.bottom
        anchors.topMargin: 20

        color: "lightgreen"

        radius: height / 4
        borderColor: "transparent"

        onClicked: helpScenePressed()
    }

    PlatformerImageButton {
        id: shopButton

        image.source: "../../assets/ui/shopBtn.png"

        width: 150
        height: 40

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: helpButton.bottom
        anchors.topMargin: 20

        color: "lightgreen"

        radius: height / 4
        borderColor: "transparent"

        onClicked: {
            onClicked: shopPressed()
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

    Rectangle{
        anchors.right: parent.right
        anchors.rightMargin: dp(10)
        anchors.bottom: parent.bottom
        anchors.bottomMargin: dp(10)
        width: 60
        height: 20
        radius: 5
        color: "lightgreen"
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "退出游戏"
            font.pixelSize: sp(14)
        }
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                cursorShape=Qt.OpenHandCursor
                parent.opacity=0.8
            }
            onExited: {
                parent.opacity=1.0
            }
            onClicked: exit()
        }
    }

}
