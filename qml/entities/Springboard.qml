//author:yanyuping
//date:2018.6.17

import Felgo 3.0
import QtQuick 2.0

TiledEntityBase {
    id: ground
    entityType: "springboard"
    //  y: level.height - (column+1)*25


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

        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "player") {
                console.debug("contact springboard begin")

                // increase the number of active contacts the player has
                player.contacts++
            }
        }

        fixture.onEndContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "player") {
                console.debug("contact springboard end")

                // if the player leaves a springboard, we decrease its number of active contacts
                player.contacts--
            }
        }
    }
}
