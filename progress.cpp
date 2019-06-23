#include "progress.h"

#include <QTextStream>

Progress::Progress()
{

}

int Progress::levels() const
{
    return mLevels;
}

void Progress::setLevels(int levels)
{
    mLevels = levels;
}

int Progress::lives() const
{
    return mLives;
}

void Progress::setLives(int lives)
{
    mLives = lives;
}

int Progress::coins() const
{
    return mCoins;
}

void Progress::setCoins(int coins)
{
    mCoins = coins;
}

void Progress::read(const QJsonObject &json)
{
    if (json.contains("levels") && json["levels"].isDouble())
        mLevels = json["levels"].toInt();

    if (json.contains("lives") && json["lives"].isDouble())
        mLives = json["lives"].toInt();

    if (json.contains("coins") && json["coins"].isDouble())
        mCoins = json["coins"].toInt();
}

void Progress::write(QJsonObject &json) const
{
    json["levels"] = mLevels;
    json["lives"] = mLives;
    json["coins"] = mCoins;
}

void Progress::print(int indentation) const
{
    const QString indent(indentation * 2, ' ');
    QTextStream(stdout) << indent << "Levels:\t" << mLevels << "\n";
    QTextStream(stdout) << indent << "Lives:\t" << mLives << "\n";
    QTextStream(stdout) << indent << "Coins:\t" << mCoins << "\n";
}
