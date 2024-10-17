math.randomseed(os.time())

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

local customStep = 0

local stickerTag = 'shi'
local curSticker = 'stickerPro'
local stickerScale = 1.2
local stickerScaleOg = 1

function onCreate()
        
    --textos
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

    makeLuaText("coisi", customStep, 0, 0, 0)
    setObjectCamera("coisi", 'other')
    addLuaText("coisi")
    setProperty("coisi.visible", false)

    --[[makeLuaText("placeholder", "Link button", 0, 0.0, 700)
    setObjectCamera("placeholder", 'other')
    addLuaText("placeholder")
    setTextSize("placeholder", 20)
    setTextBorder("placeholder", 100, "000000")]]

    --bg
    makeLuaSprite("back", 'menuDesat', 0, 0)
    setObjectCamera("back", 'hud')
    addLuaSprite("back", false)

    --[[makeLuaSprite("placeholderImg", 'galaxy_pocket', 200, 300)
    setObjectCamera("placeholderImg", 'other')
    addLuaSprite("placeholderImg", false)
    setProperty("placeholderImg.visible", false)
    scaleObject("placeholderImg", 0.3, 0.3)

    makeLuaSprite("liz", 'credits/liz', 200, 300)
    setObjectCamera("liz", 'other')
    addLuaSprite("liz", false)
    setProperty("liz.visible", false)]]

    --os cabas
    makeAnimatedLuaSprite("liz", 'credits/the/liz', 100, 180)
    addAnimationByPrefix("liz", "idle", "idle", 5, true)
    setObjectCamera("liz", 'other')
    addLuaSprite("liz", false)

    makeAnimatedLuaSprite("ukiyo", 'credits/the/ukiyo', 150, 200)
    scaleObject("ukiyo", 1.3, 1.3)
    addAnimationByPrefix("ukiyo", "eat", "nom", 60, true)
    addAnimationByPrefix("ukiyo", "idle", "idle", 0, false)
    setObjectCamera("ukiyo", 'other')
    setProperty('ukiyo.antialiasing', false)
    addLuaSprite("ukiyo", false)

    makeLuaSprite("natzy", 'credits/n4tzy', 200, 300)
    setObjectCamera("natzy", 'other')
    addLuaSprite("natzy", false)
    setProperty("natzy.visible", false)

    makeAnimatedLuaSprite("shi", 'credits/placeholders/Shilito', -100, 0)
    addAnimationByPrefix("shi", "idle", "idle", 12, true)
    setObjectCamera("shi", 'other')
    setProperty('shi.antialiasing', false)
    addLuaSprite("shi", false)

    --elementos doidos
    makeLuaSprite("cut")
    makeGraphic("cut", screenWidth, screenHeight, '000000')
    setObjectCamera("cut", 'other')
    setProperty("cut.alpha", 1)
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

    --logos links shits bitches idk man i'm tired it's almost 2am
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

    -- stickers
    makeLuaSprite("stickerCom", 'credits/stickers/composer', 980, 77)
    setObjectCamera("stickerCom", 'other')
    scaleObject("stickerCom", 0.8, 0.8)
    addLuaSprite("stickerCom", false)
    setProperty("stickerCom.visible", false)

    makeLuaSprite("stickerPro", 'credits/stickers/programmer', 850, 100)
    setObjectCamera("stickerPro", 'other')
    addLuaSprite("stickerPro", false)
    setProperty("stickerPro.visible", false)

    makeLuaSprite("stickerArt", 'credits/stickers/artist', 1180, 80)
    setObjectCamera("stickerArt", 'other')
    scaleObject("stickerArt", 0.9, 0.9)
    addLuaSprite("stickerArt", false)
    setProperty("stickerArt.visible", false)

    makeLuaSprite("stickerCha", 'credits/stickers/charter', 970, 80)
    setObjectCamera("stickerCha", 'other')
    scaleObject("stickerCha", 0.5, 0.5)
    addLuaSprite("stickerCha", false)
    setProperty("stickerCha.visible", false)

    --mouse
    setPropertyFromClass("flixel.FlxG", "mouse.visible", true)

    --timers
    runTimer("resetarMeuPau", 0.3)
    runTimer("ui", 1)

    --MORRAM!!!!!!!!!!!!!!!!1111111111
    setProperty("botplayTxt.visible", false)
    setProperty("iconP1.visible", false)
    setProperty("iconP2.visible", false)
    setProperty("scoreTxt.visible", false)
    setProperty("healthBar.visible", false)
    setProperty("camGame.visible", false)

    --i'm going to hit my box till i kill myself today at 11pm
    onCreateHitbox()

    --precacheeeeeeeeee
    precacheImage("credits/stickers/charter", false)
    precacheImage("credits/stickers/artist", false)
    precacheImage("credits/stickers/programmer", false)
    precacheImage("credits/stickers/composer", false)

    precacheSound("credits/thank_you_for_playing")
    precacheSound("credits/light_turn_on")
    precacheSound("credits/flicker")
