.pragma library

//This library a resultset structured just like the resultset from an SQLite select
//used here in place of a full SQLite Database to keep this demo simple

//see http://javascript.info/tutorial/objects for syntax

function getTemplateGroups() {
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


