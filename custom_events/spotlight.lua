luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local parsed = parseJson('stages/'..curStage..'.json')

function onCreate()
    
    makeLuaSprite("luzbf", 'spotlight')
    setProperty("luzbf.alpha", 0)
    scaleObject("luzbf", 0.1, 1, false)
    addLuaSprite("luzbf", true)

    makeLuaSprite("luzdad", 'spotlight')
    setProperty("luzdad.alpha", 0)
    scaleObject("luzdad", 0.1, 1, false)
    addLuaSprite("luzdad", true)

    makeLuaSprite("bruh", '', -500, -300)
    makeGraphic("bruh", 2250, 1600, '000000')
    setProperty("bruh.alpha", 0)
    addLuaSprite("bruh", false)

    setProperty("luzbf.x", parsed.spotlightBF[1])
    setProperty("luzbf.y", parsed.spotlightBF[2])
    setProperty("luzdad.x", parsed.spotlightDAD[1])
    setProperty("luzdad.y", parsed.spotlightDAD[2])
end

function onEvent(eventName, value1, value2, strumTime)

    local ligo = false
    
    if eventName == 'fuck' then
        if value1 == 'bf' then
            doTweenAlpha("vish", "bruh", 0.5, 0.2, "linear")
            doTweenAlpha("alphabf", "luzbf", 0.3, 0.2, "linear")
            doTweenAlpha("alphadad", "luzdad", 0, 0.2, "linear")
            doTweenX("1", "luzbf.scale", 1, 0.2, "linear")
            doTweenX("2", "luzdad.scale", 0.1, 0.2, "linear")
            doTweenColor("cumInThCara", "boyfriend", "FFFFFF", 0.2, "linear")
            doTweenColor("cumInThCaraOSecond", "dad", "808080", 0.2, "linear")

            noteTweenAlpha("morra1", 0, 0.5, 0.2, 'linear')
            noteTweenAlpha("morra2", 1, 0.5, 0.2, 'linear')
            noteTweenAlpha("morra3", 2, 0.5, 0.2, 'linear')
            noteTweenAlpha("morra4", 3, 0.5, 0.2, 'linear')
            noteTweenAlpha("morra5", 4, 1, 0.2, 'linear')
            noteTweenAlpha("morra6", 5, 1, 0.2, 'linear')
            noteTweenAlpha("morra7", 6, 1, 0.2, 'linear')
            noteTweenAlpha("morra8", 7, 1, 0.2, 'linear')
        elseif value1 == 'dad' then
            doTweenAlpha("vish", "bruh", 0.5, 0.2, "linear")
            doTweenAlpha("alphadad", "luzdad", 0.3, 0.2, "linear")
            doTweenAlpha("alphabf", "luzbf", 0, 0.2, "linear")
            doTweenX("1", "luzdad.scale", 1, 0.2, "linear")
            doTweenX("2", "luzbf.scale", 0.1, 0.2, "linear")
            doTweenColor("cumInThCara", "dad", "FFFFFF", 0.2, "linear")
            doTweenColor("cumInThCaraOSecond", "boyfriend", "808080", 0.2, "linear")

            noteTweenAlpha("morra1", 0, 1, 0.2, 'linear')
            noteTweenAlpha("morra2", 1, 1, 0.2, 'linear')
            noteTweenAlpha("morra3", 2, 1, 0.2, 'linear')
            noteTweenAlpha("morra4", 3, 1, 0.2, 'linear')
            noteTweenAlpha("morra5", 4, 0.5, 0.2, 'linear')
            noteTweenAlpha("morra6", 5, 0.5, 0.2, 'linear')
            noteTweenAlpha("morra7", 6, 0.5, 0.2, 'linear')
            noteTweenAlpha("morra8", 7, 0.5, 0.2, 'linear')
        elseif value1 == 'MORRA' then
            doTweenAlpha("eita", "luzbf", 0, 0.2, "linear")
            doTweenAlpha("eita2", "luzdad", 0, 0.2, "linear")
            doTweenAlpha("vish", "bruh", 0, 0.2, "linear")
            doTweenX("1", "luzdad.scale", 0.1, 0.2, "linear")
            doTweenX("2", "luzbf.scale", 0.1, 0.2, "linear")
            doTweenColor("cumInThCara", "boyfriend", "FFFFFF", 0.2, "linear")
            doTweenColor("cumInThCaraOSecond", "dad", "FFFFFF", 0.2, "linear")

            noteTweenAlpha("morra1", 0, 1, 0.2, 'linear')
            noteTweenAlpha("morra2", 1, 1, 0.2, 'linear')
            noteTweenAlpha("morra3", 2, 1, 0.2, 'linear')
            noteTweenAlpha("morra4", 3, 1, 0.2, 'linear')
            noteTweenAlpha("morra5", 4, 1, 0.2, 'linear')
            noteTweenAlpha("morra6", 5, 1, 0.2, 'linear')
            noteTweenAlpha("morra7", 6, 1, 0.2, 'linear')
            noteTweenAlpha("morra8", 7, 1, 0.2, 'linear')
        end
    end
end