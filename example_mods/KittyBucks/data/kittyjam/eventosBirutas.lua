lastNote = {0, ""}
luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

local pathEvent = 'backgrounds/void/events/'

function onCreate()

    makeLuaSprite('escuro', '', 0, 0)
    makeGraphic('escuro', screenWidth, screenHeight, '000000')
    setObjectCamera('escuro', 'other')
    addLuaSprite('escuro', false)

    makeLuaSprite('celula', pathEvent..'galaxy_pocket', 330, 420) --330 420
    addLuaSprite('celula', false)
    scaleObject('celula', 0.2, 0.2) --0.2
    setProperty('celula.alpha', 0)

    makeAnimatedLuaSprite("spek", pathEvent..'speakingEpicThing', 270, 360) -- 270 360
    addAnimationByPrefix("spek", "speaking", "funny", 7, true)
    scaleObject("spek", 0.6, 0.6)
    setProperty("spek.visible", false)
    addLuaSprite("spek", false)
    
    setProperty('camHUD.alpha', 0)
        
    if not lowQuality then
        makeAnimatedLuaSprite('gif', pathEvent..'speedlol')
        addAnimationByPrefix('gif', 'lesgo', 'yo', 12, true)
        screenCenter('gif')
        setObjectCamera('gif', 'hud')
        addLuaSprite('gif', true)
        setProperty('gif.alpha', 0.000001)
        precacheImage("speedlol")
            
        makeAnimatedLuaSprite('explo', pathEvent..'kaboom', 0, 0)
        addAnimationByPrefix('explo', 'bah', 'boom', 12, false)
        setObjectCamera('explo', 'other')
        addLuaSprite('explo', false)
        scaleObject('explo', 2.2, 2.2)
        setProperty('explo.visible', false)
        precacheImage("kaboom")
    end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)

    if noteType == "No Animation" then
        setProperty("celula.angle", 5)
        runTimer("vire", 0.1)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    
    if tag == 'vire' then
        setProperty("celula.angle", -5)
        runTimer("desvire", 0.1)
    elseif tag == 'desvire' then
        setProperty("celula.angle", 0)
    end
end

function onSongStart()
    
    doTweenAlpha('vai', 'escuro', 0, 10, 'linear')
    triggerEvent('Camera Follow Pos', 660, 500)
    setProperty('cameraSpeed', 99)
end

function onStepHit()
    
    if curStep == 640 then
        doTweenAlpha('f', 'gif', 1, 20, 'linear')
        triggerEvent('Camera Follow Pos', 660, 500)
    elseif curStep == 759 then
        doTweenAlpha('f', 'gif', 0, 0.5, 'linear')
        triggerEvent('Camera Follow Pos', '', '')
    elseif curStep == 1040 then
        doTweenAlpha('fhdh', 'celula', 1, 0.7, 'linear')
        doTweenY('fknc', 'celula', 490, 0.7, 'quartOut')
        setProperty("camHUD.alpha", 0)
    elseif curStep == 1065 then
        setProperty("spek.visible", true)
    elseif curStep == 1148 then
        setProperty("spek.visible", false)
    elseif curStep == 1153 then
        setProperty("camGame.visible", false)
        setProperty('explo.visible', true)
        playAnim('explo', 'bah')
    end
end