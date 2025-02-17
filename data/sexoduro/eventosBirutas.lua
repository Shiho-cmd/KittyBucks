local shit = getModSetting("pause")
local ass = getModSetting("over")
local random911 = getRandomBool(0.1)
local inCutscene = false

local podePular = false
local soundToLoad  = getTranslationPhrase('towers', 'second-tower')

function onStartCountdown()
    
    setProperty("camHUD.alpha", 0.0001)
end

function onCreate()
    precacheImage("backgrounds/void/events/plane")
    precacheImage("backgrounds/void/events/ku")
    precacheImage("backgrounds/void/events/maconha")
    precacheImage("gameOver/Explosion")

    if not lowQuality then
        precacheImage("backgrounds/void/events/gangnam")
    
        makeAnimatedLuaSprite("gang", 'backgrounds/void/events/gangnam', 0, 0)
        addAnimationByPrefix("gang", "cum", "style", 14, false)
        scaleObject("gang", 3.1, 3.1)
        setObjectCamera("gang", 'hud')
        screenCenter("gang")
        setBlendMode("gang", 'multiply')
        setProperty("gang.alpha", 0.0001)
        addLuaSprite("gang", true)
    end

    makeLuaText("skip", getTranslationPhrase('skip', 'Press SPACE to skip intro'), 0, 0.0, screenHeight)
    screenCenter("skip", 'x')
    setTextSize("skip", 20)
    setProperty("skip.alpha", 0.7)
    setObjectCamera("skip", 'other')
    addLuaText("skip")
    if shit then
        setObjectOrder("skip", getObjectOrder("barr"))
    end

    if random911 then
        precacheSound(soundToLoad)
        precacheImage('backgrounds/void/events/the')
        precacheImage('backgrounds/void/events/eht')
        precacheImage('backgrounds/void/events/red-circle')
        precacheImage('backgrounds/void/events/red-arrows')
        precacheImage(getFileTranslation('backgrounds/void/events/never-forget'))

        makeLuaSprite("towers", 'backgrounds/void/events/the', -300, 290)
        scaleObject("towers", 0.3, 0.3, false)
        addLuaSprite("towers", false)

        makeLuaSprite("forgor", getFileTranslation('backgrounds/void/events/never-forget'), 0, 0)
        setObjectCamera("forgor", 'other')
        screenCenter("forgor")
        scaleObject("forgor", 0.7, 0.7, false)
        setProperty("forgor.alpha", 0.0001)
        addLuaSprite("forgor", false)

        makeLuaSprite("tower", 'backgrounds/void/events/eht', -257, 362)
        scaleObject("tower", 0.37, 0.37, false)
        setProperty("tower.alpha", 0.0001)
        addLuaSprite("tower", false)

        makeAnimatedLuaSprite("balls", 'backgrounds/void/events/red-circle', -250, 410)
        addAnimationByPrefix("balls", "loop", "olhe", 24, true)
        scaleObject("balls", 0.8, 0.8)
        setProperty("balls.alpha", 0.0001)
        addLuaSprite("balls", false)

        makeAnimatedLuaSprite("cock", 'backgrounds/void/events/red-arrows', -250, 270)
        addAnimationByPrefix("cock", "loop", "olha", 24, true)
        --setBlendMode("cock", 'darken')
        setProperty("cock.alpha", 0.0001)
        addLuaSprite("cock", false)
    end

    makeLuaSprite("avi", 'backgrounds/void/events/plane', 100, -3000)
    addLuaSprite("avi", false)

    makeAnimatedLuaSprite("romi", 'backgrounds/void/events/ku', 300, -3000)
    addAnimationByIndices("romi", "yap", "talk", "0,1,2,1", 8, true)
    addAnimationByPrefix("romi", "bruh", "huh", 8, true)
    setProperty("romi.alpha", 0.0001)
    addLuaSprite("romi", false)

    makeAnimatedLuaSprite("kittycat", 'backgrounds/void/events/maconha', 500, -3000)
    addAnimationByPrefix("kittycat", "doido", "birutiando", 12, true)
    setProperty("kittycat.alpha", 0.0001)
    addLuaSprite("kittycat", false)

    makeAnimatedLuaSprite("bum", 'gameOver/Explosion', -300, 290)
    addAnimationByPrefix("bum", "explodiu", "boom", 24, false)
    setProperty("bum.alpha", 0.0001)
    scaleObject("bum", 0.3, 0.3, false)
    addLuaSprite("bum", false)
