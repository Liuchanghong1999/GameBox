//author:yanyuping
//date:2018.6.18

import QtQuick 2.0
import Felgo 3.0

Opponent {
    id: opponentWalker
    variationType: "walker"

    // (-1 = left, 1 = right)
    property int direction: -1

    property int speed: 70

    image.source: alive ? "../../assets/opponent/opponent_walker.png"
                        : "../../assets/opponent/opponent_walker_dead.png"

    // mirror sprite, when the opponent is moving right
    image.mirror: collider.linearVelocity.x < 0 ? false : true

    // define colliderComponent for collision detection while dragging
    colliderComponent: collider

    // When this opponent dies, we reset it's abyssChecker's
    // contacts to zero. Otherwise, after a level reset,
    // the abyssCheckers might not start with 0 contacts.
    onAliveChanged: {
        if(!alive) {
            leftAbyssChecker.contacts = 0
            rightAbyssChecker.contacts = 0
        }
    }

    // When being moved to the entity pool, reset the abyss checker's contacts.
    // For more information on entity pooling have a look at:
    // https://felgo.com/doc/felgo-entitybase/#poolingEnabled-prop
    onMovedToPool: {
        leftAbyssChecker.contacts = 0
        rightAbyssChecker.contacts = 0
    }

    // the opponents main collider
    PolygonCollider {
        id: collider
        vertices: [
            Qt.point(1, 15),
            Qt.point(31, 15),
            Qt.point(31, 30),
            Qt.point(26, 31),
            Qt.point(6, 31),
            Qt.point(1, 30)
        ]
        bodyType: Body.Dynamic

        active: !alive ? false : true

        // Category3: opponent body
        categories: Box.Category3
        // Category2: player body, Category2: player feet sensor,
        // Category5: solids
        collidesWith: Box.Category1 | Box.Category2 | Box.Category5

        // set the opponent's velocity
        linearVelocity: Qt.point(direction * speed, 0)

        onLinearVelocityChanged: {
            // if the opponent stops moving, reverse direction
            if(linearVelocity.x === 0)
                direction *= -1

            // make sure the speed is constant
            linearVelocity.x = direction * speed
        }
    }

    BoxCollider {
        id: leftAbyssChecker

        // only active, when the main collider is active
        active: collider.active

        // we make it rather small
        width: 5
        height: 5

        // place it left, below the opponent
        anchors.top: parent.bottom
        anchors.left: parent.left

        // Category4: opponent sensor
        categories: Box.Category4
        // Category5: solids
        collidesWith: Box.Category5

        // this collider should only check for collisions
        collisionTestingOnlyMode: true

        // This property keeps track of the contacts. If contacts
        // is 0, there is an abyss and the opponent should reverse
        // it's direction.
        property int contacts: 0

        // handle number of contacts
        fixture.onBeginContact: contacts++
        fixture.onEndContact: if(contacts > 0) contacts--

        // change direction when there are no contacts
        onContactsChanged: if(contacts == 0) direction *= -1
    }
    BoxCollider {
        id: rightAbyssChecker

        active: collider.active

        // size and position
        width: 5
        height: 5
        anchors.top: parent.bottom
        anchors.right: parent.right

        // Category4: opponent sensor
        categories: Box.Category4
        // Category5: solids
        collidesWith: Box.Category5

        collisionTestingOnlyMode: true

        // handle contacts
        property int contacts: 0

        fixture.onBeginContact: contacts++
        fixture.onEndContact: if(contacts > 0) contacts--

        onContactsChanged: if(contacts == 0) direction *= -1
    }

    // reset the opponent
    function reset() {
        reset_super()
        direction = -1
        collider.linearVelocity.x = Qt.point(direction * speed, 0)
    }
}
