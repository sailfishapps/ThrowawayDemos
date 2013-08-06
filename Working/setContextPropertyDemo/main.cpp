
#include <QGuiApplication>
#include <QQuickView>
#include <QQmlContext>

#include "sailfishapplication.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app(Sailfish::createApplication(argc, argv));

    //Old Harmattan / Qt 4 way, also worked with Sailfish Alpha 1
    //requires a QmlApplicationViewer section in the project
    //QScopedPointer<QQuickView> view(Sailfish::createView("main.qml"));
    //view->rootContext()->setContextProperty("cppproperty",  "Hello world");

    //New Sailfish Alpha 2 /Qt 5 way
    //requires patch to sailfishapplication.cpp from Lucien Xu
    QScopedPointer<QQuickView> view(Sailfish::createView());
    view->rootContext()->setContextProperty("cppproperty",  "Hello world");
    Sailfish::setView(view.data(), "main.qml");

    Sailfish::showView(view.data());
    return app->exec();
}


