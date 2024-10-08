function onStartCountdown() 
    if not allowCountdown then
        return Function_Stop
    end
    if allowCountdown then
        return Function_Continue
    end 
end

function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local parsed = parseJson('data/stuff.json')

local creditsName = parsed.shihoCre[1]
local creditsShortTxt = parsed.shihoCre[2]
local creditsLongTxt = parsed.shihoCre[3]
local color = parsed.shihoCre[4]
local link = parsed.shihoCre[5]

local pos = 0
local slctPos = 0

function onCreate()
        
    makeLuaText("name", creditsName, 0, 0.0, 69)
    makeLuaText("shortTxt", creditsShortTxt, 0, 0.0, 0.0)
    makeLuaText("longTxt", creditsLongTxt, 0, 700, 0.0)
    setObjectCamera("name", 'other')
    setObjectCamera("shortTxt", 'other')
    setObjectCamera("longTxt", 'other')
    setTextSize("name", 70)
    setTextSize("shortTxt", 25)
    setTextSize("longTxt", 25)
    setProperty("shortTxt.y", getProperty("name.y") + 70)
    screenCenter("name", 'x')
    screenCenter("shortTxt", 'x')
    screenCenter("longTxt", 'y')
    addLuaText("name")
    addLuaText("shortTxt")
    addLuaText("longTxt")
    setTextAlignment("longTxt", 'center')

    makeLuaText("coiso", "KITTYBUCKS TEAM!!!11", 0, -420, 15)
    setObjectCamera("coiso", 'other')
    addLuaText("coiso")
    setTextSize("coiso", 35)

    --[[makeLuaText("placeholder", "Link button", 0, 0.0, 700)
    setObjectCamera("placeholder", 'other')
    addLuaText("placeholder")
    setTextSize("placeholder", 20)
    setTextBorder("placeholder", 100, "000000")]]

    makeLuaSprite("back", 'menuDesat', 0, 0)
    setObjectCamera("back", 'hud')
    addLuaSprite("back", false)

    makeLuaSprite("placeholderImg", 'galaxy_pocket', 200, 300)
    setObjectCamera("placeholderImg", 'other')
    addLuaSprite("placeholderImg", false)
    setProperty("placeholderImg.visible", false)
    scaleObject("placeholderImg", 0.3, 0.3)

    makeLuaSprite("liz", 'credits/liz', 200, 300)
    setObjectCamera("liz", 'other')
    addLuaSprite("liz", false)
    setProperty("liz.visible", false)

    makeLuaSprite("natzy", 'credits/n4tzy', 200, 300)
    setObjectCamera("natzy", 'other')
    addLuaSprite("natzy", false)
    setProperty("natzy.visible", false)

    makeAnimatedLuaSprite("shi", 'credits/placeholders/Shilito', -100, 0)
    addAnimationByPrefix("shi", "idle", "idle", 12, true)
    setObjectCamera("shi", 'other')
    setProperty('shi.antialiasing', false)
    addLuaSprite("shi", false)

    makeLuaSprite("cut")
    makeGraphic("cut", screenWidth, screenHeight, '000000')
    setObjectCamera("cut", 'other')
    addLuaSprite("cut", true)

    makeLuaSprite("luz", 'spotlight', 110, -50)
    setObjectCamera("luz", 'other')
    setProperty("luz.alpha", 0.3)
    scaleObject("luz", 0.6, 0.6)
    addLuaSprite("luz", false)

    makeLuaSprite('barrama', '', 0, -30)
    makeGraphic('barrama', screenWidth, 100, '000000')
    addLuaSprite('barrama', false)
    setObjectCamera('barrama', 'other')
    setScrollFactor('barrama', 0, 0)
    
    makeLuaSprite('barraixo', '', 0, 650)
    makeGraphic('barraixo', screenWidth, 100, '000000')
    addLuaSprite('barraixo', false)
    setScrollFactor('barraixo', 0, 0)
    setObjectCamera('barraixo', 'other')

    makeLuaSprite("stuff", 'credits/thing', -50, 599)
    setObjectCamera("stuff", 'other')
    addLuaSprite("stuff", false)

    makeLuaSprite("tumb", 'credits/logos/tumblr', 10, 600)
    setObjectCamera("tumb", 'other')
    scaleObject("tumb", 0.1, 0.1)
    setProperty("tumb.visible", true)
    addLuaSprite("tumb", false)

    makeLuaSprite("tree", 'credits/logos/linktree', 10, 601)
    setObjectCamera("tree", 'other')
    scaleObject("tree", 0.09, 0.09)
    setProperty("tree.visible", false)
    addLuaSprite("tree", false)

    makeLuaSprite("sky", 'credits/logos/bluesky', 9, 602)
    setObjectCamera("sky", 'other')
    scaleObject("sky", 0.085, 0.085)
    setProperty("sky.visible", false)
    addLuaSprite("sky", false)

    setPropertyFromClass("flixel.FlxG", "mouse.visible", true)

    onCreateHitbox()

    runTimer("resetarMeuPau", 0.3)
    runTimer("ui", 1)

    setProperty("botplayTxt.visible", false)
    setProperty("iconP1.visible", false)
    setProperty("iconP2.visible", false)
    setProperty("scoreTxt.visible", false)
    setProperty("healthBar.visible", false)
    setProperty("camGame.visible", false)
