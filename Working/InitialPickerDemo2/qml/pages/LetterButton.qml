// Copyright (C) 2014 Chris Lamb
// This sofware is released under the MIT License --> http://en.wikipedia.org/wiki/MIT_license

import QtQuick 2.0

Text {
    id: letterButton
    signal clicked (string letter)
    onClicked: {
        //I don't like this, I have to assume the parent has an onCliced handler ...
        //so this couples our components, but I guess they are closely linked anyway
        parent.clicked(letter)
    }

    property string selectedLetter: parent.selectedLetter

    onSelectedLetterChanged: {
        //console.log("letterButton: " + text + " selectedLetter changed to: " + selectedLetter)
        if (selectedLetter == text) {
            //console.log("highlighting letterButton: " + text)
            backgroundRect.opacity = selectedOpacity
            letterButton.color = selectedColor
        }
        else {
            //console.log("unhighlighting letterButton: " + text)
            backgroundRect.opacity = normalOpacity;
            letterButton.color = normalColor;
        }
    }

    property color normalColor: "lightgrey"
    property color selectedColor: "lightblue"
    property real normalOpacity: 0.25
    property real selectedOpacity: 0.1

    width : parent.width / 5
    font.pointSize: 42
    font.weight: Font.Light
    color: normalColor
    horizontalAlignment: Text.AlignHCenter
    MouseArea {
        anchors.fill: parent
        onClicked: {
            //console.log("letterButton" + parent.text + " onClicked:")
            parent.clicked(parent.text)
        }
    }

    Rectangle {
        id: backgroundRect
        anchors.fill: parent
        color: "grey"
        opacity: normalOpacity
    }
}
