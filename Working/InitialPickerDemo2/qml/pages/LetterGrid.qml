// Copyright (C) 2014 Chris Lamb
// This sofware is released under the MIT License --> http://en.wikipedia.org/wiki/MIT_license

import QtQuick 2.0

Column {
    id: grid

    property string selectedLetter
    property string selectedRow
    property bool isHeader

    signal clicked (string letter, string rowName)

    width: picker.width
    move: Transition {
             NumberAnimation {
                 properties: "y"
                 //easing.type: Easing.OutBounce
                 //easing.type: Easing.InOutCirc
                 easing.type: Easing.OutCirc
             }
         }
    LetterRow {
        id: row1
        objectName: "row1"
        letters: ["%", "A", "B", "C", "D" ]
        onClicked: grid.clicked(letter, objectName);
        selectedLetter: grid.selectedLetter
        selectedRow: grid.selectedRow
        isHeader: grid.isHeader
    }
    LetterRow {
        id: row2
        objectName: "row2"
        letters: ["E", "F", "G", "H", "I"]
        onClicked: grid.clicked(letter, objectName);
        selectedLetter: grid.selectedLetter
        selectedRow: grid.selectedRow
        isHeader: grid.isHeader
    }
    LetterRow {
        id: row3
        objectName: "row3"
        letters: ["J", "K", "L", "M", "N"]
        onClicked: grid.clicked(letter, objectName);
        selectedLetter: grid.selectedLetter
        selectedRow: grid.selectedRow
        isHeader: grid.isHeader
    }
    LetterRow {
        id: row4
        objectName: "row4"
        letters: ["O", "P", "Q", "R", "S"]
        onClicked: grid.clicked(letter, objectName);
        selectedLetter: grid.selectedLetter
        selectedRow: grid.selectedRow
        isHeader: grid.isHeader
    }
    LetterRow {
        id: row5
        objectName: "row5"
        letters: ["T", "U", "V", "W", "X"]
        onClicked: grid.clicked(letter, objectName);
        selectedLetter: grid.selectedLetter
        selectedRow: grid.selectedRow
        isHeader: grid.isHeader
    }
    LetterRow {
        id: row6
        objectName: "row6"
        letters: ["Y", "Z", "#", "", "", ""]
        onClicked: grid.clicked(letter, objectName);
        selectedLetter: grid.selectedLetter
        selectedRow: grid.selectedRow
        isHeader: grid.isHeader
    }
}
