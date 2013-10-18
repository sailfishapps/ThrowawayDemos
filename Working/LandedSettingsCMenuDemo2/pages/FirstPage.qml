import QtQuick 2.0
import Sailfish.Silica 1.0
import "../others"
import "../others/FakeDB.js" as DB

Page {
    id: thisPage

    //06.07.2013
    //3) delegate architecture via binding: is this still needed?

    property string populationMode: "initial"
    property string configureEntity
    property int currentIndex
    property int parentId

    //Various DB initation and check functions here

    onStatusChanged: {
        if (status == PageStatus.Active) {
            console.log("Main Page Active: populationMode is: " + populationMode + ", configureEntity is:" + configureEntity + ", currentIndex is: " + currentIndex);
            var rs;
            if (populationMode == "initial") {
                rs = DB.getTemplateGroups();
                groupMVD.populate(rs, "parent");
            }
            //lots more functionality here
        }
    }

    property int itemHeight: 45;
    property int headerHeight: itemHeight;
    property int initialViewHeight: headerHeight
    property int menuHeight: 4 * Theme.itemSizeSmall
    property int viewMargin: 18;
    property int sideMargin: 20;
    property int fontSize: 24

    Flickable {
        objectName: "mainPageFlickable"
        anchors.fill: parent
        flickableDirection: Flickable.VerticalFlick

        ///////////////////////////////////////////////////////////////////////////////////////
        // groupMVD
        ///////////////////////////////////////////////////////////////////////////////////////

        LandedMVD {
            id: groupMVD
            objectName: "groupMVD"
            fontSize: thisPage.fontSize
            itemHeight: thisPage.itemHeight
            headerHeight: thisPage.headerHeight
            headerState: "stateView"
            headerText: "Groups:"
            width: thisPage.width
            sideMargin: thisPage.sideMargin           
            height: initialViewHeight
            expandedViewHeight: initialViewHeight + menuHeight
            initialViewHeight: thisPage.initialViewHeight
            menuHeight: thisPage.menuHeight

            customDelegate: ViewDelegate{
                id: groupDelegate
                height: menuOpen ? contextMenu.height + groupMVD.itemHeight : groupMVD.itemHeight
                width: groupMVD.width   - (2 * sideMargin)
                text: model.name + ", " + model.id
                fontSize: groupMVD.fontSize
                onClicked:{
                    console.log("groupDelegate.onClicked:: height is: " + groupMVD.height);
                    groupMVD.currentIndex = index;
                    //populate childs code here
                }
                onMenuOpenChanged: {
                    //Returns true on opening, false when closing
                    //Used to adjusst the height of the MVD depending on if the menu is open
                    console.log("menuOpen: " + menuOpen)
                    groupMVD.resize(menuOpen)
                }
                onNewPressed: console.log ("New pressed on the Menu");
                onCopyPressed: console.log ("Copy pressed on the Menu");
                onEditPressed: console.log ("Edit pressed on the Menu");
                onDeletePressed: console.log ("Delete pressed on the Menu")
            }
            //Three more LandedMVDs here, in a parent child relationship to groupMVD
        }
    }
    //functions here
    //menu items here
}
