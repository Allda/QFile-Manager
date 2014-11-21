#include "file.h"
#include <QFileInfo>
#include <math.h>
#include <QDir>

File::File(QObject *parent) :
    QObject(parent)
{
}

File::File(QString name, QString dir, QObject *parrent){
    QFileInfo fi(dir + "/" + name);
    this->m_wholeName = name;
    this->isFile = fi.isFile();
    this->parentDir = dir;
    if(name == ".." || name == "."){
        this->m_name = name;
        this->m_type = "";
    }
    else{
        this->m_name = fi.baseName();
        if(fi.completeSuffix() != "")
            this->m_type = fi.suffix();
        if (this->isFile)
            this->m_size = converSize(fi.size());
        else{
            QDir myDir(dir + "/" + name);
            if(myDir.entryList().length() == 0)
                this->m_size = "0 items";
            else
                this->m_size = QString::number(myDir.entryList().length() - 2) + " items";

        }
    }


}

QString File::converSize(qint64 size){
    if(size > 1000000000){ //GB
        return QString::number(roundf(size/1000000000.0 *10)/10 ) + " GB";
    }
    else if(size > 1000000){ //MB
        return QString::number(roundf(size/1000000.0 *10)/10) + " MB";
    }
    else if(size > 1000){ //MB
        return QString::number(roundf(size/1000.0 *10)/10) + " KB";
    }
    else
        return QString::number(size) + " B";
}
