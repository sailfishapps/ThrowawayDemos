// Copyright (C) 2014 Chris Lamb
// This sofware is released under the MIT License --> http://en.wikipedia.org/wiki/MIT_license

import QtQuick 2.0

Row {

    id: letterRow

    signal clicked (string letter)
    onClicked: {
        console.log("letterRow onClicked: " + letter)
    }

    //we expect an array of letters here
    property variant letters
    onLettersChanged: {
        //we populate the letterRow based on the letters supplied in the letters array
        //console.log("onLettersChanged: " + letters)
        var component;
        var letterButton;
        for (var i=0; i < letters.length; i++) {
            //console.log("adding letter: " + letters[i] );
            component = Qt.createComponent("LetterButton.qml");
            letterButton = component.createObject(letterRow, {"text": letters[i]});
        }
    }

    property string selectedLetter
    onSelectedLetterChanged: {
        //console.log("letterRow: selectedLetter changed")
    }

    property string selectedRow
    onSelectedRowChanged: {
        //There are 3 cases
        //I am the selected row         --> visible in Header, Not visible in Footer
        //I am above the selected row   --> visible in Header, Not visible in Footer
        //I am below the selected row   --> visible in Footer, Not visible in Header
        //console.log ("seleted row changed: " + objectName)
        if (isHeader) {
            inHeader(objectName, selectedRow) ? visible = true : visible = false
        }
        else {
            inHeader(objectName, selectedRow) ? visible = false : visible = true
        }
    }

    property bool isHeader: true //initially true, then overridden by binding to grid.isHeader
    //this forces a change picked up below to set inital state (footer rows not visible)

    onIsHeaderChanged: {
        //console.log ("isHeaderChanged!")
        if (!isHeader && (selectedLetter=="" || selectedLetter=="%" )) {
            visible = false;
        }
    }

    function inHeader(thisRow, selectedRow) {
        var thisRowNo = row2Num(thisRow);
        var selectedRowNo = row2Num(selectedRow);
        // if the number of this row is smaller or equal to that of the selected row, I belong in the header
        if (thisRowNo <= selectedRowNo) {
            return true
        }
        else {
            return false
        }
    }

    function row2Num(rowName) {
        return rowName.charAt(rowName.length-1);
    }

    width: parent.width

}



