import Felgo 3.0
import QtQuick 2.0
import "../common"

SceneBase {
    id: helpScene

    // set the scene alignment
    sceneAlignmentX: "left"
    sceneAlignmentY: "top"

    // make components visible from the outside
    property alias bgImage: bgImage

    // this signal is emitted when the user presses the back button
    signal backPressed

    /**
   * BACKGROUND -----------------------------------------
   */
    // background image
    BackgroundImage {
        id: bgImage

        anchors.centerIn: parent.gameWindowAnchorItem

        // this property holds which background to show
        property int bg: 0

        // paths to all backgrounds
        property string bg0: "../../assets/backgroundImage/day_bg.png"
        property string bg1: "../../assets/backgroundImage/dusk_bg.png"
        property string bg2: "../../assets/backgroundImage/night_bg.png"

        // if available, load background from levelData
        property int loadedBackground: {
            if(gameWindow.levelEditor && gameWindow.levelEditor.currentLevelData
                    && gameWindow.levelEditor.currentLevelData["customData"]
                    && gameWindow.levelEditor.currentLevelData["customData"]["background"])
                parseInt(gameWindow.levelEditor.currentLevelData["customData"]["background"])
            else
                -1 // set to -1 if background property is not available
        }

        // set image source depending on bg-property value
        source: bg == 0 ? bg0 : bg == 1 ? bg1 : bg2
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
}
