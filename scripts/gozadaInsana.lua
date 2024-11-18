local chance = getRandomBool(1)

function onSongStart()

    if chance and songName ~= 'KittyJam' then
        setPropertyFromClass("openfl.Lib", "application.window.title", 'RECEBENDO A PORRA ARITMETICA')
        startVideo("aahhh")

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
    
    if tag == 'gozou' and buildTarget ~= 'android' then
        close();
        os.exit();
    elseif tag == 'gozou' and buildTarget == 'android' then
        endSong()
    end
end