import QtQuick 2.0

Item {

    //4) Expose an item written in QML
    property alias qmlElement: wrappedItem

    WrappedItem {
        id: wrappedItem
    }
}
