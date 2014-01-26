import QtQuick 2.0
import Sailfish.Silica 1.0
import GstTorch 1.0
import org.nemomobile.policy 1.0

Page {
    id: page

    GstTorch {
        id: torch
        enabled: permissions.acquired
        onEnabledChanged: console.log ("QML GstTorch: onEnabledChanged: qml properties bound to this should also change! " + enabled)
        lightOnEnabled: true
        onTorchOnChanged: {
            console.log("QML: onTorchOnChanged: " + torchOn);
        }
        onTorchModeChanged: {
            console.log("QML: onTorchModeChanged: " + mode)
            console.log("GstTorch: " + GstTorch.Flash)
        }
    }

    Permissions {
        id: permissions
        enabled: applicationActive //when minimized should release LED, when activated acquire LED
        onEnabledChanged: console.log("QML Permissions: onEnabledChanged: " + enabled);
        autoRelease: true
        applicationClass: "player"
        Resource {
            type: Resource.Led
            onAcquiredChanged: {
                console.log("Resource.Led: permission for LED take-off acquired: " + acquired);
            }
        }
    }

    Column {
        width: page.width
        spacing: Theme.paddingLarge
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        BackgroundItem {
            id: toggleTorch
            enabled: torch.enabled
            onEnabledChanged: console.log("QML BackgroundItem onEnabledChanged: " + enabled);
            width: parent.width
            height: 160
            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: toggleTorch.enabled ? "toggle torch on / off" : "led permission not granted"
                onTextChanged: console.log("QML text onTextChanged: " + text);
                color: Theme.primaryColor
                font.bold: torch.torchOn ? true : false
            }
            onClicked: torch.toggleTorchOnOff();
        }
        BackgroundItem {
            enabled: torch.enabled
            width: parent.width
            height: 160
            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: torch.enabled ? "toggle beam / flash" : "led permission not granted"
                color: Theme.primaryColor
                font.bold: (torch.torchMode == GstTorch.Flash) ? true : false
            }
            onClicked: torch.toggleTorchMode();
        }
        Slider {
            width: parent.width
            height: 160
            minimumValue: 100
            maximumValue: 1500
            value: 500
            valueText: value + " ms"
            stepSize: 50
            onSliderValueChanged: {
                torch.flashRate = sliderValue;
            }
        }
    }

}


