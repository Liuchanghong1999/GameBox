//author:yanyuping
//date:2018.6.17

import Felgo 3.0
import QtQuick 2.0

EntityBase {
  id: originalStation
  entityType: "originalStation"

  width: 10
  height: 460
  anchors.bottom: parent.bottom
  x:0

  Rectangle{
     anchors.fill: parent
     color: "red"
  }


  BoxCollider {
    anchors.fill: parent
    bodyType: Body.Static
//    fixture.onBeginContact: {
//      var otherEntity = other.getBody().target
//      if(otherEntity.entityType === "player") player.contacts++
//    }
//    fixture.onEndContact: {
//      var otherEntity = other.getBody().target
//      if(otherEntity.entityType === "player") player.contacts--
//    }
  }
}
