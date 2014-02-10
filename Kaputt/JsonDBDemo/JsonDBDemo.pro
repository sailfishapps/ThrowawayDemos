# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = JsonDBDemo

CONFIG += sailfishapp

SOURCES += src/JsonDBDemo.cpp \
    src/jsonstorage.cpp

OTHER_FILES += qml/JsonDBDemo.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/JsonDBDemo.spec \
    rpm/JsonDBDemo.yaml \
    JsonDBDemo.desktop \
    qml/pages/jsonpath.js \
    qml/pages/readDataModel.js

HEADERS += \
    src/jsonstorage.h

