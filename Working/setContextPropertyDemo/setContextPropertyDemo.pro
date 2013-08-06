# The name of your app
TARGET = setContextPropertyDemo

# C++ sources
SOURCES += main.cpp

# C++ headers
HEADERS +=

# QML files and folders
qml.files = *.qml pages cover main.qml

# The .desktop file
desktop.files = setContextPropertyDemo.desktop

# Please do not modify the following line.
include(sailfishapplication/sailfishapplication.pri)

OTHER_FILES = \
    rpm/setContextPropertyDemo.yaml \
    rpm/setContextPropertyDemo.spec

