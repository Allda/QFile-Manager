#include <QApplication>
#include <QQmlApplicationEngine>
#include <qdebug.h>
#include "directory.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
