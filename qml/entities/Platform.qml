//author:yanyuping
//date:2018.6.17

import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {
    id: platform
    entityType: "platform"
    size: 2 // must be >= 2 and even (2,4,6,...), because we got a sprite for the start, one for the end and 2 center sprites that are only repeatable if both are used

    Row {
        id: tileRow
        //    Tile {
        //      pos: "left"
        //      image: "../../assets/platform/hahaha/left.png"
        //    }
        Repeater {
            model: size
            Tile {
                pos: "mid"
                image: "../../assets/platform/hahaha/mid.png"
            }
        }
        //    Tile {
        //      pos: "right"
        //      image: "../../assets/platform/hahaha/right.png"
        //    }
    }

    BoxCollider {
        id: collider
        anchors.fill: parent
        bodyType: Body.Static

        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "player") {
                console.debug("contact platform begin")

                // increase the number of active contacts the player has
                player.contacts++
            }
        }

        fixture.onEndContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "player") {
                console.debug("contact platform end")

                // if the player leaves a platform, we decrease its number of active contacts
                player.contacts--
            }
        }
        categories: Box.Category5
        // Category1: player body, Category2: player feet sensor,
        // Category3: opponent body, Category4: opponent sensor
        collidesWith: Box.Category1 | Box.Category2 | Box.Category3 | Box.Category4
    }
}
