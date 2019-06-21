//author:yanyuping
//date:2018.6.18

import Felgo 3.0
import QtQuick 2.0

TiledEntityBase {
  id: float_springboard
  entityType: "float_springboard"

  property int direction: 1
  property int farthest : gameScene.gridSize
  property int starting:level.height-(column+1)*gameScene.gridSize
  // the opponents jumpForce in vertical and horizontal
  // direction
  size: 1


  Row {
    id: tileRow
    Repeater {
      model: size
      Tile {
        id:tile
        height: 8
        image: "../../assets/lalala/springboard.png"
      }
    }
  }

  BoxCollider {
    id: collider
    height: 8
    bodyType: Body.Static

    categories: Box.Category5
    // Category1: player body, Category2: player feet sensor,
    // Category3: opponent body, Category4: opponent sensor
    collidesWith: Box.Category1 | Box.Category2 | Box.Category3 | Box.Category4

    //active: true
    fixture.onBeginContact: {
      var otherEntity = other.getBody().target
      if(otherEntity.entityType === "player") {
        timer3.running=true
        console.debug("contact float-springboard begin")
        player.contacts++
      }
    }

    fixture.onEndContact: {
      var otherEntity = other.getBody().target
      if(otherEntity.entityType === "player") {
          timer3.running=false
        console.debug("contact float-springboard end")
        player.contacts--
      }
    }
  }

  Timer{
      id:timer1
      running: true
      repeat: true
      interval: 1
      onTriggered: {
          if(starting-parent.y === farthest){
              timer1.running=false
              timer2.running=true
          }
          //console.log(starting)
          parent.y--
      }
  }

  Timer{
      id:timer2
      running: false
      repeat:true
      interval: 1
      onTriggered: {
          if(parent.y===starting)
          {
              timer1.running=true
              timer2.running=false
          }
          parent.y++
      }
  }

  Timer{
      id:timer3
      repeat: true
      interval: 1
      onTriggered: {
          if(timer1.running===true) player.y--
          if(timer2.running===true) player.y++
      }
  }




}
