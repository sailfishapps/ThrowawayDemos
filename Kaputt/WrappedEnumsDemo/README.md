This demo shows a bug whereby when a C++ element is wrapped in QML, enums are not directly available.

i.e. if a C++ element has an enum, this is directly accessable from QML instances.

If the C++ element is wrapped in a QML custom element, the enum is "lost", and cannot be directly accessed.

There are 2 possible workarounds:

1) shown in the demo, commented out: Create in instance of the QML element wrapping the C++ element with the enum.
Now the enum can be accessed via instanceName.xxxx where instanceName is the id of the XML instance.

2) An Equivalent Enum can be created in a C++ plugin via qmlRegisterUncreatableType, and directly accessed from QML

See https://bugreports.qt-project.org/browse/QTBUG-34226

The Qt4.8 version is targetted at Harmattan (Nokia N9)

The Qt5.0 version is targetted at Sailfish Alpha 2

