import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica.theme 1.0



Page {
    id: page

    //This project demos use of property aliases in QML

    //Note: QtLocation must be installed on the Emulator for this to work.
    //zypper se location
    //zypper in qt5-qtlocation
    //zypper in q qt5-qtdeclarative-import-location

    //1) childElementOne: OK:       Expose a property from a child item
    //2) childElementOne: NOT OK:   Try to expose a property on the same level as the alias
    //3) childElementOne: OK:       Expose the (c++) item itself
    //4) childElementTwo: OK:       Expose an item written in QML
    //5) compoundElement: OK:       Expose a compound c++ item
    //6) compoundElement: OK:       Expose a child of a compound c++ item (QtLocation PositionSource)
    //7) compoundElement: NOT OK:   Expose a child of a child of a compound c++ item
    //8) compoundElement: NOT OK:   Expose a property of a child of a child of a compound c++ item


    ChildElementOne {
        id: childElementOne
    }

    ChildElementTwo {
        id: childElementTwo
    }

    CompoundElement {
        id: compoundElement
    }
    
    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent
        
        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Overwrite itemDotProperty"
                onClicked: childElementOne.itemDotProperty = "And it's writable too!"
            }
            MenuItem {
                text: "Do Funky Stuff"
                onClicked: childElementOne.cplusplusItem.doFunkyStuff()
            }
        }
        
        // Tell SilicaFlickable the height of its content.
        contentHeight: childrenRect.height
        
        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: "UI Template"
            }
            Label { 
                x: Theme.paddingLarge
                text: childElementOne.itemDotProperty
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeLarge
            }
            Label {
                x: Theme.paddingLarge
                text: childElementOne.cplusplusItem.childItemSimpleProperty2
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeLarge
            }
            Label {
                x: Theme.paddingLarge
                text: childElementTwo.qmlElement.wrappedItemProperty
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeLarge
            }
        }
    }
}


