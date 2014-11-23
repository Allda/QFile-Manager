/****************************************************************************
** Meta object code from reading C++ file 'directory.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.3.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../FileManager/directory.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#include <QtCore/QList>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'directory.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.3.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_Directory_t {
    QByteArrayData data[20];
    char stringdata[166];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_Directory_t, stringdata) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_Directory_t qt_meta_stringdata_Directory = {
    {
QT_MOC_LITERAL(0, 0, 9),
QT_MOC_LITERAL(1, 10, 12),
QT_MOC_LITERAL(2, 23, 0),
QT_MOC_LITERAL(3, 24, 9),
QT_MOC_LITERAL(4, 34, 6),
QT_MOC_LITERAL(5, 41, 6),
QT_MOC_LITERAL(6, 48, 9),
QT_MOC_LITERAL(7, 58, 4),
QT_MOC_LITERAL(8, 63, 9),
QT_MOC_LITERAL(9, 73, 4),
QT_MOC_LITERAL(10, 78, 10),
QT_MOC_LITERAL(11, 89, 8),
QT_MOC_LITERAL(12, 98, 6),
QT_MOC_LITERAL(13, 105, 7),
QT_MOC_LITERAL(14, 113, 7),
QT_MOC_LITERAL(15, 121, 9),
QT_MOC_LITERAL(16, 131, 4),
QT_MOC_LITERAL(17, 136, 7),
QT_MOC_LITERAL(18, 144, 5),
QT_MOC_LITERAL(19, 150, 15)
    },
    "Directory\0filesChanged\0\0changeDir\0"
    "newDir\0getDir\0copyToDir\0file\0moveToDir\0"
    "cdUp\0deleteFile\0emitFlag\0rename\0oldName\0"
    "newName\0newFolder\0name\0newFile\0files\0"
    "QList<QObject*>"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Directory[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      10,   14, // methods
       1,   92, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   64,    2, 0x06 /* Public */,

 // methods: name, argc, parameters, tag, flags
       3,    1,   65,    2, 0x02 /* Public */,
       5,    0,   68,    2, 0x02 /* Public */,
       6,    1,   69,    2, 0x02 /* Public */,
       8,    1,   72,    2, 0x02 /* Public */,
       9,    0,   75,    2, 0x02 /* Public */,
      10,    2,   76,    2, 0x02 /* Public */,
      12,    2,   81,    2, 0x02 /* Public */,
      15,    1,   86,    2, 0x02 /* Public */,
      17,    1,   89,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void, QMetaType::QString,    4,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString,    7,
    QMetaType::Void, QMetaType::QString,    7,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString, QMetaType::Bool,    7,   11,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   13,   14,
    QMetaType::Void, QMetaType::QString,   16,
    QMetaType::Void, QMetaType::QString,   16,

 // properties: name, type, flags
      18, 0x80000000 | 19, 0x00495009,

 // properties: notify_signal_id
       0,

       0        // eod
};

void Directory::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Directory *_t = static_cast<Directory *>(_o);
        switch (_id) {
        case 0: _t->filesChanged(); break;
        case 1: _t->changeDir((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 2: { QString _r = _t->getDir();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 3: _t->copyToDir((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 4: _t->moveToDir((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 5: _t->cdUp(); break;
        case 6: _t->deleteFile((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< bool(*)>(_a[2]))); break;
        case 7: _t->rename((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 8: _t->newFolder((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 9: _t->newFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (Directory::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&Directory::filesChanged)) {
                *result = 0;
            }
        }
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 0:
            *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<QObject*> >(); break;
        }
    }

}

const QMetaObject Directory::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_Directory.data,
      qt_meta_data_Directory,  qt_static_metacall, 0, 0}
};


const QMetaObject *Directory::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Directory::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Directory.stringdata))
        return static_cast<void*>(const_cast< Directory*>(this));
    return QObject::qt_metacast(_clname);
}

int Directory::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 10)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 10;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 10)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 10;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QList<QObject*>*>(_v) = getFiles(); break;
        default: break;
        }
        _id -= 1;
    } else if (_c == QMetaObject::WriteProperty) {
        _id -= 1;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 1;
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        if (_id < 1)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 1;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void Directory::filesChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}
QT_END_MOC_NAMESPACE
