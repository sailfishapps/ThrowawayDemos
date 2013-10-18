import QtQuick 2.0
import Sailfish.Silica 1.0

Rectangle {
    color: Theme.highlightBackgroundColor
    radius: 5
    Behavior on y { SmoothedAnimation { duration: 75} }
}
