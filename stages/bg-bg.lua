luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

function onCreate()

    precacheImage("backgrounds/void/birutas_2")

    setProperty('camGame.bgColor', getColorFromHex('FFFFFF'))
    makeAnimatedLuaSprite("doidas", 'backgrounds/void/birutas_2', 50, 130)
    addAnimationByPrefix("doidas", "idle-loop", "boing", 12, false)
    addLuaSprite("doidas", false)
    scaleObject("doidas", 0.9, 0.9)
end

function onSongStart()
    
    setProperty("timeBar.visible", false)
    setProperty("timeTxt.visible", false)
end

function onBeatHit()

    playAnim("doidas", "idle-loop", true)
end