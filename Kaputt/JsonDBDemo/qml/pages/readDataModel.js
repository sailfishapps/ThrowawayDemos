.pragma library
.import JSONStorage 1.0 as JSDB
.import "jsonpath.js" as JSONPath

function getDatabase() {
    return JSDB.JSONStorage.openDatabase();
}

function parseJSONString(jsonString, jsonPathQuery) {
    var objectArray = JSON.parse(jsonString);
    if ( jsonPathQuery !== "" ) {
        console.log("about to pass DB to JSONPath");
        objectArray = JSONPath.jsonPath(objectArray, jsonPathQuery);
        console.log("readDataModel.js: objectArray.length: " + objectArray.length);
    }
    return objectArray;
}

function executeQuery(db, query) {
    //This executes the query and packs it as a result set
    //structured like that returned from LocalStorage
    //os our QML does not have to care about the datasource
    var jsonRows = parseJSONString(db, query);
    var rs = {
       //rs is a SQLResultSet object
       insertId: 0,
       rowsAffected: 0,
       rows: {
          //rows is a SQLResultSetRowList object
          length: jsonRows.length,
          item: function(index) {
             return jsonRows [index];
          }
       }
    }
    return rs;
}

function getAreas() {
    var db = getDatabase();
    var query = "$.landed.area[*]"
    var rs = executeQuery(db, query);
    console.log("readDataModel.js: rs.length: " + rs.length);
    return rs;
}


function getTemplates(area_id) {
    var db = getDatabase();
    console.log("getting Templates for area: " + area_id);
    //('SELECT * FROM Template t where t.area_id= ?;', [area_id]);
    //var query = "$.landed.area[?(@.id = " + area_id + ")].template[*]"
    var query = "$.landed.area[?(@.id = 1)].template[*]"
    var rs = executeQuery(db, query);
    console.log("readDataModel.js: rs.length: " + rs.length);
    return rs;
}


//just for fun, something I did earlier, returns the same structure as an SQLite LocalStorageDB
//this is the type of structure I need back from jsonpath to be able to drop in instead of a LocalStorageDB
function getAreasFake() {
    var qmlrs = [];
    qmlrs.push({id: 1, name: 'South Africa'});
    qmlrs.push({id: 2, name: 'Greece'});
    qmlrs.push({id: 3, name: 'Schweiz'});
    qmlrs.push({id: 4, name: 'France'});
    qmlrs.push({id: 5, name: 'Italy'});
    qmlrs.push({id: 6, name: 'Austria'});

    var rs = {
       //rs is a SQLResultSet object
       insertId: 0,
       rowsAffected: 0,
       rows: {
          //rows is a SQLResultSetRowList object
          length: qmlrs.length,
          item: function(index) {
             return qmlrs [index];
          }
       }
    }
    return rs;
}



//more functions wrapping selects here

