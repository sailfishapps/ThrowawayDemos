# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = GSTTorch2

CONFIG += sailfishapp

PKGCONFIG += gstreamer-0.10

SOURCES += src/GSTTorch2.cpp \
    src/gsttorch.cpp

OTHER_FILES += qml/GSTTorch2.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/GSTTorch2.spec \
    rpm/GSTTorch2.yaml \
    GSTTorch2.desktop

HEADERS += \
    gsttorch.h

