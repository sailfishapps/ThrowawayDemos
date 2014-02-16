# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = InitialPickerDemo2

CONFIG += sailfishapp

SOURCES += src/InitialPickerDemo2.cpp

OTHER_FILES += qml/InitialPickerDemo2.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/InitialPickerDemo2.spec \
    rpm/InitialPickerDemo2.yaml \
    InitialPickerDemo2.desktop \
    qml/pages/InitialPicker.qml \
    qml/pages/ExampleModel.qml \
    qml/pages/ExampleDelegate.qml \
    qml/pages/LetterGrid.qml \
    qml/pages/LetterButton.qml \
    qml/pages/LetterRow.qml

