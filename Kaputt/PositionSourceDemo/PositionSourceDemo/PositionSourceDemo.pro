# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = PositionSourceDemo

QT += positioning quick-private positioning-private qml-private core-private v8-private

CONFIG += sailfishapp

SOURCES += src/PositionSourceDemo.cpp \
    src/qdeclarativepositionsource.cpp \
    src/qdeclarativeposition.cpp \
    src/qdeclarativecoordinate.cpp \
    src/error_messages.cpp

OTHER_FILES += qml/PositionSourceDemo.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/PositionSourceDemo.spec \
    rpm/PositionSourceDemo.yaml \
    PositionSourceDemo.desktop

HEADERS += \
    src/qdeclarativepositionsource_p.h \
    src/qdeclarativeposition_p.h \
    src/qdeclarativecoordinate_p.h \
    src/error_messages.h