end

function onCreateHitbox() -- só pra ser bonitnho

    --hitbox shiho
    makeLuaSprite("box", '', 170, 260)
    makeGraphic("box", 223, 200, 'FFFFFF')
    setProperty("box.alpha", 0)
    setObjectCamera("box", 'other')
    addLuaSprite("box", true)

    --hitbox logo
    makeLuaSprite("boxLogo", '', 10, 601)
    makeGraphic("boxLogo", 50, 50, 'FFFFFF')
    setProperty("boxLogo.alpha", 0)
    setObjectCamera("boxLogo", 'other')
    addLuaSprite("boxLogo", true)

    --selection box
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

    if pos == 0 then -- shiho
        creditsName = parsed.shihoCre[1]
        creditsShortTxt = parsed.shihoCre[2]
        creditsLongTxt = parsed.shihoCre[3]
        color = parsed.shihoCre[4]
        link = parsed.shihoCre[5]
        stickerTag = 'shi'
        curSticker = 'stickerPro'
        stickerScale = 1.2
        stickerScaleOg = 1
        setProperty("shi.visible", true)
        setProperty("ukiyo.visible", false)
        setProperty("liz.visible", false)
        setProperty("natzy.visible", false)
        setProperty("box.visible", true)
        setProperty("tumb.visible", true)
        setProperty("tree.visible", false)
        setProperty("sky.visible", false)
        setProperty("stickerPro.visible", true)
        --[[setProperty("stickerCha.visible", true)
        setProperty("stickerArt.visible", true)
        setProperty("stickerCom.visible", false)]]
        doTweenColor("corYay", "back", color, 0.5, "linear")
        setTextString("name", creditsName)
        setTextString("shortTxt", creditsShortTxt)
        setTextString("longTxt", creditsLongTxt)
        screenCenter("name", 'x')
        screenCenter("shortTxt", 'x')
        setProperty("longTxt.x", 570)
    elseif pos == 1 then -- liz
        creditsName = parsed.lizCre[1]
        creditsShortTxt = parsed.lizCre[2]
        creditsLongTxt = parsed.lizCre[3]
        color = parsed.lizCre[4]
        link = parsed.lizCre[5]
        stickerTag = 'liz'
        curSticker = 'stickerCom'
        stickerScale = 1.2
        stickerScaleOg = 0.8
        setProperty("shi.visible", false)
        setProperty("ukiyo.visible", false)
        setProperty("liz.visible", true)
        setProperty("natzy.visible", false)
        setProperty("box.visible", false)
        setProperty("tumb.visible", false)
        setProperty("tree.visible", true)
        setProperty("sky.visible", false)
        --[[setProperty("stickerPro.visible", false)
        setProperty("stickerCha.visible", false)
        setProperty("stickerCom.visible", true)
        setProperty("stickerArt.visible", true)]]
        doTweenColor("corYay", "back", color, 0.5, "linear")
        setTextString("name", creditsName)
        setTextString("shortTxt", creditsShortTxt)
        setTextString("longTxt", creditsLongTxt)
        screenCenter("name", 'x')
        screenCenter("shortTxt", 'x')
        setProperty("longTxt.x", 770)
    elseif pos == 2 then -- ukiyo
        creditsName = parsed.ukiyoCre[1]
        creditsShortTxt = parsed.ukiyoCre[2]
        creditsLongTxt = parsed.ukiyoCre[3]
        color = parsed.ukiyoCre[4]
        link = parsed.ukiyoCre[5]
        stickerTag = 'uki'
        curSticker = 'stickerCom'
        stickerScale = 1.2
        stickerScaleOg = 0.8
        setProperty("shi.visible", false)
        setProperty("ukiyo.visible", true)
        setProperty("liz.visible", false)
        setProperty("natzy.visible", false)
        setProperty("box.visible", false)
        setProperty("tumb.visible", false)
        setProperty("tree.visible", true)
        setProperty("sky.visible", false)
        --[[setProperty("stickerPro.visible", false)
        setProperty("stickerCha.visible", false)
        setProperty("stickerCom.visible", true)
        setProperty("stickerArt.visible", true)]]
        doTweenColor("corYay", "back", color, 0.5, "linear")
        setTextString("name", creditsName)
        setTextString("shortTxt", creditsShortTxt)
        setTextString("longTxt", creditsLongTxt)
        screenCenter("name", 'x')
        screenCenter("shortTxt", 'x')
        setProperty("longTxt.x", 770)
    elseif pos == 3 then -- natzy
        creditsName = parsed.natzyCre[1]
        creditsShortTxt = parsed.natzyCre[2]
        creditsLongTxt = parsed.natzyCre[3]
        color = parsed.natzyCre[4]
        link = parsed.natzyCre[5]
        stickerTag = 'nat'
        curSticker = 'stickerArt'
        stickerScale = 1.1
        stickerScaleOg = 0.9
        setProperty("shi.visible", false)
        setProperty("ukiyo.visible", false)
        setProperty("liz.visible", false)
        setProperty("natzy.visible", true)
        setProperty("box.visible", false)
        setProperty("tumb.visible", false)
        setProperty("tree.visible", false)
        setProperty("sky.visible", true)
        --[[setProperty("stickerPro.visible", false)
        setProperty("stickerCha.visible", false)
        setProperty("stickerCom.visible", false)
        setProperty("stickerArt.visible", true)]]
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

    --[[if customStep == 66 then
        setProperty("luz.alpha", 0.5)
    end]]

    if keyboardJustPressed("D") or keyboardJustPressed("RIGHT") then
        pos = pos + 1
        stopSound("rag")
        objectPlayAnimation("ukiyo", "idle", true)
        playSound("credits/stickers/keyClick1", 1, stickerTag)
        setProperty(curSticker..".scale.x", stickerScale)
        setProperty(curSticker..".scale.y", stickerScale)
        doTweenX("x", curSticker..".scale", stickerScaleOg, 0.5, "sineOut")
        doTweenY("y", curSticker..".scale", stickerScaleOg, 0.5, "sineOut")
    elseif keyboardJustPressed("A") or keyboardJustPressed("LEFT") then
        pos = pos - 1
        stopSound("rag")
        objectPlayAnimation("ukiyo", "idle", true)
        playSound("credits/stickers/keyClick1", 1, stickerTag)
        setProperty(curSticker..".scale.x", stickerScale)
        setProperty(curSticker..".scale.y", stickerScale)
        doTweenX("x", curSticker..".scale", stickerScalOg, 0.5, "sineOut")
        doTweenY("y", curSticker..".scale", stickerScaleOg, 0.5, "sineOut")
    end
        
    if keyJustPressed('back') then
        exitSong(false)
    elseif getMouseX('camOther') > getProperty('box.x') and getMouseY('camOther') > getProperty('box.y') and getMouseX('camOther') < getProperty('box.x') + getProperty('box.width') and getMouseY('camOther') < getProperty('box.y') + getProperty('box.height') and mouseReleased() and getProperty("box.visible", true) then
        playSound("credits/honk", 1, 'honk')
        doTweenX("boom", "shi.scale", 1.3, 0.5, "elasticOut")
        doTweenY("moob", "shi.scale", 0.8, 0.5, "elasticOut")
        runTimer("xd", 0.1)
    elseif getMouseX('camOther') > getProperty('ukiyo.x') and getMouseY('camOther') > getProperty('ukiyo.y') and getMouseX('camOther') < getProperty('ukiyo.x') + getProperty('ukiyo.width') and getMouseY('camOther') < getProperty('ukiyo.y') + getProperty('ukiyo.height') and mouseReleased() and getProperty("ukiyo.visible", true) then
        playSound("credits/ragdoll", 1, 'rag')
        objectPlayAnimation("ukiyo", "eat", true)
    elseif getMouseX('camOther') > getProperty('boxLogo.x') and getMouseY('camOther') > getProperty('boxLogo.y') and getMouseX('camOther') < getProperty('boxLogo.x') + getProperty('boxLogo.width') and getMouseY('camOther') < getProperty('boxLogo.y') + getProperty('boxLogo.height') and mouseReleased() then
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
        playSound("credits/flicker", 1)
        runTimer("ain", 1.8)
        debugPrint(getTextString("coisi"))
    elseif tag == 'ain' then
        playSound("credits/light_turn_on", 0)
        --[[setProperty("stickerPro.visible", true)
        setProperty("stickerPro.scale.x", 1.2)
        setProperty("stickerPro.scale.y", 1.2)
        doTweenX("x", "stickerPro.scale", 1, 0.5, "sineOut")
        doTweenY("y", "stickerPro.scale", 1, 0.5, "sineOut")
        playSound("credits/stickers/keyClick1", 1, 'click')]]
        cameraFlash("other", "FFFFFF", 1, true)
        setObjectCamera("cut", 'hud')
        setProperty("cut.alpha", 0.3)
        playSound("credits/thank_you_for_playing", 0, 'music')
        soundFadeIn("music", 2, 0, 0)
        removeLuaText("coisi", true)
    end
