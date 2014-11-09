#include "file.h"

File::File(QObject *parent) :
    QObject(parent)
{
}

File::File(QString name, QString dir, QObject *parrent){
    this->m_name = name;
    this->parentDir = dir;
}
