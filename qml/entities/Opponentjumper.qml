//author:yanyuping
//date:2018.6.18

import QtQuick 2.0
import Felgo 3.0


Opponent {
    id: opponentJumper
    variationType: "jumper"

    // this property determines in which the opponent will jump next
    // (-1 = left, 1 = right)
    property int direction: -1

    // the opponents jumpForce in vertical and horizontal
    // direction
    property int verticalJumpForce: 510
    property int horizontalJumpForce: 40

    image.source: "../../assets/opponent/opponent_jumper.png"

    // define colliderComponent for collision detection while dragging
    colliderComponent: collider

    // if the opponent dies, stop it's jumpTimer
    onAliveChanged: {
        if(!alive) {
            jumpTimer.stop()
        }
    }

    // the opponents main collider
    PolygonCollider {
        id: collider

        // vertices, forming the shape of the collider
        vertices: [
            Qt.point(1, 1),
            Qt.point(31, 1),
            Qt.point(31, 30),
            Qt.point(23, 31),
            Qt.point(9, 31),
            Qt.point(1, 30)
        ]

        // the bodyType is dynamic
        bodyType: Body.Dynamic

        // the collider should not be active in edit mode or
        // when dead
        active: !alive ? false : true

        // Category3: opponent body
        categories: Box.Category3

        collidesWith: Box.Category1 | Box.Category2 | Box.Category5

        // to avoid, that the opponent slides on the ground
        friction: 1
    }

    // this collider checks for collisions from the bottom and starts
    // the jumpTimer, on collision
    BoxCollider {
        id: bottomSensor
        width: 30
        height: 3

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.bottom
        bodyType: Body.Dynamic
        active: collider.active

        // Category4: opponent sensor
        categories: Box.Category4
        // Category5: solids
        collidesWith: Box.Category5

        collisionTestingOnlyMode: true

        fixture.onContactChanged: {
            var otherEntity = other.getBody().target
            if(collider.linearVelocity.y === 0 && !jumpTimer.running)
                jumpTimer.start()
        }
    }

    // this timer is started in the bottomSensor and makes the opponent jump
    // when triggered
    Timer {
        id: jumpTimer

        interval: 300

        onTriggered: {
            // jump in the current direction
            collider.applyLinearImpulse(Qt.point(direction * horizontalJumpForce, -verticalJumpForce))
            // alternate direction after every jump
            direction *= -1
        }
    }


    // reset the opponent
    function reset() {
        alive = false
        // this is the reset function of the base entity Opponent.qml
        reset_super()
        // reset direction
        direction = -1
        // reset timer
        if(jumpTimer.running)
            jumpTimer.stop()
        alive = true
    }
}
