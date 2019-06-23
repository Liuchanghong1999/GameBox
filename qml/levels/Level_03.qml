import Felgo 3.0
import QtQuick 2.0
import "../entities"
import "." as Levels

Levels.LevelBase {
    id: level
    width: 42 * gameScene.gridSize



    BottomGround{
        row:0
        column:0
        size:5
    }

    Ground{
        row:0
        column:1
        size:5
    }


    Platform{
        row:8
        column:2
        size:6
    }

    Repeater{
        model:6
        Coin{
            x:( 8 +index) * gameScene.gridSize
            y: level.height- (5+1)*gameScene.gridSize
        }
    }

    OpponentWalker{
        x: gameScene.gridSize *  8
        y: level.height - ( 3 +1)* gameScene.gridSize
    }


    HorizontalFloatSpringboard{
        row:15
        column:4
        size:3
        farthest: gameScene.gridSize * 4
    }

    Thorn{
        row: 24
        column:3
        size:2
        direction: 1
    }

    Platform{
        row:24
        column: 2
        size: 6
    }

    Repeater{
        model:4
        Coin{
            x:( 25 +index-1) * gameScene.gridSize
            y: level.height- (6+1)*gameScene.gridSize
        }
    }




    //  OpponentWalker{
    //      x: gameScene.gridSize *  29
    //      y: level.height - ( 3 +1)* gameScene.gridSize
    //  }


    HorizontalFloatSpringboard{
        row:29
        column:4
        size:3
        farthest: gameScene.gridSize * 4
    }

    OpponentWalker{
        x: gameScene.gridSize *  30
        y: level.height - (5+1)* gameScene.gridSize
    }

    Platform{
        row:37
        column: 2
        size: 10
    }

    Opponentjumper{
        x: gameScene.gridSize * 42
        y: level.height - ( 7 +1)* gameScene.gridSize
    }

    Coin{

    }

    Ground{
        row:53
        column: 0
        size: 11
    }

    BottomGround{
        row:64
        column: 0
        size: 60
    }

    Thorn{
        row:64
        column: 1
        size: 40
    }

    AttackPlant{
        row:60
        column:1
        attack_distance: gameScene.gridSize * 7
        direction: -1
    }

    Platform{
        row:60
        column: 6
    }

    AttackPlant{
        row:60
        column: 7
        attack_distance: gameScene.gridSize * 10
        direction: 1
    }

    VerticalFloatingSpringboard{
        row:65
        column:2
        size:3
        farthest: gameScene.gridSize * 4
    }

    Repeater{
        model:5
        Platform{
            row:72+index*6
            column:6
            size:4
        }
    }

    Repeater{
        model:5
        OpponentWalker{
            x: gameScene.gridSize*(index*6 + 72)
            y: level.height - (7+1)* gameScene.gridSize
        }
    }

}
