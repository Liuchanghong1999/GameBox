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

  AttackPlant{
      row:19
      column: 1

      attack_distance: 100
  }

  OpponentWalker{
        x:25*5
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
