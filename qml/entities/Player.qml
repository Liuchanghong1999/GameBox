//author:yanyuping
//date:2018.6.17

import Felgo 3.0
import QtQuick 2.0
import "../common"

EntityBase {
  id: player
  entityType: "player"
  width: 50
  height: 50

  // add some aliases for easier access to those properties from outside
  property alias collider: collider
  property alias horizontalVelocity: collider.linearVelocity.x
  property int score: 0
    property int starInvincibilityTime: 4000
  property bool invincible: false
  property int life:0

  signal died
  signal gameWin
//  property alias controller: controller

  property int contacts: 0
  state: contacts > 0 ? "walking" : "jumping"
  onStateChanged: console.debug("player.state " + state)

  // here you could use a SpriteSquenceVPlay to animate your player
  MultiResolutionImage {
    id:playerImg
    source: "../../assets/player/runright.png"
  }

  BoxCollider {
    id: collider
    height: parent.height
    width: 30
    anchors.horizontalCenter: parent.horizontalCenter
    // this collider must be dynamic because we are moving it by applying forces and impulses
    bodyType: Body.Dynamic // this is the default value but I wanted to mention it ;)
    fixedRotation: true // we are running, not rolling...
    bullet: true // for super accurate collision detection, use this sparingly, because it's quite performance greedy
    sleepingAllowed: false
    // apply the horizontal value of the TwoAxisController as force to move the player left and right
    force: Qt.point(controller.xAxis*170*25,0)
    categories: Box.Category1
//    collidesWith: Box.Category3 | Box.Category5
    fixture.onBeginContact: {

        var otherEntity = other.getBody().target

        if(otherEntity.entityType=== "opponent" || otherEntity.entityType=== "thorn") {
            die(false);
        }

//        if(otherEntity.entityType === "plant") { console.log(life);die(false)}

        if(otherEntity.entityType === "coin" || otherEntity.entityType === "heart")
        {
            otherEntity.collect()
        }
        else if(otherEntity.entityType === "apple") {
           otherEntity.collect()
            startInvincibility(starInvincibilityTime)
        }

        if(otherEntity.entityType === "finalStation"){

            gameWin()
        }

    }

//    fixture.onEndContact: {
//        var otherEntity = other.getBody().target
//        if(otherEntity.entityType=== "thorn") {
//            die(false);
//        }
//    }

    // limit the horizontal velocity
    onLinearVelocityChanged: {
      if(linearVelocity.x > 170) linearVelocity.x = 170
      if(linearVelocity.x < -170) linearVelocity.x = -170
    }
  }

  BoxCollider {
    id: feetSensor

    // set and adjust size, depending on player size (big or small)
    width: 32 * parent.scale
    height: 10 * parent.scale

    // set position
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.bottom

    // the bodyType is dynamic
    bodyType: Body.Dynamic

    // the collider should not be active in edit mode
    //active: gameScene.state === "edit" ? false : true

    categories: Box.Category2

    collidesWith: Box.Category3 | Box.Category5

    collisionTestingOnlyMode: true

    fixture.onBeginContact: {
      var otherEntity = other.getBody().target

      if(otherEntity.variationType=== "walker") {

        var playerLowestY = player.y + player.height
        var oppLowestY = otherEntity.y + otherEntity.height

        if(playerLowestY < oppLowestY - 5) {
            player.kiiljump()
          //console.debug("kill opponent")
            otherEntity.die()

        }
      }
      // else if colliding with another solid object...
    }
  }


  BoxCollider {
    id: headSensor

    // set and adjust size, depending on player size (big or small)
    width: 25
    height: 1

    // set position
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.top

    // the bodyType is dynamic
    bodyType: Body.Dynamic

    // the collider should not be active in edit mode
    //active: gameScene.state === "edit" ? false : true

    categories: Box.Category9

    collidesWith:  Box.Category5 | Box.Category8

    collisionTestingOnlyMode: true

    }


  // this timer is used to slow down the players horizontal movement. the linearDamping property of the collider works quite similar, but also in vertical direction, which we don't want to be slowed
  Timer {
    id: updateTimer
    // set this interval as high as possible to improve performance, but as low as needed so it still looks good
    interval: 60
    running: true
    repeat: true
    onTriggered: {

      var xAxis = controller.xAxis;
      // if xAxis is 0 (no movement command) we slow the player down until he stops
      if(xAxis == 0) {
        if(Math.abs(player.horizontalVelocity) > 10) player.horizontalVelocity /= 1.5
        else player.horizontalVelocity = 0
      }
    }
  }

  MultiResolutionImage {
    id: invincibilityOverlayImage
    source: "../../assets/player/player_rainbow.png"
    opacity: 0
    NumberAnimation on opacity {
      id: invincibilityOverlayImageFadeOut
      from: 1
      to: 0
      duration: 500
    }
  }

  Timer {
    id: invincibilityWarningTimer
    onTriggered: warnInvincibility()
  }

  Timer {
    id: invincibilityTimer
    onTriggered: endInvincibility()
  }

  function jump() {
    console.debug("jump requested at player.state " + state)
    if(player.state == "walking") {
      console.debug("do the jump")
      // for the jump, we simply set the upwards velocity of the collider
      collider.linearVelocity.y = -420
        audioManager.playSound("playerJump")
    }
  }

  function jumping() {
      //if(player.state=="walking"){
          collider.linearVelocity.y=-500
          audioManager.playSound("playerJump")
      //}
  }

  function kiiljump(){
     collider.linearVelocity.x=-300
     collider.linearVelocity.y=-400

  }

  function die(dieImmediately) {
      //console.log("dieImmediayely: "+dieImmediately+ " invincible:"+invincible)

      if(dieImmediately || (!invincible && player.life==0))
      {
             // ...die
        console.log(player.life + " + "+ invincible)
        audioManager.playSound("playerDie")

        if(life>0)
            life--
        //gameScene.resetLevel()
        died()
      }

      else if(invincible)
      {
          //do nothing
      }

      else if((player.life>0) && !invincible)
      {
          player.life--
      }
  }

  function startInvincibility(interval) {
    // this is the time the player is warned, that the invincibility will
    // end soon
    var warningTime = 500

    // the interval (invincibility time) must be at least as long as the
    // warning time
    if(interval < warningTime)
      interval = warningTime

    // show invincibility overlay
    invincibilityOverlayImage.opacity = 1

    // Calculate and set time until the invincibility warning.
    // This value is at least 0.
    invincibilityWarningTimer.interval = interval - warningTime
    // start timer
    invincibilityWarningTimer.start()

    // Calculate and set time until the invincibility ends.
    // This value is at least warningTime.
    invincibilityTimer.interval = interval
    // start timer
    invincibilityTimer.start()


    invincible = true
    audioManager.playSound("playerInvincible")

    console.debug("start invincibility; interval: "+interval)
  }

  function warnInvincibility() {
    invincibilityOverlayImageFadeOut.start()
    console.debug("warn invincibility")
  }

  function endInvincibility() {
    invincible = false
    audioManager.stopSound("playerInvincible")
    console.debug("stop invincibility")
  }


  function changeSpriteOrientation() {
    if(controller.xAxis == -1) {
      playerImg.mirrorX = true
      invincibilityOverlayImage.mirrorX = true
    }
    else if (controller.xAxis == 1) {
      playerImg.mirrorX = false
      invincibilityOverlayImage.mirrorX = false
    }
  }

  function reset() {
    // reset position
    x = 20
    y = 100

    // reset velocity
//    collider.linearVelocity.x = 0
//    collider.linearVelocity.y = 0
      collider.linearVelocity = Qt.point(0,0)

    // reset score
    score = 0

    //resetContacts()

//    // reset invincibility
    invincible = false
    invincibilityTimer.stop()
    invincibilityWarningTimer.stop()
    invincibilityOverlayImage.opacity = 0
    audioManager.stopSound("playerInvincible")
  }

  function stop(){
      score = 0

      collider.linearVelocity = Qt.point(0,0)
      invincible = false
      invincibilityTimer.stop()
      invincibilityWarningTimer.stop()
      invincibilityOverlayImage.opacity = 0
      audioManager.stopSound("playerDie")
      audioManager.stopSound("playerInvincible")
  }

  function resetContacts() {
    // Reset the contacts to ensure the player starts each level
    // with zero contacts.
    contacts = 0
  }
}

