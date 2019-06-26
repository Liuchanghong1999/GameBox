//author:yanyuping
//date:2018.6.22

import Felgo 3.0
import QtQuick 2.0
import "../common"

SceneBase {

    signal backPressed


    Rectangle{
        anchors.fill: parent.gameWindowAnchorItem

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: dp(20)

            source: "../../assets/ui/helpBtn.png"
        }

        color: "lightblue"

        Text {
            anchors.left: parent.left
            anchors.leftMargin: dp(10)
            anchors.top:parent.top
            anchors.topMargin: dp(70)
            text: "踩在老鼠上面，或是躲避它"
        }

        Image {
            anchors.left: parent.left
            anchors.leftMargin: dp(50)
            anchors.top:parent.top
            anchors.topMargin: dp(100)
            width: 25
            height: 25
            source: "../../assets/opponent/opponent_walker.png"
        }
        Image {
            anchors.top:parent.top
            anchors.topMargin: dp(100)
            anchors.left: parent.left
            anchors.leftMargin: dp(100)
            width: 25;height: 25
            source: "../../assets/opponent/opponent_walker_dead.png"
        }

        Text {
            anchors.left: parent.left
            anchors.leftMargin: dp(10)
            anchors.top:parent.top
            anchors.topMargin: dp(140)
            text: "你只能躲避它"
        }

        Image {
            anchors.top:parent.top
            anchors.topMargin: dp(160)
            anchors.left: parent.left
            anchors.leftMargin: dp(50)
            width: 25
            height: 25
            source: "../../assets/opponent/opponent_jumper.png"
        }

        Text {
            anchors.left: parent.left
            anchors.leftMargin: dp(10)
            anchors.top:parent.top
            anchors.topMargin: dp(200)
            text: "你需要躲避它的子弹"
        }

        Image {
            anchors.top:parent.top
            anchors.topMargin: dp(220)
            anchors.left: parent.left
            anchors.leftMargin: dp(40)
            width: 40
            height: 40
            source: "../../assets/opponent/plant.png"
        }




    }

    Rectangle {
        width: parent.gameWindowAnchorItem.width
        height: 40
        color: "#00000000"

        anchors.top: parent.gameWindowAnchorItem.top
        anchors.left: parent.gameWindowAnchorItem.left

        // back to menu button
        PlatformerImageButton {
            id: menuButton

            image.source: "../../assets/ui/home.png"

            width: 40
            height: 30

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 5

            // go back to MenuScene
            onClicked: backPressed()
        }
    }

}
