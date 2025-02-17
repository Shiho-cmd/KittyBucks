luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

function onCreate()

    makeLuaSprite("br", '', -500, -300)
    makeGraphic("br", 2250, 1600, 'FFFFFF')
    setProperty("br.alpha", 0)
    addLuaSprite("br", false)

    makeLuaSprite('cima', '', -100, -250)
    makeGraphic('cima', screenWidth + 200, 200, '000000')
    addLuaSprite('cima', false)
    setObjectCamera('cima', 'hud')
    setScrollFactor('cima', 0, 0)

    makeLuaSprite('baixo', '', -100, 770)
    makeGraphic('baixo', screenWidth + 200, 500, '000000')
    addLuaSprite('baixo', false)
    setScrollFactor('baixo', 0, 0)
    setObjectCamera('baixo', 'hud')
end

function onEvent(eventName, value1, value2, strumTime)

    ass = stringSplit(value1, ", ")
    
    if eventName == 'blackWhite' then
        if value1 == 'on' then
            doTweenAlpha("uh", "br", 1, 0.5, "linear")
            doTweenColor("hu", "boyfriend", "000000", 0.5, "linear")
            doTweenColor("huh", "dad", "000000", 0.5, "linear")
            
            doTweenAlpha("woeuv", 'healthBar', 0, 0.5, "linear")
            doTweenAlpha("woeu", 'iconP1', 0, 0.5, "linear")
            doTweenAlpha("woe", 'iconP2', 0, 0.5, "linear")
            doTweenAlpha("wo", 'scoreTxt', 0, 0.5, "linear")
            doTweenY('1', 'cima', -120, 0.5, 'quartOut')
            doTweenY('2', 'baixo', 640, 0.5, 'quartOut')
        elseif value1 == 'off' then
            doTweenAlpha("uh", "br", 0, 0.5, "linear")
            doTweenColor("hu", "boyfriend", "FFFFFF", 0.5, "linear")
            doTweenColor("huh", "dad", "FFFFFF", 0.5, "linear")
            doTweenY('1', 'cima', -250, 0.5, 'quartOut')
            doTweenY('2', 'baixo', 770, 0.5, 'quartOut')

            doTweenAlpha("woeuv", 'healthBar', 1, 0.5, "linear")
            doTweenAlpha("woeu", 'iconP1', 1, 0.5, "linear")
            doTweenAlpha("woe", 'iconP2', 1, 0.5, "linear")
            doTweenAlpha("wo", 'scoreTxt', 1, 0.5, "linear")
        end

        if value2 == 'bf' then
            doTweenAngle('among', 'cima', 3, 0.5, 'quartOut')
            doTweenAngle(' us', 'baixo', 3, 0.5, 'quartOut')
        elseif value2 == 'dad' then
            doTweenAngle('among', 'cima', -3, 0.5, 'quartOut')
            doTweenAngle('us', 'baixo', -3, 0.5, 'quartOut')
        elseif value2 == 'fudido morra agora' then
            doTweenAngle('among', 'cima', 1, 0.5, 'quartOut')
            doTweenAngle('us', 'baixo', 1, 0.5, 'quartOut')
        end
    end
end