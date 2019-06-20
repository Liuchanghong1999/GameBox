//author:yanyuping
//date:2018.6.20

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

GameWindow {
    id: gameWindow

    activeScene: menuScene

    screenWidth: 960
    screenHeight: 640

    // update background music when scene changes
    onActiveSceneChanged: {
        audioManager.handleMusic()
    }

    AudioManager {
        id: audioManager
    }

    // custom mario style font
    FontLoader {
        id: marioFont
        source: "../assets/fonts/SuperMario256.ttf"
    }

    // Scenes -----------------------------------------
    MenuScene {
        id: menuScene
        onSelectLevelPressed: gameWindow.state = "selectLevel"
        onHelpScenePressed: {
            gameWindow.state = "help"
        }
    }

    SelectLevelScene {
      id: selectLevelScene
      onLevelPressed: {
        gameScene.setLevel(selectedLevel)
        gameScene.visible=true
        gameWindow.state = "game"
      }
      onBackPressed:   gameWindow.state = "menu"
    }

    GameScene {
      id: gameScene
      visible: false
      onExitLevelPressed: {
          gameScene.visible=false
          selectLevelScene.opacity=1
      }

      onPlayer_died: {
          gameScene.opacity=0
          gameWindow.state="gameover"
          selectLevelScene.opacity=0
      }
    }


    HelpScene {
        id: helpScene

//        onBackPressed: {
//            gameWindow.state = "menu"
//        }
    }

    GameOverScene{
        id:gameOverScene
        onOnceAgain: gameWindow.state = "once_again"
        onExitLevel: gameWindow.state = "exit_level"
    }

    // states
    state: "menu"

    // this state machine handles the transition between scenes
    states: [
        State {
            name: "menu"
            PropertyChanges {target: menuScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: menuScene}
        },
        State {
          name: "selectLevel"
          PropertyChanges {target: selectLevelScene; opacity: 1}
          PropertyChanges {target: gameWindow; activeScene: selectLevelScene}
        },
        State {
            name: "help"
            PropertyChanges {target: helpScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: helpScene}
        },
        State {
          name: "game"
          PropertyChanges {target: gameScene; opacity: 1}
          PropertyChanges {target: gameWindow; activeScene: gameScene}
//          PropertyChanges {target: selectLevelScene; opacity:0}
//          PropertyChanges {target: gameOverScene; opacity:0}
        },
        State{
            name:"gameover"
            PropertyChanges {target: gameOverScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: gameOverScene}
        },
        State {
            name: "once_again"
            PropertyChanges {target: gameScene; opacity:1; focus:true}
            PropertyChanges {target: gameWindow; activeScene: gameScene}
        },
        State {
            name: "exit_level"
            PropertyChanges {target: selectLevelScene; opacity:1  }
            PropertyChanges {target: gameWindow; activeScene: selectLevelScene}
        }

    ]
}
