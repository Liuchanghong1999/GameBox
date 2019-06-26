//author:yanyuping
//date:2018.6.17

import Felgo 3.0
import QtQuick 2.0

Item {
    width: gameScene.gridSize
    height: gameScene.gridSize

    property alias image: sprite.source
    property string pos: "mid" // can be either "mid","left" or "right"

    MultiResolutionImage {
        id: sprite
        anchors.left: pos == "right" ? parent.left : undefined
        anchors.right: pos == "left" ? parent.right : undefined
        anchors.top: pos=="top" ? parent.top : undefined
    }
}

