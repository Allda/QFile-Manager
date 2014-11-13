TEMPLATE = app

QT += qml quick widgets
QT += declarative

SOURCES += main.cpp \
    directory.cpp \
    file.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    directory.h \
    file.h

RC_FILE = myapp.rc
