//author:yanyuping
//date:2018.6.17

import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {
  id: barrier
  entityType: "barrier"
  size: 1
  Row {
    id: tileRow
    Repeater {
      model: size
      Tile {
        pos: "mid"
        image: "../../assets/lalala/barrier.png"
      }
    }
  }

  BoxCollider {
    id: collider
    anchors.fill: parent
    bodyType: Body.Static

    fixture.onBeginContact: {
      var otherEntity = other.getBody().target
      if(otherEntity.entityType === "player") {
        console.debug("contact barrier begin")

        // increase the number of active contacts the player has
        player.contacts++
      }
    }

    fixture.onEndContact: {
      var otherEntity = other.getBody().target
      if(otherEntity.entityType === "player") {
        console.debug("contact barrier end")

        // if the player leaves a barrier, we decrease its number of active contacts
        player.contacts--
      }
    }
  }
}
