luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

function onCreate()

    setProperty('camGame.bgColor', getColorFromHex('FFFFFF'))

    if songName == 'KittyJam' then
        makeAnimatedLuaSprite("doidas", 'backgrounds/void/birutas_2', 50, 130)
        addAnimationByPrefix("doidas", "idle-loop", "boing", 12, false)
        addLuaSprite("doidas", false)
        scaleObject("doidas", 0.9, 0.9)
    else
        makeLuaSprite("banana", '', 500, 470)
        loadGraphic("banana", "backgrounds/void/PBJT", 202, 200)
        addAnimation("banana", "danceLeft", {0, 1, 2, 3}, 12, false)
        addAnimation("banana", "danceRight", {2, 3, 5, 4}, 12, false)
        addAnimation("banana", "loop", {0, 1, 2, 3, 5, 4, 6, 7}, 12, true)
        scaleObject("banana", 1.5, 1.5)
        addLuaSprite("banana", false)
    end
end

function onGameOver()
    
    --setProperty('camGame.bgColor', getColorFromHex('000000'))
end

function onUpdate(elapsed)
    
    setProperty("timeBar.visible", false)
    setProperty("timeTxt.visible", false)
end

function onBeatHit()
    
    if songName == 'KittyJam' then
        playAnim("doidas", "idle-loop", true)
    end

    if songName ~= 'KittyJam' then
        if curBeat % 2 == 0 then
            playAnim("banana", "danceLeft", true)
        else
            playAnim("banana", "danceRight", true, true)
        end
    end
end

--[[function onCountdownTick(swagCounter)
    
    if swagCounter == 0 and songName == 'SexoDURO' then
        playAnim("banana", "danceLeft", true)
    elseif swagCounter == 1 and songName == 'SexoDURO' then
        playAnim("banana", "danceRight", true, true)
    elseif swagCounter == 2 and songName == 'SexoDURO' then
        playAnim("banana", "danceLeft", true)
    elseif swagCounter == 3 and songName == 'SexoDURO' then
        playAnim("banana", "danceRight", true, true)
    end
end]]