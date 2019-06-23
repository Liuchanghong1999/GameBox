//author:yanyuping
//date:2018.6.23

import Felgo 3.0
import QtQuick 2.9
import QtQuick.Controls 2.5


Scene{
    opacity: 0
    visible: opacity>0

    signal backPressed

    Rectangle {
        id: mainRec
        color: "lightblue"
        anchors.fill: parent.gameWindowAnchorItem

        Rectangle{
            width: dp(40)
            height: dp(30)
            color: "steelblue"
            radius: 3
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: "返回"
                font.pixelSize: sp(18)
            }
            MouseArea{
                anchors.fill: parent
                onClicked: backPressed()
            }
        }

        Rectangle{
            id: middleRect

            anchors.horizontalCenter: parent.horizontalCenter

            anchors.verticalCenter: parent.verticalCenter

            width: dp(20); height: dp(20)
            color: "transparent"; //border.color: "Gray"; radius: 6

            MouseArea{
                anchors.fill: parent;
                onClicked: mainRec.state="middleRight"
            }
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: middleRect.top
            anchors.bottomMargin: dp(30)
            text: "Please enter your name"
            font.pixelSize: sp(10)
        }

        TextArea{
            id:name
            width: 120
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: middleRect.bottom
            font.pixelSize: sp(18)
            placeholderText:"Enter name"
        }

        Rectangle{
            id:check
            width: dp(80)
            height: dp(25)
            border.color: "black"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top:name.bottom
            anchors.topMargin: dp(5)
            Text{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: "点击查询密码"
                font.pixelSize: sp(10)
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    check_success.visible=true
                    //changeInfoPage.allInfoPage.visible=true
                }
            }

        }
    }

    Rectangle{
        id:check_success
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: false
        width: 150
        height: 30
        color: "yellow"
        opacity: 0.4
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "Your password : " + "123456"
            font.pixelSize: sp(14)
        }
        MouseArea{
            anchors.fill: parent
            onClicked: parent.visible=false

        }
    }

}
