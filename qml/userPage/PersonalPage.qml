//author:yanyuping
//date:2018.6.16

import Felgo 3.0
import QtQuick 2.9
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0


Scene{
    opacity: 0
    visible: opacity>0
    property alias gobackhome: gobackhome

    Rectangle {
        anchors.fill: parent


        border.color: "red"
        color: "white"
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: "#f9a30e";
            }
            GradientStop {
                position: 1.00;
                color: "#ffffff";
            }
        }




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

        Image {
            anchors.leftMargin: 4
            anchors.topMargin: 4
            scale: 1.5
            source: "images/home.svg"
            anchors.top: background.top
            anchors.left: background.left

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

        AppText {
            id: name
            anchors.bottom: background.bottom
            anchors.left: avatarArea.right
            anchors.leftMargin: dp(20)
            color: "#fdfdfd"
            text: "Eudora"
            font.pointSize: sp(20)
        }


        Column{
            anchors.top: background.bottom
            anchors.topMargin: dp(10)
            anchors.left: avatarArea.right
            anchors.leftMargin: dp(20)
            AppText {
                id: id
                font.pixelSize: sp(12)
                text: "ID: 123456789"
            }
            AppText {
                id: moreInfo
                text: "女 双鱼座 新西兰-奥克兰"
                font.pixelSize: sp(12)
            }
        }

        Rectangle{
            id:otherInfo
            height: parent.height-avatar.y-avatar.height*1.5
            anchors.right: middleRec.left
            anchors.left: parent.left
            anchors.rightMargin: dp(30)
            anchors.leftMargin: dp(10)
            anchors.bottom: parent.bottom

            Column{
                anchors.fill: parent
                AppText {
                    id:signature
                    width: parent.width
                    wrapMode: Text.WrapAnywhere
                    text: "心情: " + "You are my sunshine."
                    font.pixelSize: sp(12)
                }

                AppText {
                    id:level
                    text: "等级: " + "LV1"
                    font.pixelSize: sp(12)
                }

                AppText {
                    id: award
                    text: "勋章墙"
                    font.pixelSize: sp(12)
                }

            }
        }

        Rectangle{
            id:photoAlbum
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.left: changeInfoBtn.right
            anchors.leftMargin: dp(10)
            height: otherInfo.height
            border.color: "grey"

            Rectangle{
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: dp(18)
                border.color: "grey"

                Text {
                    anchors.fill: parent
                    text: "游戏相册"
                    font.pixelSize: sp(12)
                }
            }
        }

        ChangeInfoPage{
            id:changeInfoPage
            allInfoPage.width: otherInfo.width*(3/4.0)
        }

        Button{
            id:changeInfoBtn
            width: dp(60)
            height: dp(25)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            text: "修改资料"
            font.pixelSize: sp(12)
            onClicked: {
                changeInfoPage.allInfoPage.visible=true
            }
        }
    }
}
