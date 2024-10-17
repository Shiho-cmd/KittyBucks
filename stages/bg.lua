function onCreate()

    setProperty('camGame.bgColor', getColorFromHex('FFFFFF'))
    setProperty('camGame.bg.alpha', 0.5)
    makeAnimatedLuaSprite("doidas", 'birutas_2', 50, 130)
    addAnimationByPrefix("doidas", "idle-loop", "boing", 12, false)
    addLuaSprite("doidas", false)
    scaleObject("doidas", 0.9, 0.9)

    if songName == 'KittyJam' and difficultyName == 'erect' then
        --[[setProperty('camGame.bgColor', getColorFromHex('DADADA'))

        makeLuaSprite("cloud", 'rain_cloud', -160, -90)
        --screenCenter("cloud")
        scaleObject("cloud", 1.5, 1)
        setScrollFactor("cloud", 0, 0)
        addLuaSprite("cloud", false)
        setObjectOrder("cloud", 0)

        scaleObject("doidas", 0.7, 0.7)
        setProperty("doidas.x", 255)
        setProperty("doidas.y", 300)
        setScrollFactor("doidas", 1.15, 1.15)]]
    end
end

local shader = "blur"

function onCreatePost()
    if shadersEnabled and songName == 'KittyJam' and difficultyName == 'erect' then
        --[[nitLuaShader("blur")
        setSpriteShader('doidas', shader)]]
    end
end

function onGameOver()
    
    setProperty('camGame.bgColor', getColorFromHex('000000'))
end

function onUpdate(elapsed)
    
    setProperty("timeBar.visible", false)
    setProperty("timeTxt.visible", false)
    --[[setShaderFloat('doidas', 'Directions', 30)
    setShaderFloat('doidas', 'Quality', 10)
    setShaderFloat('doidas', 'Size', 3)]]

    if songName == 'KittyJam' and difficultyName == 'erect' then
        --[[setProperty("boyfriend.color", getColorFromHex("CACACA"))
        setProperty("dad.color", getColorFromHex("CACACA"))
        setProperty("doidas.color", getColorFromHex("CACACA"))]]
    end
end

function onBeatHit()
    
    objectPlayAnimation("doidas", "idle-loop", true)
end