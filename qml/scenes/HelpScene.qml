//author:yanyuping
//date:2018.6.22

import Felgo 3.0
import QtQuick 2.0
import "../common"

SceneBase {

    signal backPressed


    Rectangle{
        anchors.fill: parent.gameWindowAnchorItem



        color: "lightblue"

        Image {
            width: 50
            height:36
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: txt.top
            source: "/root/yypGame/assets/backgroundImage/hh2.jpg"
        }

        Text {
            id:txt
            anchors.centerIn: parent
            text: "Help!"
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
