//author:yanyuping
//date:2018.6.17

import Felgo 3.0
import QtQuick 2.0
import "../entities"
import "../levels"
import "../editorElements"
import "../common"

Scene {
    id: gameScene
    // the "logical size" - the scene content is auto-scaled to match the GameWindow size
    width: 570
    height: 325

    gridSize: 25

    opacity: 0
    visible: opacity > 0

    signal exitLevelPressed

    signal player_died

    signal game_win
    signal handCoin()

    property int offsetBeforeScrollingStarts: 240

    // filename of the current level
    property string activeLevelFileName
    // currently loaded level
    property var activeLevel
    // countdown shown at level start
    property int countdown: 0
    property alias loader: loader
    property alias player:player


    function setLevel(fileName) {
        activeLevelFileName = fileName
    }

    EntityManager {
        id: entityManager
    }

    // the whole screen is filled with an incredibly beautiful blue ...
    Rectangle {
        anchors.fill: gameScene.gameWindowAnchorItem
        color: "#74d6f7"
    }

    // ... followed by 2 parallax layers with trees and grass
    ParallaxScrollingBackground {
        sourceImage: "../../assets/background/layer3.png"
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
        // we move the parallax layers at the same speed as the player
        movementVelocity: player.x > offsetBeforeScrollingStarts ? Qt.point(-player.horizontalVelocity,0) : Qt.point(0,0)
        // the speed then gets multiplied by this ratio to create the parallax effect
        ratio: Qt.point(0.3,0)
    }
    //  ParallaxScrollingBackground {
    //    sourceImage: "../assets/background/layer1.png"
    //    anchors.bottom: gameScene.gameWindowAnchorItem.bottom
    //    anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
    //    movementVelocity: player.x > offsetBeforeScrollingStarts ? Qt.point(-player.horizontalVelocity,0) : Qt.point(0,0)
    //    ratio: Qt.point(0.6,0)
    //  }

    // this is the moving item containing the level and player
    Item {
        id: viewPort
        //    height: level.height
        //    width: level.width
        height: 325
        width:42 * gameScene.gridSize
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        //    anchors.top: gameScene.gameWindowAnchorItem.top
        x: player.x > offsetBeforeScrollingStarts ? offsetBeforeScrollingStarts-player.x : 0


        property alias physicsWorld: physicsWorld

        PhysicsWorld {
            id: physicsWorld
            gravity: Qt.point(0, 35)
            debugDrawVisible: true // enable this for physics debugging
            z: 1000

            onPreSolve: {
                //this is called before the Box2DWorld handles contact events
                var entityA = contact.fixtureA.getBody().target
                var entityB = contact.fixtureB.getBody().target
                if((entityB.entityType === "platform"|| entityB.entityType ==="springboard" ) && entityA.entityType === "player" &&
                        entityA.y + entityA.height > entityB.y) {
                    //by setting enabled to false, they can be filtered out completely
                    //-> disable cloud platform collisions when the player is below the platform
                    contact.enabled = false
                }
            }
        }

        Loader {
            id: loader
            source: activeLevelFileName ? "../levels/" + activeLevelFileName : ""
            onSourceChanged: player.resetContacts()
            onLoaded: {
                // store the loaded level as activeLevel for easier access
                activeLevel = item
            }
        }

        OriginalStation{}

        Player {
            id: player
            x: 20
            y: 100

            onDied: {
                player_died()
            }

            onGameWin: {
                handCoin()
                game_win()
            }
        }

        ResetSensor {
            width: player.width
            height: 10
            x: player.x
            anchors.bottom: viewPort.bottom
            // if the player collides with the reset sensor, he goes back to the start
            onContact: {
                //gameScene.resetLevel()
                player.die(true)
                //player_died()
            }
            // this is just for you to see how the sensor moves, in your real game, you should position it lower, outside of the visible area
            Rectangle {
                anchors.fill: parent
                color: "transparent"
            }
        }
    }

    Rectangle {
        anchors.right: parent.right
        anchors.top: parent.top
        height: 100
        width: 100
        color: "transparent"
        //opacity: 0.4

        Image {
            id:coin_img
            width: 25
            height: 25
            source: "../../assets/lalala/coin.png"
        }

        Text {
            anchors.left: coin_img.right
            text: "   X " + player.score
            color: "white"
            font.pixelSize: 11
        }

        Image {
            width: 18
            height: 18
            id: heart_img
            anchors.top: coin_img.bottom
            anchors.topMargin: 10
            anchors.left: coin_img.left
            anchors.leftMargin: 5
            source: "../../assets/lalala/heart.png"
        }
        Text {
            anchors.left: heart_img.right
            anchors.top: coin_img.bottom
            anchors.topMargin: 10
            text: "   X " + player.life
            color: "white"
            font.pixelSize: 11
        }

        Text {
            anchors.bottom: parent.bottom
            text: player.invincible == true ? "Invincible!": ""
            font.pixelSize: 11
        }
    }

    Rectangle{
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 40
        height: 20
        width: 60
        color: "yellow"
        opacity: 0.4
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "退出本关"
            font.pixelSize: 11
        }
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                cursorShape = Qt.OpenHandCursor
                parent.opacity = 0.2
            }
            onExited: {
                parent.opacity = 0.4
            }
            onClicked: {
                resetLevel()
                exitLevelPressed()
            }
        }
    }

    Rectangle {
        // you should hide those input controls on desktops, not only because they are really ugly in this demo, but because you can move the player with the arrow keys there
        //visible: !system.desktopPlatform
        //enabled: visible
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        height: 50
        width: 150
        color: "blue"
        opacity: 0.4

        Rectangle {
            anchors.centerIn: parent
            width: 1
            height: parent.height
            color: "white"
        }
        MultiPointTouchArea {
            anchors.fill: parent
            onPressed: {
                if(touchPoints[0].x < width/2){
                    controller.xAxis = -1
                }
                else{
                    controller.xAxis = 1
                }
            }
            onUpdated: {
                if(touchPoints[0].x < width/2){
                    controller.xAxis = -1
                }
                else{
                    controller.xAxis = 1
                }
            }
            onReleased: controller.xAxis = 0
        }
    }


    Rectangle {
        // same as the above input control
        //visible: !system.desktopPlatform
        //enabled: visible
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 100
        width: 100
        color: "green"
        opacity: 0.4

        Text {
            anchors.centerIn: parent
            text: "jump"
            color: "white"
            font.pixelSize: 9
        }
        MouseArea {
            anchors.fill: parent
            onPressed: player.jump()
        }
    }

    // on desktops, you can move the player with the arrow keys, on mobiles we are using our custom inputs above to modify the controller axis values. With this approach, we only need one actual logic for the movement, always referring to the axis values of the controller
    Keys.forwardTo: controller
    TwoAxisController {
        id: controller
        onInputActionPressed: {
            console.debug("key pressed actionName " + actionName)
            if(actionName == "up") {
                player.jump()
            }
        }
        onXAxisChanged: player.changeSpriteOrientation()
    }


    // resets the level
    // this function is i.a. called everytime the player dies, or the user
    // switches from test to edit mode
    function resetLevel() {
        // reset player

        player.reset()
        player.resetContacts()
        // reset opponents
        var opponents = entityManager.getEntityArrayByType("opponent")
        for(var opp in opponents) {
            opponents[opp].reset()
        }
        // reset coins
        var coins = entityManager.getEntityArrayByType("coin")
        for(var coin in coins) {
            coins[coin].reset()
        }

        var surprises = entityManager.getEntityArrayByType("surprise")
        for(var surprise in surprises){
            surprises[surprise].reset()
        }

        var apples = entityManager.getEntityArrayByType("apple")
        for(var apple in apples)
        {
            apples[apple].reset()
        }

        var hearts = entityManager.getEntityArrayByType("heart")
        for(var heart in hearts)
        {
            hearts[heart].reset()
        }
    }

    function stopLevel() {
        player.stop()
        var opponents = entityManager.getEntityArrayByType("opponent")
        for(var opp in opponents) {
            opponents[opp].stop()
        }
    }

    //  /**
    // * BACKGROUND -----------------------------------------
    // */
    //  // background image
    //  BackgroundImage {
    //      id: bgImage

    //      anchors.centerIn: parent.gameWindowAnchorItem

    //      // this property holds which background to show
    //      property int bg: 0

    //      // paths to all backgrounds
    //      property string bg0: "../../assets/backgroundImage/day_bg.png"
    //      property string bg1: "../../assets/backgroundImage/dusk_bg.png"
    //      property string bg2: "../../assets/backgroundImage/night_bg.png"

    //      // if available, load background from levelData
    //      property int loadedBackground: {
    //          if(gameWindow.levelEditor && gameWindow.levelEditor.currentLevelData
    //                  && gameWindow.levelEditor.currentLevelData["customData"]
    //                  && gameWindow.levelEditor.currentLevelData["customData"]["background"])
    //              parseInt(gameWindow.levelEditor.currentLevelData["customData"]["background"])
    //          else
    //              -1 // set to -1 if background property is not available
    //      }

    //      // set image source depending on bg-property value
    //      source: bg == 0 ? bg0 : bg == 1 ? bg1 : bg2
    //  }

    //  Rectangle {
    //      id: mainBar

    //      width: parent.gameWindowAnchorItem.width
    //      height: 40
    //      color: "#00000000"

    //      anchors.top: parent.gameWindowAnchorItem.top
    //      anchors.left: parent.gameWindowAnchorItem.left

    //      // background gradient
    //      gradient: Gradient {
    //          GradientStop { position: 0.0; color: "transparent" }
    //          GradientStop { position: 0.5; color: "#80ffffff" }
    //          GradientStop { position: 1.0; color: "transparent" }
    //      }

    //      // back to menu button
    //      PlatformerImageButton {
    //          id: menuButton

    //          image.source: "../../assets/ui/home.png"

    //          width: 40
    //          height: 30

    //          anchors.verticalCenter: parent.verticalCenter
    //          anchors.right: parent.right
    //          anchors.rightMargin: 5

    //          // go back to MenuScene
    //          onClicked: backPressed()
    //      }
    //  }

}

