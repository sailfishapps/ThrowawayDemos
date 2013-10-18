import QtQuick 2.0

Item {
    id: wrappedItem
    property string wrappedItemProperty : "Qml wrapped item"
    function doEvenFunkierStuff () {
        wrappedItemProperty = "FunkierStuff done"
    }
}
