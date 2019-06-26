//author:yanyuping
//date:2018.6.14

import Felgo 3.0
import QtQuick 2.9
import QtQuick.Controls 2.5
//import Mario 1.0

Scene{
    opacity: 0
    visible: opacity>0

    signal loginButtonPressed  //登录按钮
    signal registerButtonPressed   //注册按钮
    signal forgetPasswordPressed  //忘记密码

    property alias name_txt : name_txt  //输入的名字
    property alias password_txt : password_txt   //输入的密码
    property alias warning_timer : warning_timer  //将warning的visible设置为false的定时器
    property alias warning : warning    //提示名字或密码错误

    Rectangle {
        id: mainRec
        color: "lightblue"
        anchors.fill: parent.gameWindowAnchorItem

                Image {
                    id: logo
                    scale: 0.8
                    height: dp(142)
                    width: dp(450)
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: dp(10)
                    source: "../../assets/ui/gamebox.png"
                }

        Rectangle{
            id: middleRect

            anchors.horizontalCenter: parent.horizontalCenter

            y:dp(80)

            width: dp(20); height: dp(20)
            color: "transparent"; //border.color: "Gray"; radius: 6

            MouseArea{
                anchors.fill: parent;
                onClicked: mainRec.state="middleRight"
            }
        }

        AppText{
            id:user_id
            text: "Name"
            scale: 0.8
            anchors.top: middleRect.bottom
            anchors.topMargin: dp(60)
            anchors.right: middleRect.left
            anchors.rightMargin: dp(30)
        }
        AppTextField{
            id:name_txt
            scale: 0.7
            horizontalAlignment: Text.AlignLeft
            font.pointSize: sp(10)

            anchors.left: user_id.right
            anchors.top: middleRect.bottom
            anchors.topMargin: dp(50)
            placeholderText:"Enter me"
        }

        AppText{
            id:password
            text: "Password"
            scale: 0.8
            anchors.top: middleRect.bottom
            anchors.topMargin: dp(100)
            anchors.right: middleRect.left
            anchors.rightMargin: dp(30)
        }
        AppTextField{
            id:password_txt
            scale: 0.7
            horizontalAlignment: Text.AlignLeft
            font.pointSize: sp(10)

            anchors.left: password.right
            anchors.top: middleRect.bottom
            anchors.topMargin: dp(90)
            placeholderText:"Enter password"
        }
        AppText{
            id:forgetPassword
            color: "#6c6161"
            text: "忘记密码?"
            anchors.left: password.right
            anchors.leftMargin: dp(160)
            anchors.top: middleRect.bottom
            anchors.topMargin: dp(100)
            scale: 0.7
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
                onClicked: forgetPasswordPressed()
            }
        }

        //        //登录 注册 忘记密码

        AppButton{
            id:login
            text: "登录"
            scale: 0.7
            anchors.top: middleRect.bottom
            anchors.topMargin: dp(140)
            anchors.right: middleRect.left
            onClicked:
            {
                loginButtonPressed()
            }
        }
        AppButton{
            id:register
            text: "注册"
            scale: 0.7
            anchors.top: middleRect.bottom
            anchors.topMargin: dp(140)
            anchors.left: middleRect.right
            onClicked: registerButtonPressed()
        }
    }

    Rectangle{
        id:warning
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 200
        height: 44
        color: "yellow"
        opacity: 0.4
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "用户名或密码错误"
            font.pixelSize: sp(14)
        }
    }

    Timer{
        id:warning_timer
        running: false
        interval: 1000
        onTriggered: warning.visible=false
    }


}
