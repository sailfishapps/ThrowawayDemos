// Copyright (C) 2014 Chris Lamb
// This sofware is released under the MIT License --> http://en.wikipedia.org/wiki/MIT_license


import QtQuick 2.0

Rectangle {
    height: text.height;
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.leftMargin: 20
    anchors.rightMargin: 20
    color: "transparent"
    Text {
        id:text
        text: model.displayLabel
        font.pointSize: 28
        color: "white"
        height: 70
        verticalAlignment: Text.AlignVCenter
    }
    MouseArea {
        anchors.fill: parent
        onClicked: console.log ("delegate clicked ")
    }
}
