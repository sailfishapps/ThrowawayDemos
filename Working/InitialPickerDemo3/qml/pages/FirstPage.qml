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
    // Basically it filters a model based on the selected initial letter,
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
        charactersPerRow: 5
        characters: ["%", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "" ]
    }

    //Note: It is assummed that the model is already alphabetically sorted!
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


