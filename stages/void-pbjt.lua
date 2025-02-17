luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

local path = 'backgrounds/void/'

function onCreate()

    precacheImage(path.."PBJT")

    setProperty('camGame.bgColor', getColorFromHex('FFFFFF'))
    makeLuaSprite("banana", '', 470, 450)
    loadGraphic("banana", path.."PBJT", 202, 200)
    addAnimation("banana", "loop", {0, 1, 2, 3, 5, 4, 6, 7}, 12, true)
    addAnimation("banana", "danceLeft", {0, 1, 2, 3}, 12, false)
    addAnimation("banana", "danceRight", {2, 3, 5, 4}, 12, false)
    scaleObject("banana", 1.5, 1.5)
    addLuaSprite("banana", false)
end

function onSongStart()
    
    setProperty("timeBar.visible", false)
    setProperty("timeTxt.visible", false)
end

function onBeatHit()
    
    if curBeat % 2 == 0 then
        playAnim("banana", "danceLeft", true)
    else
        playAnim("banana", "danceRight", true, true)
    end
end