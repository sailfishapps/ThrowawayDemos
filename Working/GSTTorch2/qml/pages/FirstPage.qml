import QtQuick 2.0
import Sailfish.Silica 1.0
import GstTorch 1.0

Page {
    id: page

    GstTorch {
        id: torch
        onTorchOnChanged: {
            console.log("QML: onTorchOnChanged: " + torchOn);
        }
        onTorchModeChanged: {
            console.log("QML: onTorchModeChanged: " + mode)
            console.log("GstTorch: " + GstTorch.Flash)
        }
    }

    Column {
        width: page.width
        spacing: Theme.paddingLarge
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        BackgroundItem {
            width: parent.width
            height: 160
            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: "toggle torch on / off"
                color: Theme.primaryColor
                font.bold: torch.torchOn ? true : false
            }
            onClicked: torch.toggleTorchOnOff();
        }
        BackgroundItem {
            width: parent.width
            height: 160
            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: "toggle beam / flash"
                color: Theme.primaryColor
                font.bold: (torch.torchMode == GstTorch.Flash) ? true : false
            }
            onClicked: torch.toggleTorchMode();
        }
    }

}


