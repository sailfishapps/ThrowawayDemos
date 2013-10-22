# The name of your app
TARGET = WrappedEnumsDemoQt5_0

# C++ sources
SOURCES += main.cpp

# C++ headers
HEADERS +=

# QML files and folders
qml.files = *.qml pages cover main.qml

# The .desktop file
desktop.files = WrappedEnumsDemoQt5_0.desktop

# Please do not modify the following line.
include(sailfishapplication/sailfishapplication.pri)

OTHER_FILES = \
    rpm/WrappedEnumsDemoQt5_0.yaml \
    rpm/WrappedEnumsDemoQt5_0.spec

