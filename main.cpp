#include <QApplication>
#include <FelgoApplication>

#include <QTextStream>
#include <QDebug>

#include <QQmlApplicationEngine>
#include <QQmlComponent>

#include "game.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    qmlRegisterType<Game>("Mario", 1, 0, "Game");
    qmlRegisterType<Character>("Mario", 1, 0, "Character");
    qmlRegisterType<Progress>("Mario", 1, 0, "Progress");
    QQmlApplicationEngine engine;
    //    QQmlEngine engine;
    QQmlComponent component(&engine, QUrl("qrc:Main.qml"));
    Game *mar = qobject_cast<Game *>(component.create());
    Character *player = qobject_cast<Character *>(component.create());
    Progress *process = qobject_cast<Progress *>(component.create());

    Game game;

    game.loadGame();
    if(!game.isExist)
    {
            game.modify();
    }


        game.saveGame();

    FelgoApplication felgo;

    // QQmlApplicationEngine is the preferred way to start qml projects since Qt 5.2
    // if you have older projects using Qt App wizards from previous QtCreator versions than 3.1, please change them to QQmlApplicationEngine
    //    QQmlApplicationEngine engine;
    felgo.initialize(&engine);

    // Set an optional license key from project file
    // This does not work if using Felgo Live, only for Felgo Cloud Builds and local builds
    felgo.setLicenseKey(PRODUCT_LICENSE_KEY);

    // use this during development
    // for PUBLISHING, use the entry point below
    felgo.setMainQmlFileName(QStringLiteral("qml/Main.qml"));

    // use this instead of the above call to avoid deployment of the qml files and compile them into the binary with qt's resource system qrc
    // this is the preferred deployment option for publishing games to the app stores, because then your qml files and js files are protected
    // to avoid deployment of your qml files and images, also comment the DEPLOYMENTFOLDERS command in the .pro file
    // also see the .pro file for more details
    // felgo.setMainQmlFileName(QStringLiteral("qrc:/qml/Main.qml"));

    engine.load(QUrl(felgo.mainQmlFileName()));

    return app.exec();
}
















//#include <QApplication>
//#include <FelgoApplication>

//#include <QTextStream>
//#include <QDebug>

//#include <QQmlApplicationEngine>
//#include <QQmlComponent>

//int main(int argc, char *argv[])
//{
//    QApplication app(argc, argv);

//    QQmlApplicationEngine engine;

//    FelgoApplication felgo;

//    // QQmlApplicationEngine is the preferred way to start qml projects since Qt 5.2
//    // if you have older projects using Qt App wizards from previous QtCreator versions than 3.1, please change them to QQmlApplicationEngine
//    //    QQmlApplicationEngine engine;
//    felgo.initialize(&engine);

//    // Set an optional license key from project file
//    // This does not work if using Felgo Live, only for Felgo Cloud Builds and local builds
//    felgo.setLicenseKey(PRODUCT_LICENSE_KEY);

//    // use this during development
//    // for PUBLISHING, use the entry point below
//    felgo.setMainQmlFileName(QStringLiteral("qml/Main.qml"));

//    // use this instead of the above call to avoid deployment of the qml files and compile them into the binary with qt's resource system qrc
//    // this is the preferred deployment option for publishing games to the app stores, because then your qml files and js files are protected
//    // to avoid deployment of your qml files and images, also comment the DEPLOYMENTFOLDERS command in the .pro file
//    // also see the .pro file for more details
//    // felgo.setMainQmlFileName(QStringLiteral("qrc:/qml/Main.qml"));

//    engine.load(QUrl(felgo.mainQmlFileName()));

//    return app.exec();
//}
