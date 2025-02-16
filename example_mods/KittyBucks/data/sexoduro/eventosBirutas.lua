function onCreate()

    precacheImage("gangnam")
    
    makeAnimatedLuaSprite("gang", 'gangnam', 0, 0)
    addAnimationByPrefix("gang", "cum", "style", 24, true)
    setObjectCamera("gang", 'hud')
    screenCenter("gang")
    addLuaSprite("gang", true)
end