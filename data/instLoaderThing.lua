luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

local chance = getRandomBool(50)

function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local parsed = parseJson('data/baldiSave.json')

function onCountdownStarted()
    
    playMusic('instrumentals/'..songName..'/Inst-'..difficultyName, 0, false)
end

function onCreate()

    precacheSound('instrumentals/'..songName..'/Inst-'..difficultyName)
    precacheMusic('instrumentals/'..songName..'/Inst-'..difficultyName)
end

function onSongStart()

    if not chance and not parsed.podeGozar then
        playSound('instrumentals/'..songName..'/Inst-'..difficultyName, 0, 'vala')
        playMusic('instrumentals/'..songName..'/Inst-'..difficultyName, 1, false)
    elseif chance and parsed.podeGozar then
        saveFile("mods/KittyBucks/data/baldiSave.json", "{\n\"podeGozar\": false\n}", true)
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