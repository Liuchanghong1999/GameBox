# allows to add DEPLOYMENTFOLDERS and links to the Felgo library and QtCreator auto-completion
CONFIG += felgo

qmlFolder.source = qml
DEPLOYMENTFOLDERS += qmlFolder # comment for publishing

assetsFolder.source = assets
DEPLOYMENTFOLDERS += assetsFolder

# Add more folders to ship with the application here

RESOURCES += #    resources.qrc # uncomment for publishing

# NOTE: for PUBLISHING, perform the following steps:
# 1. comment the DEPLOYMENTFOLDERS += qmlFolder line above, to avoid shipping your qml files with the application (instead they get compiled to the app binary)
# 2. uncomment the resources.qrc file inclusion and add any qml subfolders to the .qrc file; this compiles your qml files and js files to the app binary and protects your source code
# 3. change the setMainQmlFile() call in main.cpp to the one starting with "qrc:/" - this loads the qml files from the resources
# for more details see the "Deployment Guides" in the Felgo Documentation

# during development, use the qmlFolder deployment because you then get shorter compilation times (the qml files do not need to be compiled to the binary but are just copied)
# also, for quickest deployment on Desktop disable the "Shadow Build" option in Projects/Builds - you can then select "Run Without Deployment" from the Build menu in Qt Creator if you only changed QML files; this speeds up application start, because your app is not copied & re-compiled but just re-interpreted


# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp

android {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    OTHER_FILES += android/AndroidManifest.xml
}

ios {
    QMAKE_INFO_PLIST = ios/Project-Info.plist
    OTHER_FILES += $$QMAKE_INFO_PLIST
}

DISTFILES += \
    qml/entities/BottomGround.qml \
    qml/entities/Thorn.qml \
    qml/entities/Springboard.qml \
    qml/entities/BigTree.qml \
    qml/entities/SmallTree.qml \
    qml/entities/Barrier.qml \
    qml/entities/OriginalStation.qml \
    qml/entities/FinalStation.qml \
    qml/entities/JumpingBed.qml \
    qml/entities/Stars.qml \
    qml/entities/Opponent.qml \
    qml/entities/OpponentWalker.qml \
    qml/entities/Opponentjumper.qml \
    qml/entities/Heart.qml \
    qml/entities/HorizontalFloatSpringboard.qml \
    qml/entities/VerticalFloatingSpringboard.qml \
    qml/entities/Surprise.qml \
    qml/entities/AttackPlant.qml \
    qml/entities/Wall.qml \
    qml/scenes/HelpScene.qml \
    qml/scenes/SceneBase.qml \
    qml/scenes/MenuScene.qml \
    qml/music/PlatformerImageButton.qml \
    qml/scenes/SelectLevelScene.qml \
    qml/music/MenuButton.qml \
    qml/levels/Level_02.qml \
    qml/scenes/GameOverScene.qml \
    qml/entities/Coin.qml \
    qml/common/Level_03.qml

