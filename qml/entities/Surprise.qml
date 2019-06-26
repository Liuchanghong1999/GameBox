//author:yanyuping
//date:2018.6.18

import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {
    id: surprise
    entityType: "surprise"
    size: 1

    y: level.height - (column+2)*gameScene.gridSize
    height: gameScene.gridSize*2

    property int strike : 0

    Column {
        id: tileRow
        Coin{ id:coin; collected: true; }
        Tile{
            id:box
            image: "../../assets/lalala/surprise.png"
        }
    }

    BoxCollider {
        id: collider
        anchors.bottom: box.bottom
        height: box.height
        y:box.y
        bodyType: Body.Static

        categories: Box.Category5
        // Category1: player body, Category2: player feet sensor,
        // Category3: opponent body, Category4: opponent sensor
        collidesWith: Box.Category1 | Box.Category2 | Box.Category3 | Box.Category4


        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "player") {
                console.debug("contact surprise begin")

                // increase the number of active contacts the player has
                player.contacts++
            }
        }

        fixture.onEndContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "player") {
                console.debug("contact surprise end")

                // if the player leaves a surprise, we decrease its number of active contacts
                player.contacts--
            }
        }
    }

    BoxCollider {
        id: bottomSensor

        // set size and position
        width: 10
        height: 0.1

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom

        // the bodyType is dynamic
        bodyType: Body.Static

        // only active when the main collider is active
        active: collider.active

        // Category4: opponent sensor
        categories: Box.Category8
        // Category5: solids
        collidesWith: Box.Category9

        collisionTestingOnlyMode: true

        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType==="player"){
                strike++
            }
            if(strike==1){
                box.image="../../assets/lalala/barrier.png"
                audioManager.playSound("dragEntity")
                coin.collected=false
            }
        }
    }

    CircleCollider {
        id: circlecollider

        // make the collider a little smaller than the sprite
        radius: coin.width / 2 - 5

        x:5 ; y:5

        // disable collider when coin is collected
        active: !coin.collected

        // the collider is static (shouldn't move) and should only test
        // for collisions
        bodyType: Body.Static
        collisionTestingOnlyMode: true

        fixture.onBeginContact:{
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "player") coin.collect()
        }
    }

    function reset(){
        coin.collected=true
        strike=0
        box.image= "../../assets/lalala/surprise.png"
    }
}
