#ifndef FILE_H
#define FILE_H

#include <QObject>

class File : public QObject
{
    Q_OBJECT
    Q_PROPERTY (QString wholeName READ getWholeName NOTIFY wholeNameChanged)
    Q_PROPERTY (QString name READ getName NOTIFY nameChanged)
    Q_PROPERTY (QString type READ getType NOTIFY typeChanged)
    Q_PROPERTY (QString size READ getSize NOTIFY sizeChanged)
    Q_PROPERTY (QString icon READ getIcon NOTIFY typeChanged)
public:
    explicit File(QObject *parent = 0);
    File(QString name, QString dir, QObject *parrent = 0);
    QString getWholeName () const { return m_wholeName; }
    QString getName () const { return m_name; }
    QString getType () const { return m_type; }
    QString getSize () const { return m_size; }
    QString getIcon();
    QString converSize(qint64 size);
signals:
    void wholeNameChanged();
    void nameChanged();
    void typeChanged();
    void sizeChanged();

public slots:

private:
    QString parentDir;
    QString m_wholeName;
    QString m_name;
    QString m_type;
    QString m_size;
    bool isFile;

};

#endif // FILE_H
