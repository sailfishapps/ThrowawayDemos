# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = InitialPickerDemo3

CONFIG += sailfishapp

SOURCES += src/InitialPickerDemo3.cpp

OTHER_FILES += qml/InitialPickerDemo3.qml \
    rpm/InitialPickerDemo3.spec \
    rpm/InitialPickerDemo3.yaml \
    InitialPickerDemo3.desktop \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/gui/InitialCharacterPicker/InitialCharacterPicker.qml \
    qml/gui/InitialCharacterPicker/CharacterButton.qml \
    qml/gui/InitialCharacterPicker/CharacterGrid.qml \
    qml/gui/InitialCharacterPicker/CharacterRow.qml \
    qml/gui/ExampleDelegate.qml \
    qml/models/ExampleModel.qml

