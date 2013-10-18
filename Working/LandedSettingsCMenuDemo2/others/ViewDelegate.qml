import QtQuick 2.0
import Sailfish.Silica 1.0

Item{
    id: thisDelegate
    signal clicked();
    signal doubleClicked();
    signal pressed();
    signal pressAndHold();
    signal released();

    signal newPressed();
    signal editPressed();
    signal copyPressed();
    signal deletePressed();
    property int fontSize: 24
    property string text
    property variant model
    property variant index
    property int closedHeight

    Text {
        text: thisDelegate.text
        font.pointSize: thisDelegate.fontSize
        font.weight: Font.Light
        color: "white"
        verticalAlignment: Text.AlignVCenter
        width: thisDelegate.width
        elide: Text.ElideRight
    }

    property Item contextMenu
    Component {
        id: contextMenuComponent
        ContextMenu {
            id: menu
            MenuItem {
                text: "New"
                onClicked: newPressed();
            }
            MenuItem {
                text: "Copy"
                onClicked: copyPressed();
            }
            MenuItem {
                text: "Edit"
                onClicked: editPressed();
            }
            MenuItem {
                text: "Delete"
                onClicked: deletePressed();
            }
        }
    }
    property bool menuOpen: contextMenu != null && contextMenu.parent === groupDelegate

    onPressAndHold: {
        if (!contextMenu)
            contextMenu = contextMenuComponent.createObject(groupDelegate);
        contextMenu.show(groupDelegate);
    }

    MouseArea{
        anchors.fill: parent;
        onClicked:{
            thisDelegate.clicked();
        }
        onDoubleClicked:{
            thisDelegate.doubleClicked();
        }
        onPressed: {
            thisDelegate.pressed();
        }

        onPressAndHold: {
            thisDelegate.pressAndHold();
        }
        onReleased: {
            thisDelegate.released();
        }
    }
}
