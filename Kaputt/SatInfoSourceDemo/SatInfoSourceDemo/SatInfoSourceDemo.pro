# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = SatInfoSourceDemo

CONFIG += sailfishapp

QT += positioning

SOURCES += src/SatInfoSourceDemo.cpp \
    src/satinfosource.cpp

HEADERS += \
    satinfosource.h

OTHER_FILES += qml/SatInfoSourceDemo.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/SatInfoSourceDemo.spec \
    rpm/SatInfoSourceDemo.yaml \
    SatInfoSourceDemo.desktop



