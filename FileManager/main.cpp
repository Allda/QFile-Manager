#include <QtQml>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <qdebug.h>
#include "directory.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;

    /*Directory directory("C:\\");
    directory.loadFiles();
    Directory directory2("C:\\");
    directory.loadFiles();*/

    //engine.rootContext()->setContextProperty("my_dir",&directory);
    //engine.rootContext()->setContextProperty("my_dir2",&directory2);

    qmlRegisterType<Directory>("directory", 1, 0, "Directory");

    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
