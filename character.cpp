#include "character.h"

#include <QTextStream>

Character::Character(QObject *parent) : QObject(parent)
{

}

QString Character::name() const
{
    return mName;
}

void Character::setName(const QString &name)
{
    mName = name;
}

QString Character::password() const
{
    return mPassword;
}

void Character::setPassword(const QString &password)
{
    mPassword = password;
}

QString Character::sex() const
{
    return mSex;
}

void Character::setSex(const QString &sex)
{
    mSex = sex;
}

QString Character::birthdayYear() const
{
    return mBirthdayYear;
}

void Character::setBirthdayYear(const QString &birthdayYear)
{
    mBirthdayYear = birthdayYear;
}

QString Character::hometown() const
{
    return mHometown;
}

void Character::setHometown(const QString &hometown)
{
    mHometown = hometown;
}

QString Character::avatar() const
{
    return mAvatar;
}

void Character::setAvatar(const QString &avatar)
{
    mAvatar = avatar;
}

QString Character::constellation() const
{
    return mConstellation;
}

void Character::setConstellation(const QString &constellation)
{
    mConstellation = constellation;
}

void Character::read(const QJsonObject &json)
{
    if (json.contains("name") && json["name"].isString())
        mName = json["name"].toString();

    if (json.contains("password") && json["password"].isString())
        mPassword = json["password"].toString();

    if (json.contains("sex") && json["sex"].isString())
        mSex = json["sex"].toString();

    if (json.contains("birthdayyear") && json["birthdayyear"].isString())
        mBirthdayYear = json["birthdayyear"].toString();

    if (json.contains("hometown") && json["hometown"].isString())
        mHometown = json["hometown"].toString();

    if (json.contains("avarar") && json["avarar"].isString())
        mAvatar = json["avarar"].toString();

    if (json.contains("constellation") && json["constellation"].isString())
        mConstellation = json["constellation"].toString();
}

void Character::write(QJsonObject &json) const
{
    json["name"] = mName;
    json["password"] = mPassword;
    json["sex"] = mSex;
    json["birthdayyear"] = mBirthdayYear;
    json["hometown"] = mHometown;
    json["avatar"] = mAvatar;
    json["constellation"] = mConstellation;
}

void Character::print(int indentation) const
{
    const QString indent(indentation * 2, ' ');
    QTextStream(stdout) << indent << "Name:\t" << mName << "\n";
    QTextStream(stdout) << indent << "Password:\t" << mPassword << "\n";
    QTextStream(stdout) << indent << "Sex:\t" << mSex << "\n";
    QTextStream(stdout) << indent << "Birthday:\t" << mBirthdayYear << "\n";
    QTextStream(stdout) << indent << "Hometown:\t" << mHometown << "\n";
    QTextStream(stdout) << indent << "Avatar:\t" << mAvatar << "\n";
    QTextStream(stdout) << indent << "Constellation:\t" << mConstellation << "\n";
}
