import QtQuick 2.0
import QtLocation 5.0

Item {

    property alias aliasToPositionSource: positionSource;
    property alias aliasToPositionSourcePosition: positionSource.position;

    //Gives error:
    //Invalid alias location
    //property alias aliasToPositionSourcePositionCoordinate: positionSource.position.coordinate

    //Gives error:
    //Invalid alias reference. An alias reference must be specified as <id>, <id>.<property> or <id>.<value property>.<property>
    //property alias aliasToPositionSourcePositionCoordLati: positionSource.position.coordinate.latitude

    PositionSource {
        id: positionSource
    }
}
