//author:yanyuping
//date:2018.6.17

import Felgo 3.0
import QtQuick 2.0

TiledEntityBase {
  id: trees
  entityType: "trees"
  y: level.height - column*25-60
  size: 1 // must be >= 2, because we got a sprite for the start, one for the end and a repeatable center sprite

  Row {
    id: tileRow
    Repeater {
      model: size
      Tile {
        height: 60
        image: "../../assets/tree/smalltree.png"
      }
    }
  }
}
