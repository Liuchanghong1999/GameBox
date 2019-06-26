import QtQuick 2.0
import Felgo 3.0

EntityBaseDraggable {
    id: entityBase

    property var scene: gameScene

    property alias image: sprite

    property point lastPosition

    Component.onCompleted: lastPosition = Qt.point(x, y)

    width: sprite.width
    height: sprite.height

    gridSize: scene.gridSize

    // handle position changes
    onXChanged: positionChanged()
    onYChanged: positionChanged()

    // the sprite of the entity
    MultiResolutionImage {
        id: sprite
    }

    // in this function we check if the entity is dragged out of bounds
    function positionChanged() {
        // if entity is dragged, check if entity is in bounds
        if(entityBase.entityState == "entityDragged") {
            // calculate x screen coordinate
            // adjust entity position to scale, and add container position
            var xScreen = entityBase.x * scene.container.scale + scene.container.x

            // The leftLimit is the leftmost point where the entity
            // may be released.
            // To get this value, we take the width of the sidebar,
            // and subtract a small tolerance value.
            var leftLimit = scene.editorOverlay.sidebar.width - 8 * scene.container.scale

            // calculate y screen coordinate
            // adjust entity position to scale, and add container position
            var yScreen = entityBase.y * scene.container.scale + scene.container.y

            // The bottomLimit is the lowest point on the screen, where
            // the entity may be released. This value is calculated by
            // subtracting a small tolerance value from the game window
            // height.
            var bottomLimit = scene.gameWindowAnchorItem.height - 17 * scene.container.scale
        }
    }
}


