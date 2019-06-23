//author:yanyuping
//date:2018.6.14

import Felgo 3.0
import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2 as QQD

Scene{

    opacity: 0
    visible: opacity>0
    property alias setPassword:dialogs.savePasswordDialog
    property alias name: name
    property alias password: password

    signal backPressed

    Rectangle{

        id: rectangle
        anchors.fill: parent.gameWindowAnchorItem
        color: "lightblue"

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

        TextArea{
            id:name
            width: 120
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 100
            placeholderText:"set name"
            font.pixelSize: sp(15)
            property bool isTooLong: name.text.length >= 8
        }

        Text {
            anchors.left: name.right
            anchors.top: name.top
            anchors.topMargin: 11
            text: "*名字长度不能超过8位"
            color: name.isTooLong ? "red" : "black"
            font.pixelSize: 11
        }


        TextArea{
            id:password
            width: 120
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 130
            placeholderText:"set password"
            font.pixelSize: sp(15)
            property bool isTooLong: password.text.length >= 8
        }


        Text{
            anchors.left: password.right
            anchors.top: password.top
            anchors.topMargin: 11
            text: "*密码长度不能超过8位"
            color: password.isTooLong ?"red":"black"
            font.pixelSize: 11
        }


        Button{
            id:complete
            visible: !name.isTooLong && !password.isTooLong
            text: "完成注册"
            font.pixelSize: sp(14)
            //font.pointSize: 8
            width: dp(80)
            height: dp(20)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 80
            MouseArea{
                anchors.fill: parent
                onClicked: dialogs.savePasswordDialog.open()
            }
        }

        Dialogs{
            anchors.top:parent.top
            anchors.topMargin: dp(100)
            anchors.left: parent.left
            anchors.leftMargin: complete.x/2
            id:dialogs
        }
    }
}

