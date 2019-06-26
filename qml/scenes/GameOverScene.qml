//author:yanyuping
//date:2018.6.20

import Felgo 3.0
import QtQuick 2.0
import "../common"

Scene{
    opacity:0

    visible: opacity>0
    signal onceAgain //再来一次
    signal exitLevel //退出关卡

    Rectangle
    {
        color: "lightblue"
        anchors.fill: parent.gameWindowAnchorItem

        Image {
            width: 50
            height:50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: txt.top
            source: "/root/yypGame/assets/backgroundImage/hh1.png"
        }

        Text {
            id:txt
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "Game Over!"
            font.pixelSize: dp(25)
        }

        Rectangle {
            width: 80
            height: 30
            anchors.right: parent.right
            anchors.rightMargin: 40
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 40
            radius: 10
            color: "green"

            MenuButton {
                text: "再来一次"
                width: 36
                height: 36
                anchors.centerIn: parent
                buttonText.color: "lightgreen"
                buttonText.font.pixelSize: 20
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    onceAgain()
                }
            }
        }

        Rectangle {
            width: 80
            height: 30
            anchors.left: parent.left
            anchors.leftMargin: 40
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 40
            radius: 10
            color: "green"

            MenuButton {
                text: "不玩了"
                width: 36
                height: 36
                anchors.centerIn: parent
                buttonText.color: "lightgreen"
                buttonText.font.pixelSize: 20
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    exitLevel()
                }
            }
        }


    }
}
