import Felgo 3.0
import QtQuick 2.0
import "../entities"
import "." as Levels

Levels.LevelBase {
  id: level
  // we need to specify the width to get correct debug draw for our physics
  // the PhysicsWorld component fills it's parent by default, which is the viewPort Item of the gameScene and this item uses the size of the level
  // NOTE: thy physics will also work without defining the width here, so no worries, you can ignore it untill you want to do some physics debugging
  width: 42 * gameScene.gridSize // 42 because our last tile is a size 30 Ground at row 12


  // you could draw your level on a graph paper and then add the tiles here only by defining their row, column and size

  BottomGround{
      row:0
      column:0
      size:13
  }


    Ground{
        row:0
        column: 1
        size: 6
    }

    Repeater{
        model:3
        Coin{
            x: 3*gameScene.gridSize + index * gameScene.gridSize
            y: level.height- (2+1)*gameScene.gridSize
        }
    }

    Thorn{
        row: 6
        column:1
        size:3
        direction: 1
    }

    Ground{
        row:9
        column:1
        size:4
    }

    Coin{
        x:9*gameScene.gridSize
        y:level.height- (2+1)*gameScene.gridSize
    }

    Thorn{
        row:11
        column:2
        size:1
    }

    Ground{
        row:16
        column:0
        size:1
    }

    Coin{
        x:16*gameScene.gridSize
        y:level.height- (1+1)*gameScene.gridSize
    }

    BottomGround{
        row:20
        column: 0
        size:38

    }

    Ground{
        row:20
        column: 1
        size:1
    }

    Coin{
        x:20*gameScene.gridSize
        y:level.height- (2+1)*gameScene.gridSize
    }

    Thorn{
        row:21
        column: 1
        size: 12
    }

    HorizontalFloatSpringboard{
        row:22
        column:3
        size:6
        farthest:gameScene.gridSize * 4
    }

    Coin{
        x:24*gameScene.gridSize
        y:level.height- (4+1)*gameScene.gridSize
    }

    Coin{
        x:28*gameScene.gridSize
        y:level.height- (4+1)*gameScene.gridSize
    }

    Thorn{
        row:26
        column: 5
        size: 1
    }



    Barrier{
        row:35
        column: 3
        size: 1
    }

    Ground{
        row:33
        column: 1
        size: 2
    }

    HorizontalFloatSpringboard{
        row:37
        column: 5
        size: 10
        farthest: gameScene.gridSize * 6
    }

    Repeater{
        model:5
        Thorn{
            row:44+(index-1)*4
            column: 7
        }
    }

    Coin{
        x:38*gameScene.gridSize
        y:level.height- (8 +1)*gameScene.gridSize
    }

    Heart{
        x: gameScene.gridSize * 40
        y: level.height-(8+1)*gameScene.gridSize-8
    }

    Repeater{
        model:4
        Coin{
            x:  44*gameScene.gridSize  + (index-1) * gameScene.gridSize*2
            y: level.height- (8 +1)*gameScene.gridSize
        }
    }

    Thorn{
        row:35
        column: 1
        size: 3

    }

    Ground{
        row:38
        column:1
        size: 20
    }

    Repeater{
        model: 9
        Coin{
            x:(39+ index*2)*gameScene.gridSize
            y:level.height- (2+1)*gameScene.gridSize
        }
    }

    VerticalFloatingSpringboard{
        row:58
        column:0
        size:3
        farthest: gameScene.gridSize * 8
    }

    Wall{
        row:62
        column:0
        size:9
        direction: -1
    }
    Wall{
        row:63
        column: 0
        size: 9
        direction: 1
    }

    Repeater{
        model: 3
        Platform{
            row: 68+index*6
            column:8-index*2
            size:3
        }
    }

    Repeater{
        model:2
        Coin{
            x:(68 + index)*gameScene.gridSize
            y:level.height- (9+1)*gameScene.gridSize
        }
    }

    Thorn{
        row:70
        column: 10
    }

    Repeater{
        model:2
        Coin{
            x:(74 + index)*gameScene.gridSize
            y:level.height- (7+1)*gameScene.gridSize
        }
    }

    Thorn{
        row:76
        column: 8
        y:level.height - ( 8+1)*gameScene.gridSize+30
    }

    Repeater{
        model:3
        Coin{
            x:(80 + index)*gameScene.gridSize
            y:level.height- (5+1)*gameScene.gridSize
        }
    }

    Platform{
        row:88
        column: 2
        size: 5
    }

    Repeater{
        model:2
        Coin{
            x:(88 + index)*gameScene.gridSize
            y:level.height- (3+1)*gameScene.gridSize
        }
    }

    Thorn{
        row:90
        column: 3
        y:level.height - ( 3+1)*gameScene.gridSize+10
        size: 2
    }

    JumpingBed{
        x:gameScene.gridSize * 92
        y:level.height - ( 3+1)*gameScene.gridSize
    }

    Repeater{
        model:7
        Coin{
            x: gameScene.gridSize *92
            y: level.height- (4+1+index)*gameScene.gridSize
          }
    }


    Platform{
        id:last
        row:95
        column: 7
        size: 3
    }

    FinalStation{
        x:(last.row+1)*gameScene.gridSize
        anchors.bottom: last.top
    }
}
