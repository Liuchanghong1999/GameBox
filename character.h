#ifndef CHARACTER_H
#define CHARACTER_H

#include <QObject>
#include <QJsonObject>
#include <QString>

class Character : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name WRITE setName)
    Q_PROPERTY(QString password READ password WRITE setPassword)
    Q_PROPERTY(QString sex READ sex WRITE setSex)
    Q_PROPERTY(QString birthdayYear READ birthdayYear WRITE setBirthdayYear)
    Q_PROPERTY(QString hometown READ hometown WRITE setHometown)
    Q_PROPERTY(QString avatar READ avatar WRITE setAvatar)
    Q_PROPERTY(QString constellation READ constellation WRITE setConstellation)
public:
    Character(QObject *parent = nullptr);

    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;

    void print(int indentation = 0) const;

    QString name() const;
    void setName(const QString &name);

    QString password() const;
    void setPassword(const QString &password);

    QString sex() const;
    void setSex(const QString &sex);

    QString birthdayYear() const;
    void setBirthdayYear(const QString &birthdayYear);

    QString hometown() const;
    void setHometown(const QString &hometown);

    QString avatar() const;
    void setAvatar(const QString &avatar);

    QString constellation() const;
    void setConstellation(const QString &constellation);
private:
    QString mName;
    QString mPassword;
    QString mSex;
    QString mBirthdayYear;
    QString mHometown;
    QString mAvatar;
    QString mConstellation;
};

#endif // CHARACTER_H
