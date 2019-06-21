import Felgo 3.0
import QtQuick 2.0

Scene {

    opacity: 0
    visible: opacity>0

    signal backPressed
    signal nextLevelPressed

    Rectangle{
        anchors.fill: parent
        color: "white"
        Rectangle{
            anchors.fill: parent
            color: "yellow"
            opacity: 0.4
        }
        Text {
            anchors.centerIn: parent
            text: "Congratulations!"
        }

        Rectangle{
            width: 100
            height: 50
            color: "blue"
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            Text {
                text: "返回关卡界面"
                        font.pixelSize: 11
            }
            MouseArea{
                anchors.fill: parent
                onClicked: backPressed()
            }
        }

        Rectangle{
            width: 100
            height: 50
            color: "blue"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            Text {
                text: "进入下一关"
                        font.pixelSize: 11
            }
            MouseArea{
                anchors.fill: parent
                onClicked: nextLevelPressed()
            }
        }
    }
}
