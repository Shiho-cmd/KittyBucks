luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

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

local parsed = parseJson('data/'..songName..'/songData-'..difficultyName..'.json')

local creditsName = parsed.shihoCre[1]
local creditsShortTxt = parsed.shihoCre[2]
local creditsLongTxt = parsed.shihoCre[3]
local color = parsed.shihoCre[4]
local link = parsed.shihoCre[5]
local link2 = parsed.shihoCre[6]

local pos = 0
local slctPos = 0

local customStep = 0
local cut = true

local shinyChance = 0.012
local shinyCharm = false
local modernShinyChance = false
local itsShiny = nil

function onCreate()

    if getTextFromFile("data/kittyjam/save.txt") == 'essa música foi passada?: sim' and getTextFromFile("data/kittyjam/save-erect.txt") == 'essa música foi passada?: sim' and getTextFromFile("data/supernova/save.txt") == 'essa música foi passada?: sim'  and getTextFromFile("data/sexoduro/save.txt") == 'essa música foi passada?: sim' then
        modernShinyChance = true
    end
    
    if getTextFromFile("data/kittyjam/save-perfect.txt") == 'foi feito 100% nessa música?: sim' then
        shinyCharm = true
    end

    if modernShinyChance and not shinyCharm then
        shinyChance = 0.024
    elseif shinyCharm and not modernShinyChance then
        shinyChance = 0.036
    elseif shinyCharm and modernShinyChance then
        shinyChance = 0.073
    end

    itsShiny = getRandomBool(shinyChance)

    debugPrint(difficulty)

    if buildTarget == 'android' then
        precacheImage("virtualpad")

        makeLuaSprite("buttonB", '', 855, 570)
        loadGraphic("buttonB", "virtualPad", 132, 127)
        addAnimation("buttonB", "pressed", {16, 17}, 10, false)
        addAnimation("buttonB", "idle", {16}, 0, true)
        setObjectCamera("buttonB", 'other')
        setProperty("buttonB.alpha", 0.5)
        setProperty("buttonB.color", FlxColor("YELLOW"))
        setProperty("buttonB.alpha", 0.5)
        addLuaSprite("buttonB", true)

        makeLuaSprite("buttonL", '', 1000, 570)
        loadGraphic("buttonL", "virtualPad", 132, 127)
        addAnimation("buttonL", "pressed", {2, 1}, 10, false)
        addAnimation("buttonL", "idle", {1}, 0, true)
        setObjectCamera("buttonL", 'other')
        setProperty("buttonL.alpha", 0.5)
        setProperty("buttonL.color", 0xF634B5)
        setProperty("buttonL.alpha", 0.5)
        addLuaSprite("buttonL", true)

        makeLuaSprite("buttonR", '', 1145, 570)
        loadGraphic("buttonR", "virtualPad", 132, 127)
        addAnimation("buttonR", "pressed", {11, 10}, 10, false)
        addAnimation("buttonR", "idle", {10}, 0, true)
        setObjectCamera("buttonR", 'other')
        setProperty("buttonR.alpha", 0.5)
        setProperty("buttonR.color", 0x52465E)
        setProperty("buttonR.alpha", 0.5)
        addLuaSprite("buttonR", true)
    end

    --precacheeeeeeeeee
    precacheImage("credits/stickers/charter", false)
    precacheImage("credits/stickers/artist", false)
    precacheImage("credits/stickers/programmer", false)
    precacheImage("credits/stickers/composer", false)

    precacheSound("credits/thank_you_for_playing")
    precacheSound("credits/light_turn_on")
    precacheSound("credits/flicker")
        
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

    --bg
    makeLuaSprite("back", 'menuDesat', 0, 0)
    setObjectCamera("back", 'hud')
    addLuaSprite("back", false)

    --os cabas
    makeLuaSprite("liz", '', -30, 140)
    loadGraphic("liz", "credits/the/liz", 864, 648)
    addAnimation("liz", "idle", {0, 1}, 5, true)
    setObjectCamera("liz", 'other')
    scaleObject("liz", 0.7, 0.7)
    addLuaSprite("liz", false)

    makeAnimatedLuaSprite("ukiyo", 'credits/the/ukiyo', 150, 200)
    scaleObject("ukiyo", 1.3, 1.3)
    addAnimationByPrefix("ukiyo", "eat", "nom", 60, true)
    addAnimationByPrefix("ukiyo", "idle", "idle", 0, false)
    setObjectCamera("ukiyo", 'other')
    setProperty('ukiyo.antialiasing', false)
    addLuaSprite("ukiyo", false)

    makeLuaSprite("natzy", 'credits/the/natzy', 115, 140)
    setObjectCamera("natzy", 'other')
    addLuaSprite("natzy", false)
    scaleObject("natzy", 0.7, 0.7)
    setProperty("natzy.visible", false)
    doTweenY("1", "natzy.scale", 0.6, 1, "quadInOut")
    doTweenX("2", "natzy.scale", 0.8, 1, "quadInOut")
    doTweenY("11", "natzy", 145, 1, "quadInOut")

    --[[makeAnimatedLuaSprite("shi", 'credits/placeholders/Shilito', -100, 0)
    addAnimationByPrefix("shi", "idle", "idle", 12, true)
    setObjectCamera("shi", 'other')
    setProperty('shi.antialiasing', false)
    addLuaSprite("shi", false)]]

    makeLuaSprite("shi", nil, 150, 250)
    loadGraphic("shi", "credits/the/shiho", 266, 239)
    addAnimation("shi", "idleShiny", {2, 3}, 12, true)
    makeLuaSprite("sparkles", nil, 80, 175)
    loadGraphic("sparkles", "credits/shinySparkles", 151, 151)
    addAnimation("sparkles", "wow", {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67}, 69, false)
    setObjectCamera("sparkles", 'other')
    scaleObject("sparkles", 2.5, 2.5)
    setProperty("sparkles.alpha", 0)
    addLuaSprite("sparkles", true)
    addAnimation("shi", "idle", {0, 1}, 12, true)

    setObjectCamera("shi", 'other')
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

    makeLuaSprite("twi", 'credits/logos/twitter', 70, 602)
    setObjectCamera("twi", 'other')
    scaleObject("twi", 0.045, 0.045)
    setProperty("twi.visible", false)
    addLuaSprite("twi", false)

    makeLuaSprite("spo", 'credits/logos/spotify', 63, 602)
    setObjectCamera("spo", 'other')
    scaleObject("spo", 0.082, 0.082)
    setProperty("spo.visible", false)
    addLuaSprite("spo", false)

    -- stickers
    makeLuaSprite("stickerCom", 'credits/stickers/composer', 980, 77)
    setObjectCamera("stickerCom", 'other')
    scaleObject("stickerCom", 0.8, 0.8)
    setProperty('stickerCom.antialiasing', false)
    addLuaSprite("stickerCom", false)
    setProperty("stickerCom.visible", false)

    makeLuaSprite("stickerPro", 'credits/stickers/programmer', 850, 100)
    setObjectCamera("stickerPro", 'other')
    setProperty('stickerPro.antialiasing', false)
    addLuaSprite("stickerPro", false)
    setProperty("stickerPro.visible", false)

    makeLuaSprite("stickerArt", 'credits/stickers/artist', 1180, 80)
    setObjectCamera("stickerArt", 'other')
    scaleObject("stickerArt", 0.9, 0.9)
    setProperty('stickerArt.antialiasing', false)
    addLuaSprite("stickerArt", false)
    setProperty("stickerArt.visible", false)

    makeLuaSprite("stickerCha", 'credits/stickers/charter', 970, 80)
    setObjectCamera("stickerCha", 'other')
    scaleObject("stickerCha", 0.5, 0.5)
    setProperty('stickerCha.antialiasing', false)
    addLuaSprite("stickerCha", false)
    setProperty("stickerCha.visible", false)

    --timers
    runTimer("resetarMeuPau", 0.3)
    runTimer("ui", 1)

    --i'm going to hit my box till i kill myself today at 11pm
    onCreateHitbox()
