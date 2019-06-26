//author:yanyuping
//date:2018.6.18

import QtQuick 2.0
import Felgo 3.0

// this is the base class for all opponents
PlatformerEntityBaseDraggable {
    id: opponent
    entityType: "opponent"

    property int startX
    property int startY

    property bool alive: true

    property bool hidden: false

    z: 1 // to make opponent appear in front of the platforms

    width: image.width
    height: image.height

    // hide opponent after its death
    image.visible: !hidden

    // update the entity's start position when the entity is created or moved
    onEntityCreated: updateStartPosition()
    onEntityReleased: updateStartPosition()

    // this timer hides the opponent a few seconds after its death
    Timer {
        id: hideTimer
        interval: 2000
        onTriggered: hidden = true
    }

    function updateStartPosition()
    {
        startX = x
        startY = y
    }

    // this function resets all properties, which all opponents have in common
    function reset_super()
    {
        // reset alive property
        alive = true

        // stop hideTimer, to avoid unwanted, delayed hiding of the opponent
        hideTimer.stop()
        // reset hidden
        hidden = false

        // reset position
        x = startX
        y = startY

        // reset velocity
        collider.linearVelocity.x = 0
        collider.linearVelocity.y = 0

        // reset force
        collider.force = Qt.point(0, 0)
    }

    function die() {
        alive = false
        hideTimer.start()
        if(variationType == "walker")
            audioManager.playSound("opponentWalkerDie")
        else if(variationType == "jumper")
            audioManager.playSound("opponentJumperDie")
        player.kiiljump()
    }

    function stop()
    {
        alive = false
        hideTimer.start()
        if(variationType == "walker")
            audioManager.stopSound("opponentWalkerDie")
    }
}
