# The name of your app
TARGET = AliasesDemo

# C++ sources
SOURCES += main.cpp

# C++ headers
HEADERS +=

# QML files and folders
qml.files = *.qml pages cover main.qml

# The .desktop file
desktop.files = AliasesDemo.desktop

# Please do not modify the following line.
include(sailfishapplication/sailfishapplication.pri)

OTHER_FILES = \
    rpm/AliasesDemo.yaml \
    rpm/AliasesDemo.spec \
    pages/ChildElementOne.qml

