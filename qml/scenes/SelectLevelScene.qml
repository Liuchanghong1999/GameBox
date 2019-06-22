//author:yanyuping
//date:2018.6.22

import QtQuick 2.0
import Felgo 3.0
import "../common"

SceneBase {
    id: levelScene

    signal backPressed
    signal levelPressed(string selectedLevel)

    property int activeLevel:1
    property int flag:1
    // background
    Rectangle {
        id: background
        anchors.fill: parent.gameWindowAnchorItem
        color: "lightblue"

    }

    Rectangle {
        width: parent.gameWindowAnchorItem.width
        height: 40
        color: "#00000000"

        anchors.top: parent.gameWindowAnchorItem.top
        anchors.left: parent.gameWindowAnchorItem.left

        // back to menu button
        PlatformerImageButton {
            id: menuButton

            image.source: "../../assets/ui/home.png"

            width: 40
            height: 30

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 5

            // go back to MenuScene
            onClicked: backPressed()
        }
    }

    // show selectable levels
    Grid {
      id:grid
      anchors.centerIn: parent
      spacing: 10
      columns: 4
      rows:2

      // repeater adds 10 levels to grid
      Repeater {
        id:repeater
        model: 8
        delegate:
        Rectangle { // delegate describes the structure for each level item
            width: 52
            height: 52
            radius: 12
            color: "lightgreen"

            Rectangle {
                width: 44
                height: 44
                anchors.centerIn: parent
                radius: 11
                color: "transparent"

                Rectangle {
                width: 40
                height: 40
                anchors.centerIn: parent
                radius: 10
                color: "green"


                MenuButton {
                    property int level: index + 1 // index holds values from 0 to 9 (we set our repeater model to 10)

                    text: level
                    width: 36
                    height: 36
                    anchors.centerIn: parent
                    buttonText.color:  flag<level? "white": "lightgreen"
                    buttonText.font.family: standardFont.name
                    buttonText.font.pixelSize: 24
                    onClicked: {
                        activeLevel=level
                        if(flag<activeLevel){
                            warning.visible=true
                            timer1.running=true
                            console.log("falg++++++"+flag)
                        }
                        else{
                            var levelFile = "Level_"+level+".qml";
                            if(level < 10)
                                levelFile = "Level_0"+level+".qml";
                            levelPressed(levelFile) // e.g. Level_01.qml, Level_02.qml, ... Level_10.qml
                        }
                    }
                }
             }
          }
        }
      }
    }

    Rectangle{
        id:warning
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "yellow"
        opacity: 0.4
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "请先通过上一关"
        }
    }

    Timer{
        id:timer1
        running: false
        interval: 1000
        onTriggered: warning.visible=false
    }

}
