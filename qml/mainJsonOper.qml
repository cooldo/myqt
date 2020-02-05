import QtQuick 2.0
Item {
    // json object
    property var obj: {
        "name":"Bill Gates", "age": 62, "city":"eattle"
    }

    Component.onCompleted: {
        // get value of name
        console.log(obj["name"]);
        // iterate all json key/value pairs
        for (var key in obj) {
            console.log(key)
            console.log(obj[key])
        }

        // transform json object to string and print
        var data = JSON.stringify(obj);
        console.log(data);
        // transform string to json object
        var obj2 = JSON.parse(data);
  }
}
