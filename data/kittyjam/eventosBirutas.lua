function onCreate()
    
    makeLuaSprite('escuro', '', 0, 0)
    makeGraphic('escuro', screenWidth, screenHeight, '000000')
    setObjectCamera('escuro', 'other')
    addLuaSprite('escuro', false)
    
    makeLuaSprite('celula', 'galaxy_pocket', 330, 420)
    addLuaSprite('celula', false)
    scaleObject('celula', 0.2, 0.2)
    setProperty('celula.alpha', 0)
    
    setProperty('camHUD.alpha', 0)

    if not lowQuality then
        makeAnimatedLuaSprite('gif', 'speedlol')
        addAnimationByPrefix('gif', 'lesgo', 'yo', 12, true)
        screenCenter('gif')
        setObjectCamera('gif', 'hud')
        addLuaSprite('gif', true)
        setProperty('gif.alpha', 0.01)
        precacheImage("speedlol")

        makeAnimatedLuaSprite('explo', 'kaboom', 0, 0)
        addAnimationByPrefix('explo', 'bah', 'boom', 12, false)
        setObjectCamera('explo', 'other')
        addLuaSprite('explo', false)
        scaleObject('explo', 2.2, 2.2)
        setProperty('explo.visible', false)
        precacheImage("kaboom")
    end
end

function onSongStart()
    
    doTweenAlpha('vai', 'escuro', 0, 10, 'linear')
    triggerEvent('Camera Follow Pos', getProperty('dad.x') + 1000, 500)
    setProperty('cameraSpeed', 99)
end

function onStepHit()
    
    if curStep == 640 then
        doTweenAlpha('f', 'gif', 1, 20, 'linear')
        triggerEvent('Camera Follow Pos', getProperty('dad.x') + 1000, 500)
    elseif curStep == 759 then
        doTweenAlpha('f', 'gif', 0, 0.5, 'linear')
        triggerEvent('Camera Follow Pos', '', '')
    elseif curStep == 1040 then
        doTweenAlpha('fhdh', 'celula', 1, 0.7, 'linear')
        doTweenY('fknc', 'celula', 490, 0.7, 'quartOut')
    elseif curStep == 1153 then
        setProperty('explo.visible', true)
        objectPlayAnimation('explo', 'bah')
        setProperty("camGame.alpha", 0)
    end
end