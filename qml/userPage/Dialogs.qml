//author:yanyuping
//date:2018.6.17

import Felgo 3.0
import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.3 as QQD
//import QtMultimedia 5.9


Item {
    property alias saveInfoDialog: saveInfoDialog
    property alias savePasswordDialog: savePasswordDialog
    property alias fileOpenDialog: fileOpen
    //    property alias selectPicsDialog: selectPicsDialog

    function opensaveInfoDialog() { saveInfoDialog.open() }
    function opensavePasswordDialog() {savePasswordDialog.open()}
    function openFileDialog() { fileOpen.open(); }
    //    function openselectPicsDialog() {selectPicsDialog.open();}


    QQD.FileDialog {
        id: fileOpen
        title: "Select an image file"
        folder: shortcuts.documents
        nameFilters: [ "Image files (*.png *.jpeg *.jpg)" ]
    }


    Dialog{
        id:saveInfoDialog
        contentItem: Rectangle{
            color:"lightskyblue"
            implicitWidth:dp(600)
            implicitHeight: dp(100)
            Text {
                text: "Do you wanna save changes?"
                color: "navy"
                font.pixelSize: sp(25)
                anchors.centerIn: parent
            }
        }
        standardButtons: Dialog.Ok | Dialog.Cancel
    }


    Dialog{
        id:savePasswordDialog
        contentItem: Rectangle{
            color:"lightskyblue"
            implicitWidth:dp(600)
            implicitHeight: dp(100)
            AppText {
                text: "Do you wanna save password?"
                color: "navy"
                font.pixelSize: sp(35)
                anchors.centerIn: parent
            }
        }
        standardButtons: Dialog.Ok | Dialog.Cancel
    }
}

