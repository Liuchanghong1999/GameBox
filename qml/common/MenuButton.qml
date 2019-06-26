import QtQuick 2.0

// button with text
Rectangle {
    id: button
    width: buttonText.width + paddingHorizontal * 2
    height: buttonText.height + paddingVertical * 2
    color: "transparent"
    radius: 10
    property int paddingHorizontal: 20
    property int paddingVertical: 10

    signal clicked

    // access the text of the Text component
    property alias buttonText: buttonText
    property alias text: buttonText.text
    property alias label: label
    property bool active: false


    Image {
        id: label
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
    }

    Text {
        id: buttonText
        anchors.centerIn: parent
        font.pixelSize: 36
        color: "black"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: button.clicked()
        onPressed: button.opacity = 0.5
        onReleased: button.opacity = 1
    }

}

