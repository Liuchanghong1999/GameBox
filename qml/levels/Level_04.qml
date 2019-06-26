//author:yanyuping
//date:2019.6.25

import Felgo 3.0
import QtQuick 2.0
import "../entities"
import "." as Levels

Levels.LevelBase {
    id: level
    width: 42 * gameScene.gridSize // 42 because our last tile is a size 30 Ground at row 12

    JumpingBed{
        x:gameScene.gridSize * 3
        y:level.height - ( 1+1)*gameScene.gridSize
    }

    BottomGround{
            row:0
            column:0
            size:14
   }

    BottomGround{
        row:22
        column: 0
        size: 5
    }

    OpponentWalker{
        x: gameScene.gridSize *25
        y: level.height - ( 1 +1)* gameScene.gridSize
    }


    HorizontalFloatSpringboard{
        row:14
        column:0
        size:4
        farthest: gameScene.gridSize * 4
    }

    Platform{
        row:6
        column:4
        size:4
    }

    Surprise{
        row:10
        column:4
        size:1
    }

    Repeater{
        model: 5
        Platform{
            row:11+index*3
            column:4
            size:2
        }
    }

    Repeater{
        model:4
        Surprise{
            row:13+index*3
            column:4
            size:1
        }
    }

    Repeater{
        model: 5
        Thorn{
            row: 31+index*4
            column:4
            size:1
            direction: 1
        }
    }

    Apple{
        x: gameScene.gridSize * 30
        y: level.height-(5 +1)*gameScene.gridSize
    }

    Repeater{
        model:8
        Coin{
            x: gameScene.gridSize *(32+index*2)
            y: level.height- ( 5+1)*gameScene.gridSize
        }
    }


    Springboard{
        row:29
        column:2
        size:24
    }

    Wall{
        row:56
        column:0
        size:3
        direction: -1
    }

    Repeater{
        model: 2
        BottomGround{
            row:57
            column:index
            size:12
        }
    }

    Ground{
        row:57
        column: 2
        size: 3
    }

    Wall{
        row:60
        column:3
        size:2
        direction: -1
    }

    BottomGround{
        row:60
        column: 2
        size: 9
    }

    Repeater{
        model: 2
        BottomGround{
            row:61
            column:index+2
            size:8
        }
    }
    Ground{
        id:last
        row:61
        column: 4
        size: 8
    }

    Repeater{
        model: 5
        Coin{
            x: gameScene.gridSize *(60+index)
            y: level.height- ( 7+1)*gameScene.gridSize
        }
    }

    AttackPlant{
        row:66
        column:5
        attack_distance: gameScene.gridSize * 5
        direction:-1
    }

    FinalStation{
        x:(last.row+7)*gameScene.gridSize
        anchors.bottom: last.top
    }

}
