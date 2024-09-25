local barras = false

function onCreate()
    
    makeLuaSprite('barrama','',0,-120)
    makeGraphic('barrama',1281,100,'000000')
    addLuaSprite('barrama',false)
    setObjectCamera('barrama','hud')
    setScrollFactor('barrama',0,0)

    makeLuaSprite('barraixo','',0,740)
    makeGraphic('barraixo',12801,100,'000000')
    addLuaSprite('barraixo',false)
    setScrollFactor('barraixo',0,0)
    setObjectCamera('barraixo','hud')
    
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

function onUpdate(elapsed)
    
    if barras == false then
        doTweenY('1', 'barrama', -120, 0.5, 'quartOut')
        doTweenY('2', 'barraixo', 740, 0.5, 'quartOut')
    else
        doTweenY('1', 'barrama', -30, 0.5, 'quartOut')
        doTweenY('2', 'barraixo', 650, 0.5, 'quartOut')
    end
end

function onStepHit()
    
    if curStep == 127 then
        doTweenAlpha('oi', 'camHUD', 1, 1, 'linear')
        triggerEvent('Camera Follow Pos', '', '')
    elseif curStep == 384 then
        barras = true
    elseif curStep == 512 then
        barras = false
        setProperty('gif.alpha', 0)
    elseif curStep == 640 then
        doTweenAlpha('f', 'gif', 1, 20, 'linear')
        triggerEvent('Camera Follow Pos', getProperty('dad.x') + 1000, 500)
        doTweenAlpha('a', 'healthBar', 0, 0.5, 'linear')
        doTweenAlpha('aa', 'iconP1', 0, 0.5, 'linear')
        doTweenAlpha('aaa', 'iconP2', 0, 0.5, 'linear')
        doTweenAlpha('aaaa', 'scoreTxt', 0, 0.5, 'linear')
        setProperty('botplayTxt.x', -999)
		noteTweenAlpha("morra1", 0, 0, 0.5, "linear")
		noteTweenAlpha("morra2", 1, 0, 0.5, "linear")
		noteTweenAlpha("morra3", 2, 0, 0.5, "linear")
		noteTweenAlpha("morra4", 3, 0, 0.5, "linear")
		noteTweenAlpha("morra5", 4, 0, 0.5, "linear")
		noteTweenAlpha("morra6", 5, 0, 0.5, "linear")
		noteTweenAlpha("morra7", 6, 0, 0.5, "linear")
		noteTweenAlpha("morra8", 7, 0, 0.5, "linear")
    elseif curStep == 759 then
        doTweenAlpha('f', 'gif', 0, 0.5, 'linear')
        triggerEvent('Camera Follow Pos', '', '')
        barras = true
        doTweenAlpha('a', 'healthBar', 1, 0.5, 'linear')
        doTweenAlpha('aa', 'iconP1', 1, 0.5, 'linear')
        doTweenAlpha('aaa', 'iconP2', 1, 0.5, 'linear')
        doTweenAlpha('aaaa', 'scoreTxt', 1, 0.5, 'linear')
        screenCenter('botplayTxt', 'x')
		noteTweenAlpha("morra1", 0, 1, 0.5, "linear")
		noteTweenAlpha("morra2", 1, 1, 0.5, "linear")
		noteTweenAlpha("morra3", 2, 1, 0.5, "linear")
		noteTweenAlpha("morra4", 3, 1, 0.5, "linear")
		noteTweenAlpha("morra5", 4, 1, 0.5, "linear")
		noteTweenAlpha("morra6", 5, 1, 0.5, "linear")
		noteTweenAlpha("morra7", 6, 1, 0.5, "linear")
		noteTweenAlpha("morra8", 7, 1, 0.5, "linear")
    elseif curStep == 1024 then
        barras = false
        doTweenAlpha('a', 'healthBar', 0, 0.5, 'linear')
        doTweenAlpha('aa', 'iconP1', 0, 0.5, 'linear')
        doTweenAlpha('aaa', 'iconP2', 0, 0.5, 'linear')
        doTweenAlpha('aaaa', 'scoreTxt', 0, 0.5, 'linear')
        setProperty('botplayTxt.x', -999)
		noteTweenAlpha("morra1", 0, 0, 0.5, "linear")
		noteTweenAlpha("morra2", 1, 0, 0.5, "linear")
		noteTweenAlpha("morra3", 2, 0, 0.5, "linear")
		noteTweenAlpha("morra4", 3, 0, 0.5, "linear")
		noteTweenAlpha("morra5", 4, 0, 0.5, "linear")
		noteTweenAlpha("morra6", 5, 0, 0.5, "linear")
		noteTweenAlpha("morra7", 6, 0, 0.5, "linear")
		noteTweenAlpha("morra8", 7, 0, 0.5, "linear")
    elseif curStep == 1040 then
        doTweenAlpha('fhdh', 'celula', 1, 0.7, 'linear')
        doTweenY('fknc', 'celula', 490, 0.7, 'quartOut')
    elseif curStep == 1153 then
        setProperty('explo.visible', true)
        objectPlayAnimation('explo', 'bah')
        setProperty("camGame.alpha", 0)
    end
end