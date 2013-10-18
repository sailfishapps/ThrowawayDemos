/****************************************************************************************
**
** Copyright (C) 2013 Jolla Ltd.
** Contact: Martin Jones <martin.jones@jollamobile.com>
** All rights reserved.
**
** This file is part of Sailfish Silica UI component package.
**
** You may use this file under the terms of BSD license as follows:
**
** Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are met:
**     * Redistributions of source code must retain the above copyright
**       notice, this list of conditions and the following disclaimer.
**     * Redistributions in binary form must reproduce the above copyright
**       notice, this list of conditions and the following disclaimer in the
**       documentation and/or other materials provided with the distribution.
**     * Neither the name of the Jolla Ltd nor the
**       names of its contributors may be used to endorse or promote products
**       derived from this software without specific prior written permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
** ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
** DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
** ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
** (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
** LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
** ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
** SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**
****************************************************************************************/

//This is a clone of the standard Sailfish.Silica contextMenu.qml
//this is used temporarily in its place so we can add debug calls, and experiment with different values

import QtQuick 1.1
import Sailfish.Silica 1.0
import "Util.js" as Util
import Sailfish.Silica.private 1.0

MouseArea {
    id: contextMenu
    objectName: "contextMenu"

    property bool active
    property bool closeOnActivation: true

    property int _openAnimationDuration: 200
    property Item _nextItem
    property Item _highlightedItem
    property Flickable _flickable
    property Item _parentMouseArea
    property bool _closeOnOutsideClick: true

    signal activated(int index)

    default property alias children: contentColumn.data
    property alias _contentColumn: contentColumn

    height: 0
    width: _flickable !== null ? _flickable.width : 0
    parent: null
    clip: height > 0
    enabled: active
    visible: height > 0
    anchors.bottom: parent ? parent.bottom : undefined

    onPressed: _highlightMenuItem(mouse.y - contentColumn.y)
    onPositionChanged: _highlightMenuItem(mouse.y - contentColumn.y)
    onCanceled:  _setHighlightedItem(null)
    onReleased: {
        if (_highlightedItem !== null) {
            _activatedMenuItem(_highlightedItem)
        }
    }
    drag.target: Item {}

    onHeightChanged: {
        if (_highlightedItem) {
            // reposition the highlightBar
            highlightBar.highlight(_highlightedItem, contentColumn)
        }
    }

    onActiveChanged: {
        if (_parentMouseArea) {
            _parentMouseArea.preventStealing = active
        }
        console.log ("y1: " + contextMenu.mapToItem(_flickable.contentItem, 0, contextMenu.childrenRect.height).y );
        console.log ("_flickable.height: " + _flickable.height);
        console.log ("_flickable.contentItem.height: " + _flickable.contentItem.height)
        console.log ("contextMenu.childrenRect.height: " + contextMenu.childrenRect.height)
        console.log ("_flickable.contentY: " + _flickable.contentY);
        console.log ("_flickable.objectName: "+ _flickable.objectName)
        console.log("******")
        console.log ("0: " + contextMenu.mapToItem(_flickable.contentItem, 0, 00).y )
        console.log ("10: " + contextMenu.mapToItem(_flickable.contentItem, 0, 10).y )
        console.log ("100: " + contextMenu.mapToItem(_flickable.contentItem, 0, 100).y )
        console.log ("300: " + contextMenu.mapToItem(_flickable.contentItem, 0, 300).y )
        console.log ("350: " + contextMenu.mapToItem(_flickable.contentItem, 0, 350).y )
        console.log ("400: " + contextMenu.mapToItem(_flickable.contentItem, 0, 400).y )
        console.log ("500: " + contextMenu.mapToItem(_flickable.contentItem, 0, 500).y )
        console.log ("600: " + contextMenu.mapToItem(_flickable.contentItem, 0, 600).y )
        console.log ("700: " + contextMenu.mapToItem(_flickable.contentItem, 0, 700).y )
        console.log ("800: " + contextMenu.mapToItem(_flickable.contentItem, 0, 800).y )
    }

    SceneChangeNotifier {
        onHasSceneChanged: {
            if (!hasScene && active) {
                // We are no longer in the scene
                hide()
            }
        }
    }

    function show(item) {
        if (contextMenu.parent) {
            if (contextMenu.parent !== item) {
                _nextItem = item
                active = false
            }
            return
        } else {
            if (item) {
                parent = item
                _flickable = Util.findFlickable(item)
                _parentMouseArea = _findBackgroundItem(item)
                active = true
            } else {
                console.log("ContextMenu::show() called with an invalid item")
            }
        }
    }
    function hide() {
        active = false
        _parentMouseArea = null
    }

    function _findBackgroundItem(item) {
        if (item.hasOwnProperty("preventStealing") && item.pressed) {
            return item;
        }

        var parent = item
        for (var i=0; i < parent.children.length; i++) {
            var child = parent.children[i]
            if (child.hasOwnProperty("preventStealing") && child.pressed) {
                return child
            }
            var descendant = _findBackgroundItem(child)
            if (descendant) {
                return descendant
            }
        }

        return null
    }

    function _highlightMenuItem(yPos) {
        var xPos = width/2
        var child = contentColumn.childAt(xPos, yPos)
        if (!child) {
            _setHighlightedItem(null)
            return
        }
        var parentItem
        while (child) {
            if (child && child.hasOwnProperty("__silica_menuitem") && child.enabled) {
                _setHighlightedItem(child)
                break
            }
            parentItem = child
            yPos = parentItem.mapToItem(child, xPos, yPos).y
            child = parentItem.childAt(xPos, yPos)
        }
    }

    function _setHighlightedItem(item) {
        if (item === _highlightedItem) {
            return
        }
        if (_highlightedItem) {
            _highlightedItem.down = false
            highlightBar.clearHighlight()
        }
        _highlightedItem = item
        if (_highlightedItem) {
            highlightBar.highlight(_highlightedItem, contentColumn)
            _highlightedItem.down = true
        }
    }

    function _activatedMenuItem(item) {
        var menuItemCount = 0
        for (var i=0; i<children.length; i++) {
            if (children[i].hasOwnProperty("__silica_menuitem")) {
                if (children[i] === item) {
                    contextMenu.activated(menuItemCount)
                    children[i].clicked()
                    if (contextMenu.closeOnActivation) {
                        delayedHiding.restart()
                    }
                    return
                }
                menuItemCount++
            }
        }
    }

    Connections {
        target: _parentMouseArea
        onPositionChanged: {
            var mapY = contentColumn.mapFromItem(_parentMouseArea, mouse.x, mouse.y).y
            _highlightMenuItem(mapY)
        }
        onReleased: contextMenu.released(mouse)
    }

    Rectangle {
        anchors.fill: parent
        color: theme.highlightBackgroundColor
        opacity: theme.highlightBackgroundOpacity
        InverseMouseArea {
            anchors.fill: parent
            enabled: active && _closeOnOutsideClick
            stealPress: true
            onPressedOutside: hide()
        }
    }


    HighlightBar {
        id: highlightBar
    }

    Column {
        id: contentColumn
        width: parent.width
        anchors.bottom: parent.bottom
    }

    Timer {
        id: delayedHiding
        interval: 10
        onTriggered: contextMenu.hide()
    }

    states: State {
        when: active && _flickable !== null
        onCompleted: console.log ("State Changes completed; _flickable.contentY is now: " + _flickable.contentY)
        PropertyChanges {
            target: contextMenu
            height: contentColumn.height
        }
        // Move the view content up to keep the menu visible.

        PropertyChanges {
            target: _flickable
            contentY: Math.max(contextMenu.mapToItem(_flickable.contentItem, 0, contextMenu.childrenRect.height).y - _flickable.height, _flickable.contentY)

            //1) map a point of 350 (contextMenu.childrenRect) on the contextMenu to the _flickable.contentItem --> 790
            //basically this means the bottom of the contextMenu is way below the _flickable.contentItem (which is only 315 high)
            //2) subtract the flickable.height of 665 --> 125
            //3) 125 is higher than the _flickable.contentY of 0 --> new _flicakble.contentY = 125
            //RESULT: the menu "slides up", the top 125 pixels of the ListView are hidden.

            //so why is our _flickable.contentItem only 315?
            //why does it not contain the contextMenu?

            //interesting is also that a point 0 on the contextMenu is 440 on the _flickable.contentItem
            //so the top of our contextMenu is painted too low

            //In the case above the contentMenu.height is 350,
            //which is greater than the initial height of the _flickable 315 / _flickable.contentItemHeight (also 350)

            //If I have a menu of 270 heigh, (less than _flickable height)
            //things look a little better (but not much)
            //a) when the top item is selected:
            //the menu opens below the item as expected
            //the view Header disappears (slides up offscreen)
            //b) other itemss in the list can either
            //1) snap to the top (sliding the header and higher items away)
            //the menu opening below as expected
            //or
            //2)remain in place with the menu opening below as expected
            //but heigher items and the header are rendered invisible
            //behaviours 1 and 2) seem to be random


            interactive: false
            explicit: true
        }


/*
        PropertyChanges {
            target: _flickable
            contentY: Math.max(contextMenu.mapToItem(_flickable.contentItem, 0, contextMenu.childrenRect.height).y - _flickable.height, _flickable.contentY)
            interactive: false
            explicit: true
        }
*/
    }
    transitions: Transition {
        SequentialAnimation {
            NumberAnimation {
                properties: "height,contentY"
                duration: contextMenu._openAnimationDuration
                easing.type: Easing.InOutQuad
            }
            ScriptAction {
                script: {
                    if (!contextMenu.active) {
                        contextMenu.parent = null
                        if (_nextItem) {
                            contextMenu.show(_nextItem)
                            _nextItem = null
                        }
                        _setHighlightedItem(null)
                    }
                }
            }
        }
    }
}
