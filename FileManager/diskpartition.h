    #ifndef DISKPARTITION_H
#define DISKPARTITION_H

#include <QObject>
#include <QStringList>

class DiskPartition : public QObject
{
    Q_OBJECT
    Q_PROPERTY (QStringList diskList READ getDiskList NOTIFY diskListChanged)
public:
    explicit DiskPartition(QObject *parent = 0);
    Q_INVOKABLE QStringList getDiskList () const { return m_diskList; }
    Q_INVOKABLE int getListLength() { return m_diskList.length();}
signals:
    void diskListChanged();

public slots:

private:
    QStringList m_diskList;

};

#endif // DISKPARTITION_H
