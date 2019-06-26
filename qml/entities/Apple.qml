//author:yanyuping
//date:2018.6.19

import Felgo 3.0
import QtQuick 2.0
import "../common"

EntityBase{
    id: apple
    entityType: "apple"

    width: gameScene.gridSize
    height: gameScene.gridSize

    // property alias starActive:collider.active
    property bool collected: false

    Image {
        id: img
        source: "../../assets/lalala/apple.png"
        visible:!collected
    }

    CircleCollider {
        id: collider

        // make the collider a little smaller than the sprite
        radius: parent.width / 2 - 5

        x:5 ; y:5

        // disable collider when coin is collected
        active: !collected

        // the collider is static (shouldn't move) and should only test
        // for collisions
        bodyType: Body.Static
        collisionTestingOnlyMode: true

    }

    // set collected to true
    function collect() {
        //console.debug("collect apple")
        apple.collected = true
    }

    // reset coin
    function reset() {
        apple.collected = false
    }
}

