This app demos an "initial picker" similar to that used in the Jolla People App

Basically it filters a model based on the selected initial letter,
It:
a) reduces the need to scroll through long lists

b) is easier to use then a search dialog

This implementation is provided "as is". It is a demo which you are free to use and adapt.
It is entirely my own code, sharing nothing with the offical people app other than similar look and feel and behaviour
In its current form it does have some rough edges
a) the transitions could be better
b) I have found no way yet of elegantly passing in the field / role to be filtered. This is "hard-coded"
in InitialPicker.qml as "displayLabel", so either your model provides this field / role,
or you will have to edit InitialPicker.qml
c) When initialised with % (display all), the header opens "off screen", but you can scroll up to it.
d) if opened on a Jolla device from QtCreator, things may not respond properly until the app is minimised
   and maximised once (this is common to many apps, and is a problem with the development environment, not the app itself)

How does it work?

It's a list view, with clever header and footer components.
The rows of character buttons are hosted by the listView's header and footers (both the header and footer host the full alphabet)
Each row decides for itself if it should be visible on the header or footer.
The model displayed is a copy of that provided by parameter to InitialPicker.qml, filtered as necessary.
A javascript array count the number of hits per character. This is used to provide visual indication if a button is worth pressing.
Both rows and the buttons they host are dynmically created QML elements.
which is a neat trick cutting down repetative code. In a future version I might apply the same trick to the rows.

Change Control

Version 3: Second public version
1) Components renamed from "Letter" to "Character", as the Initial may also be a digit. Thanks CDW.
2) Folders introduced to better structure the code, and separate the component elements from demo code
3) Rows are now also dynamically created, and all chars are provided as one long array to InitialCharacterPicker
4) Buttons that have no entries are have darkgrey text (to indicate no hits), and mousearea is disabled.

Version 2: First public version

Version 1: Proof on Concept version: 90% completed, but had some major flaws --> was canibalised and reused for version 2
