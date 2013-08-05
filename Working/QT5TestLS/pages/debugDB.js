.pragma library

.import "settingsDB.js" as SDB
//.import QtQuick.LocalStorage 2.0 as LS // not required, as "inherited" from settingsDB
//Qt.include("settingsDB.js") //old Qt 4 style

///////////////////////////////////////////////////////////////
// Support / debug functions
///////////////////////////////////////////////////////////////

function allTables() {
    var db = SDB.getDatabase();
    var rs;
    db.transaction(
        function(tx) {
            rs = tx.executeSql('SELECT name FROM sqlite_master WHERE type = ?;', ["table"]);
        }
    )
    return rs;
}

function countRecords(table) {
    var db = SDB.getDatabase();
    var cntStmt = "Select Count(*) cnt FROM " + table
    var rs;
    db.transaction(
        function(tx) {
            //rs = tx.executeSql('SELECT count(*) cnt FROM ?;', [table]);
            rs = tx.executeSql(cntStmt);
        }
    )
    return rs;
}
