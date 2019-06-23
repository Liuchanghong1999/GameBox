
//author:yanyuping
//date:2018.6.17

import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {
    id: wall
    entityType: "wall"

    size: 1

    //1 is right, -1 is left
    property int direction : 1

    x: row*gameScene.gridSize
    y: level.height - (column+size)*gameScene.gridSize
    width: gameScene.gridSize
    height: gameScene.gridSize *size


    Column {
        id: tileRow
        Tile {
            pos: "top"
            image: direction==1? "../../assets/wall/right.png" : "../../assets/wall/left.png"
        }
        Repeater {
            model: size-1
            Tile {

                image: direction==1? "../../assets/wall/single_right.png": "../../assets/wall/single_left.png"
            }
        }
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