end

function onSongStart()
    
    podePular = true
    doTweenY("bumcha", "skip", screenHeight - 20, 1, "quartOut")
end

function onUpdate(elapsed)
    
    if keyboardJustPressed("SPACE") and podePular then
        setSongPosition(6862)
    end

    if getSongPosition() >= 6862 and podePular then
        podePular = false
        doTweenY("calaca", "skip", screenHeight, 1, "quartOut")
        doTweenAlpha('vai', 'escuro', 0, 0.01, 'linear')
        triggerEvent('Camera Follow Pos', '', '')
        doTweenZoom('camz', 'camGame', 0.79, 0.01, 'linear')
    end
end

function onStepHit()
    
    if curStep == 580 then
        setProperty("romi.alpha", 1)
        scaleObject("romi", 0.1, 0.1, false)
        doTweenX("romiX", "romi.scale", 1, 0.5, "quadOut")
        doTweenY("romiY", "romi.scale", 1, 0.5, "quadOut")
    elseif curStep == 600 then
        playAnim("romi", "bruh")
    elseif curStep == 605 then
        playAnim("romi", "yap")
    elseif curStep == 631 then
        setProperty("kittycat.alpha", 1)
        scaleObject("kittycat", 0.1, 0.1, false)
        doTweenX("kittycatX", "kittycat.scale", 1.5, 0.3, "quartOut")
        doTweenY("kittycatY", "kittycat.scale", 1.5, 0.3, "quartOut")
        playAnim("romi", "bruh")
        doTweenX("romiX", "romi.scale", 0.7, 0.3, "quadOut")
        doTweenY("romiY", "romi.scale", 0.7, 0.3, "quadOut")
        cameraShake("game", 0.015, 0.9)
    elseif curStep == 704 then
        removeLuaSprite("romi")
        removeLuaSprite("kittycat")
        scaleObject("avi", 0.1, 0.1, false)
        setProperty("avi.x", 4000)
        doTweenX("aviX", "avi", -500, 3, "linear")
        doTweenY("aviY", "avi", 290, 3, "linear")
        doTweenAngle("aviAngle", "avi", -360, 1, "linear")
    elseif curStep == 985 and not lowQuality then
        doTweenAlpha("style", "gang", 1, 6, "linear")
        playAnim("gang", "cum")
    end
end

function onTweenCompleted(tag, vars)
    
    if tag == 'aviAngle' then
        setProperty("avi.angle", 0)
        doTweenAngle("aviAngle", "avi", -360, 1, "linear")
    elseif tag == 'aviX' and not random911 then
        setProperty("bum.alpha", 1)
        playAnim("bum", "explodiu")
        setProperty("avi.visible", false)
    elseif tag == 'aviX' and random911 then
        inCutscene = true
        setProperty("bum.alpha", 1)
        playAnim("bum", "explodiu")
        setProperty("avi.visible", false)
        removeLuaSprite("towers")
        setProperty("tower.alpha", 1)
    elseif tag == 'willNever' and random911 then
        exitSong(true)
    elseif tag == 'calaca' then
        removeLuaText("skip", true)
    end
end

function onCustomSubstateCreatePost(name)
    
    if name == 'bah' then
        insertToCustomSubstate('balls', 0)
        insertToCustomSubstate('cock', 0)
        setObjectCamera("balls", 'game')
        setObjectCamera("cock", 'game')
        setProperty("balls.alpha", 1)
        setProperty("cock.alpha", 1)
        playSound(soundToLoad, 1, 'tower-second')
    end
end

function onUpdate(elapsed)
    
    if inCutscene and shit then
        removeLuaScript("scripts/disabled/pauseSubState")
    end

    if inCutscene and ass then
        removeLuaScript("scripts/disabled/itsBingover")
    end

    if getProperty('bum.animation.curAnim.name') == 'explodiu' and getProperty('bum.animation.curAnim.finished') and inCutscene then
        openCustomSubstate("bah", true)
    end
end

function onPause()
    
    if inCutscene then
        return Function_Stop;
    end
end

function onGameOverStart()
    
    if inCutscene then
        return Function_Stop;
    end
end

function onSoundFinished(tag)
    
    if tag == 'tower-second' then
        setProperty("camHUD.visible", false)
        setProperty("camGame.visible", false)
        doTweenAlpha("willNever", "forgor", 1, 4, "linear")
    end
end