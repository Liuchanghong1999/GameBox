//author:yanyuping
//date:2018.6.20

import Felgo 3.0
import QtQuick 2.0
import "../common"

Scene{
    opacity: 0
    visible: opacity>0

    property int mycoins:0
    signal backPressed
    signal buy_success

    property int price:10
    property int player_life:0


    Rectangle{
        color: "lightblue"
        anchors.fill: parent.gameWindowAnchorItem


        PlatformerImageButton {
            id: menuButton

            image.source: "../../assets/ui/home.png"

            width: 40
            height: 30

            anchors.top: parent.top
            anchors.right: parent.right
            anchors.rightMargin: 5

            // go back to MenuScene
            onClicked:{
                backPressed()
                success.visible=false
                warning.visible=false
            }
        }


        Text {
            id:slogan
            anchors.top: parent.top
            anchors.topMargin: 80
            anchors.left: parent.left
            anchors.leftMargin: 20
            width: 100
            height: 20
            color: "black"
            text: " 拥有金币数:"+ mycoins
            font.pixelSize: sp(14)

         }

        Text {
            anchors.top: parent.top
            anchors.topMargin: 80
            anchors.left: slogan.right
            anchors.leftMargin: 10
            width: 100
            height: 20
            color: "black"
            text: " 拥有生命数:"+ player_life
            font.pixelSize: sp(14)

         }

    Rectangle{
        color: "black"
        height: 2
        width: 960
        anchors.top:slogan.bottom
        anchors.topMargin: 2
    }

    Image {
        id:heart
        anchors.top: slogan.bottom
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 60
        width: 25
        height: 25
        source: "../../assets/lalala/heart.png"
    }

    Rectangle{
        anchors.left: parent.left
        anchors.leftMargin: 35
        anchors.top: heart.bottom
        anchors.topMargin: 5
        Text {
            id:txt
            text: "价格: "
            font.pixelSize: sp(14)

        }
        Image {
            id:coin_img
            width: 10
            height: 10
            anchors.top: parent.top
            anchors.topMargin: 4
            anchors.left: txt.right
            source: "../../assets/lalala/coin.png"
        }
        Text {
            anchors.left: coin_img.right
            text: " *100"
            font.pixelSize: sp(14)
        }
    }

    Rectangle{
        width: 65
        height: 15
        anchors.top: heart.bottom
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 36
        color: "transparent"
        border.color: "steelblue"
        radius: 4
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "点击购买"
            font.pixelSize: sp(14)

        }
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                cursorShape=Qt.OpenHandCursor
                parent.opacity=0.8
            }
            onExited: {
                parent.opacity=1.0
            }
            onClicked: {
               if(mycoins>=price){
                    buy_success()
                    reduceCoins()
                   success.visible=true
                   timer1.running=true
               }
               else{
                    warning.visible=true
                    timer2.running=true
               }
            }
        }
    }

    Rectangle{
        id:success
        visible: false
        width: 150
        height: 50
        color: "yellow"
        opacity: 0.4
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "购买成功！"
            font.pixelSize: sp(14)

        }
    }

    Rectangle{
        id:warning
        visible: false
        width: 150
        height: 50
        color: "yellow"
        opacity: 0.4
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "对不起你的金币不足"
            font.pixelSize: sp(14)
        }
    }


    Timer{
        id:timer1
        running: false
        interval: 1000
        onTriggered:
            success.visible=false

        }

    Timer{
        id:timer2
        running: false
        interval: 1000
        onTriggered: warning.visible=false
    }
    }

    function addCoins(num){
        mycoins+=num
    }

    function reduceCoins(){
        mycoins-=price
    }

}

