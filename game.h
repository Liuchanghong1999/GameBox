#ifndef GAME_H
#define GAME_H

#include <QObject>
#include <QJsonObject>

#include "character.h"
#include "progress.h"

class Game : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Character *player READ player WRITE setPlayer)
    Q_PROPERTY(Progress *process READ process WRITE setProcess)
public:
    Game();

    Q_INVOKABLE bool loadGame();
    Q_INVOKABLE bool saveGame() const;

    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;

    void print(int indentation = 0) const;

    void modify();

    Character *player() const;
    void setPlayer(Character *player);

    Progress *process() const;
    void setProcess(Progress *process);

    bool isExist = true;
private:
    Character *mPlayer;
    Progress *mProcess;
};

#endif // GAME_H
