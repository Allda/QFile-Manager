#ifndef DIRECTORY_H
#define DIRECTORY_H
#include <QString>
#include <QDir>
#include <QStringList>
#include <QObject>

class Directory : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QList<QObject*> files READ getFiles NOTIFY filesChanged)
public:
    Directory();
    QList<QObject*> getFiles () const { return m_files; }
    void loadFiles();
    Q_INVOKABLE void changeDir(QString newDir);
    Q_INVOKABLE QString getDir();
    Q_INVOKABLE void copyToDir(QString file);
    Q_INVOKABLE void moveToDir(QString file);
    Q_INVOKABLE void cdUp();
    Q_INVOKABLE void deleteFile(QString file, bool emitFlag);
    Q_INVOKABLE void rename(QString oldName, QString newName);
    Q_INVOKABLE void newFolder(QString name);
    Q_INVOKABLE void newFile(QString name);
    Q_INVOKABLE void refresh();
    void copyPath(QString src, QString dst);
    bool removeDir(const QString & dirName);
    /*void addToSelected(QString item);
    void printFiles();
    Q_INVOKABLE QString test2();
    Q_INVOKABLE void printSelectedFiles();
    Q_INVOKABLE QStringList getFiles();
    QStringList getSelectedFiles();
    void removeFromSelected(QString item);
    void copySelected(QString dir);
    void renameSelected(QString newName);*/

signals:
    void filesChanged ();
protected:
    QList<QObject*> m_files;
    QString dir;
    QStringList files;
    QStringList selectedFiles;
};

#endif // DIRECTORY_H
