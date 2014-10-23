#ifndef DIRECTORY_H
#define DIRECTORY_H
#include <QString>
#include <QList>
#include <QDir>
#include <QStringList>
class Directory
{
public:
    Directory(QString dir);
    void loadFiles();
    void addToSelected(QString item);
    void printFiles();
    void printSelectedFiles();
    QStringList getFiles();
    QStringList getSelectedFiles();
    void removeFromSelected(QString item);
    void copySelected(QString dir);
    void renameSelected(QString newName);
protected:
    QString dir;
    QStringList files;
    QStringList selectedFiles;
};

#endif // DIRECTORY_H
