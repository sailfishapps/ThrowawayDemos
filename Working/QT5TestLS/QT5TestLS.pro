# The name of your app
TARGET = QT5TestLS

# C++ sources
SOURCES += main.cpp

# C++ headers
HEADERS +=

# QML files and folders
qml.files = *.qml pages cover main.qml

# The .desktop file
desktop.files = QT5TestLS.desktop

# Please do not modify the following line.
include(sailfishapplication/sailfishapplication.pri)

OTHER_FILES = \
    rpm/QT5TestLS.yaml \
    rpm/QT5TestLS.spec

