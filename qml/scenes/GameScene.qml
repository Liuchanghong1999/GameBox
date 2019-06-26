//author:yanyuping
//date:2018.6.17

import Felgo 3.0
import QtQuick 2.0
import "../entities"
import "../levels"
import "../common"

Scene {
    id: gameScene
    // the "logical size" - the scene content is auto-scaled to match the GameWindow size
    width: 570
    height: 325

    gridSize: 25

    opacity: 0
    visible: opacity > 0

    signal exitLevelPressed //退出关卡

    signal player_died //玩家死亡

    signal game_win //过关
    signal handCoin() //在每局过后都会提交金币数 只有通过了一关才会加到总金币数中

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
            //debugDrawVisible: true // enable this for physics debugging
            z: 1000
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

            onDied_once: {
                playerImg.opacity=0.5
                die_once_warning.visible=true
                died_once_timer.running=true
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
            font.pixelSize: 13
            color: "red"
        }
    }

    Timer{
        id:died_once_timer
        running: false
        repeat: false
        interval: 1000
        onTriggered:{
            player.playerImg.opacity=1
            die_once_warning.visible=false
        }
    }

    Rectangle {
       id:die_once_warning
       visible: false
       height: 25
       width: 40
       anchors.horizontalCenter: parent.horizontalCenter
       anchors.top: parent.top
       color: "transparent"
       Image {
           id:img_heart
           anchors.horizontalCenter: parent.horizontalCenter
           anchors.verticalCenter: parent.verticalCenter
           width: 25
           height: 25
           source: "../../assets/lalala/heart.png"
       }
       Text {
           anchors.left: img_heart.right
           text: " -1 "
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
        //player.resetContacts()
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

//        var floatspringboards = entityManager.getEntityArrayByType("float_springboard")
//        for(var floatspringboard in floatspringboards){
//            floatspringboards[floatspringboard].reset()
//        }
    }

    function stopLevel() {
        player.stop()
        var opponents = entityManager.getEntityArrayByType("opponent")
        for(var opp in opponents) {
            opponents[opp].stop()
        }

//        var floatspringboards = entityManager.getEntityArrayByType("float_springboard")
//        for(var floatspringboard in floatspringboards){
//            floatspringboards[floatspringboard].stop()
//        }
    }

}

