//author:yanyuping
//date:2018.6.15


import Felgo 3.0
import QtQuick 2.9
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import Mario 1.0
import "../common"

Scene{
    opacity: 0
    visible: opacity>0
    property alias gobackhome: gobackhome
    signal enterGame
    signal exit

    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem


        border.color: "red"
        color: "white"


        Rectangle{
            id:middleRec
            width: dp(5);height: dp(5)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "red"
        }

        Rectangle{
            id:background
            height: middleRec.y-dp(40)
            anchors.right: parent.right
            anchors.left: parent.left
            border.color: "grey"
            color: "lightblue"
        }

        Rectangle{
            id:cover
            visible: true
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            height: parent.height-background.height
            Image {
                width: 960
                fillMode: Image.PreserveAspectCrop
                source: "../../assets/backgroundImage/bg4.png"
            }
            Rectangle{
                width: 150
                height: 40
                radius: 5
                border.color: "lightgreen"
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                MenuButton {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: "进入游戏"
                    width: 36
                    height: 36
                    buttonText.color: "lightgreen"
                    buttonText.font.pixelSize: 24
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        cursorShape=Qt.OpenHandCursor
                        parent.opacity=0.2
                    }
                    onExited: {
                        parent.opacity=1.0
                    }
                    onClicked: {
                        enterGame()
                    }
                }
            }
        }


        Text {
            anchors.topMargin: 4
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.rightMargin: 4
            text: "退出登录"
            color: "white"
            font.pixelSize: sp(14)
            MouseArea{
                id: gobackhome
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    cursorShape=Qt.OpenHandCursor
                    parent.opacity=0.5
                }
                onExited: {
                    parent.opacity=1.0
                }
                onClicked: exit()
            }
        }


        Image {
            id: avatar
            width: dp(80)
            height: dp(80)
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: background.height-height/2
            anchors.leftMargin: dp(10)
            source: "images/avatar.jpg"
            smooth: true
            antialiasing: true
            visible: false

        }

        Rectangle{
            id: mask
            radius: height/2
            anchors.fill: avatar
            visible: false
            antialiasing: true
            smooth: true
            color: "black"
        }

        OpacityMask {
            id:avatarArea
            anchors.fill: avatar
            source: avatar
            maskSource: mask
            visible: true
            antialiasing: true
        }

        //    Text {
        //        id: name
        //        anchors.bottom: background.bottom
        //        anchors.left: avatarArea.right
        //        anchors.leftMargin: dp(20)
        //        color: "#fdfdfd"
        //        text:display_name
        //        font.pixelSize: sp(10)
        //    }


        //    Column{
        //        anchors.top: background.bottom
        //        anchors.topMargin: dp(10)
        //        anchors.left: avatarArea.right
        //        anchors.leftMargin: dp(20)
        //        AppText {
        //            id: moreInfo
        //            text: "女 双鱼座 新西兰-奥克兰"
        //                font.pixelSize: sp(12)
        //        }
        //    }

        ChangeInfoPage{
            id:changeInfoPage
            allInfoPage.width: dp(150)
        }

        Rectangle{
            id:changeInfoBtn
            width: dp(60)
            height: dp(25)
            color: "lightblue"
            anchors.right: parent.right
            anchors.rightMargin: dp(5)
            anchors.bottom: parent.bottom
            Text{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: "修改资料"
                font.pixelSize: sp(10)
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    changeInfoPage.allInfoPage.visible=true
                }
            }

        }
    }
}
