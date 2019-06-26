//author:yanyuping
//date:2018.6.23

import Felgo 3.0
import QtQuick 2.9
import QtQuick.Controls 2.5


Scene{
    opacity: 0
    visible: opacity>0

    signal backPressed  //返回到登录页面
    signal checkPressed  //点击查询时发送信号

    property alias name:name.text

    property string password

    property bool is_correct:false  //标志用户名是否存在

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
                id:area
                anchors.fill: parent
                onClicked: {
                    checkPressed()
                    if(is_correct){
                        check_success.visible=true
                        timer.running=true
                    }
                    else {
                        check_fail.visible=true
                        timer.running=true
                    }

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
            id:password
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            //text: "Your password : " + password
            font.pixelSize: sp(14)
        }
    }

    Rectangle{
        id:check_fail
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
            text: "查询失败，用户名不存在"
        }
    }

    Timer{
        id:timer
        running: false
        repeat: false
        interval: 1000
        onTriggered:{
            check_success.visible=false
            check_fail.visible=false
        }
    }

    function checkName(game)
    {
        is_correct= (game.player.name === name.text)
        display_password(game)
    }

    function display_password(game)
    {
        password.text="Your password : "+game.player.password
    }

}
