import QtQuick 2.12
import QtQuick.Layouts 1.12

Flickable {
    id: root
    property int columns: 1
    property ListModel model: ListModel {}
    property Component itemDelegate: Item {}
    property Component sectionDelegate: Item {}
    contentHeight: layout.height
    contentWidth: layout.width
    Rectangle {
        anchors.fill: parent
        color: "black"

    GridLayout {
        id: layout
        columns: 3
        columnSpacing: 0
        rowSpacing: 0
        Component.onCompleted: {
            var lastSection = "";
            for(var i = 0;i < root.model.count;i ++)
            {
                var element = root.model.get(i);
                //console.log("gaoqiang:" + element.name.split(":")[0])
                var section = element.name.split(":")[0]
                if(section !== lastSection)
                    //root.sectionDelegate.createObject(layout, { "name": element.section, "Layout.columnSpan": root.columns });
                    root.sectionDelegate.createObject(layout, { "name": section, "Layout.columnSpan": 3});

                root.itemDelegate.createObject(layout, { "name": element.name, "index": i});
                lastSection = section
            }
        }
    }
    }
}
