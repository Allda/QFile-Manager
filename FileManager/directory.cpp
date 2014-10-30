#include "directory.h"
#include <QDebug>

Directory::Directory() {

}

Directory::Directory(QString dir)
{
    this->dir = dir;
}

void Directory::loadFiles(){
    QDir directory(this->dir);
    files = directory.entryList();

}

void Directory::addToSelected(QString item){
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
