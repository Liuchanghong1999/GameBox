import Felgo 3.0
import QtQuick 2.0
import QtMultimedia 5.0

Item {
    id: audioManager

    Component.onCompleted: handleMusic()

    BackgroundMusic {
        id: menuMusic
        autoPlay: false
        source: "../../assets/audio/music/menuMusic.mp3"
    }

    SoundEffect {
        id: playerJump
        source: "../../assets/audio/sounds/phaseJump1.wav"
    }

    SoundEffect {
        id: playerHit
        source: "../../assets/audio/sounds/whizz.wav"
    }

    SoundEffect {
        id: playerDie
        source: "../../assets/audio/sounds/lose.wav"
    }

    SoundEffect {
        id: playerInvincible
        source: "../../assets/audio/sounds/threeTone2.wav"
        loops: SoundEffect.Infinite
    }

    SoundEffect {
        id: collectCoin
        source: "../../assets/audio/sounds/coin_3.wav"
    }

    SoundEffect {
        id: collectMushroom
        source: "../../assets/audio/sounds/zapThreeToneUp.wav"
    }

    SoundEffect {
        id: finish
        source: "../../assets/audio/sounds/coin-04.wav"
    }

    SoundEffect {
        id: opponentWalkerDie
        source: "../../assets/audio/sounds/bird-chirp.wav"
    }

    SoundEffect {
        id: opponentJumperDie
        source: "../../assets/audio/sounds/twitch.wav"
    }

    SoundEffect {
        id: start
        source: "../../assets/audio/sounds/yahoo.wav"
    }

    SoundEffect {
        id: click
        source: "../../assets/audio/sounds/click1.wav"
    }

    SoundEffect {
        id: dragEntity
        source: "../../assets/audio/sounds/slide-network.wav"
    }

    SoundEffect {
        id: createOrDropEntity
        source: "../../assets/audio/sounds/tap_professional.wav"
    }

    SoundEffect {
        id: removeEntity
        source: "../../assets/audio/sounds/tap_mellow.wav"
    }

    // this function sets the music, depending on the current scene and the gameScene's state
    function handleMusic() {
            audioManager.startMusic(menuMusic)

    }

    // starts the given music
    function startMusic(music) {
        // if music is already playing, we don't have to do anything
        if(music.playing)
            return

        // otherwise stop all music tracks
        menuMusic.stop()

        music.play()
    }

    // play the sound effect with the given name
    function playSound(sound) {
        if(sound === "playerJump")
            playerJump.play()
        else if(sound === "playerHit")
            playerHit.play()
        else if(sound === "playerDie")
            playerDie.play()
        else if(sound === "playerInvincible")
            playerInvincible.play()
        else if(sound === "collectCoin")
            collectCoin.play()
        else if(sound === "collectMushroom")
            collectMushroom.play()
        else if(sound === "opponentWalkerDie")
            opponentWalkerDie.play()
        else if(sound === "start")
            start.play()
        else if(sound === "click")
            click.play()
        else if(sound==="dragEntity")
            dragEntity.play()
        else
            console.debug("unknown sound name:", sound)
    }

    function stopSound(sound) {
        if(sound === "playerInvincible")
            playerInvincible.stop()
        else
            console.debug("unknown sound name:", sound)
    }
}
