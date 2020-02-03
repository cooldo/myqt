/*
The default database location is:
$HOME/.local/share/QtProject/QtQmlViewer/QML/OfflineStorage/Databases/

This database cannot be created from outside LocalStorage interface.
Therefore this database can only be used by this application and cannot support multi-process read/write.

There are 3 types of file read/write method.

    1. Use Settings qml module (import Qt.labs.settings 1.0)
        simple, small data storage, in labs(means premature)

    2. Use REST API. (new XMLHttpRequest())
        complicated, need HTTP server side support, json data format communication

    3. Sqlite database. (import QtQuick.LocalStorage 2.0)
        complicated, the database cannot be created from other application

*/
import QtQuick 2.5
import QtQuick.LocalStorage 2.0

Item {
    // reference to the database object
    property var db;
    function initDatabase() {
        // initialize the database object
        print('initDatabase()')
        db = LocalStorage.openDatabaseSync("CrazyBox", "1.0", "A box who remembers its position", 100000);
        db.transaction( function(tx) {
            print('... create table')
            tx.executeSql('CREATE TABLE IF NOT EXISTS data(name TEXT, value TEXT)');
        });
    }

    function storeData(crazyX, crazyY) {
        // stores data to DB
        print('storeData()')
        if(!db) { return; }
        db.transaction( function(tx) {
            print('... check if a crazy object exists')
            var result = tx.executeSql('SELECT * from data where name = "crazy"');
            // prepare object to be stored as JSON
            var obj = { x: crazyX, y: crazyY };
            if(result.rows.length === 1) {// use update
                print('... crazy exists, update it')
                result = tx.executeSql('UPDATE data set value=? where name="crazy"', [JSON.stringify(obj)]);
            } else { // use insert
                print('... crazy does not exists, create it')
                result = tx.executeSql('INSERT INTO data VALUES (?,?)', ['crazy', JSON.stringify(obj)]);
            }
        });
    }

    function readData() {
        // reads and applies data from DB
        var ret = {x: 0, y: 0};
        print('readData()')
        if(!db) { return; }
        db.transaction( function(tx) {
            print('... read crazy object')
            var result = tx.executeSql('select * from data where name="crazy"');
            if(result.rows.length === 1) {
                print('... update crazy geometry')
                // get the value column
                var value = result.rows[0].value;
                // convert to JS object
                var obj = JSON.parse(value)
                // apply to object
                ret.x = obj.x;
                ret.y = obj.y;
            }
        });
        return ret;
    }
}
