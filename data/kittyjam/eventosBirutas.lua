function onCreate()

    makeLuaSprite('celula', 'galaxy_pocket', 330, 420)
    addLuaSprite('celula', false)
    scaleObject('celula', 0.2, 0.2)
    setProperty('celula.alpha', 0)

    makeLuaSprite('escuro', '', 0, 0)
    makeGraphic('escuro', screenWidth, screenHeight, '000000')
    setObjectCamera('escuro', 'other')
    addLuaSprite('escuro', false)
    
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
    
    if difficultyName == 'buck' then
        doTweenAlpha('vai', 'escuro', 0, 10, 'linear')
        triggerEvent('Camera Follow Pos', 660, 500)
        setProperty('cameraSpeed', 99)
    else
        doTweenAlpha('vai', 'escuro', 0, 10, 'linear')
        triggerEvent('Camera Follow Pos', 660, -400)
        setProperty('cameraSpeed', 99)
        setProperty("defaultCamZoom", 0.55)
    end
end

function onUpdate(elapsed)

    if difficultyName == 'buck' then
        if curStep == 640 then
            doTweenAlpha('f', 'gif', 1, 20, 'linear')
            triggerEvent('Camera Follow Pos', 660, 500)
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
end

function onStepHit()
    
    if difficultyName == 'erect' then
        if curStep == 1818 then
            doTweenAlpha('fhdh', 'celula', 1, 0.7, 'linear')
            doTweenY('fknc', 'celula', 490, 0.7, 'quartOut')
        elseif curStep == 1917 then
            setProperty('explo.visible', true)
            objectPlayAnimation('explo', 'bah')
            setProperty("camGame.alpha", 0)
        end      
    end
end