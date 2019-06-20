import QtQuick 2.0
import Felgo 3.0
import "../common"

SceneBase {
    id: levelScene

    signal backPressed
    signal levelPressed(string selectedLevel)

    // background
    Rectangle {
        id: background

        anchors.fill: parent.gameWindowAnchorItem

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#4595e6" }
            GradientStop { position: 0.9; color: "#80bfff" }
            GradientStop { position: 0.95; color: "#009900" }
            GradientStop { position: 1.0; color: "#804c00" }
        }
    }

    Rectangle {
        id: mainBar

        width: parent.gameWindowAnchorItem.width
        height: 40
        color: "#00000000"

        anchors.top: parent.gameWindowAnchorItem.top
        anchors.left: parent.gameWindowAnchorItem.left

        // background gradient
        gradient: Gradient {
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 0.5; color: "#80ffffff" }
            GradientStop { position: 1.0; color: "transparent" }
        }



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
      anchors.centerIn: parent
      spacing: 10
      columns: 4
      rows:2

      // repeater adds 10 levels to grid
      Repeater {
        model: 8
        delegate: Rectangle { // delegate describes the structure for each level item
          width: 52
          height: 52
          radius: 12
          color: "white"

          Rectangle {
            width: 44
            height: 44
            anchors.centerIn: parent
            radius: 11
            color: "#54A4BF"

            Rectangle {
              width: 40
              height: 40
              anchors.centerIn: parent
              radius: 10
              color: "white"

              MenuButton {
                property int level: index + 1 // index holds values from 0 to 9 (we set our repeater model to 10)
                text: level
                width: 36
                height: 36
                anchors.centerIn: parent
                buttonText.color: "#54A4BF"
                buttonText.font.family: standardFont.name
                buttonText.font.pixelSize: 24
                onClicked: {
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
