//author:yanyuping
//date:2018.6.17

import Felgo 3.0
import QtQuick 2.0
import "../common"

EntityBase{
    id: coin
    entityType: "void_bug"

    width: gameScene.gridSize
    height: gameScene.gridSize

    //property alias starActive:collider.active
    property bool collected: false

    Rectangle{
        width: 25
        height: 25
        color: "red"
    }

    BoxCollider {
        id: collider
        anchors.fill: parent
        bodyType: Body.Static
        //collisionTestingOnlyMode: true
        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "player") Qt.point(-1000,0)
        }
    }
}

