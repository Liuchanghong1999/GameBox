//author:yanyuping
//date:2018.6.21

import Felgo 3.0
import QtQuick 2.0
import "../common"

Scene {

    opacity: 0
    visible: opacity>0

    signal backPressed  //返回到关卡选择
    signal nextLevelPressed  //进入到下一关

    Rectangle{
        anchors.fill: parent.gameWindowAnchorItem
        color: "lightblue"

        Image {
            width: 50
            height:36
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: txt.top
            source: "/root/yypGame/assets/backgroundImage/hh2.png"
        }

        Text {
            id:txt
            anchors.centerIn: parent
            text: "Congratulations!"
            font.pixelSize: 25
        }

        Rectangle {
            width: 100
            height: 25
            anchors.top:txt.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            radius: 10
            color: "green"

            MenuButton {
                text: "下一关"
                width: 36
                height: 36
                anchors.centerIn: parent
                buttonText.color: "lightgreen"
                buttonText.font.pixelSize: 20
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    console.log("hahahahah")
                    nextLevelPressed()
                }
            }
        }

        Rectangle {
            width: 140
            height: 25
            anchors.top:txt.bottom
            anchors.topMargin: 70
            anchors.horizontalCenter: parent.horizontalCenter
            radius: 10
            color: "green"

            MenuButton {
                text: "返回关卡界面"
                width: 36
                height: 36
                anchors.centerIn: parent
                buttonText.color: "lightgreen"
                buttonText.font.pixelSize: 20
            }
            MouseArea{
                anchors.fill: parent
                onClicked: backPressed()
            }
        }

    }
}
