import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    id: page
    tools: commonTools

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

}
