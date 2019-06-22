//author:yanyuping
//date:2018.6.21

import Felgo 3.0
import QtQuick 2.0
import "../common"

Scene {

    opacity: 0
    visible: opacity>0

    signal backPressed
    signal nextLevelPressed

    Rectangle{
        anchors.fill: parent
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
            text: "Congratulations!"
        }


        Rectangle {
            width: 140
            height: 40
            anchors.top:txt.bottom
            anchors.topMargin: 20
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
