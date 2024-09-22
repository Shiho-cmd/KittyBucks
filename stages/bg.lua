function onCreate()

    setProperty('camGame.bgColor', getColorFromHex('FFFFFF'))
    makeAnimatedLuaSprite("doidas", 'birutas_2', 50, 130)
    addAnimationByPrefix("doidas", "idle-loop", "boing", 12, false)
    addLuaSprite("doidas", false)
    scaleObject("doidas", 0.9, 0.9)
end

function onGameOver()
    
    setProperty('camGame.bgColor', getColorFromHex('000000'))
end

function onUpdate(elapsed)
    
    setProperty("timeBar.visible", false)
    setProperty("timeTxt.visible", false)
end

function onBeatHit()
    
    objectPlayAnimation("doidas", "idle-loop", true)
end