end

function onCreateHitbox() -- só pra ser bonitnho

    makeLuaSprite("box", '', 170, 260)
    makeGraphic("box", 223, 200, 'FFFFFF')
    setProperty("box.alpha", 0)
    setObjectCamera("box", 'other')
    addLuaSprite("box", true)

    makeLuaSprite("boxLogo", '', 10, 601)
    makeGraphic("boxLogo", 50, 50, 'FFFFFF')
    setProperty("boxLogo.alpha", 0)
    setObjectCamera("boxLogo", 'other')
    addLuaSprite("boxLogo", true)

    makeLuaSprite("select", 'credits/selectionBox')
    setObjectCamera("select", 'other')
    addLuaSprite("select", true)
    setProperty("select.visible", false)
end

local shader = "wavy"

function onCreatePost()
    if shadersEnabled then
        initLuaShader("wavy")
        setSpriteShader('back', shader)
    end
end

function onUpdate(elapsed)

    setShaderFloat('back', 'frequency', 8)
    setShaderFloat('back', 'wamplitude', 0.05)

    if pos == 0 then
        creditsName = parsed.shihoCre[1]
        creditsShortTxt = parsed.shihoCre[2]
        creditsLongTxt = parsed.shihoCre[3]
        color = parsed.shihoCre[4]
        link = parsed.shihoCre[5]
        setProperty("shi.visible", true)
        setProperty("placeholderImg.visible", false)
        setProperty("liz.visible", false)
        setProperty("natzy.visible", false)
        setProperty("box.visible", true)
        setProperty("tumb.visible", true)
        setProperty("tree.visible", false)
        setProperty("sky.visible", false)
        doTweenColor("corYay", "back", color, 0.5, "linear")
        setTextString("name", creditsName)
        setTextString("shortTxt", creditsShortTxt)
        setTextString("longTxt", creditsLongTxt)
        screenCenter("name", 'x')
        screenCenter("shortTxt", 'x')
        setProperty("longTxt.x", 570)
    elseif pos == 1 then
        creditsName = parsed.lizCre[1]
        creditsShortTxt = parsed.lizCre[2]
        creditsLongTxt = parsed.lizCre[3]
        color = parsed.lizCre[4]
        link = parsed.lizCre[5]
        setProperty("shi.visible", false)
        setProperty("placeholderImg.visible", false)
        setProperty("liz.visible", true)
        setProperty("natzy.visible", false)
        setProperty("box.visible", false)
        setProperty("tumb.visible", false)
        setProperty("tree.visible", true)
        setProperty("sky.visible", false)
        doTweenColor("corYay", "back", color, 0.5, "linear")
        setTextString("name", creditsName)
        setTextString("shortTxt", creditsShortTxt)
        setTextString("longTxt", creditsLongTxt)
        screenCenter("name", 'x')
        screenCenter("shortTxt", 'x')
        setProperty("longTxt.x", 770)
    elseif pos == 2 then
        creditsName = parsed.ukiyoCre[1]
        creditsShortTxt = parsed.ukiyoCre[2]
        creditsLongTxt = parsed.ukiyoCre[3]
        color = parsed.ukiyoCre[4]
        link = parsed.ukiyoCre[5]
        setProperty("shi.visible", false)
        setProperty("placeholderImg.visible", true)
        setProperty("liz.visible", false)
        setProperty("natzy.visible", false)
        setProperty("box.visible", false)
        setProperty("tumb.visible", false)
        setProperty("tree.visible", true)
        setProperty("sky.visible", false)
        doTweenColor("corYay", "back", color, 0.5, "linear")
        setTextString("name", creditsName)
        setTextString("shortTxt", creditsShortTxt)
        setTextString("longTxt", creditsLongTxt)
        screenCenter("name", 'x')
        screenCenter("shortTxt", 'x')
        setProperty("longTxt.x", 770)
    elseif pos == 3 then
        creditsName = parsed.natzyCre[1]
        creditsShortTxt = parsed.natzyCre[2]
        creditsLongTxt = parsed.natzyCre[3]
        color = parsed.natzyCre[4]
        link = parsed.natzyCre[5]
        setProperty("shi.visible", false)
        setProperty("placeholderImg.visible", false)
        setProperty("liz.visible", false)
        setProperty("natzy.visible", true)
        setProperty("box.visible", false)
        setProperty("tumb.visible", false)
        setProperty("tree.visible", false)
        setProperty("sky.visible", true)
        doTweenColor("corYay", "back", color, 0.5, "linear")
        setTextString("name", creditsName)
        setTextString("shortTxt", creditsShortTxt)
        setTextString("longTxt", creditsLongTxt)
        screenCenter("name", 'x')
        screenCenter("shortTxt", 'x')
        setProperty("longTxt.x", 770)
    elseif pos > 3 then
        pos = 0
    elseif pos < 0 then
        pos = 3
    end

    if slctPos == 1 then
        setProperty("select.y", 593)
        setProperty("select.x", 0)
        scaleObject("select", 0.5, 0.5)
    elseif slctPos == 0 then
        scaleObject("select", 2.05, 2.1)
        setProperty("select.x", 145)
        setProperty("select.y", 245)
    elseif slctPos > 1 and getProperty("box.visible", true) then
        slctPos = 0
    elseif slctPos < 0 and getProperty("box.visible", true) then
        slctPos = 1
    end

    if keyboardJustPressed("D") or keyboardJustPressed("RIGHT") then
        pos = pos + 1
        setProperty("select.visible", false)
        setPropertyFromClass("flixel.FlxG", "mouse.visible", true)
    elseif gamepadJustPressed(1, "DPAD_RIGHT") or gamepadJustPressed(1, "LEFT_STICK_DIGITAL_RIGHT") then
        pos = pos + 1
        slctPos = 1
        setPropertyFromClass("flixel.FlxG", "mouse.visible", false)
    elseif keyboardJustPressed("A") or keyboardJustPressed("LEFT") then
        pos = pos - 1
        setProperty("select.visible", false)
        setPropertyFromClass("flixel.FlxG", "mouse.visible", true)
    elseif gamepadJustPressed(1, "DPAD_LEFT") or gamepadJustPressed(1, "LEFT_STICK_DIGITAL_LEFT") then
        pos = pos - 1
        slctPos = 1
        setPropertyFromClass("flixel.FlxG", "mouse.visible", false)
    elseif gamepadJustPressed(1, "DPAD_DOWN") and getProperty("box.visible", true) or gamepadJustPressed(1, "LEFT_STICK_DIGITAL_DOWN") then
        setProperty("select.visible", true)
        slctPos = slctPos + 1
        setPropertyFromClass("flixel.FlxG", "mouse.visible", false)
    elseif gamepadJustPressed(1, "DPAD_UP") and getProperty("box.visible", true) or gamepadJustPressed(1, "LEFT_STICK_DIGITAL_UP") and getProperty("box.visible", true) then
        slctPos = slctPos - 1
        setPropertyFromClass("flixel.FlxG", "mouse.visible", false)
    end
        
    if keyJustPressed('back') then
        exitSong(false)
    elseif getMouseX('camOther') > getProperty('box.x') and getMouseY('camOther') > getProperty('box.y') and getMouseX('camOther') < getProperty('box.x') + getProperty('box.width') and getMouseY('camOther') < getProperty('box.y') + getProperty('box.height') and mouseReleased() and getProperty("box.visible", true) or slctPos == 0 and getProperty("box.visible", true) and getProperty("select.visible", true) and gamepadJustPressed(1, "A") then
        playSound("honk", 1, 'honk')
        doTweenX("boom", "shi.scale", 1.3, 0.5, "elasticOut")
        doTweenY("moob", "shi.scale", 0.8, 0.5, "elasticOut")
        runTimer("xd", 0.1)
    elseif getMouseX('camOther') > getProperty('boxLogo.x') and getMouseY('camOther') > getProperty('boxLogo.y') and getMouseX('camOther') < getProperty('boxLogo.x') + getProperty('boxLogo.width') and getMouseY('camOther') < getProperty('boxLogo.y') + getProperty('boxLogo.height') and mouseReleased() or slctPos == 1 and getProperty("select.visible", true) and gamepadJustPressed(1, "A") then
        local function open_link()
            os.execute("start "..link)
        end
        open_link()
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
        
    if tag == 'xd' then
        doTweenX("boom", "shi.scale", 1, 0.5, "elasticOut")
        doTweenY("moob", "shi.scale", 1, 0.5, "elasticOut")
    elseif tag == 'resetarMeuPau' then
        doTweenColor("malaca", "select", "C4EBFF", 0.3, "linear")
        runTimer("pauResetado", 0.3)
    elseif tag == 'pauResetado' then
        doTweenColor("atu", "select", "FFFFFF", 0.3, "linear")
        runTimer("resetarMeuPau", 0.3)
    elseif tag == 'ui' then
        playSound("flicker", 1)
        runTimer("ain", 1.8)
    elseif tag == 'ain' then
        playSound("light_turn_on", 1)
        cameraFlash("other", "FFFFFF", 1, true)
        setObjectCamera("cut", 'hud')
        setProperty("cut.alpha", 0.3)
        playSound("funnyCredits", 0, 'music')
        soundFadeIn("music", 2, 0, 1)
    end
end

function onUpdatePost(elapsed)
        
    setProperty("shi.angle", getProperty("shi.angle") + 0.5)
    setProperty("box.angle", getProperty("box.angle") + 0.5)
    setShaderFloat('back', 'iTime', os.clock())
    setProperty("coiso.x", getProperty("coiso.x") + 1)

    if getProperty("coiso.x") == screenWidth then
        setProperty("coiso.x", -430)
    end
end

function onSoundFinished(tag)
        
    if tag == 'music' then
        playSound("funnyCredits", 1, 'music')
    end 
end