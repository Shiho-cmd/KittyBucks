function onCreate()

    removeLuaScript("mods/KittyBucks/scripts/disabled/pauseSubState.lua")
    removeLuaScript("mods/KittyBucks/scripts/itsBingover.lua")
    
    makeLuaSprite("carrossel", 'lindo', 0, 0)
    setObjectCamera("carrossel", 'other')
    scaleObject("carrossel", 2.1, 1.9)
    screenCenter("carrossel")
    addLuaSprite("carrossel", false)

    makeLuaSprite("weed", 'weed', screenWidth, 500)
    setObjectCamera("weed", 'other')
    scaleObject("weed", 0.4, 0.4)
    addLuaSprite("weed", true)

    doTweenX("deew", "weed", -screenHeight, 11, "linear")
    doTweenAngle("mlg", "weed", -360, 3, "linear")
    runTimer("bah", 3, 143)

    setProperty('skipCountdown', true)
end

function onTimerCompleted(tag, loops, loopsLeft)
    
    if tag == 'bah' then
        setProperty("weed.angle", 0)
        doTweenAngle("mlg", "weed", -360, 3, "linear")
    end
end

function onUpdate(elapsed)

    setPropertyFromClass('openfl.Lib', 'application.window.fullscreen', true)		
    setPropertyFromClass('openfl.Lib', 'application.window.borderless', true)
    
    if keyJustPressed("debug_1") or keyJustPressed('debug_2') then
        restartSong(true)
    end
end

function onPause()
    
    return Function_Stop;
end

function onGameOver()
    
    return Function_Stop;
end

function onEndSong()
    
    close();
    os.exit();
end