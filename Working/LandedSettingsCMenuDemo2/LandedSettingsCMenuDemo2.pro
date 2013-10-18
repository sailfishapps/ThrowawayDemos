# The name of your app
TARGET = LandedSettingsCMenuDemo2

# C++ sources
SOURCES += main.cpp

# C++ headers
HEADERS +=

# QML files and folders
qml.files = *.qml pages cover others main.qml

# The .desktop file
desktop.files = LandedSettingsCMenuDemo2.desktop

# Please do not modify the following line.
include(sailfishapplication/sailfishapplication.pri)

OTHER_FILES = \
    rpm/LandedSettingsCMenuDemo2.yaml \
    rpm/LandedSettingsCMenuDemo2.spec

