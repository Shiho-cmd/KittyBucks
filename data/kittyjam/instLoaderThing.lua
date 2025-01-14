luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

local chance = getRandomBool(1)

function onCountdownStarted()
    
    playMusic('instrumentals/'..songName..'/Inst-'..difficultyName, 0, false)
end

function onCreate()

    precacheSound('instrumentals/'..songName..'/Inst-'..difficultyName)
    precacheMusic('instrumentals/'..songName..'/Inst-'..difficultyName)
end

function onSongStart()

    if not chance then
        playSound('instrumentals/'..songName..'/Inst-'..difficultyName, 0, 'vala')
        playMusic('instrumentals/'..songName..'/Inst-'..difficultyName, 1, false)
    else
        setPropertyFromClass("openfl.Lib", "application.window.title", 'RECEBENDO A PORRA ARITMETICA')
        startVideo("aahhh", false)

        unlockAchievement("fertilizado")
        openCustomSubstate("qualquerMerda", true)
    end
end

function onCustomSubstateCreate(name)
    
    if name == 'qualquerMerda' then
        runTimer("gozou", 11)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    
    if tag == 'gozou' then
        close();
        os.exit();
    end
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