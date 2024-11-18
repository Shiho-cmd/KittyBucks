local chance = getRandomBool(50)

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
        runTimer("gozou", 11.03)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    
    if tag == 'gozou' then
        close();
        os.exit();
    end
end