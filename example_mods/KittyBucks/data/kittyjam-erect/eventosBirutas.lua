luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

local pathEvent = 'backgrounds/void/events/'
local podePular = false

function onCreate()

    makeLuaSprite('escuro', '', 0, 0)
    makeGraphic('escuro', screenWidth, screenHeight, '000000')
    setObjectCamera('escuro', 'other')
    addLuaSprite('escuro', false)
    setObjectOrder("escuro", getObjectOrder("barr")-1)

    makeLuaText("skip", "Press SPACE to skip intro", 0, 0.0, screenHeight)
    screenCenter("skip", 'x')
    setTextSize("skip", 20)
    setProperty("skip.alpha", 0.7)
    setObjectCamera("skip", 'other')
    addLuaText("skip")
    setObjectOrder("skip", getObjectOrder("barr"))

    makeLuaSprite('celula', pathEvent..'galaxy_pocket', 330, 420) --330 420
    addLuaSprite('celula', false)
    scaleObject('celula', 0.2, 0.2) --0.2
    setProperty('celula.alpha', 0)

    makeAnimatedLuaSprite("spek", pathEvent..'speakingEpicThing', 270, 360) -- 270 360
    addAnimationByPrefix("spek", "speaking", "funny", 7, true)
    scaleObject("spek", 0.6, 0.6)
    setProperty("spek.visible", false)
    addLuaSprite("spek", false)
    
    setProperty('camHUD.alpha', 0.00001)
        
    if not lowQuality then
        precacheImage("kaboom")
            
        makeAnimatedLuaSprite('explo', pathEvent..'kaboom', 0, 0)
        addAnimationByPrefix('explo', 'bah', 'boom', 12, false)
        setObjectCamera('explo', 'other')
        addLuaSprite('explo', false)
        scaleObject('explo', 2.2, 2.2)
        setProperty('explo.visible', false)
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
    
    podePular = true
    doTweenAlpha('vai', 'escuro', 0, 10, 'linear')
    triggerEvent('Camera Follow Pos', 660, -1000)
    setProperty('cameraSpeed', 99)
    scaleObject('celula', 0.25, 0.25)
    setProperty("celula.x", 270)
    setProperty("celula.y", 310)
    setProperty("spek.x", 230)
    setProperty("spek.y", 250)
    doTweenY("bumcha", "skip", screenHeight - 20, 1, "quartOut")
end

function onUpdate(elapsed)
    
    if keyboardJustPressed("SPACE") and podePular then
        setSongPosition(23000)
    end

    if getSongPosition() >= 23000 and podePular then
        podePular = false
        doTweenY("calaca", "skip", screenHeight, 1, "quartIn")
        doTweenAlpha('vai', 'escuro', 0, 0.01, 'linear')
        triggerEvent('Camera Follow Pos', '', '')
        doTweenZoom('camz', 'camGame', 0.79, 0.01, 'linear')
    end
end

function onStepHit()
    
    if curStep == 1818 then
        doTweenAlpha('fhdh', 'celula', 1, 0.7, 'linear')
        doTweenY('fknc', 'celula', 380, 0.7, 'quartOut')
    elseif curStep == 1839 then
        setProperty("spek.visible", true)
    elseif curStep == 1914 then
        setProperty("spek.visible", false)
    elseif curStep == 1917 then
        setProperty("camGame.visible", false)
        setProperty('explo.visible', true)
        playAnim('explo', 'bah')      
    end
end

function onTweenCompleted(tag, vars)
    
    if tag == 'calaca' then
        removeLuaText("skip", true)
    end
end