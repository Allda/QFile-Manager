#include "diskpartition.h"
#include <QDir>
#include <qdebug.h>

DiskPartition::DiskPartition(QObject *parent) :
    QObject(parent)
{
    QFileInfoList l = QDir::drives();
    qDebug() << "Disk: ";
    for(int i = 0; i < l.length();i++){
        this->m_diskList.append(l.at(i).absolutePath());
        qDebug() << l.at(i).absolutePath();
    }
}
