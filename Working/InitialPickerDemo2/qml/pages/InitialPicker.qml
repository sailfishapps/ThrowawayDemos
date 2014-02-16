import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: picker

    signal clicked (string letter, string rowName)
    onClicked: {
        console.log("InitialPicker onClicked:" + letter + ", row is: " + rowName);
        if (selectedLetter == letter) {
            console.log("the same letter has been clicked again, close up")
            selectedLetter = "";
        }
        else {
            selectedLetter = letter;
        }
        selectedRow = rowName;
    }

    property alias delegate: listView.delegate
    property QtObject model

    anchors.fill: parent

    property string initialInitial: ""
    property string selectedLetter
    property string selectedRow

    onSelectedLetterChanged: {
        console.log("picker: onSelectedLetterChanged: " + selectedLetter + " filtering model")
        modelFiltered.populate(picker.model, selectedLetter);
    }

    Component.onCompleted: {
        modelFiltered.populate(picker.model, initialInitial);
    }

    ListModel {
        id: modelFiltered
        objectName: "modelFiltered"
        function populate(model, filter) {
            console.log("populating modelFiltered for letter: " + filter)
            modelFiltered.clear()
            if (filter =="") {
                //leave the model empty
            }
            else if (filter =="%") {
                console.log("don't filter, copy the model lock stock and barrel " + model.count);
                //modelFiltered = model;
                for (var i = 0; i < model.count; i ++) {
                    var rec = model.get(i);
                    modelFiltered.append(rec);
                }
            }
            else {
                //filter on the chosen letter
                for (var i = 0; i < model.count; i ++) {
                    var rec = model.get(i);
                    if (rec.displayLabel.charAt(0) == filter) {
                        console.log("appending to modelFiltered")
                        modelFiltered.append(rec);
                    }
                }
            }
            console.log("populated modelFiltered with entries: " + modelFiltered.count);
            countModel.populate();
        }
    }

    //in a future version this model will be populated with number of hits per Letter
    // and can be used to colour the buttons text to give an indication of if any entries are available for the
    // indicated letter
    ListModel {
        id: countModel
        function populate() {
        }
    }

    ListView {
        id: listView
        anchors.fill: parent
        //height: childrenRect.height // don't this, it stops the listview flicking!!!!!
        model: modelFiltered
        header: initialHeader
        footer: initialFooter
        clip: true
    }

    Component{
        id: initialHeader
        LetterGrid {
            //these 3 properties used to determine which letter rows should be open on header or footer
            selectedLetter: picker.selectedLetter
            selectedRow: picker.selectedRow
            isHeader: true
            onClicked: picker.clicked(letter, rowName);
        }
    }

    Component{
        id: initialFooter
        LetterGrid {
            //these 3 properties used to determine which letter rows should be open on header or footer
            selectedLetter: picker.selectedLetter
            selectedRow: picker.selectedRow
            isHeader: false //we are a footer!
            onClicked: picker.clicked(letter, rowName);
        }
    }
}
