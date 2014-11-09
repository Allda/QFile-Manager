#ifndef FILE_H
#define FILE_H

#include <QObject>

class File : public QObject
{
    Q_OBJECT
    Q_PROPERTY (QString name READ getName NOTIFY nameChanged)
    Q_PROPERTY (QString type READ getType NOTIFY typeChanged)
public:
    explicit File(QObject *parent = 0);
    File(QString name, QString dir, QObject *parrent = 0);
    QString getName () const { return m_name; }
    QString getType () const { return m_type; }
signals:
    void nameChanged();
    void typeChanged();

public slots:

private:
    QString parentDir;
    QString m_name;
    QString m_type;

};

#endif // FILE_H
