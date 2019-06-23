#ifndef PROGRESS_H
#define PROGRESS_H

#include <QObject>
#include <QJsonObject>
#include <QString>

class Progress : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int levels READ levels WRITE setLevels)
    Q_PROPERTY(int lives READ lives WRITE setLives)
    Q_PROPERTY(int coins READ coins WRITE setCoins)
public:
    Progress();

    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;

    void print(int indentation = 0) const;

    int levels() const;
    void setLevels(int levels);

    int lives() const;
    void setLives(int lives);

    int coins() const;
    void setCoins(int coins);
private:
    int mLevels;
    int mLives;
    int mCoins;
};

#endif // PROGRESS_H
