//author:yanyuping
//date:2018.6.20


import Felgo 3.0
import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2 as QQD
import QtGraphicalEffects 1.0
// import QtMultimedia 5.9


Rectangle {
    id:mainRec
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    y:0
    x:-300
    width: dp(600)
    color: "transparent"

    property alias allInfoPage: allInfo
    property alias avatar:avatar //头像
    signal savePressed //保存
    signal unsavePressed //不保存

    Rectangle{
        id:allInfo
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        //width: dp(200)
        x:0;y:0
        color: "steelblue"
        visible: false
        onVisibleChanged: {
            mainRec.state="goleft"
        }

        Image {
            id: avatar
            width: dp(65)
            height: dp(65)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: dp(10)
            //source: "../images/avatar.jpg"
            smooth: true
            antialiasing: true
            visible: false
        }

        Rectangle{
            id: mask
            width: dp(65)
            height: dp(65)
            radius: height/2
            anchors.fill: avatar
            visible: false
            antialiasing: true
            smooth: true
            color: "black"
        }

        OpacityMask {
            anchors.fill: avatar
            source: avatar
            maskSource: mask
            visible: true
            antialiasing: true

            MouseArea{
                id:avatarArea
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    cursorShape=Qt.OpenHandCursor
                    parent.opacity=0.2
                    changeAvatar.visible=true
                }
                onExited: {
                    parent.opacity=1.0
                    changeAvatar.visible=false
                }

                onClicked: dialogs.openFileDialog()
            }
        }


        AppText {
            id: changeAvatar
            text: "修改头像"
            font.pixelSize: sp(10)
            anchors.horizontalCenter: avatar.horizontalCenter
            anchors.verticalCenter: avatar.verticalCenter
            visible: false
        }

        AppText{
            id:name
            anchors.left: parent.left
            anchors.leftMargin: name_txt.x/2-dp(8)
            anchors.top: avatar.bottom
            anchors.topMargin: dp(13)
            text: "昵称 "
            font.pixelSize: sp(12)
        }
        AppTextField{
            id:name_txt
            width: dp(70)
            height: dp(20)
            anchors.left: avatar.left
            anchors.leftMargin: dp(10)

            anchors.top: avatar.bottom
            anchors.topMargin: dp(10)
            font.pixelSize: sp(12)
        }

        AppText {
            id:sex
            anchors.top: name.bottom
            anchors.topMargin: dp(10)
            anchors.right: name.right
            text: qsTr("性别")
            font.pixelSize: sp(10)
        }
        AppTextField {
            id:sex_txt
            anchors.left: name_txt.left
            y:sex.y
            width: dp(70)
            height: dp(20)

            font.pixelSize: sp(12)
        }
        AppText {
            id:birthyear
            anchors.top: sex.bottom
            anchors.topMargin: dp(10)
            anchors.right: name.right
            text: "出生年"
            font.pixelSize: sp(10)
        }
        AppTextField {
            id:birthyear_txt
            anchors.left: name_txt.left
            y:birthyear.y
            width: dp(70)
            height: dp(20)
            font.pixelSize: sp(12)
        }
        AppText{
            id:hometown
            anchors.top: birthyear.bottom
            anchors.topMargin: dp(10)
            anchors.right: name.right
            text: qsTr("家乡")
            font.pixelSize: sp(12)
        }
        AppTextField {
            id:hometown_txt
            anchors.left: name_txt.left
            y:hometown.y
            width: dp(70)
            height: dp(20)
            font.pixelSize: sp(12)
        }
        AppText {
            id:constellation
            anchors.top: hometown.bottom
            anchors.topMargin: dp(10)
            anchors.right: name.right
            text: qsTr("星座")
            font.pixelSize: sp(12)
        }
        AppTextField {
            id:constellation_txt
            anchors.left: name_txt.left
            y:constellation.y
            width: dp(70)
            height: dp(20)
            font.pixelSize: sp(12)
        }

        Button{
            id:saveBtn
            width: dp(80)
            height: dp(20)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: unsaveBtn.top
            anchors.bottomMargin: dp(20)
            text: "保存"
            font.pixelSize: sp(10)
            onClicked: {
                savePressed()
                dialogs.saveInfoDialog.open()
            }
        }

        Button{
            id:unsaveBtn
            width: dp(80)
            height: dp(20)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            text: "不保存"
            font.pixelSize: sp(10)
            onClicked: {
                unsavePressed()
                allInfo.visible=false
            }
        }
    }



    Dialogs{
        id:dialogs
        anchors.top:parent.top
        anchors.topMargin: dp(100)
        anchors.left: parent.left
        anchors.leftMargin: parent.width/4

        saveInfoDialog.onAccepted: {
            mainRec.state="goright"
            allInfo.visible=false
        }

        fileOpenDialog.onAccepted: {
            avatar.source=fileOpenDialog.fileUrl
        }

    }

    function init(game){
        avatar.source=game.player.avatar
        sex_txt.text=game.player.sex
        name_txt.text=game.player.name
        birthyear_txt.text=game.player.birthdayYear
        hometown_txt.text=game.player.hometown
        constellation_txt.text=game.player.constellation

    }

    function saveSetting(game){
        game.player.avatar=avatar.source
        game.player.name=name_txt.text
        game.player.sex=sex_txt.text
        game.player.birthdayYear=birthyear_txt.text
        game.player.hometown=hometown_txt.text
        game.player.constellation=constellation_txt.text

    }

    states: [
        State {
            name: "goleft"
            PropertyChanges {
                target: allInfo
                x:300; y:0
            }
        },
        State {
            name: "goright"
            PropertyChanges {
                target: allInfo
                x:0; y:0
            }
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "goleft"
            NumberAnimation{
                properties: "x,y"; easing.type: Easing.InCirc; duration: 200
            }
        },
        Transition {
            from: "*"
            to: "goright"
            NumberAnimation{
                properties: "x,y"; easing.type: Easing.InCirc; duration: 200
            }
        }
    ]
}
