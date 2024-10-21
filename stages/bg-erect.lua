local podeSim = true

function onCreate()

    precacheImage("backgrounds/erect/clouds", false)
    precacheImage("backgrounds/erect/city", false)
    precacheImage("backgrounds/erect/street", false)
    precacheImage("backgrounds/erect/buildings", false)
    precacheImage("backgrounds/erect/guys", false)

    setProperty('camGame.bgColor', getColorFromHex('FFFFFF'))

    makeLuaSprite("clo", 'backgrounds/erect/clouds', -630, -300)
    --setScrollFactor("clo", 0.5, 0.5)
    addLuaSprite("clo", false)

    makeLuaSprite("ty", 'backgrounds/erect/city', -630, -300)
    addLuaSprite("ty", false)

    makeLuaSprite("stre", 'backgrounds/erect/street', -630, -300)
    addLuaSprite("stre", false)

    makeLuaSprite("bui", 'backgrounds/erect/buildings', -630, -300)
    addLuaSprite("bui", false)

    makeAnimatedLuaSprite("the", 'backgrounds/erect/guys', -650, -300)
    addAnimationByPrefix("the", "idle", "idle", 12, false)
    addLuaSprite("the", false)
end

function onGameOver()
    
    setProperty('camGame.bgColor', getColorFromHex('000000'))
end

function onUpdate(elapsed)
    
    setProperty("timeBar.visible", false)
    setProperty("timeTxt.visible", false)

    local hueValue = -5;
    local saturationValue = -40;
    local contrastValue = -25;
    local brightnessValue = -20;

    if podeSim == true then
    setSpriteShader('dad', 'adjustColor')
    setShaderFloat('dad', 'hue', hueValue)
    setShaderFloat('dad', 'saturation', saturationValue)
    setShaderFloat('dad', 'contrast', contrastValue)
    setShaderFloat('dad', 'brightness', brightnessValue)
    setSpriteShader('boyfriend', 'adjustColor')
    setShaderFloat('boyfriend', 'hue', hueValue)
    setShaderFloat('boyfriend', 'saturation', saturationValue)
    setShaderFloat('boyfriend', 'contrast', contrastValue)
    setShaderFloat('boyfriend', 'brightness', brightnessValue)
    else
        removeSpriteShader("boyfriend")
        removeSpriteShader("dad")
    end
end

function onBeatHit()
    
    objectPlayAnimation("the", "idle", true)
end

function onSectionHit()
    
    if curSection == 64 then
        podeSim = false
    elseif curSection == 80 then
        podeSim = true
    end
end