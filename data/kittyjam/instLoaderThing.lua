luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

function onCountdownStarted()
    
    playMusic('instrumentals/'..songName..'/Inst-'..difficultyName, 0, false)
end

function onCreate()

    precacheSound('instrumentals/'..songName..'/Inst-'..difficultyName)
    precacheMusic('instrumentals/'..songName..'/Inst-'..difficultyName)
end

function onSongStart()

    playSound('instrumentals/'..songName..'/Inst-'..difficultyName, 0, 'vala')
    playMusic('instrumentals/'..songName..'/Inst-'..difficultyName, 1, false)
end

function onPause()
    
    pauseSound("vala")
end

function onResume()
    
    resumeSound("vala")
end

function onGameOver()
    
    stopSound("vala")
end

function onSoundFinished(tag)
    
    if tag == 'vala' then
        endSong()
    end
end