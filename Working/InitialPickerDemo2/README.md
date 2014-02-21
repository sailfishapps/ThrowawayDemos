2014.02.21 Please see https://github.com/sailfishapps/ThrowawayDemos/tree/master/Working/InitialPickerDemo3


This app demos an "initial picker" similar to that used in the Jolla People App

Basically it filters a model based on the selected initial letter,

It:

a) reduces the need to scroll through long lists
     
b) is easier to use then a search dialog

This implementation is provided "as is". It is a demo which you are free to use and adapt.
It is entirely my own code, sharing nothing with the offical people app other than similar look and feel and behaviour

In its current form it does have some rough edges

a) the transitions could be better

b) I have found no way yet of elegantly passing in the field to be filtered. This is "hard-coded" in InitialPicker.qml as "displayLabel", so either your model provides this field / role, or you will have to edit InitialPicker.qml

c) There is no visual indication (yet) if a letter has any entries (and is thus worth pressing). I hope to add this soon.


How does it work?

It's a list view, with clever header and footer components.

The rows of letter buttons are hosted by the listView's header and footers (both the header and footer host the full alphabet)

Each row decides for itself if it should be visible on the header or footer, so a row will only be visible in either the header, or the footer, never in both.

When a letter button is pressed, the ListView appears to open immediately below the row hosting the letter.

The model displayed is a copy of that provided by parameter to InitialPicker.qml, filtered as necessary.

The LetterButton.qml instances are created dynamically in LetterRow.qml, which is a neat trick cutting down repetative code. In a future version I might apply the same trick to the rows.