end

function onUpdatePost(elapsed)
        
    setProperty("shi.angle", getProperty("shi.angle") + 0.5)
    setProperty("box.angle", getProperty("box.angle") + 0.5)
    setShaderFloat('back', 'iTime', os.clock())
    setProperty("coiso.x", getProperty("coiso.x") + 1)
    customStep = customStep + 1
    setTextString("coisi", customStep)

    if getProperty("coiso.x") == screenWidth then
        setProperty("coiso.x", -430)
    end
end

function onSoundFinished(tag)
        
    if tag == 'music' then
        playSound("credits/thank_you_for_playing", 0, 'music')
    elseif tag == 'shi' then
        setProperty("stickerCha.visible", true)
        setProperty("stickerCha.scale.x", 0.6)
        setProperty("stickerCha.scale.y", 0.6)
        doTweenX("x2", "stickerCha.scale", 0.5, 0.5, "sineOut")
        doTweenY("y2", "stickerCha.scale", 0.5, 0.5, "sineOut")
        playSound("credits/stickers/keyClick1", 1, 'shi2')
    elseif tag == 'shi2' then
        playSound("credits/stickers/keyClick1", 1, 'shi3')
        setProperty("stickerArt.visible", true)
        setProperty("stickerArt.scale.x", 1.1)
        setProperty("stickerArt.scale.y", 1.1)
        doTweenX("x3", "stickerArt.scale", 0.9, 0.5, "sineOut")
        doTweenY("y3", "stickerArt.scale", 0.9, 0.5, "sineOut")
    elseif tag == 'rag' then
        objectPlayAnimation("ukiyo", "idle", true)
    end 

    if tag == 'kms' and pos == 0 then
        playSound("credits/stickers/keyClick1", 1, 'kys')
        setProperty("stickerCha.visible", true)
        setProperty("stickerCha.scale.x", 0.6)
        setProperty("stickerCha.scale.y", 0.6)
        doTweenX("x2", "stickerCha.scale", 0.5, 0.5, "sineOut")
        doTweenY("y2", "stickerCha.scale", 0.5, 0.5, "sineOut")
    elseif tag == 'kys' then
        playSound("credits/stickers/keyClick1", 1, 'clicker')
        setProperty("stickerArt.visible", true)
        setProperty("stickerArt.scale.x", 1.2)
        setProperty("stickerArt.scale.y", 1.2)
        doTweenX("x3", "stickerArt.scale", 0.9, 0.5, "sineOut")
        doTweenY("y3", "stickerArt.scale", 0.9, 0.5, "sineOut")
    end
end