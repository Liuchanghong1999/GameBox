////author:yanyuping
////date:2018.6.20

//import Felgo 3.0
//import QtQuick 2.0
//import "common"
//import "scenes"
//import "levels"

//GameWindow {
//  id: gameWindow

//  activeScene: gameScene
//  screenHeight: 640

//  AudioManager {
//    id: audioManager
//  }

//  GameScene {
//    id: gameScene
//  }
//}


import Felgo 3.0
import QtQuick 2.0
import "scenes"
import "common"
import "userPage"

GameWindow {
    id: gameWindow

    activeScene: loginScene

    screenWidth: 960
    screenHeight: 640

    Login{
        id:loginScene
        onLoginButtonPressed:gameWindow.state="mainScene"
        onRegisterButtonPressed: gameWindow.state="registerScene"
    }

    Register{
        id:registerScene
        setPassword.onAccepted: {
            gameWindow.state="login"
            name.clear()
            password.clear()
        }
        onBackPressed: gameWindow.state="login"
    }


    MainPage{
        id:mainScene
        onEnterGame: gameWindow.state="menu"
        onExit: gameWindow.state="login"
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

    property int coins:0

    // update background music when scene changes
//    onActiveSceneChanged: {
//        audioManager.handleMusic()
//    }

    AudioManager {
        id: audioManager
    }

    // Scenes -----------------------------------------
    MenuScene {
        id: menuScene
        onSelectLevelPressed: gameWindow.state = "selectLevel"
        onHelpScenePressed: {
            gameWindow.state = "help"
        }
        onShopPressed: gameWindow.state="shopScene"
        onExit: gameWindow.state="mainScene"
    }

    SelectLevelScene {
      id: selectLevelScene

      onLevelPressed: {
        gameScene.setLevel(selectedLevel)
        gameScene.resetLevel()
        gameScene.visible=true
        gameWindow.state = "game"
      }
      onBackPressed:   gameWindow.state = "menu"
    }

    GameScene {
      id: gameScene
      visible: false
      onExitLevelPressed: {
          gameWindow.state="selectLevel"
          gameScene.stopLevel()
      }

      onPlayer_died: {
          gameScene.stopLevel()
          gameWindow.state="gameover"
      }

      onGame_win: {
          gameWindow.state="gamewin";
          if(selectLevelScene.flag==selectLevelScene.activeLevel){
              console.log("哈哈哈哈哈哈哈哈哈哈"+selectLevelScene.flag+ "hahahah"+selectLevelScene.activeLevel)
              selectLevelScene.flag+=1
          }
      }

      onHandCoin: {
            coins=gameScene.player.score
            shopScene.addCoins(coins)
      }
    }


    HelpScene {
        id: helpScene
        onBackPressed: gameWindow.state="menu"
    }

    ShopScene{
        id:shopScene
        player_life: gameScene.player.life
        onBuy_success: {
//            coins=coins-price
//            mycoins=corns
            gameScene.player.life++
        }
        onBackPressed: {
            gameWindow.state="menu"
        }
    }

    GameOverScene{
        id:gameOverScene
        onOnceAgain:{ gameWindow.state = "once_again"; gameScene.resetLevel()}
        onExitLevel:{
            gameScene.stopLevel()
            gameWindow.state="selectLevel"
        }
    }

    GameWinScene{
        id:gameWinScene
        onBackPressed: gameWindow.state="selectLevel";

    }

    // states
    state: "login"

    // this state machine handles the transition between scenes
    states: [
        State {
            name: "login"
            PropertyChanges { target: loginScene; opacity:1}
            PropertyChanges {target: gameWindow; activeScene: loginScene}
        },
        State {
            name: "registerScene"
            PropertyChanges {target: registerScene; opacity:1}
            PropertyChanges {target: gameWindow; activeScene: registerScene}
        },

        State {
            name: "mainScene"
            PropertyChanges { target: mainScene; opacity:1}
            PropertyChanges {target: gameWindow; activeScene: mainScene}
        },

        State {
            name: "menu"
            PropertyChanges {target: menuScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: menuScene}
        },
        State {
          name: "selectLevel"
          PropertyChanges {target: selectLevelScene; opacity: 1}
          PropertyChanges {target: gameWindow; activeScene: selectLevelScene}
          PropertyChanges {target: gameScene; visible:false}
        },
        State {
            name: "help"
            PropertyChanges {target: helpScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: helpScene}
        },
        State {
          name: "game"
          PropertyChanges {target: gameScene; opacity: 1}
          PropertyChanges {target: gameScene; visible:true}
          PropertyChanges {target: gameWindow; activeScene: gameScene}
        },
        State{
            name:"gameover"
            PropertyChanges {target: gameOverScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: gameOverScene}
            PropertyChanges {target: gameScene; visible:false}
        },
        State {
            name: "once_again"
            PropertyChanges {target: gameScene; opacity:1; focus:true; visible:true}
            PropertyChanges {target: gameWindow; activeScene: gameScene}
        },
        State {
            name: "exit_level"
            PropertyChanges {target: selectLevelScene; opacity:1  }
            PropertyChanges {target:gameOverScene; opacity:0}
            PropertyChanges {target:gameScene; visible:false}
            PropertyChanges {target: gameWindow; activeScene: selectLevelScene}

        },
        State {
            name: "gamewin"
            PropertyChanges {target: gameWinScene; opacity:1}
            PropertyChanges {target: gameWindow; activeScene:gameWinScene}
            PropertyChanges {target: gameScene; visible:false}

        },
        State {
            name: "shopScene"
            PropertyChanges {target: shopScene; opacity:1}
            PropertyChanges {target: gameWindow; activeScene:shopScene}
        }
    ]
}
