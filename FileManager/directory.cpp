#include "directory.h"
#include <QDebug>
#include <QDir>
#include <QFileInfo>
#include <QDesktopServices>
#include <QUrl>
#include "file.h"


Directory::Directory()
{
    this->dir = QDir::drives().at(0).absolutePath();
    qDebug() << QDir::drives().at(0).absolutePath();
    this->loadFiles();
}

void Directory::loadFiles(){
    QDir directory(this->dir);
    files = directory.entryList();
    this->m_files.clear();
    for(int i = 0; i < files.count();i++){
        //qDebug() << files.at(i);
        this->m_files.append(new File(files.at(i), this->dir));
    }
    emit filesChanged ();

}

void Directory::changeDir(QString newDir){
    QFileInfo fi(newDir);
    if(fi.isDir()){
        this->dir = fi.absoluteFilePath();
        loadFiles();
    }
    else{
        QDesktopServices::openUrl(QUrl(newDir));
    }

}

QString Directory::getDir(){
    return dir;
}

/*void Directory::addToSelected(QString item){
    selectedFiles.append(item);
}

void Directory::printFiles(){
    for(int i = 0; i < files.length();i++){
        qDebug() << files.at(i);
    }
}

void Directory::printSelectedFiles(){
    for(int i = 0; i < selectedFiles.length();i++){
        qDebug() << selectedFiles.at(i);
    }
}

QStringList Directory::getFiles(){
    return files;
}

QStringList Directory::getSelectedFiles(){
    return selectedFiles;
}

void Directory::removeFromSelected(QString item){
    selectedFiles.removeOne(item);
}

void Directory::copySelected(QString dir){
    for(int i = 0; i < selectedFiles.length();i++){
        qDebug() << QFile::copy(this->dir + "/" + selectedFiles.at(i),dir + "/" + selectedFiles.at(i));
        qDebug() << "Copy: "+this->dir+"/"+selectedFiles.at(i) + " - " + dir + "/" + selectedFiles.at(i);
    }
}

void Directory::renameSelected(QString newName){
    if(selectedFiles.length() == 1){
        QFile::rename(this->dir + "/" + selectedFiles.at(0),this->dir + "/" + newName);
        this->selectedFiles.removeAt(0);
        selectedFiles.append(newName);
    }
    else
        return;
}

QString Directory::test2(){
    return "qweqweqwe";
}*/