end

function onCreateHitbox() -- só pra ser bonitnho

    --hitbox shiho
    makeLuaSprite("box", '', 170, 260)
    makeGraphic("box", 223, 200, 'FFFFFF')
    setProperty("box.alpha", 0)
    setProperty("box.visible", false)
    setObjectCamera("box", 'other')
    addLuaSprite("box", true)

    --hitbox logo
    makeLuaSprite("boxLogo", '', 10, 601)
    makeGraphic("boxLogo", 50, 50, 'FFFFFF')
    setProperty("boxLogo.alpha", 0)
    setObjectCamera("boxLogo", 'other')
    addLuaSprite("boxLogo", true)

    makeLuaSprite("boxLogo2", '', 73, 601)
    makeGraphic("boxLogo2", 50, 50, 'FFFFFF')
    setProperty("boxLogo2.alpha", 0)
    setProperty("boxLogo2.visible", false)
    setObjectCamera("boxLogo2", 'other')
    addLuaSprite("boxLogo2", true)

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

local leftJustPressed = nil
local rightJustPressed = nil
local bJustPressed = nil
local leftPressed = nil
local rightPressed = nil
local bPressed = nil
local leftReleased = nil
local rightReleased = nil
local bReleased = nil
function onUpdate(elapsed)

    --MORRAM!!!!!!!!!!!!!!!!1111111111
    setProperty("botplayTxt.visible", false)
    setProperty("iconP1.visible", false)
    setProperty("iconP2.visible", false)
    setProperty("scoreTxt.visible", false)
    setProperty("healthBar.visible", false)
    setProperty("camGame.visible", false)

    if keyboardPressed("SIX") and keyboardPressed("NINE") then
        loadSong('ultimate-koopa', 0)
    end

    if shadersEnabled then
    setShaderFloat('back', 'frequency', 8)
    setShaderFloat('back', 'wamplitude', 0.05)
    end

    if itsShiny and pos == 3 then
        playSound("credits/shiny", 1)
        setProperty("sparkles.alpha", 1)
        playAnim("shi", "idleShiny", true)
        playAnim("sparkles", "wow", true)
        runTimer("PENIS", 0.01)
    end

    if buildTarget == 'android' then
    leftJustPressed = getMouseX('camOther') > getProperty('buttonL.x') and getMouseY('camOther') > getProperty('buttonL.y') and getMouseX('camOther') < getProperty('buttonL.x') + getProperty('buttonL.width') and getMouseY('camOther') < getProperty('buttonL.y') + getProperty('buttonL.height') and mouseClicked()
    rightJustPressed = getMouseX('camOther') > getProperty('buttonR.x') and getMouseY('camOther') > getProperty('buttonR.y') and getMouseX('camOther') < getProperty('buttonR.x') + getProperty('buttonR.width') and getMouseY('camOther') < getProperty('buttonR.y') + getProperty('buttonR.height') and mouseClicked()
    bJustPressed = getMouseX('camOther') > getProperty('buttonB.x') and getMouseY('camOther') > getProperty('buttonB.y') and getMouseX('camOther') < getProperty('buttonB.x') + getProperty('buttonB.width') and getMouseY('camOther') < getProperty('buttonB.y') + getProperty('buttonB.height') and mouseClicked()
    end

    if pos == 3 then -- shiho
        creditsName = parsed.shihoCre[1]
        creditsShortTxt = parsed.shihoCre[2]
        creditsLongTxt = parsed.shihoCre[3]
        color = parsed.shihoCre[4]
        link = parsed.shihoCre[5]
        link2 = parsed.shihoCre[6]
        setProperty("shi.visible", true)
        setProperty("ukiyo.visible", false)
        setProperty("liz.visible", false)
        setProperty("natzy.visible", false)
        setProperty("box.visible", true)
        setProperty("boxLogo2.visible", true)
        setProperty("tumb.visible", true)
        setProperty("tree.visible", false)
        setProperty("sky.visible", true)
        setProperty("twi.visible", false)
        setProperty("spo.visible", false)
        setProperty("stuff.x", 0)
        setProperty("sky.x", 70)
        setProperty("stuff.scale.x", 1.2)
        setProperty("stickerPro.visible", true)
        setProperty("stickerCha.visible", true)
        setProperty("stickerArt.visible", true)
        setProperty("stickerCom.visible", false)
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
        setProperty("shi.visible", false)
        setProperty("ukiyo.visible", false)
        setProperty("liz.visible", true)
        setProperty("natzy.visible", false)
        setProperty("box.visible", false)
        setProperty("boxLogo2.visible", false)
        setProperty("tumb.visible", false)
        setProperty("tree.visible", true)
        setProperty("sky.visible", false)
        setProperty("twi.visible", false)
        setProperty("spo.visible", false)
        setProperty("stuff.x", -50)
        setProperty("stuff.scale.x", 1)
        setProperty("stickerPro.visible", false)
        setProperty("stickerCha.visible", false)
        setProperty("stickerCom.visible", true)
        setProperty("stickerArt.visible", true)
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
        link2 = parsed.ukiyoCre[6]
        setProperty("shi.visible", false)
        setProperty("ukiyo.visible", true)
        setProperty("liz.visible", false)
        setProperty("natzy.visible", false)
        setProperty("box.visible", false)
        setProperty("boxLogo2.visible", true)
        setProperty("tumb.visible", false)
        setProperty("tree.visible", true)
        setProperty("sky.visible", false)
        setProperty("twi.visible", false)
        setProperty("spo.visible", true)
        setProperty("stuff.x", 0)
        setProperty("stuff.scale.x", 1.2)
        setProperty("stickerPro.visible", false)
        setProperty("stickerCha.visible", false)
        setProperty("stickerCom.visible", true)
        setProperty("stickerArt.visible", true)
        doTweenColor("corYay", "back", color, 0.5, "linear")
        setTextString("name", creditsName)
        setTextString("shortTxt", creditsShortTxt)
        setTextString("longTxt", creditsLongTxt)
        screenCenter("name", 'x')
        screenCenter("shortTxt", 'x')
        setProperty("longTxt.x", 770)
    elseif pos == 0 then -- natzy
        creditsName = parsed.natzyCre[1]
        creditsShortTxt = parsed.natzyCre[2]
        creditsLongTxt = parsed.natzyCre[3]
        color = parsed.natzyCre[4]
        link = parsed.natzyCre[5]
        link2 = parsed.natzyCre[6]
        stickerTag = 'nat'
        curSticker = 'stickerArt'
        setProperty("shi.visible", false)
        setProperty("ukiyo.visible", false)
        setProperty("liz.visible", false)
        setProperty("natzy.visible", true)
        setProperty("box.visible", false)
        setProperty("boxLogo2.visible", true)
        setProperty("tumb.visible", false)
        setProperty("tree.visible", false)
        setProperty("sky.visible", true)
        setProperty("twi.visible", true)
        setProperty("spo.visible", false)
        setProperty("stuff.x", 0)
        setProperty("stuff.scale.x", 1.2)
        setProperty("sky.x", 9)
        setProperty("stickerPro.visible", false)
        setProperty("stickerCha.visible", false)
        setProperty("stickerCom.visible", false)
        setProperty("stickerArt.visible", true)
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
    elseif slctPos == 1 and pos == 3 then
        setProperty("select.y", 593)
        setProperty("select.x", 0)
        scaleObject("select", 0.5, 0.5)
    elseif slctPos == 2 and pos == 3 then
        setProperty("select.y", 593)
        setProperty("select.x", 63)
        scaleObject("select", 0.5, 0.5)
    elseif slctPos == 2 and pos == 2 then
        setProperty("select.y", 593)
        setProperty("select.x", 63)
        scaleObject("select", 0.5, 0.5)
    elseif slctPos == 2 and pos == 0 then
        setProperty("select.y", 593)
        setProperty("select.x", 63)
        scaleObject("select", 0.5, 0.5)
    elseif slctPos == 0 and pos == 3 then
        scaleObject("select", 2.05, 2.1)
        setProperty("select.x", 145)
        setProperty("select.y", 245)
    elseif slctPos == 1 and pos == 2 then
        setProperty("select.y", 593)
        setProperty("select.x", 0)
        scaleObject("select", 0.5, 0.5)
    elseif slctPos == 0 and pos == 2 then
        scaleObject("select", 1.9, 2.28)
        setProperty("select.x", 145)
        setProperty("select.y", 240)
    elseif slctPos > 2 and pos == 3 or slctPos > 2 and pos == 2 then
        slctPos = 0
    elseif slctPos < 0 and pos == 3 or slctPos < 0 and pos == 2 or slctPos > 1 and pos == 2 or pos == 1 or pos == 0 then
        slctPos = 1
    end

    if customStep == 66 then
        setProperty("luz.alpha", 0.5)
        setObjectOrder("luz", 400)
    elseif customStep == 69 then
        setProperty("luz.alpha", 0.1)
    elseif customStep == 77 then
        setProperty("luz.alpha", 0.6)
    elseif customStep == 80 then
        setProperty("luz.alpha", 0.2)
    elseif customStep == 82 then
        setProperty("luz.alpha", 0.7)
    elseif customStep == 84 then
        setProperty("luz.alpha", 0.4)
    elseif customStep == 86 then
        setProperty("luz.alpha", 0.6)
    elseif customStep == 88 then
        setProperty("luz.alpha", 0)
    end

    if keyboardJustPressed("D") and cut == false or keyboardJustPressed("RIGHT") and cut == false then
        pos = pos + 1
        stopSound("rag")
        playAnim("ukiyo", "idle", true)
        setProperty("select.visible", false)
        setPropertyFromClass("flixel.FlxG", "mouse.visible", true)
    elseif keyboardJustPressed("A") and cut == false or keyboardJustPressed("LEFT") and cut == false then
        pos = pos - 1
        stopSound("rag")
        playAnim("ukiyo", "idle", true)
        setProperty("select.visible", false)
        setPropertyFromClass("flixel.FlxG", "mouse.visible", true)
        
    elseif rightJustPressed and cut == false and buildTarget == 'android' then
        pos = pos + 1
        stopSound("rag")
        playAnim("ukiyo", "idle", true)
        setProperty("select.visible", false)
        playAnim("buttonR", "pressed", true)
    elseif leftJustPressed and cut == false and buildTarget == 'android' then
        pos = pos - 1
        stopSound("rag")
        playAnim("ukiyo", "idle", true)
        setProperty("select.visible", false)
        playAnim("buttonL", "pressed", true)

    elseif gamepadJustPressed(1, "DPAD_RIGHT") and cut == false or gamepadJustPressed(1, "LEFT_STICK_DIGITAL_RIGHT") and cut == false then
        pos = pos + 1
        stopSound("rag")
        playAnim("ukiyo", "idle", true)
        setPropertyFromClass("flixel.FlxG", "mouse.visible", false)
    elseif gamepadJustPressed(1, "DPAD_LEFT") and cut == false or gamepadJustPressed(1, "LEFT_STICK_DIGITAL_LEFT") and cut == false then
        pos = pos - 1
        stopSound("rag")
        playAnim("ukiyo", "idle", true)
        setPropertyFromClass("flixel.FlxG", "mouse.visible", false)
    elseif gamepadJustPressed(1, "DPAD_DOWN") and cut == false or gamepadJustPressed(1, "LEFT_STICK_DIGITAL_DOWN") and cut == false then
        setProperty("select.visible", true)
        slctPos = slctPos + 1
        setPropertyFromClass("flixel.FlxG", "mouse.visible", false)
    elseif gamepadJustPressed(1, "DPAD_UP") and cut == false and pos == 3 or gamepadJustPressed(1, "LEFT_STICK_DIGITAL_UP") and cut == false and pos == 3 or gamepadJustPressed(1, "DPAD_UP") and cut == false and pos == 2 or gamepadJustPressed(1, "LEFT_STICK_DIGITAL_UP") and cut == false and pos == 2 then
        slctPos = slctPos - 1
        setPropertyFromClass("flixel.FlxG", "mouse.visible", false)
    end
        
    if keyJustPressed('back') then
        exitSong(false)
        setPropertyFromClass("flixel.FlxG", "mouse.visible", false)
    elseif bJustPressed and cut == false and buildTarget == 'android' then
        exitSong(false)
        playAnim("buttonB", "pressed", true)
    end

    if getMouseX('camOther') > getProperty('box.x') and getMouseY('camOther') > getProperty('box.y') and getMouseX('camOther') < getProperty('box.x') + getProperty('box.width') and getMouseY('camOther') < getProperty('box.y') + getProperty('box.height') and mouseReleased() and getProperty("box.visible", true) and cut == false or slctPos == 0 and getProperty("box.visible") and getProperty("select.visible") and gamepadJustPressed(1, "A") and cut == false then
        playSound("credits/honk", 1, 'honk')
        doTweenX("boom", "shi.scale", 1.3, 0.5, "elasticOut")
        doTweenY("moob", "shi.scale", 0.8, 0.5, "elasticOut")
        runTimer("xd", 0.1)
    elseif getMouseX('camOther') > getProperty('ukiyo.x') and getMouseY('camOther') > getProperty('ukiyo.y') and getMouseX('camOther') < getProperty('ukiyo.x') + getProperty('ukiyo.width') and getMouseY('camOther') < getProperty('ukiyo.y') + getProperty('ukiyo.height') and mouseReleased() and getProperty("ukiyo.visible", true) and cut == false or slctPos == 0 and not getProperty("box.visible") and getProperty("select.visible") and gamepadJustPressed(1, "A") and cut == false then
        playSound("credits/ragdoll", 1, 'rag')
        playAnim("ukiyo", "eat", true)
    elseif getMouseX('camOther') > getProperty('boxLogo.x') and getMouseY('camOther') > getProperty('boxLogo.y') and getMouseX('camOther') < getProperty('boxLogo.x') + getProperty('boxLogo.width') and getMouseY('camOther') < getProperty('boxLogo.y') + getProperty('boxLogo.height') and mouseReleased() and cut == false or slctPos == 1 and getProperty("select.visible", true) and gamepadJustPressed(1, "A") and cut == false then
        callMethodFromClass('backend.CoolUtil', 'browserLoad', {link})
    end
    
    if getMouseX('camOther') > getProperty('boxLogo2.x') and getMouseY('camOther') > getProperty('boxLogo2.y') and getMouseX('camOther') < getProperty('boxLogo2.x') + getProperty('boxLogo2.width') and getMouseY('camOther') < getProperty('boxLogo2.y') + getProperty('boxLogo2.height') and mouseReleased() and getProperty("boxLogo2.visible", false) or slctPos == 2 and getProperty("select.visible", true) and gamepadJustPressed(1, "A") and cut == false then
        callMethodFromClass('backend.CoolUtil', 'browserLoad', {link2})
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
    end

    if tag == 'ain' and buildTarget == 'android' then
        playSound("credits/light_turn_on", 1)
        setProperty("luz.alpha", 0.3)
        setObjectOrder("luz", getObjectOrder("shi") + 1)
        cameraFlash("other", "FFFFFF", 1, true)
        setObjectCamera("cut", 'hud')
        setProperty("cut.alpha", 0.3)
        playSound("credits/thank_you_for_playing", 0, 'music')
        soundFadeIn("music", 2, 0, 1)
        removeLuaText("coisi", true)
        cut = false
        runTimer("morse", 300)
    elseif tag == 'ain' and buildTarget ~= 'android' then
        playSound("credits/light_turn_on", 1)
        setProperty("luz.alpha", 0.3)
        setObjectOrder("luz", getObjectOrder("shi") + 1)
        cameraFlash("other", "FFFFFF", 1, true)
        setObjectCamera("cut", 'hud')
        setProperty("cut.alpha", 0.3)
        playSound("credits/thank_you_for_playing", 0, 'music')
        soundFadeIn("music", 2, 0, 1)
        removeLuaText("coisi", true)
        cut = false
        setPropertyFromClass("flixel.FlxG", "mouse.visible", true)
        runTimer("morse", 300)
    elseif tag == 'morse' then
        soundFadeOut("music", 0.5, 0)
        playSound("credits/stickers/shhh/nada_pra_ver_aqui", 1, 'code')
    elseif tag == 'PENIS' then
        itsShiny = false
    end
