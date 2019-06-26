//author:yanyuping
//date:2018.6.20

import Felgo 3.0
import QtQuick 2.0
import Mario 1.0
import "scenes"
import "common"
import "userPage"


GameWindow {
    id: gameWindow

    activeScene: loginScene

    screenWidth: 960
    screenHeight: 640

    Game{
        id:game
    }


    Component.onCompleted: {
        game.loadGame()
        console.log(game.player.avatar)
        selectLevelScene.initFlag(game.process.levels)
        shopScene.mycoins=game.process.coins
        gameScene.player.life=game.process.lives

        mainScene.changeInfoPage.init(game)
    }

    Login{
        id:loginScene
        onLoginButtonPressed:{
            if((name_txt.text!==game.player.name || password_txt.text!==game.player.password)
                    || (name_txt.text==="" || password_txt.text===""))
            {
                warning.visible=true
                warning_timer.running=true
            }
            else gameWindow.state="mainScene"
        }
        onRegisterButtonPressed: gameWindow.state="registerScene"
        onForgetPasswordPressed: gameWindow.state="forgetPassword"
    }

    Register{
        id:registerScene
        setPassword.onAccepted: {
            gameWindow.state="login"
            game.player.name=name.text
            game.player.password=password.text
            game.saveGame()
            mainScene.changeInfoPage.init(game)
            name.clear()
            password.clear()
        }
        onBackPressed: gameWindow.state="login"
    }

    ForgetPassword{
        id:forgetPassword
        onCheckPressed: checkName(game)
        onBackPressed: gameWindow.state="login"
        //password: game.player.password
    }

    MainPage{
        id:mainScene
        onEnterGame: gameWindow.state="menu"
        onExit: {
            gameWindow.state="login"

            game.saveGame()
        }
        changeInfoPage.onSavePressed: changeInfoPage.saveSetting(game)
        changeInfoPage.onUnsavePressed: {
            changeInfoPage.init(game) //在没有改变的情况或者是改了却不保存，应该将所有内容依然为原来的值
            //game.saveGame()
        }
    }

    property int coins:0

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
        onExit: {
            gameWindow.state="mainScene"
            game.saveGame()
        }
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
            game.process.lives=player.life
            game.saveGame()
        }

        onGame_win: {
            gameWindow.state="gamewin";
            console.log("selectLevelScene.flag:"+selectLevelScene.flag)
            console.log("selectLevelScene.activeLevel:"+selectLevelScene.activeLevel)
            if(selectLevelScene.flag==selectLevelScene.activeLevel){
                selectLevelScene.flag+=1
                //console.log("hahahahahhaha"+selectLevelScene.flag+"hhhh"+game.process.levels)
                game.process.levels=selectLevelScene.flag
                game.saveGame()
            }
        }

        onHandCoin: {
            coins=gameScene.player.score
            shopScene.addCoins(coins)
            game.process.coins=shopScene.mycoins
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
            game.process.coins=mycoins
            gameScene.player.life++
            game.process.lives=gameScene.player.life
            game.saveGame()
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
        onNextLevelPressed: {
            var nextLevel=selectLevelScene.activeLevel+1
            selectLevelScene.activeLevel+=1
            //console.log("selectLevelScene.activeLevel: "+selectLevelScene.activeLevel)
            var levelFile
            if(nextLevel < 10) levelFile = "Level_0"+nextLevel+".qml";
            else levelFile = "Level_"+nextLevel+".qml";
            gameScene.setLevel(levelFile)
            gameScene.resetLevel()
            gameScene.visible=true
            gameWindow.state = "game"
        }
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
            name: "forgetPassword"
            PropertyChanges {target: forgetPassword; opacity:1}
            PropertyChanges {target: gameWindow; activeScene: forgetPassword}
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
