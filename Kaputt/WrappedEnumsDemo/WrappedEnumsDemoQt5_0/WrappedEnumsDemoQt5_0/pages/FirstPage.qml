import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica.theme 1.0


Page {
    id: page
    
    //This demo shows that when a C++ type with an enum is wrapped in a QML element,
    // the enum is NOT available to instantiations of whe wrapper QML Element

    WrappedContactModel {
        sortOrders: [
            //Note: for some reason the enums of ContactDetail (ContactDetailType) and ContactName (FieldType)
            //get lost when wrapped in QML, and are not longer directly referencable
            //If I was to use the C++ SortOrder / ContactDetail / Name directly the enums would be available
            WrappedSortOrder {

                //does not work
                detail: WrappedContactDetail.Name
                field: WrappedName.FirstName

                //Ugly Workaround: have instances of WrappedContactDetail and WrappedContactModel, and refer to the instances
                //detail: wrappedContactDetail.Name
                //field: wrappedName.FirstName

            }
        ]
    }

    /*
    //Ugly Workaround: instances to be referenced from WrappedSortOrder
    WrappedName{
        id: wrappedName
    }
    WrappedContactDetail {
        id: wrappedContactDetail
    }
    */


    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent
        
        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Show Page 2"
                onClicked: pageStack.push(Qt.resolvedUrl("SecondPage.qml"))	            
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
                text: "Hello Sailors" 
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeLarge
            }
        }
    }
}


