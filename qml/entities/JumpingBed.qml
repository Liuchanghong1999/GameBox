//author:yanyuping
//date:2018.6.17

import QtQuick 2.0
import Felgo 3.0

EntityBase {
   id: jumping_bed
   entityType: "jumping_bed"

   y:level.height-75

    width: 25
    height: 25

    SpriteSequence {
      id: jumping
      anchors.centerIn: parent
      running: false
      Sprite {
        id:sprite
        //frameDuration: 100
        frameCount: 3
        frameRate: 50
        frameWidth: 25
        frameHeight: 25
        source: "../../assets/lalala/jumpingBed.png"
      }
    }

    BoxCollider {
      id: collider
      bodyType: Body.Static
      height: sprite.frameHeight
      fixture.onBeginContact: {
        var otherEntity = other.getBody().target
        if(otherEntity.entityType === "player") {player.contacts++;jumping.running=true;player.jumping()}
      }
      fixture.onEndContact: {
        var otherEntity = other.getBody().target
        if(otherEntity.entityType === "player") {player.contacts--; jumping.running=false;}
      }
    }
}

