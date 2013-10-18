import QtQuick 2.0

Item {
    id: parentItem

    //1) expose a property from a child item
    property alias itemDotProperty: childItem.childItemSimpleProperty

    //2) try to expose a property on the same level as the alias
    property string parentItemSimpleProperty: "this is a simple property"
    /*
    //This does not work, but as parentItemSimpleProperty is directly available outside,
    //I don't see why you would want to do this.
    property alias simpleProperty: parentItemSimpleProperty
    */


    //3) expose the item itself
    property alias cplusplusItem: childItem

    Item {
        id: childItem
        property string childItemSimpleProperty: "This a property of a child"
        property string childItemSimpleProperty2: "Second child proprty"

        function doFunkyStuff() {
            childItemSimpleProperty2 = "Funky Stuff done"
        }
    }
}
