import QtQuick 2.0

Rectangle {
    height: text.height;
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.leftMargin: 20
    anchors.rightMargin: 20
    color: "transparent"
    Text {
        id:text
        text: model.displayLabel
        font.pointSize: 28
        color: "white"
        height: 70
        verticalAlignment: Text.AlignVCenter
    }
    MouseArea {
        anchors.fill: parent
        onClicked: console.log ("delegate clicked ")
    }
}
