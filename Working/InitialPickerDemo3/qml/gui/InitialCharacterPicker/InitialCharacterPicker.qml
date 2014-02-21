// Copyright (C) 2014 Chris Lamb
// This sofware is released under the MIT License --> http://en.wikipedia.org/wiki/MIT_license

import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: picker

    signal clicked (string character, string rowName)
    onClicked: {
        console.log("InitialPicker onClicked:" + character + ", row is: " + rowName);
        if (selectedCharacter == character) {
            console.log("the same character has been clicked again, close up")
            selectedCharacter = "";
        }
        else {
            selectedCharacter = character;
        }
        selectedRow = rowName;
    }

    property alias delegate: listView.delegate
    property QtObject model

    anchors.fill: parent

    property variant characters
    property int charactersPerRow
    property string initialCharacter: ""
    property string selectedCharacter
    property string selectedRow: "none"

    onSelectedCharacterChanged: {
        console.log("picker: onSelectedCharacterChanged: " + selectedCharacter + " filtering model")
        filteredModel.populate(picker.model, selectedCharacter);
    }

    Component.onCompleted: {
        privateObject.populateModels();
    }

    QtObject {
        id: privateObject
        property variant charactersModel

        function populateModels() {
            //first count how many of each char we have in the full model
            var charsModel = []
            for (var i=0; i < characters.length; i++) {
                var character = characters[i]
                var hits = 0;
                if (characters[i] == "%") {
                    hits = picker.model.count;
                }
                else {
                    //normal character
                    for (var j = 0; j < model.count; j ++) {
                        var rec = model.get(j);
                        if (rec.displayLabel.charAt(0).toUpperCase() == character.toUpperCase()) {
                            hits++;
                        }
                    }
                }
                charsModel.push({"char": character, "hits": hits});
            }
            console.log("populateModels: length: " + charsModel.length)
            privateObject.charactersModel = charsModel;

            //Now populate the filter model
            filteredModel.clear();
            filteredModel.populate(picker.model, picker.initialCharacter);
        }
    }

    ListModel {
        id: filteredModel
        objectName: "filteredModel"
        function populate(model, filter) {
            console.log("populating filteredModel for character: " + filter)
            filteredModel.clear();
            if (filter =="") {
                //leave the model empty
            }
            else if (filter =="%") {
                console.log("don't filter, copy the model lock stock and barrel " + model.count);
                //filteredModel = model;
                for (var i = 0; i < model.count; i ++) {
                    var rec = model.get(i);
                    filteredModel.append(rec);
                }
            }
            else {
                //filter on the chosen character
                for (var i = 0; i < model.count; i ++) {
                    var rec = model.get(i);
                    if (rec.displayLabel.charAt(0).toUpperCase() == filter.toUpperCase()) {
                        //console.log("appending to filteredModel")
                        filteredModel.append(rec);
                    }
                }
            }
            console.log("populated filteredModel with entries: " + filteredModel.count);
        }
    }

    ListView {
        id: listView
        anchors.fill: parent
        //height: childrenRect.height // don't this, it stops the listview flicking!!!!!
        model: filteredModel
        header: characterHeader
        footer: characterFooter
        clip: true
    }

    Component{
        id: characterHeader
        CharacterGrid {
            charactersPerRow: picker.charactersPerRow
            charactersModel: privateObject.charactersModel
            //these 3 properties used to determine which character rows should be open on header or footer
            selectedCharacter: picker.selectedCharacter
            selectedRow: picker.selectedRow
            isHeader: true
            onClicked: picker.clicked(character, rowName);
        }
    }

    Component{
        id: characterFooter
        CharacterGrid {
            charactersPerRow: picker.charactersPerRow
            charactersModel: privateObject.charactersModel
            //these 3 properties used to determine which character rows should be open on header or footer
            selectedCharacter: picker.selectedCharacter
            selectedRow: picker.selectedRow
            isHeader: false //we are a footer!
            onClicked: picker.clicked(character, rowName);
        }
    }
}
