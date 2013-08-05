import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica.theme 1.0
import "settingsDB.js" as DB
import "initiateDB.js" as DBInit
import "debugDB.js" as DBDebug

Page {
    id: page

    Component.onCompleted: {
        listAllTables();
    }

    function listAllTables() {
        var rs = DBDebug.allTables();
        if (rs.rows.length == 0) {
            console.log("No database tables found: DB will be initialised‘");
            DBInit.initiateDb();
            DBInit.populateDb();
        }
        else {
            console.log("Tables Found!!!");
            for(var i = 0; i < rs.rows.length; i++) {
                console.log("Found Table: " + rs.rows.item(i).name + "; " + countRecords(rs.rows.item(i).name));
            }
        }
    }

    function countRecords(table) {
        var rs = DBDebug.countRecords(table);
        return ("No recs: " + rs.rows.item(0).cnt )
    }

    Column {
        width: page.width
        spacing: Theme.paddingLarge
        PageHeader {
            title: "UI Template"
        }
        Label {
            x: Theme.paddingLarge
            text: "Hello Sailors"
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeLarge
        }
    }

}


