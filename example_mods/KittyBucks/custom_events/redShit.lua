luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

function onCreate()
    
    makeLuaSprite("overshit", nil, 0, 0)
    makeGraphic("overshit", screenWidth, screenHeight, 'FF0000')
    setObjectCamera("overshit", 'other')
    setProperty("overshit.alpha", 0)
    setBlendMode('overshit', 'darken')
    addLuaSprite("overshit", true)
end

function onUpdate(elapsed)
    
    setProperty("camGame.color", getColorFromHex("FF0000"))
end

function onEvent(eventName, value1, value2, strumTime)

    spliters = stringSplit(value2, ", ")
    
    if eventName == 'redShit' then
        if value1 == 'on' and spliters[1] == 'n' then
            setProperty("overshit.alpha", 1)
        elseif value1 == 'off' and spliters[1] == 'n' then
            setProperty("overshit.alpha", 0)
        elseif value1 == 'on' and spliters[1] == 's' then
            doTweenAlpha("cacetadas", "overshit", 1, spliters[2], "linear")
        elseif value1 == 'off' and spliters[1] == 's' then
            doTweenAlpha("cacetadas", "overshit", 0, spliters[2], "linear")
        end
    end
end