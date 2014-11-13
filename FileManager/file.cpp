#include "file.h"
#include <QFileInfo>

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
            this->m_type = "."+fi.completeSuffix();
        /*if (this->isFile)
            this->m_size = fi.size();
        else this->m_size = 0;*/

    }


}
