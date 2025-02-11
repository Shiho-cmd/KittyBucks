local chance = getRandomBool(50)

function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local parsed = parseJson('data/baldiSave.json')

function onSongStart()

    if chance and songName ~= 'KittyJam' and parsed.podeGozar then
        setPropertyFromClass("openfl.Lib", "application.window.title", 'RECEBENDO A PORRA ARITMETICA')
        startVideo("aahhh", false)

        unlockAchievement("fertilizado")
        openCustomSubstate("qualquerMerda", true)
    end
end

function onCustomSubstateCreate(name)
    
    if name == 'qualquerMerda' then
        runTimer("gozou", 11)
        saveFile("mods/KittyBucks/data/baldiSave.json", "{\n\"podeGozar\": false\n}", true)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    
    if tag == 'gozou' then
        close();
        os.exit();
    end
end