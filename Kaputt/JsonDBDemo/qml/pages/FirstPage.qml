import QtQuick 2.0
import Sailfish.Silica 1.0

import "readDataModel.js" as DB


Page {
    id: page


    Component.onCompleted: {
        areaModel.populate();
        //proper wqy to populate templates would be when an area is chosen, but this is a throwaway demo
        //focussed on proving if jsonpath queries work!
        templateModel.populate();
    }

    ListModel {
        id: areaModel
        function populate(){
            clear();
            console.log("area model populating: About to getAreas from JSON");
            var rs = DB.getAreas();
            console.log("area model populating: No Rows: " + rs.rows.length);
            areaView.resize(rs.rows.length);
            for(var i = 0; i < rs.rows.length; i++) {
                areaModel.append({"name": rs.rows.item(i).name, "area_id":  rs.rows.item(i).id});
            }
        }
    }

    ListModel {
        id: templateModel
        function populate(){
            clear();
            console.log("template model populating: About to getTemplates from JSON");
            var rs = DB.getTemplates();
            console.log("template model populating: No Rows: " + rs.rows.length);
            templateView.resize(rs.rows.length);
            for(var i = 0; i < rs.rows.length; i++) {
                templateModel.append({"name": rs.rows.item(i).name, "template_id":  rs.rows.item(i).id});
            }
        }
    }

    Column {
        ListView {
            id: areaView
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingLarge
            anchors.right:parent.right
            anchors.rightMargin: Theme.paddingLarge
            property int itemHeight: 60
            property int headerHeight: itemHeight
            model: areaModel
            delegate: areaDelegate
            function resize(items){
                console.log("resizing");
                areaView.height = (items * itemHeight) + headerHeight;
            }
        }

        ListView {
            id: templateView
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingLarge
            anchors.right:parent.right
            anchors.rightMargin: Theme.paddingLarge
            property int itemHeight: 60
            property int headerHeight: itemHeight
            model: templateModel
            delegate: templateDelegate
            function resize(items){
                console.log("resizing");
                templateView.height = (items * itemHeight) + headerHeight;
            }
        }
    }



    Component {
        id: areaHedader
        Label{
            width: areaView.width
            height: areaView.itemHeight
            text: "Areas from JSON"
            font.pointSize: 26
        }
    }

    Component {
        id: templateHedader
        Label{
            width: templateView.width
            height: templateView.itemHeight
            text: "Template from JSON"
            font.pointSize: 26
        }
    }

    Component {
        id: templateDelegate
        Label{
            width: templateView.width
            height: templateView.itemHeight
            text: name + " " + template_id
            font.pointSize: 26
        }
    }

    Component {
        id: areaDelegate
        Label{
            width: areaView.width
            height: areaView.itemHeight
            text: name
            font.pointSize: 26
        }
    }


}


