luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

function onCreate()

    precacheImage("backgrounds/erect/clouds", false)
    precacheImage("backgrounds/erect/city", false)
    precacheImage("backgrounds/erect/street", false)
    precacheImage("backgrounds/erect/buildings", false)
    precacheImage("backgrounds/erect/guys", false)

    setProperty('camGame.bgColor', getColorFromHex('FFFFFF'))

    makeLuaSprite("clo", 'backgrounds/erect/clouds', -630, -300)
    --setScrollFactor("clo", 0.5, 0.5)
    addLuaSprite("clo", false)

    makeLuaSprite("ty", 'backgrounds/erect/city', -630, -300)
    addLuaSprite("ty", false)

    makeLuaSprite("stre", 'backgrounds/erect/street', -630, -300)
    addLuaSprite("stre", false)

    makeLuaSprite("bui", 'backgrounds/erect/buildings', -630, -300)
    addLuaSprite("bui", false)

    makeAnimatedLuaSprite("the", 'backgrounds/erect/guys', -650, -300)
    addAnimationByPrefix("the", "idle", "idle", 12, false)
    addLuaSprite("the", false)
end

function onUpdate(elapsed)
    
    setProperty("timeBar.visible", false)
    setProperty("timeTxt.visible", false)
end

function onBeatHit()
    
    playAnim("the", "idle", true)
end