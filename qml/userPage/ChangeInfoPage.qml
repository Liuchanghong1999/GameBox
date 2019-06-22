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

    Rectangle{
        id:allInfo
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        //width: dp(200)
        x:0;y:0
        color: "grey"
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
            source: "images/avatar.jpg"
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
            width: dp(75)
            height: dp(25)
            anchors.left: avatar.left
            anchors.leftMargin: dp(10)

            anchors.top: avatar.bottom
            anchors.topMargin: dp(10)
            text: "Eudora";
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
        ComboBox {
            anchors.left: name_txt.left
            y:sex.y
            scale: 0.8

            height: dp(15)
            width: dp(40)
            model:["女", "男"]
            font.pixelSize: sp(6)
        }
        AppText {
            id:birthyear
            anchors.top: sex.bottom
            anchors.topMargin: dp(10)
            anchors.right: name.right
            text: "出生年"
            font.pixelSize: sp(10)
        }
        ComboBox {
            anchors.left: name_txt.left
            y:birthyear.y
            height: dp(15)
            width: dp(60)
            model:["1990", "1991","1992","1993","1994","1995","1996","1997",
                    "1998","1999","2000","2001","2002","2003","2004","2005",
                    "2006","2007","2008","2009","2010"]
            font.pixelSize: sp(10)
        }
        AppText{
            id:hometown
            anchors.top: birthyear.bottom
            anchors.topMargin: dp(10)
            anchors.right: name.right
            text: qsTr("家乡")
            font.pixelSize: sp(12)
        }
        ComboBox {
            anchors.left: name_txt.left
            y:hometown.y
            height: dp(15)
            width: dp(80)
            model: ["China","Singapore","Japan","America","England"]
           font.pixelSize: sp(10)
        }
        AppText {
            id:constellation
            anchors.top: hometown.bottom
            anchors.topMargin: dp(10)
            anchors.right: name.right
            text: qsTr("星座")
            font.pixelSize: sp(12)
        }
        ComboBox {
            anchors.left: name_txt.left
            y:constellation.y
            height: dp(15)
            width: dp(60)
            model: ["双鱼座"]
            font.pixelSize: sp(10)
        }
        AppText {
            id:spirit
            anchors.top: constellation.bottom
            anchors.topMargin: dp(10)
            anchors.right: name.right
            text: qsTr("心情")
            font.pixelSize: sp(12)
        }

        Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: dp(5)
            anchors.left: name_txt.left

            y:spirit.y

            height: width/2
            color: "#ffffff"
            TextArea {
                       id: textArea
                       text: qsTr("Text Area")
                       font.pixelSize: sp(10)
                       font.wordSpacing: 0
                       font.weight: Font.Normal
                       anchors.fill: parent
                       wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }
        }

        Button{
            id:saveBtn
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            text: "保存"
            font.pixelSize: sp(10)
            onClicked: dialogs.saveInfoDialog.open()
        }
    }



    Dialogs{
        id:dialogs
        saveInfoDialog.onAccepted: {
            mainRec.state="goright"
            allInfo.visible=false
        }
//        cameraBtn.onClicked: {
//            onClicked: nativeUtils.displayCameraPicker("Take Photo")
//        }

//        Connections {
//          target: nativeUtils
//          onCameraPickerFinished: {
//            avatar.source = ""
//            if(accepted) {
//              avatar.source = path
//            }
//          }
//        }

        fileOpenDialog.onAccepted: {
            avatar.source=fileOpenDialog.fileUrl
        }

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
