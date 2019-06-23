//author:yanyuping
//date:2018.6.19

import Felgo 3.0
import QtQuick 2.0

EntityBase {
    id: tiledEntity
    entityType: "plant"
    property int column: 0
    property int row: 0


    property int attack_distance:0
    // -1 is left, 1 is right
    property int direction:-1
    property int attac_flag : 0

    x: row*gameScene.gridSize
    y: level.height - (column+1)*gameScene.gridSize
    width: gameScene.gridSize
    height: gameScene.gridSize


    Rectangle{
        id:plant
        color: "purple"
        anchors.fill: parent
        z:1
    }

    Rectangle{
        id:bullet
        width: parent.width/2; height: parent.height/2
        radius:width/2
        color: "black"
    }

    CircleCollider {
        id: collider
        anchors.fill: bullet
        radius: bullet.radius

        bodyType: Body.Static
        collisionTestingOnlyMode: true

        fixture.onBeginContact: {

            var otherEntity = other.getBody().target

            if(otherEntity.entityType=== "player") {
                attac_flag++;
                console.log("lalalallalala" + attac_flag)
                if(attac_flag==1){
                    player.die(true);
                }
            }
        }
    }

    // every bullet
    Timer{
        id:timer1
        repeat: true
        interval: 1
        onTriggered: {
            bullet.visible=true
            if(-bullet.x===attack_distance){
                timer1.running=false
                bullet.visible=false
            }
            bullet.x+=direction
        }
    }

    //all bullet
    Timer{
        id:timer2
        running: true
        repeat: true
        interval: 4000
        onTriggered: {
            bullet.x=0
            timer1.running=true
        }
    }

    function stop(){
        timer2.running=false
    }
}

