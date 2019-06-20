//author:yanyuping
//date:2018.6.17

import Felgo 3.0
import QtQuick 2.0

TiledEntityBase {
  id: thorn
  entityType: "thorn"
  y: level.height - (column+1)*22
  size: 1 // must be >= 2, because we got a sprite for the start, one for the end and a repeatable center sprite

  //1 is up, -1 is down
  property int direction:1

  Row {
    id: tileRow
    Repeater {
      model: size
      Tile {
          height: 22

        image:  direction==1? "../../assets/lalala/bottom_thorn.png" : "../../assets/lalala/top_thorn.png"
      }
    }
  }

  BoxCollider {
    height: 22
    bodyType: Body.Static
  }
}
