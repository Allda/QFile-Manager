#include <QtQml>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <qdebug.h>
#include "directory.h"
#include "diskpartition.h"




int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<Directory>("directory", 1, 0, "Directory");
    qmlRegisterType<DiskPartition>("diskpartition", 1, 0, "DiskPartition");

    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
