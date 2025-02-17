luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

function onCreate()
    
    makeLuaSprite('barrama', '', 0, -120)
    makeGraphic('barrama', screenWidth, 100, '000000')
    addLuaSprite('barrama', false)
    setObjectCamera('barrama', 'hud')
    setScrollFactor('barrama', 0, 0)

    makeLuaSprite('barraixo', '', 0, 740)
    makeGraphic('barraixo', screenWidth, 100, '000000')
    addLuaSprite('barraixo', false)
    setScrollFactor('barraixo', 0, 0)
    setObjectCamera('barraixo', 'hud')
end

function onEvent(eventName, value1, value2, strumTime)

    split = stringSplit(value2, ", ")
    
    if eventName == 'bars' then
        if value1 == 'off' then
            doTweenY('1', 'barrama', -120, split[1], split[2])
            doTweenY('2', 'barraixo', 740, split[1], split[2])
        elseif value1 == 'on' then
            doTweenY('1', 'barrama', -30, split[1], split[2])
            doTweenY('2', 'barraixo', 650, split[1], split[2])
        end
    end
end