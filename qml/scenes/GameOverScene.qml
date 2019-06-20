//author:yanyuping
//date:2018.6.20

import Felgo 3.0
import QtQuick 2.0

Scene{
    opacity:0

    signal onceAgain
    signal exitLevel

    Rectangle
    {
        color: "white"
        anchors.fill: parent

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "Game Over!"
        }
        Text {
            width: 100
            height: 100
            color: "red"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            text: "再来一次"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                        onceAgain()
                }
            }
        }
        Text {
            width: 100
            height: 100
            color: "red"
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            text: "不玩了"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    exitLevel()
                }
            }
        }
    }

}
