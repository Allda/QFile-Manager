TEMPLATE = app

QT += qml quick widgets
QT += declarative

SOURCES += main.cpp \
    directory.cpp \
    file.cpp \
    diskpartition.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

CONFIG += c++11

HEADERS += \
    directory.h \
    file.h \
    diskpartition.h

RC_FILE = myapp.rc
