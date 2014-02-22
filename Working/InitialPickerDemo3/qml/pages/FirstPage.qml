// Copyright (C) 2014 Chris Lamb
// This sofware is released under the MIT License --> http://en.wikipedia.org/wiki/MIT_license

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../gui"
import "../gui/InitialCharacterPicker"
import "../models"

Page {
    id: page

    // This app demos an "initial picker" similar to that used in the Jolla People App
    // It filters a model based on the selected initial letter, thus:,
    // It,  a) reduces the need to scroll through long lists
    //      b) is easier to use then a search dialog

    // This implementation is provided "as is". It is a demo which you are free to use and adapt.
    // It is entirely my own code, sharing nothing with the offical people app other than similar look and feel and behaviour
    // In its current form it does have some rough edges
    // a) the transitions could be better
    // b) When initialised with % (display all), the header opens "off screen", but you can scroll up to it.
    // c) if opened on a Jolla device from QtCreator, things may not respond properly until the app is minimised
    //    and maximised once (this is common to many apps, and is a problem with the development environment, not the app itself)

    //How does it work?
    // It's a list view, with clever header and footer components.
    // The rows of character buttons are hosted by the listView's header and footers (both the header and footer host the full alphabet)
    // Each row decides for itself if it should be visible on the header or footer.
    // The model displayed is a copy of that provided by parameter to InitialPicker.qml, filtered as necessary.
    // A javascript array count the number of hits per character. This is used to provide visual indication if a button is worth pressing.
    // Both rows and the buttons they host are dynmically created QML elements.
    // which is a neat trick cutting down repetative code. In a future version I might apply the same trick to the rows.

    //Change Control

    //Version 3: Second public version
    //1) Components renamed from "Letter" to "Character", as the Initial may also be a digit. Thanks CDW.
    //2) Folders introduced to better structure the code, and separate the component elements from demo code
    //3) Rows are now also dynamically created, and all chars are provided as one long array to InitialCharacterPicker
    //4) Buttons that have no entries are have darkgrey text (to indicate no hits), and mousearea is disabled.
    //5) VerticalScolldecorator added
    //6) The Model used must have a function value2FilterOn(index) return the value of the field to be filtered
    //   This means that the field's role is no longer hard-coded inside InitialCharacterPicker
    //   --> better encapsulation, lower coupling.
    //7) new parameter caseSensitive (default false)
    //8) Leading blanks are trimmed away in filter and sort
    //9) "#" hash symbol acts a wild card for entries starting with a digit
    //10) We demonstrate building the characters array programmatically with loops, rather than as a "longhand-coded" array declaration

    //Version 2: First public version

    //Version 1: Proof on Concept version: 90% completed, but had some major flaws --> was canibalised and reused for version 2


    InitialCharacterPicker {
        id: initiaPicker
        anchors.top: parent.top
        width: parent.width
        model: exampleModel
        delegate: exampleDelegate
        //initialCharacter is used to provide the initial to filter on when the component is created
        //"" will chose nothing, "%" all entries, any other letter will be filtered upon as normal.
        initialCharacter: ""
        caseSensitive: false
        charactersPerRow: 5
        //characters: ["%", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "#" ]

        //demo programmatic building of character array --> helps avoid typos!
        //as the app builder is is up to you how you build the array of characters, longhand as above, or via function as below
        property bool displayChars: true
        property bool displayNumerals: true
        characters: buildCharacters(displayChars, displayNumerals);

        function buildCharacters(displayChars, displayNumerals) {
            var ret = [];
            if (displayChars) {
                //alphanumeric wild card, will display all entries
                ret.push("%");
                //65-90 ascii codes for chars A to Z
                for (var i = 65; i <= 90; i++) {
                    ret.push(String.fromCharCode(i));
                }
            }
            if (displayNumerals) {
                //48-57 ascii codes for digits 0 to 9
                for (var i = 48; i <= 57; i++) {
                    ret.push(String.fromCharCode(i));
                }
                //numeric wildcard, will display entries starting with a numeral
                ret.push("#");
            }
            return ret;
        }
    }

    //The model has a role displayLabel: This is the role that will be filtered on
    ExampleModel {
        id: exampleModel
        objectName: "exampleModel"
        //attempt to pass the role name to a dynamic javascript function
        //property string role2Filter: "displayLabel"
        function value2FilterOn(index){
            return get(index).displayLabel;
        }
    }

    Component {
        id: exampleDelegate
        ExampleDelegate {
        }
    }
}