end

function onUpdatePost(elapsed)
        
    setProperty("shi.angle", getProperty("shi.angle") + 0.5)
    setProperty("box.angle", getProperty("box.angle") + 0.5)

    setProperty("coiso.x", getProperty("coiso.x") + 1)

    if shadersEnabled then
        setShaderFloat('back', 'iTime', os.clock())
    end

    if cut then
        customStep = customStep + 1
        setTextString("coisi", customStep)
    end

    if getProperty("coiso.x") == screenWidth then
        setProperty("coiso.x", -430)
    end
end

function onSoundFinished(tag)
        
    if tag == 'music' then
        playSound("credits/thank_you_for_playing", 1, 'music')
    elseif tag == 'rag' then
        playAnim("ukiyo", "idle", true)
    elseif tag == 'code' then
        soundFadeIn("music", 2, 0, 1)
    end
end

function onTweenCompleted(tag, vars)
    
    if tag == '1' then
        doTweenY("33", "natzy", 140, 0.85, "quadInOut")
        doTweenY("3", "natzy.scale", 0.7, 0.85, "quadInOut")
        doTweenX("4", "natzy.scale", 0.7, 0.85, "quadInOut")
    elseif tag == '4' then
        doTweenY("1", "natzy.scale", 0.65, 0.85, "quadInOut")
        doTweenX("2", "natzy.scale", 0.83, 0.85, "quadInOut")
        doTweenY("11", "natzy", 153, 0.85, "quadInOut")
    end
end