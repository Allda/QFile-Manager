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
    for(int i = 1; i < files.count();i++){
        //qDebug() << files.at(i);
        this->m_files.append(new File(files.at(i), this->dir));
    }
    emit filesChanged ();

}

void Directory::changeDir(QString newDir){
    QFileInfo fi(newDir);
    if(fi.isDir()){
        QDir myDir(newDir);
        if(myDir.entryList().length() == 0)
            return;
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

void Directory::copyToDir(QString file){
    QFileInfo f(file);
    if(f.isFile()){
        QFile::copy(file, this->dir + '/' + f.baseName());
    }
    else{
        QDir(this->dir).mkdir(f.baseName());
        this->copyPath(file, this->dir+'/'+f.baseName());
    }
    loadFiles();
}

void Directory::copyPath(QString src, QString dst)
{
    QDir dir(src);
    if (! dir.exists())
        return;

    foreach (QString d, dir.entryList(QDir::Dirs | QDir::NoDotAndDotDot)) {
        QString dst_path = dst + QDir::separator() + d;
        dir.mkpath(dst_path);
        copyPath(src+ QDir::separator() + d, dst_path);
    }

    foreach (QString f, dir.entryList(QDir::Files)) {
        QFile::copy(src + QDir::separator() + f, dst + QDir::separator() + f);
    }
}

void Directory::moveToDir(QString file){
    QFileInfo f(file);
    QDir d;
    if(f.isFile()){
        d.rename(file, this->dir + '/' + f.baseName());
    }
    else{
        copyPath(file, this->dir + "/" + f.baseName());
        removeDir(file);
    }
    loadFiles();
}

void Directory::cdUp(){
    QDir d(this->dir);
    d.cdUp();
    this->changeDir(d.absolutePath());
    this->loadFiles();
}

void Directory::newFolder(QString name){
    if(!QDir(this->dir + '/' + name).exists())
        QDir().mkdir(this->dir + '/' + name);
    loadFiles();
}

void Directory::newFile(QString name){
    if(!QFile(this->dir + '/' + name).exists()){
        QFile f(this->dir + '/' + name);
        f.open(QIODevice::WriteOnly);
        loadFiles();
    }
}

void Directory::deleteFile(QString file, bool emitFlag){
    QFileInfo f(this->dir + "/" + file);
    if(f.isFile()){
        QFile::remove(this->dir + "/" + file);
    }
    else{
        removeDir(this->dir + "/" + file);
    }
    if(emitFlag)
        loadFiles();
}

bool Directory::removeDir(const QString & dirName)
{
    bool result = true;
    QDir dir(dirName);

    if (dir.exists(dirName)) {
        Q_FOREACH(QFileInfo info, dir.entryInfoList(QDir::NoDotAndDotDot | QDir::System | QDir::Hidden  | QDir::AllDirs | QDir::Files, QDir::DirsFirst)) {
            if (info.isDir()) {
                result = removeDir(info.absoluteFilePath());
            }
            else {
                result = QFile::remove(info.absoluteFilePath());
            }

            if (!result) {
                return result;
            }
        }
        result = dir.rmdir(dirName);
    }
    return result;
}

void Directory::rename(QString oldName, QString newName){
    QDir d;
    d.rename(this->dir + '/'+oldName, this->dir + '/' + newName);
    loadFiles();
}

void Directory::refresh(){
    loadFiles();
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
