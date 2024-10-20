local stuff = {'healthBar', 'iconP1', 'iconP2', 'scoreTxt'}

function onCreate()

    makeLuaSprite("br", '', -500, -300)
    makeGraphic("br", 2250, 1600, 'FFFFFF')
    setProperty("br.alpha", 0)
    addLuaSprite("br", false)

    setObjectOrder("boyfriendGroup", 10)
    setObjectOrder("dadGroup", 9)
    setObjectOrder("br", 6)
end

function onEvent(eventName, value1, value2, strumTime)
    
    if eventName == 'cum' then
        if value1 == 'on' then
            doTweenAlpha("uh", "br", 1, 0.5, "linear")
            doTweenColor("hu", "boyfriend", "000000", 0.5, "linear")
            doTweenColor("huh", "dad", "000000", 0.5, "linear")
        elseif value1 == 'off' then
            doTweenAlpha("uh", "br", 0, 0.5, "linear")
            doTweenColor("hu", "boyfriend", "FFFFFF", 0.5, "linear")
            doTweenColor("huh", "dad", "FFFFFF", 0.5, "linear")
        end

        if value2 == 'pode :3' then
            doTweenAlpha("woeuv", 'healthBar', 0, 0.5, "linear")
            doTweenAlpha("woeu", 'iconP1', 0, 0.5, "linear")
            doTweenAlpha("woe", 'iconP2', 0, 0.5, "linear")
            doTweenAlpha("wo", 'scoreTxt', 0, 0.5, "linear")
        elseif value2 == 'num pode mais >:(' then
            doTweenAlpha("woeuv", 'healthBar', 1, 0.5, "linear")
            doTweenAlpha("woeu", 'iconP1', 1, 0.5, "linear")
            doTweenAlpha("woe", 'iconP2', 1, 0.5, "linear")
            doTweenAlpha("wo", 'scoreTxt', 1, 0.5, "linear")
        end
    end
end