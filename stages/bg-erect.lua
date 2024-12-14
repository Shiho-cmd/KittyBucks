luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

local path = 'backgrounds/erect/'

function onCreate()

    precacheImage(path.."street", false)
    precacheImage(path.."buildings", false)
    precacheImage(path.."guys", false)

    setProperty('camGame.bgColor', getColorFromHex('FFFFFF'))

    makeLuaSprite("stre", path..'street', -630, -300)

    makeLuaSprite("bui", path..'buildings', -630, -300)

    makeAnimatedLuaSprite("the", path..'guys', -650, -300)
    addAnimationByPrefix("the", "idle", "idle", 12, false)

    if not lowQuality then

        precacheImage(path.."clouds", false)
        precacheImage(path.."city", false)

        makeLuaSprite("clo", path..'clouds', -630, -300)

        makeLuaSprite("ty", path..'city', -630, -300)
    end

    addLuaSprite("clo", false)
    addLuaSprite("ty", false)
    addLuaSprite("stre", false)
    addLuaSprite("bui", false)
    addLuaSprite("the", false)
end

function onSongStart()
    
    setProperty("timeBar.visible", false)
    setProperty("timeTxt.visible", false)
end

function onBeatHit()
    
    playAnim("the", "idle", true)
end