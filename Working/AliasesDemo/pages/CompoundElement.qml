import QtQuick 2.0
import QtLocation 5.0

Item {

    //5) compoundElement: OK:       Expose a compound c++ item (QtLocation PositionSource)

    property alias aliasToPositionSource: positionSource;

    //6) compoundElement: OK:       Expose a child of a compound c++ item (QtLocation PositionSource.position)
    property alias aliasToPositionSourcePosition: positionSource.position;

    //7) compoundElement: NOT OK:   Expose a child of a child of a compound c++ item (QtLocation PositionSource.position.coordinate)
    //Gives error:
    //Invalid alias location
    //property alias aliasToPositionSourcePositionCoordinate: positionSource.position.coordinate

    //8) compoundElement: NOT OK:   Expose a property of a child of a child of a compound c++ item (QtLocation PositionSource.position.coordinate.latitude)
    //Gives error:
    //Invalid alias reference. An alias reference must be specified as <id>, <id>.<property> or <id>.<value property>.<property>
    //property alias aliasToPositionSourcePositionCoordLati: positionSource.position.coordinate.latitude

    PositionSource {
        id: positionSource
    }

    //9) compoundElement: OK:       Indirectly expose grandChild properties
    //                              by exposing QML Item with properties boud to those of grandChild element
    property alias aliastoCoordinate: thisCoordinate

    Item { id: thisCoordinate
        property real latitude: positionSource.position.coordinate.latitude;
        property real longitude: positionSource.position.coordinate.longitude;
    }
}
