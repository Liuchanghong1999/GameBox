//author:yanyuping
//date:2018.6.17

import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {
  id: ground
  entityType: "ground"

  size: 2 // must be >= 2, because we got a sprite for the start, one for the end and a repeatable center sprite

  Row {
    id: tileRow
//    Tile {
//      pos: "left_pos"
//      image: "../../assets/ground/hahaha/left.png"
//    }

    Repeater {
      model: size
      Tile {
        pos: "mid_pos"
        image: "../../assets/ground/hahaha/mid.png"
      }
    }
//    Tile {
//      pos: "right_pos"
//      image: "../../assets/ground/hahaha/right.png"
//    }
  }

  BoxCollider {
    anchors.fill: parent
    bodyType: Body.Static
    fixture.onBeginContact: {
      var otherEntity = other.getBody().target
      if(otherEntity.entityType === "player") player.contacts++
    }
    fixture.onEndContact: {
      var otherEntity = other.getBody().target
      if(otherEntity.entityType === "player") player.contacts--
    }

    categories: Box.Category5
    // Category1: player body, Category2: player feet sensor,
    // Category3: opponent body, Category4: opponent sensor
    collidesWith: Box.Category1 | Box.Category2 | Box.Category3 | Box.Category4
  }
}
