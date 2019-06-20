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

//  SmallTree{
//      row:2
//      column: 2
//      size: 1
//  }


  OpponentWalker{
    x:25*18
  }

  Opponentjumper{
      x:25*33

  }

//  BigTree{
//      row:6
//      column: 1
//      size: 1
//  }

  Ground {
    row: 0
    column: 1
    size: 3
  }



    Springboard{
        row:4
        column: 3
        size:3

    }

  Ground {
    row: 8
    column: 1
    size: 2
  }

  HorizontalFloatSpringboard{
      row:7
      column: 7
      size: 3
      starting: row*gameScene.gridSize
      farthest: 250
  }

//  VerticalFloatingSpringboard{
//      row:11
//      column: 4
//      size: 5
//      starting:level.height-(column+1)*gameScene.gridSize
//      farthest: 100
//  }

//  OpponentWalker{
//      x:5*25
//      y:level.height-(column+1)*gameScene.gridSizev-8
//  }

  Platform {
    row: 3
    column: 6
    size: 4
  }

  JumpingBed{
      x:25*3
      y: level.height - (7+1)*gameScene.gridSize
  }

  Heart{
            x:5*25
            y:level.height-(column+1)*gameScene.gridSizev-8
  }

  Surprise{
      row:6
      column: 6
      size: 1
  }

  AttackPlant{
      row:22
      column: 4
      attack_distance: 25*3
      direction: 1
  }

  Repeater{
  model: 5
  Star{
      x:75+index*25
      y: level.height - (4+1)*gameScene.gridSize
  }
  }

  Apple{
    x:75
      y: level.height - (4+1)*gameScene.gridSize

  }

  Barrier{
    row:10
    column: 3
    size:1
  }

  Platform {
    row: 11
    column: 3
    size: 2
  }
  Ground {
    row: 12
    column: 1
    size: 30
  }
  Platform {
    row: 17
    column: 3
    size: 10
  }

  BottomGround{
//      id:bottomground
      row:0
      column: 0
      size: 6
  }

  BottomGround{
            id:bottomground
      row:13
      column: 0
      size:50
  }

  FinalStation{
     id:finalStation
     x:gameScene.gridSize*bottomground.size

  }

  Thorn{
      row:42
      column: 1
      size:3
      //direction: -1

  }

  Wall{
      row:45
      column: 1
      size: 3
      direction: -1
  }
}
