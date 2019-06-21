import Felgo 3.0
import QtQuick 2.0
import "../entities"
import "." as Levels

Levels.LevelBase {
  id: level
  width: 42 * gameScene.gridSize


    Repeater{
        model:4
        BottomGround{
            row:0
            column:index
            size:8
        }
    }

    Ground{
        row:0
        column: 4
        size: 8
    }

    Repeater{
        model: 4
        BottomGround{
            row:11
            column: index
            size: 1
        }
    }

    Ground{
        row:11
        column: 4
        size: 1
     }


    Repeater{
        model: 4
        BottomGround{
            row:15
            column: index
            size: 1
        }
    }

    Ground{
        row:15
        column: 4
        size: 1
     }

    Repeater{
        model: 4
        BottomGround{
            row:19
            column: index
            size: 1
        }
    }

    Ground{
        row:19
        column: 4
        size: 1
     }

    Repeater{
        model: 4
        BottomGround{
            row:23
            column: index
            size: 1
        }
    }

    Ground{
        row:23
        column: 4
        size: 1
     }

    Repeater{
        model: 4
        BottomGround{
            row:27
            column: index
            size: 1
        }
    }

    Ground{
        row:27
        column: 4
        size: 1
     }

    Repeater{
        model: 4
        BottomGround{
            row:31
            column: index
            size: 1
        }
    }

    Ground{
        row:31
        column: 4
        size: 1
     }

    Repeater{
        model: 5
        BottomGround{
            row:35
            column: index
            size: 1
        }
    }

    Ground{
        row:35
        column: 5
        size: 1
    }


    Repeater{
        model: 2
        BottomGround{
            row:39
            column: index
            size: 1
        }
    }

    Ground{
        row:39
        column: 2
        size: 1
     }

    Repeater{
        model: 4
        BottomGround{
            row:43
            column: index
            size: 1
        }
    }

    Ground{
        row:43
        column: 4
        size: 1
     }

    Repeater{
        model: 2
        BottomGround{
            row:47
            column: index
            size: 1
        }
    }

    Ground{
        row:47
        column: 2
        size: 1
     }

    Repeater{
        model: 4
        BottomGround{
            row:50
            column: index
            size: 1
        }
    }

    Ground{
        row:50
        column: 4
        size: 1
     }

    Coin{
        x: gameScene.gridSize*11
        y: level.height- (8+1)*gameScene.gridSize
    }

    Repeater{
        model:2
        Coin{
            x: gameScene.gridSize*13
            y: level.height- (8+index)*gameScene.gridSize
        }
    }

    Coin{
        x: gameScene.gridSize*15
        y: level.height- (8+1)*gameScene.gridSize
    }


    Repeater{
        model:2
        Coin{
            x: gameScene.gridSize*17
            y: level.height- (8+index)*gameScene.gridSize
        }
    }

    Coin{
        x: gameScene.gridSize*19
        y: level.height- (8+1)*gameScene.gridSize
    }


    Repeater{
        model:2
        Coin{
            x: gameScene.gridSize*21
            y: level.height- (8+index)*gameScene.gridSize
        }
    }


    Coin{
        x: gameScene.gridSize*23
        y: level.height- (8+1)*gameScene.gridSize
    }


    Repeater{
        model:2
        Coin{
            x: gameScene.gridSize*25
            y: level.height- (8+index)*gameScene.gridSize
        }
    }

    Repeater{
        model:10
        Coin{
            x: gameScene.gridSize*27  + (2*index-2) * gameScene.gridSize
            y: level.height- (8 +1)*gameScene.gridSize
        }
    }

    BottomGround{
        id:last
        row:51
        column: 0
        size: 20
    }

    FinalStation{
        x:55*25
        anchors.bottom: last.top
    }
}
