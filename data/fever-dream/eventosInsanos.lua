function onCreate()
    
    makeAnimatedLuaSprite("u", 'characters/uboa', 0, 0)
    addAnimationByPrefix("u", "idle", "idle", 12, true)
    addLuaSprite("u", false)
    setProperty("u.alpha", 1)
end

function onStepHit()
    
    if curStep == 767 then
        setProperty("u.alpha", 1)
        setProperty("dad.alpha", 0.00001)
    elseif curStep == 1087 then
        setProperty("u.alpha", 0.00001)
        setProperty("dad.alpha", 1)
    elseif curStep == 1558 then
        setProperty("u.alpha", 1)
        setProperty("dad.alpha", 0.00001)
    end
end