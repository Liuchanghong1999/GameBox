#include "game.h"

#include <QFile>
#include <QJsonDocument>
#include <QTextStream>

Game::Game()
{
    mPlayer = new Character;
    mProcess = new Progress;
}

bool Game::loadGame()
{
    QFile loadFile(QStringLiteral("save.json"));

    if (!loadFile.open(QIODevice::ReadOnly)) {
        qWarning("Couldn't open save file.");
        return false;
    }

    QByteArray saveData = loadFile.readAll();

    QJsonDocument loadDoc(QJsonDocument::fromJson(saveData));

    read(loadDoc.object());

    return true;
}

bool Game::saveGame() const
{
    QFile saveFile(QStringLiteral("save.json"));

    if (!saveFile.open(QIODevice::WriteOnly)) {
        qWarning("Couldn't open save file.");
        return false;
    }

    QJsonObject gameObject;
    write(gameObject);
    QJsonDocument saveDoc(gameObject);
    saveFile.write(saveDoc.toJson());

    return true;
}

void Game::read(const QJsonObject &json)
{
    if (json.contains("player") && json["player"].isObject()) {
        mPlayer->read(json["player"].toObject());
        //        mPlayer->print();
    }

    if (json.contains("process") && json["process"].isObject()) {
        mProcess->read(json["process"].toObject());
        //        mProcess->print();
    }
}

void Game::write(QJsonObject &json) const
{
    QJsonObject playerObject;
    mPlayer->write(playerObject);
    json["player"] = playerObject;

    QJsonObject processObject;
    mProcess->write(processObject);
    json["process"] = processObject;
}

void Game::print(int indentation) const
{
    const QString indent(indentation * 2, ' ');
    QTextStream(stdout) << indent << "Player\n";
    mPlayer->print(indentation + 1);

    QTextStream(stdout) << indent << "Process\n";
    mProcess->print(indentation + 1);
}

void Game::modify()
{
    mPlayer->setName("yyp");
    mProcess->setLevels(5);
}

Character *Game::player() const
{
    return mPlayer;
}

void Game::setPlayer(Character *player)
{
    mPlayer = player;
}

Progress *Game::process() const
{
    return mProcess;
}

void Game::setProcess(Progress *process)
{
    mProcess = process;
}
