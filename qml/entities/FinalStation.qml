//author:yanyuping
//date:2018.6.17

import Felgo 3.0
import QtQuick 2.0

EntityBase {
  id: finalStation
  entityType: "finalStation"

  width: 30
  height: 34
  anchors.bottom: parent.bottom

  Image {
     anchors.fill: parent
     source: "../../assets/lalala/finish.png"
  }


  BoxCollider {
    anchors.fill: parent
    bodyType: Body.Static
  }
}
