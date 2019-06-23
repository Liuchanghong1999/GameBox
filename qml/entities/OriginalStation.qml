//author:yanyuping
//date:2018.6.17

import Felgo 3.0
import QtQuick 2.0

EntityBase {
    id: originalStation
    entityType: "originalStation"

    width: 10
    height: 460
    anchors.bottom: parent.bottom
    x:-2

    Rectangle{
        anchors.fill: parent
        color: "red"
    }


    BoxCollider {
        anchors.fill: parent
        bodyType: Body.Static
    }
}
