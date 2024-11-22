local menos = 0.1
local mais = 0.1

function onCreate()

    -- esse script num vai ficar na versão final do mod (ou será que vai?)
    precacheImage("socks")
    
    makeAnimatedLuaSprite("sock", 'socks', 0, 550)
    addAnimationByPrefix("sock", "idle", "dance", 24, true)
    setObjectCamera("sock", 'other')
    scaleObject("sock", 0.6, 0.6, true)
    addLuaSprite("sock", true)

    makeLuaText("cam", "Socks Cam:", 0, 11, 520)
    setObjectCamera("cam", 'other')
    setTextSize("cam", 20)
    addLuaText("cam")
end

function onSongStart()
    
    playAnim("sock", "idle", true)
end

function onUpdate(elapsed)
    
    if songName == 'credits' then
        screenCenter("sock", 'x')
        screenCenter("cam", 'x')
    end

    if keyboardJustPressed("LEFT") then
        setProperty("sock.alpha", getProperty("sock.alpha") - menos)
        setProperty("cam.alpha", getProperty("cam.alpha") - menos)
    elseif keyboardJustPressed("RIGHT") then
        setProperty("sock.alpha", getProperty("sock.alpha") + mais)
        setProperty("cam.alpha", getProperty("cam.alpha") + mais)
    --[[elseif keyboardPressed("LEFT") then
        setProperty("sock.alpha", getProperty("sock.alpha") - menos)
        setProperty("cam.alpha", getProperty("cam.alpha") - menos)
    elseif keyboardPressed("RIGHT") then
        setProperty("sock.alpha", getProperty("sock.alpha") + mais)
        setProperty("cam.alpha", getProperty("cam.alpha") + mais)]]
    end
end