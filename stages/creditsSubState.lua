luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

function onStartCountdown() 

    --MORRAM!!!!!!!!!!!!!!!!1111111111
    setProperty("botplayTxt.visible", false)
    setProperty("iconP1.visible", false)
    setProperty("iconP2.visible", false)
    setProperty("scoreTxt.visible", false)
    setProperty("healthBar.visible", false)
    setProperty("camGame.visible", false)
    return Function_Stop;
end

function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local parsed = parseJson('data/'..songName..'/songData-'..difficultyName..'.json')
local siivaSave = parseJson('data/credits/siivaSave.json')
local omoriSave = parseJson('data/credits/omoriSave.json')

local creditsName = parsed.shihoCre[1]
local creditsShortTxt = parsed.shihoCre[2]
local creditsLongTxt = parsed.shihoCre[3]
local color = parsed.shihoCre[4]
local link = parsed.shihoCre[5]
local link2 = parsed.shihoCre[6]

local pos = 1
local pos2 = 1
local slctPos = 0

local customStep = 0
local cut = true

local shinyChance = 0.012
local shinyCharm = false
local modernShinyChance = false
local itsShiny = nil

local section = 0

local nameSiiva = parsed.misterySiiva[1]
local longTxtSiiva = parsed.misterySiiva[2]
local colorSiiva = parsed.misterySiiva[3]
local linkSiiva = nil
local nameOmori = parsed.misteryOmori[1]
local longTxtOmori = parsed.misteryOmori[2]
local colorOmori = parsed.misteryOmori[3]
local linkOmori = nil

local shihoBooped = false
local ukiyoBooped = false

local shader = "wavy"

local check = nil

local volume = 1
local volume2 = 0
local numPodeNaoMan = false
local updateShit = true

function onCreate()

    setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | '..getTranslationPhrase('win_creditos', 'Credits Menu'))

    --precacheeeeeeeeee
    precacheImage("credits/stickers/charter")
    precacheImage("credits/stickers/artist")
    precacheImage("credits/stickers/programmer")
    precacheImage("credits/stickers/composer")
    precacheImage("credits/stickers/animator")
    precacheImage("credits/stickers/director")

    precacheImage("credits/pins/eventCode")
    precacheImage("credits/pins/github")
    precacheImage("credits/pins/siivagunner")

    precacheImage("credits/shinySparkles")
    precacheImage("credits/thing")
    precacheImage("credits/gradiant")
    precacheImage("credits/pinSparkle")
    precacheImage("credits/sectionSelect")

    precacheImage("credits/logos/bluesky")
    precacheImage("credits/logos/gamebanana")
    precacheImage("credits/logos/linktree")
    precacheImage("credits/logos/spotify")
    precacheImage("credits/logos/tumblr")
    precacheImage("credits/logos/twitter")
    precacheImage("credits/logos/youtube")

    precacheImage("credits/the/liz")
    precacheImage("credits/the/natzy")
    precacheImage("credits/the/shiho")
    precacheImage("credits/the/ukiyo")

    precacheImage("keroppica")

    precacheSound("credits/thank_you_for_playing")
    precacheSound("credits/thank_you_for_muffle_everything_omg_help")
    precacheSound("credits/light_turn_on")
    precacheSound("credits/flicker")
    precacheSound("credits/warp")
    precacheSound("credits/honk")
    precacheSound("credits/ragdoll")
    precacheSound("credits/shiny")
    precacheSound("credits/stickers/shhh/nada_pra_ver_aqui")

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

    makeLuaText("coiso", getTranslationPhrase('cre_time', 'KITTYBUCKS TEAM!!!11'), 0, -420, 15)
    setObjectCamera("coiso", 'other')
    addLuaText("coiso")
    setTextSize("coiso", 35)

    makeLuaText("coiso2", getTranslationPhrase('cre_especial', 'SPECIAL THANKS!!!11'), 0, screenWidth, 665)
    setObjectCamera("coiso2", 'other')
    addLuaText("coiso2")
    setTextSize("coiso2", 35)
    setProperty("coiso2.alpha", 0.0001)

    makeLuaText("mostresla", "BUCETAAAAAAAAAAA", 0, 0.0, 200)
    setObjectCamera("mostresla", 'other')
    setTextBorder("mostresla", 100, "000000")
    setProperty("mostresla.alpha", 0)
    addLuaText("mostresla")

    --bg
    makeLuaSprite("back", 'menuDesat', 0, 0)
    setObjectCamera("back", 'hud')
    addLuaSprite("back", false)

    -- gradishit
    makeLuaSprite("gra", 'credits/gradiant', 0, 0)
    setObjectCamera("gra", 'other')
    setProperty("gra.alpha", 0.5)
    setProperty("gra.alpha", 0.0001)
    setProperty("gra.flipY", true)
    addLuaSprite("gra", false)

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
    setProperty("natzy.alpha", 0.0001)
    doTweenY("1", "natzy.scale", 0.6, 1, "quadInOut")
    doTweenX("2", "natzy.scale", 0.8, 1, "quadInOut")
    doTweenY("11", "natzy", 145, 1, "quadInOut")

    makeLuaSprite("pica", 'keroppica', 160, 270)
    setObjectCamera('pica', "other")
    addLuaSprite("pica", false)

    makeLuaSprite("shi", nil, 150, 250)
    loadGraphic("shi", "credits/the/shiho", 266, 239)
    addAnimation("shi", "idle", {0, 1}, 12, true)
    addAnimation("shi", "idleShiny", {2, 3}, 12, true)
    makeLuaSprite("sparkles", nil, 80, 175)
    loadGraphic("sparkles", "credits/shinySparkles", 151, 151)
    addAnimation("sparkles", "wow", {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67}, 69, false)
    setObjectCamera("sparkles", 'other')
    scaleObject("sparkles", 2.5, 2.5)
    setProperty("sparkles.alpha", 0)
    addLuaSprite("sparkles", true)

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
    
    makeLuaSprite('barraixo', '', 0, 650)
    makeGraphic('barraixo', screenWidth, 100, '000000')
    addLuaSprite('barraixo', false)
    setObjectCamera('barraixo', 'other')

    --logos links shits bitches idk man i'm tired it's almost 2am
    makeLuaSprite("stuff", 'credits/thing', -50, 599)
    setObjectCamera("stuff", 'other')
    addLuaSprite("stuff", false)

    makeLuaSprite("tumb", 'credits/logos/tumblr', 10, 600)
    setObjectCamera("tumb", 'other')
    scaleObject("tumb", 0.1, 0.1)
    setProperty("tumb.alpha", 1)
    addLuaSprite("tumb", false)

    makeLuaSprite("tree", 'credits/logos/linktree', 10, 601)
    setObjectCamera("tree", 'other')
    scaleObject("tree", 0.09, 0.09)
    setProperty("tree.alpha", 0.0001)
    addLuaSprite("tree", false)

    makeLuaSprite("sky", 'credits/logos/bluesky', 9, 602)
    setObjectCamera("sky", 'other')
    scaleObject("sky", 0.085, 0.085)
    setProperty("sky.alpha", 0.0001)
    addLuaSprite("sky", false)

    makeLuaSprite("twi", 'credits/logos/twitter', 70, 602)
    setObjectCamera("twi", 'other')
    scaleObject("twi", 0.045, 0.045)
    setProperty("twi.alpha", 0.0001)
    addLuaSprite("twi", false)

    makeLuaSprite("spo", 'credits/logos/spotify', 63, 602)
    setObjectCamera("spo", 'other')
    scaleObject("spo", 0.082, 0.082)
    setProperty("spo.alpha", 0.0001)
    addLuaSprite("spo", false)

    makeLuaSprite("you", 'credits/logos/youtube', 5, 605)
    scaleObject("you", 0.057, 0.057)
    setObjectCamera("you", 'other')
    setProperty("you.alpha", 0.0001)
    addLuaSprite("you", false)

    makeLuaSprite("bana", 'credits/logos/gamebanana', 3, 595)
    setObjectCamera("bana", 'other')
    scaleObject("bana", 0.073, 0.073)
    setProperty("bana.alpha", 0.0001)
    addLuaSprite("bana", false)

    -- stickers
    makeLuaSprite("stickerCom", 'credits/stickers/composer', 980, 77)
    setObjectCamera("stickerCom", 'other')
    scaleObject("stickerCom", 0.8, 0.8)
    setProperty('stickerCom.antialiasing', false)
    addLuaSprite("stickerCom", false)
    setProperty("stickerCom.visible", false)

    makeLuaSprite("stickerPro", 'credits/stickers/programmer', 915, 105)
    setObjectCamera("stickerPro", 'other')
    scaleObject("stickerPro", 1.1, 1.1)
    setProperty('stickerPro.antialiasing', false)
    addLuaSprite("stickerPro", false)
    setProperty("stickerPro.visible", false)

    makeLuaSprite("stickerArt", 'credits/stickers/artist', 1180, 80)
    setObjectCamera("stickerArt", 'other')
    scaleObject("stickerArt", 0.9, 0.9)
    setProperty('stickerArt.antialiasing', false)
    addLuaSprite("stickerArt", false)
    setProperty("stickerArt.visible", false)

    makeLuaSprite("stickerCha", 'credits/stickers/charter', 1050, 90)
    setObjectCamera("stickerCha", 'other')
    scaleObject("stickerCha", 1.1, 1.1)
    setProperty('stickerCha.antialiasing', false)
    addLuaSprite("stickerCha", false)
    setProperty("stickerCha.visible", false)

    makeLuaSprite("stickerDir", 'credits/stickers/director', 1050, 80)
    setObjectCamera("stickerDir", 'other')
    setProperty('stickerDir.antialiasing', false)
    addLuaSprite("stickerDir", false)
    setProperty("stickerDir.visible", false)

    makeLuaSprite("stickerAni", 'credits/stickers/animator', 1050, 80)
    setObjectCamera("stickerAni", 'other')
    setProperty('stickerAni.antialiasing', false)
    addLuaSprite("stickerAni", false)
    setProperty("stickerAni.visible", false)

    -- pins
    makeLuaSprite("pinGit", 'credits/pins/github', 1090, 120)
    setProperty("pinGit.angle", 20)
    setObjectCamera("pinGit", 'other')
    setProperty('pinGit.antialiasing', false)
    addLuaSprite("pinGit", false)
    setProperty("pinGit.alpha", 0.0001)

    makeLuaSprite("pinSiiva", 'credits/pins/siivagunner', 1080, 90)
    setProperty("pinSiiva.angle", 20)
    setObjectCamera("pinSiiva", 'other')
    setProperty('pinSiiva.antialiasing', false)
    addLuaSprite("pinSiiva", false)
    setProperty("pinSiiva.alpha", 0.0001)

    makeLuaSprite("pinEC", 'credits/pins/eventCode', 1100, 150)
    scaleObject("pinEC", 1.7, 1.7)
    setProperty("pinEC.angle", 20)
    setObjectCamera("pinEC", 'other')
    setProperty('pinEC.antialiasing', false)
    addLuaSprite("pinEC", false)
    setProperty("pinEC.alpha", 1)

    makeAnimatedLuaSprite("pinSparkle", 'credits/pinSparkle', 1100, 125)
    addAnimationByPrefix("pinSparkle", "idle", "spark", 10, true)
    scaleObject("pinSparkle", 1.5, 1.5)
    setObjectCamera("pinSparkle", 'other')
    addLuaSprite("pinSparkle", false)

    -- section select
    makeAnimatedLuaSprite("sec", 'credits/sectionSelect', 0, 655)
    addAnimationByIndices("sec", "spe", "special", "1, 2, 3", 12, true)
    addAnimationByIndices("sec", "bucks", "kitty", "1, 2, 3", 12, true)
    addAnimationByIndices("sec", "speGay", "specialGamepad", "1, 2, 3", 12, true)
    addAnimationByIndices("sec", "bucksGay", "kittyGamepad", "1, 2, 3", 12, true)
    screenCenter("sec", 'x')
    setObjectCamera("sec", 'other')
    setProperty('sec.antialiasing', false)
    addLuaSprite("sec", false)

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
    setProperty("box.alpha", 0.0001)
    setProperty("box.visible", false)
    setObjectCamera("box", 'other')
    addLuaSprite("box", true)

    --hitbox logo
    makeLuaSprite("boxLogo", '', 10, 601)
    makeGraphic("boxLogo", 50, 50, 'FFFFFF')
    setProperty("boxLogo.alpha", 0.00001)
    setObjectCamera("boxLogo", 'other')
    addLuaSprite("boxLogo", true)

    makeLuaSprite("boxLogo2", '', 73, 601)
    makeGraphic("boxLogo2", 50, 50, 'FFFFFF')
    setProperty("boxLogo2.alpha", 0.0001)
    setProperty("boxLogo2.visible", false)
    setObjectCamera("boxLogo2", 'other')
    addLuaSprite("boxLogo2", true)
end

function onCreatePost()
    if shadersEnabled then
        initLuaShader("wavy")
        setSpriteShader('back', shader)
    end
end

function onUpdate(elapsed)

    --[[if isAchievementUnlocked("funny") then
        longTxtSiiva = parsed.siivaCre[2]
    end]]

    if keyboardPressed("SIX") and keyboardPressed("NINE") then
        loadSong('bruh', -1)
    end
    
    if keyboardPressed("C") and keyboardPressed("E") and keyboardPressed("U") then
        loadSong('carrossel', -1)
    end

    if shihoBooped and ukiyoBooped then
        setAchievementScore("boop", 2, false)
    end

    if shadersEnabled then
    setShaderFloat('back', 'frequency', 8)
    setShaderFloat('back', 'wamplitude', 0.05)
    end

    if itsShiny and pos == 5 then
        playSound("credits/shiny", 1)
        setProperty("sparkles.alpha", 1)
        playAnim("shi", "idleShiny", true)
        playAnim("sparkles", "wow", true)
        runTimer("PENIS", 0.01)
    end

    checkArt = getMouseX('camOther') > getProperty('stickerArt.x') and getMouseY('camOther') > getProperty('stickerArt.y') and getMouseX('camOther') < getProperty('stickerArt.x') + getProperty('stickerArt.width') and getMouseY('camOther') < getProperty('stickerArt.y') + getProperty('stickerArt.height') and getProperty("stickerArt.visible")
    checkDir = getMouseX('camOther') > getProperty('stickerDir.x') and getMouseY('camOther') > getProperty('stickerDir.y') and getMouseX('camOther') < getProperty('stickerDir.x') + getProperty('stickerDir.width') and getMouseY('camOther') < getProperty('stickerDir.y') + getProperty('stickerDir.height') and getProperty("stickerDir.visible")
    checkPro = getMouseX('camOther') > getProperty('stickerPro.x') and getMouseY('camOther') > getProperty('stickerPro.y') and getMouseX('camOther') < getProperty('stickerPro.x') + getProperty('stickerPro.width') and getMouseY('camOther') < getProperty('stickerPro.y') + getProperty('stickerPro.height') and getProperty("stickerPro.visible")
    checkCha = getMouseX('camOther') > getProperty('stickerCha.x') and getMouseY('camOther') > getProperty('stickerCha.y') and getMouseX('camOther') < getProperty('stickerCha.x') + getProperty('stickerCha.width') and getMouseY('camOther') < getProperty('stickerCha.y') + getProperty('stickerCha.height') and getProperty("stickerCha.visible")
    checkAni = getMouseX('camOther') > getProperty('stickerAni.x') and getMouseY('camOther') > getProperty('stickerAni.y') and getMouseX('camOther') < getProperty('stickerAni.x') + getProperty('stickerAni.width') and getMouseY('camOther') < getProperty('stickerAni.y') + getProperty('stickerAni.height') and getProperty("stickerAni.visible")
    checkCom = getMouseX('camOther') > getProperty('stickerCom.x') and getMouseY('camOther') > getProperty('stickerCom.y') and getMouseX('camOther') < getProperty('stickerCom.x') + getProperty('stickerCom.width') and getMouseY('camOther') < getProperty('stickerCom.y') + getProperty('stickerCom.height') and getProperty("stickerCom.visible")

    if pos == 5 and section == 0 and updateShit then -- shiho
        updateShit = false
        creditsName = parsed.shihoCre[1]
        creditsShortTxt = parsed.shihoCre[2]
        creditsLongTxt = parsed.shihoCre[3]
        color = parsed.shihoCre[4]
        link = parsed.shihoCre[5]
        link2 = parsed.shihoCre[6]
        setProperty("shi.alpha", 1)
        setProperty("ukiyo.alpha", 0.0001)
        setProperty("liz.alpha", 0.0001)
        setProperty("natzy.alpha", 0.0001)
        setProperty("pica.alpha", 0.0001)
        setProperty("box.visible", true)
        setProperty("boxLogo2.visible", true)
        setProperty("tumb.alpha", 1)
        setProperty("tree.alpha", 0.0001)
        setProperty("sky.alpha", 1)
        setProperty("twi.alpha", 0.0001)
        setProperty("spo.alpha", 0.0001)
        setProperty("you.alpha", 0.0001)
        setProperty("bana.alpha", 0.0001)
        setProperty("pinGit.alpha", 0.0001)
        setProperty("pinSiiva.alpha", 0.0001)
        setProperty("pinEC.alpha", 0.0001)
        setProperty("pinSparkle.x", -999)
        setProperty("pinSparkle.y", -999)
        setProperty("stuff.x", 0)
        setProperty("sky.x", 70)
        setProperty("stuff.scale.x", 1.2)
        setProperty("stickerPro.visible", true)
        setProperty("stickerCha.visible", true)
        setProperty("stickerArt.visible", true)
        setProperty("stickerCom.visible", false)
        setProperty("stickerDir.visible", false)
        setProperty("stickerAni.visible", true)
        setProperty("stickerAni.x", 820)
        doTweenColor("corYay", "back", color, 0.5, "linear")
        setTextString("name", creditsName)
        setTextString("shortTxt", creditsShortTxt)
        setTextString("longTxt", creditsLongTxt)
        setTextWidth("longTxt", 500)
        screenCenter("name", 'x')
        screenCenter("shortTxt", 'x')
        screenCenter("longTxt", 'y')
        setProperty("longTxt.x", 650)
    elseif pos == 2 and section == 0 and updateShit then -- liz
        updateShit = false
        creditsName = parsed.lizCre[1]
        creditsShortTxt = parsed.lizCre[2]
        creditsLongTxt = parsed.lizCre[3]
        color = parsed.lizCre[4]
        link = parsed.lizCre[5]
        link2 = parsed.lizCre[6]
        setProperty("shi.alpha", 0.0001)
        setProperty("ukiyo.alpha", 0.0001)
        setProperty("liz.alpha", 1)
        setProperty("natzy.alpha", 0.0001)
        setProperty("pica.alpha", 0.0001)
        setProperty("box.visible", false)
        setProperty("boxLogo2.visible", true)
        setProperty("tumb.alpha", 0.0001)
        setProperty("tree.alpha", 1)
        setProperty("sky.alpha", 0.0001)
        setProperty("twi.alpha", 1)
        setProperty("spo.alpha", 0.0001)
        setProperty("you.alpha", 0.0001)
        setProperty("bana.alpha", 0.0001)
        setProperty("pinGit.alpha", 0.0001)
        setProperty("pinSiiva.alpha", 0.0001)
        setProperty("pinEC.alpha", 0.0001)
        setProperty("pinSparkle.x", -999)
        setProperty("pinSparkle.y", -999)
        setProperty("stuff.x", 0)
        setProperty("stuff.scale.x", 1.2)
        setProperty("twi.x", 70)
        setProperty("stickerPro.visible", false)
        setProperty("stickerCha.visible", false)
        setProperty("stickerCom.visible", true)
        setProperty("stickerArt.visible", true)
        setProperty("stickerDir.visible", true)
        setProperty("stickerAni.visible", false)
        setProperty("stickerDir.x", 855)
        doTweenColor("corYay", "back", color, 0.5, "linear")
        setTextString("name", creditsName)
        setTextString("shortTxt", creditsShortTxt)
        setTextString("longTxt", creditsLongTxt)
        setTextWidth("longTxt", 500)
        screenCenter("name", 'x')
        screenCenter("shortTxt", 'x')
        screenCenter("longTxt", 'y')
        setProperty("longTxt.x", 650)
    elseif pos == 3 and section == 0 and updateShit then -- ukiyo
        updateShit = false
        creditsName = parsed.ukiyoCre[1]
        creditsShortTxt = parsed.ukiyoCre[2]
        creditsLongTxt = parsed.ukiyoCre[3]
        color = parsed.ukiyoCre[4]
        link = parsed.ukiyoCre[5]
        link2 = parsed.ukiyoCre[6]
        setProperty("shi.alpha", 0.0001)
        setProperty("ukiyo.alpha", 1)
        setProperty("liz.alpha", 0.0001)
        setProperty("natzy.alpha", 0.0001)
        setProperty("pica.alpha", 0.0001)
        setProperty("box.visible", false)
        setProperty("boxLogo2.visible", true)
        setProperty("tumb.alpha", 0.0001)
        setProperty("tree.alpha", 1)
        setProperty("sky.alpha", 0.0001)
        setProperty("twi.alpha", 0.0001)
        setProperty("spo.alpha", 1)
        setProperty("you.alpha", 0.0001)
        setProperty("bana.alpha", 0.0001)
        setProperty("pinGit.alpha", 0.0001)
        setProperty("pinSiiva.alpha", 0.0001)
        setProperty("pinEC.alpha", 0.0001)
        setProperty("pinSparkle.x", -999)
        setProperty("pinSparkle.y", -999)
        setProperty("stuff.x", 0)
        setProperty("stuff.scale.x", 1.2)
        setProperty("stickerPro.visible", false)
        setProperty("stickerCha.visible", false)
        setProperty("stickerCom.visible", true)
        setProperty("stickerArt.visible", true)
        setProperty("stickerDir.visible", false)
        setProperty("stickerAni.visible", false)
        doTweenColor("corYay", "back", color, 0.5, "linear")
        setTextString("name", creditsName)
        setTextString("shortTxt", creditsShortTxt)
        setTextString("longTxt", creditsLongTxt)
        setTextWidth("longTxt", 600)
        screenCenter("name", 'x')
        screenCenter("shortTxt", 'x')
        screenCenter("longTxt", 'y')
        setProperty("longTxt.x", 600)
    elseif pos == 1 and section == 0 and updateShit then -- natzy
        updateShit = false
        creditsName = parsed.natzyCre[1]
        creditsShortTxt = parsed.natzyCre[2]
        creditsLongTxt = parsed.natzyCre[3]
        color = parsed.natzyCre[4]
        link = parsed.natzyCre[5]
        link2 = parsed.natzyCre[6]
        setProperty("shi.alpha", 0.0001)
        setProperty("ukiyo.alpha", 0.0001)
        setProperty("liz.alpha", 0.0001)
        setProperty("natzy.alpha", 1)
        setProperty("pica.alpha", 0.0001)
        setProperty("box.visible", false)
        setProperty("boxLogo2.visible", true)
        setProperty("tumb.alpha", 0.0001)
        setProperty("tree.alpha", 0.0001)
        setProperty("sky.alpha", 1)
        setProperty("twi.alpha", 1)
        setProperty("spo.alpha", 0.0001)
        setProperty("you.alpha", 0.0001)
        setProperty("bana.alpha", 0.0001)
        setProperty("pinGit.alpha", 0.0001)
        setProperty("pinSiiva.alpha", 0.0001)
        setProperty("pinEC.alpha", 0.0001)
        setProperty("stickerDir.x", 1050)
        setProperty("pinSparkle.x", -999)
        setProperty("pinSparkle.y", -999)
        setProperty("stuff.x", 0)
        setProperty("stuff.scale.x", 1.2)
        setProperty("sky.x", 9)
        setProperty("twi.x", 70)
        setProperty("stickerPro.visible", false)
        setProperty("stickerCha.visible", false)
        setProperty("stickerCom.visible", false)
        setProperty("stickerArt.visible", true)
        setProperty("stickerDir.visible", true)
        setProperty("stickerAni.visible", false)
        doTweenColor("corYay", "back", color, 0.5, "linear")
        setTextString("name", creditsName)
        setTextString("shortTxt", creditsShortTxt)
        setTextString("longTxt", creditsLongTxt)
        setTextWidth("longTxt", 600)
        screenCenter("name", 'x')
        screenCenter("shortTxt", 'x')
        screenCenter("longTxt", 'y')
        setProperty("longTxt.x", 650)
    elseif pos == 4 and section == 0 and updateShit then -- bluck
        updateShit = false
        creditsName = parsed.bluckCre[1]
        creditsShortTxt = parsed.bluckCre[2]
        creditsLongTxt = parsed.bluckCre[3]
        color = parsed.bluckCre[4]
        link = parsed.bluckCre[5]
        setProperty("shi.alpha", 0.0001)
        setProperty("ukiyo.alpha", 0.0001)
        setProperty("liz.alpha", 0.0001)
        setProperty("natzy.alpha", 0.0001)
        setProperty("box.visible", false)
        setProperty("pica.alpha", 1)
        setProperty("boxLogo2.visible", false)
        setProperty("tumb.alpha", 0.0001)
        setProperty("tree.alpha", 0.0001)
        setProperty("sky.alpha", 0.0001)
        setProperty("twi.alpha", 1)
        setProperty("spo.alpha", 0.0001)
        setProperty("you.alpha", 0.0001)
        setProperty("bana.alpha", 0.0001)
        setProperty("pinGit.alpha", 0.0001)
        setProperty("pinSiiva.alpha", 0.0001)
        setProperty("pinEC.alpha", 0.0001)
        setProperty("pinSparkle.x", -999)
        setProperty("pinSparkle.y", -999)
        setProperty("stuff.x", -50)
        setProperty("stuff.scale.x", 1)
        setProperty("twi.x", 5)
        setProperty("stickerPro.visible", false)
        setProperty("stickerCha.visible", false)
        setProperty("stickerCom.visible", false)
        setProperty("stickerArt.visible", true)
        setProperty("stickerDir.visible", false)
        setProperty("stickerAni.visible", true)
        setProperty("stickerAni.x", 1070)
        doTweenColor("corYay", "back", color, 0.5, "linear")
        setTextString("name", creditsName)
        setTextString("shortTxt", creditsShortTxt)
        setTextString("longTxt", creditsLongTxt)
        setTextWidth("longTxt", 600)
        screenCenter("name", 'x')
        screenCenter("shortTxt", 'x')
        screenCenter("longTxt", 'y')
        setProperty("longTxt.x", 650)
    elseif pos > 5 and section == 0 then
        pos = 1
    elseif pos < 1 and section == 0 then
        pos = 5
    end

    if pos2 == 1 and section == 1 and updateShit then
        updateShit = false
        creditsName = parsed.seventenCre[1]
        creditsLongTxt = parsed.seventenCre[2]
        color = parsed.seventenCre[3]
        link = parsed.seventenCre[4]
        setProperty("boxLogo2.visible", false)
        setProperty("stuff.visible", true)
        setProperty("stuff.x", -60)
        setProperty("shortTxt.alpha", 0.0001)
        setProperty("tumb.alpha", 0.0001)
        setProperty("tree.alpha", 0.0001)
        setProperty("sky.alpha", 0.0001)
        setProperty("twi.alpha", 0.0001)
        setProperty("spo.alpha", 0.0001)
        setProperty("you.alpha", 0.0001)
        setProperty("bana.alpha", 1)
        setProperty("pinGit.alpha", 1)
        setProperty("pinSiiva.alpha", 0.0001)
        setProperty("pinEC.alpha", 0.0001)
        setProperty("pinSparkle.x", 1100)
        setProperty("pinSparkle.y", 120)
        doTweenColor("corYay", "back", color, 0.5, "linear")
        setTextString("name", creditsName)
        setTextString("longTxt", creditsLongTxt)
        setTextWidth("longTxt", 600)
        screenCenter("name", 'x')
        screenCenter("shortTxt", 'x')
        screenCenter("longTxt", 'y')
        screenCenter("longTxt")
    elseif pos2 == 2 and section == 1 and updateShit then
        updateShit = false
        creditsName = parsed.gitCre[1]
        creditsLongTxt = parsed.gitCre[2]
        color = parsed.gitCre[3]
        link = nil
        setProperty("boxLogo2.visible", false)
        setProperty("stuff.visible", false)
        setProperty("shortTxt.alpha", 0.0001)
        setProperty("tumb.alpha", 0.0001)
        setProperty("tree.alpha", 0.0001)
        setProperty("sky.alpha", 0.0001)
        setProperty("twi.alpha", 0.0001)
        setProperty("spo.alpha", 0.0001)
        setProperty("you.alpha", 0.0001)
        setProperty("bana.alpha", 0.0001)
        setProperty("pinGit.alpha", 1)
        setProperty("pinSiiva.alpha", 0.0001)
        setProperty("pinEC.alpha", 0.0001)
        setProperty("pinSparkle.x", 1100)
        setProperty("pinSparkle.y", 120)
        doTweenColor("corYay", "back", color, 0.5, "linear")
        setTextString("name", creditsName)
        setTextString("longTxt", creditsLongTxt)
        setTextWidth("longTxt", 600)
        screenCenter("name", 'x')
        screenCenter("shortTxt", 'x')
        screenCenter("longTxt", 'y')
        screenCenter("longTxt")
    elseif pos2 == 3 and section == 1 and updateShit then
        updateShit = false
        creditsName = parsed.scriptCre[1]
        creditsLongTxt = parsed.scriptCre[2]
        color = parsed.scriptCre[3]
        link = nil
        setProperty("boxLogo2.visible", false)
        setProperty("stuff.visible", false)
        setProperty("stuff.x", -50)
        setProperty("stuff.scale.x", 1)
        setProperty("shortTxt.alpha", 0.0001)
        setProperty("tumb.alpha", 0.0001)
        setProperty("tree.alpha", 0.0001)
        setProperty("sky.alpha", 0.0001)
        setProperty("twi.alpha", 0.0001)
        setProperty("spo.alpha", 0.0001)
        setProperty("you.alpha", 0.0001)
        setProperty("bana.alpha", 0.0001)
        setProperty("pinGit.alpha", 0.0001)
        setProperty("pinSiiva.alpha", 0.0001)
        setProperty("pinEC.alpha", 1)
        setProperty("pinSparkle.x", 1100)
        setProperty("pinSparkle.y", 140)
        doTweenColor("corYay", "back", color, 0.5, "linear")
        setTextString("name", creditsName)
        setTextString("longTxt", creditsLongTxt)
        setTextWidth("longTxt", 600)
        screenCenter("name", 'x')
        screenCenter("shortTxt", 'x')
        screenCenter("longTxt", 'y')
        screenCenter("longTxt")
    elseif pos2 == 4 and section == 1 and updateShit then
        updateShit = false
        creditsName = nameSiiva
        creditsLongTxt = longTxtSiiva
        color = colorSiiva
        link = linkSiiva
        setProperty("boxLogo2.visible", false)
        setProperty("stuff.visible", siivaSave.pin)
        setProperty("stuff.x", -50)
        setProperty("stuff.scale.x", 1)
        setProperty("shortTxt.alpha", 0.0001)
        setProperty("tumb.alpha", 0.0001)
        setProperty("tree.alpha", 0.0001)
        setProperty("sky.alpha", 0.0001)
        setProperty("twi.alpha", 0.0001)
        setProperty("spo.alpha", 0.0001)
        setProperty("you.visible", siivaSave.pin)
        setProperty("bana.alpha", 0.0001)
        setProperty("pinGit.alpha", 0.0001)
        setProperty("pinSiiva.visible", siivaSave.pin)
        setProperty("pinEC.alpha", 0.0001)
        --setProperty("pinSparkle.x", 1100)
        setProperty("pinSparkle.x", siivaSave.sparkleX)
        setProperty("pinSparkle.y", 145)
        doTweenColor("corYay", "back", color, 0.5, "linear")
        setTextString("name", creditsName)
        setTextString("longTxt", creditsLongTxt)
        setTextWidth("longTxt", 600)
        screenCenter("name", 'x')
        screenCenter("shortTxt", 'x')
        screenCenter("longTxt", 'y')
        screenCenter("longTxt")
    elseif pos2 == 5 and section == 1 and updateShit then
        updateShit = false
        creditsName = nameOmori
        creditsLongTxt = longTxtOmori
        color = colorOmori
        link = linkOmori
        setProperty("boxLogo2.visible", false)
        setProperty("stuff.visible", omoriSave.pin)
        setProperty("stuff.x", -50)
        setProperty("stuff.scale.x", 1)
        setProperty("shortTxt.alpha", 0.0001)
        setProperty("tumb.alpha", 0.0001)
        setProperty("tree.alpha", 0.0001)
        setProperty("sky.alpha", 0.0001)
        setProperty("twi.alpha", 0.0001)
        setProperty("spo.alpha", 0.0001)
        setProperty("you.alpha", 0.0001)
        setProperty("bana.alpha", 0.0001)
        setProperty("pinGit.alpha", 0.0001)
        setProperty("pinSiiva.visible", omoriSave.pin)
        setProperty("pinEC.alpha", 0.0001)
        --setProperty("pinSparkle.x", 1100)
        setProperty("pinSparkle.x", omoriSave.sparkleX)
        setProperty("pinSparkle.y", 145)
        doTweenColor("corYay", "back", color, 0.5, "linear")
        setTextString("name", creditsName)
        setTextString("longTxt", creditsLongTxt)
        setTextWidth("longTxt", 600)
        screenCenter("name", 'x')
        screenCenter("shortTxt", 'x')
        screenCenter("longTxt", 'y')
        screenCenter("longTxt")
    elseif pos2 > 5 and section == 1 then
        pos2 = 1
    elseif pos2 < 1 and section == 1 then
        pos2 = 5
    end

    if checkArt then
        setTextString("mostresla", getTranslationPhrase('cre_sticker_art', 'Artist'))
        setProperty("mostresla.x", getMouseX("other"))
        setProperty("mostresla.y", getMouseY("other") + 35)
        doTweenAlpha("putaRapariga", "mostresla", 1, 0.1, "linear")
    elseif checkDir then
        setTextString("mostresla", getTranslationPhrase('cre_sticker_dir', 'Director'))
        setProperty("mostresla.x", getMouseX("other"))
        setProperty("mostresla.y", getMouseY("other") + 35)
        doTweenAlpha("putaRapariga", "mostresla", 1, 0.1, "linear")
    elseif checkPro then
        setTextString("mostresla", getTranslationPhrase('cre_sticker_pro', 'Programmer'))
        setProperty("mostresla.x", getMouseX("other"))
        setProperty("mostresla.y", getMouseY("other") + 35)
        doTweenAlpha("putaRapariga", "mostresla", 1, 0.1, "linear")
    elseif checkCha then
        setTextString("mostresla", "Charter")
        setProperty("mostresla.x", getMouseX("other"))
        setProperty("mostresla.y", getMouseY("other") + 35)
        doTweenAlpha("putaRapariga", "mostresla", 1, 0.1, "linear")
    elseif checkAni and pos == 5 then
        setTextString("mostresla", getTranslationPhrase('cre_sticker_anima', 'Animator'))
        setProperty("mostresla.x", getMouseX("other"))
        setProperty("mostresla.y", getMouseY("other") + 35)
        doTweenAlpha("putaRapariga", "mostresla", 1, 0.1, "linear")
    elseif checkAni and pos == 4 then
        setTextString("mostresla", getTranslationPhrase('cre_sticker_animo', 'Animator'))
        setProperty("mostresla.x", getMouseX("other"))
        setProperty("mostresla.y", getMouseY("other") + 35)
        doTweenAlpha("putaRapariga", "mostresla", 1, 0.1, "linear")
    elseif checkCom and pos == 2 then
        setTextString("mostresla", getTranslationPhrase('cre_sticker_compa', 'Composer'))
        setProperty("mostresla.x", getMouseX("other"))
        setProperty("mostresla.y", getMouseY("other") + 35)
        doTweenAlpha("putaRapariga", "mostresla", 1, 0.1, "linear")
    elseif checkCom and pos == 3 then
        setTextString("mostresla", getTranslationPhrase('cre_sticker_compo', 'Composer'))
        setProperty("mostresla.x", getMouseX("other"))
        setProperty("mostresla.y", getMouseY("other") + 35)
        doTweenAlpha("putaRapariga", "mostresla", 1, 0.1, "linear")
    else
        doTweenAlpha("putaRapariga", "mostresla", 0, 0.1, "linear")
    end

    if customStep == 66 and flashingLights then
        setProperty("luz.alpha", 0.5)
        setObjectOrder("luz", 400)
    elseif customStep == 69 and flashingLights then
        setProperty("luz.alpha", 0.1)
    elseif customStep == 77 and flashingLights then
        setProperty("luz.alpha", 0.6)
    elseif customStep == 80 and flashingLights then
        setProperty("luz.alpha", 0.2)
    elseif customStep == 82 and flashingLights then
        setProperty("luz.alpha", 0.7)
    elseif customStep == 84 and flashingLights then
        setProperty("luz.alpha", 0.4)
    elseif customStep == 86 and flashingLights then
        setProperty("luz.alpha", 0.6)
    elseif customStep == 88 and flashingLights then
        setProperty("luz.alpha", 0)
    end

    if keyJustPressed('ui_right') and not cut and section == 0 then
        updateShit = true
        pos = pos + 1
        stopSound("rag")
        playAnim("ukiyo", "idle", true)
        setProperty("select.alpha", 0.0001)
    elseif keyJustPressed('ui_left') and not cut and section == 0 then
        updateShit = true
        pos = pos - 1
        stopSound("rag")
        playAnim("ukiyo", "idle", true)
        setProperty("select.alpha", 0.0001)

    elseif keyJustPressed('ui_right') and not cut and section == 1 then
        updateShit = true
        pos2 = pos2 + 1
    elseif keyJustPressed('ui_left') and not cut and section == 1 then
        updateShit = true
        pos2 = pos2 - 1
    end
        
    if keyJustPressed('back') then
        exitSong(false)
        setPropertyFromClass("flixel.FlxG", "mouse.visible", false)
    end

    if section == 0 and not numPodeNaoMan then
        volume = 0
        volume2 = 1
    elseif section == 1 and not numPodeNaoMan then
        volume = 1
        volume2 = 0
    else
        volume = 0
        volume2 = 0
    end

    if keyJustPressed('ui_down') and not cut and section == 0 then
        cut = true
        stopSound("rag")
        playAnim("ukiyo", "idle", true)
        setProperty("select.alpha", 0.0001)
        playSound("credits/warp", 1, 'warp')
        doTweenY("bruhbruh", "camOther", -screenHeight, 0.35, "quartIn")
        doTweenY("hurbhurb", "camHUD", -screenHeight, 0.35, "quartIn")
        soundFadeOut("music", volume2, 0)
    elseif keyJustPressed('ui_up') and not cut and section == 1 then
        cut = true
        playSound("credits/warp", 1, 'praw')
        doTweenY("bruhbruh", "camOther", screenHeight, 0.35, "quartIn")
        doTweenY("hurbhurb", "camHUD", screenHeight, 0.35, "quartIn")
        soundFadeOut("musicMuffled", volume, 0)
    end

    if getMouseX('camOther') > getProperty('box.x') and getMouseY('camOther') > getProperty('box.y') and getMouseX('camOther') < getProperty('box.x') + getProperty('box.width') and getMouseY('camOther') < getProperty('box.y') + getProperty('box.height') and mouseReleased() and getProperty("box.visible") and not cut then
        playSound("credits/honk", 1, 'honk')
        doTweenX("boom", "shi.scale", 1.3, 0.5, "elasticOut")
        doTweenY("moob", "shi.scale", 0.8, 0.5, "elasticOut")
        runTimer("xd", 0.1)
        shihoBooped = true
        setAchievementScore("obama", getAchievementScore("obama") + 1, false)
    elseif getMouseX('camOther') > getProperty('ukiyo.x') and getMouseY('camOther') > getProperty('ukiyo.y') and getMouseX('camOther') < getProperty('ukiyo.x') + getProperty('ukiyo.width') and getMouseY('camOther') < getProperty('ukiyo.y') + getProperty('ukiyo.height') and mouseReleased() and getProperty("ukiyo.alpha") == 1 and not cut then
        playSound("credits/ragdoll", 1, 'rag')
        playAnim("ukiyo", "eat", true)
        ukiyoBooped = true
    elseif getMouseX('camOther') > getProperty('boxLogo.x') and getMouseY('camOther') > getProperty('boxLogo.y') and getMouseX('camOther') < getProperty('boxLogo.x') + getProperty('boxLogo.width') and getMouseY('camOther') < getProperty('boxLogo.y') + getProperty('boxLogo.height') and mouseReleased() and not cut then
        callMethodFromClass('backend.CoolUtil', 'browserLoad', {link})
    end
    
    if getMouseX('camOther') > getProperty('boxLogo2.x') and getMouseY('camOther') > getProperty('boxLogo2.y') and getMouseX('camOther') < getProperty('boxLogo2.x') + getProperty('boxLogo2.width') and getMouseY('camOther') < getProperty('boxLogo2.y') + getProperty('boxLogo2.height') and mouseReleased() and getProperty("boxLogo2.visible") and link2 ~= nil then
        callMethodFromClass('backend.CoolUtil', 'browserLoad', {link2})
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
        
    if tag == 'xd' then
        doTweenX("boom", "shi.scale", 1, 0.5, "elasticOut")
        doTweenY("moob", "shi.scale", 1, 0.5, "elasticOut")
    elseif tag == 'ui' then
        playSound("credits/flicker", 1)
        runTimer("ain", 1.8)
    end

    if tag == 'ain' and flashingLights then
        playSound("credits/light_turn_on", 1)
        setProperty("luz.alpha", 0.3)
        setObjectOrder("luz", getObjectOrder("shi") + 1)
        cameraFlash("other", "FFFFFF", 1, true)
        setObjectCamera("cut", 'hud')
        setProperty("cut.alpha", 0.3)
        playSound("credits/thank_you_for_playing", 0, 'music')
        playSound("credits/thank_you_for_muffle_everything_omg_help", 0, 'musicMuffled')
        soundFadeIn("music", 2, 0, 1)
        cut = false
        setPropertyFromClass("flixel.FlxG", "mouse.visible", true)
        runTimer("morse", 300)
    elseif tag == 'ain' and not flashingLights then
        playSound("credits/light_turn_on", 1)
        setProperty("luz.alpha", 0.3)
        setObjectOrder("luz", getObjectOrder("shi") + 1)
        setObjectCamera("cut", 'hud')
        setProperty("cut.alpha", 0.3)
        setProperty("camHUD.alpha", 0)
        setProperty("camOther.alpha", 0)
        doTweenAlpha("bahmeu", "camHUD", 1, 1, "linear")
        doTweenAlpha("meubah", "camOther", 1, 1, "linear")
        playSound("credits/thank_you_for_playing", 0, 'music')
        playSound("credits/thank_you_for_muffle_everything_omg_help", 0, 'musicMuffled')
        soundFadeIn("music", 2, 0, 1)
        cut = false
        setPropertyFromClass("flixel.FlxG", "mouse.alpha", 1)
        runTimer("morse", 300)
    elseif tag == 'morse' then
        numPodeNaoMan = true
        soundFadeOut("music", 0.5, 0)
        soundFadeOut("musicMuffled", 0.5, 0)
        playSound("credits/stickers/shhh/nada_pra_ver_aqui", 1, 'code')
    elseif tag == 'PENIS' then
        itsShiny = false
    end
end

function onUpdatePost(elapsed)
        
    setProperty("shi.angle", getProperty("shi.angle") + 0.5)
    setProperty("box.angle", getProperty("box.angle") + 0.5)

    setProperty("coiso.x", getProperty("coiso.x") + 1)
    setProperty("coiso2.x", getProperty("coiso2.x") - 1)

    if shadersEnabled then
        setShaderFloat('back', 'iTime', os.clock())
    end

    if cut then
        customStep = customStep + 1
    end

    if getProperty("coiso.x") >= screenWidth then
        setProperty("coiso.x", -430)
    elseif getProperty("coiso2.x") <= -430 then
        setProperty("coiso2.x", screenWidth)
    end
end

local the = {'natzy', 'liz', 'ukiyo', 'pica', 'shi'}
local theSticker = {'stickerCom', 'stickerCha', 'stickerAni', 'stickerArt', 'stickerDir', 'stickerPro'}
local theLogo = {'twi', 'sky', 'tumb', 'spo', 'tree'}

function onSoundFinished(tag)
        
    for i = 1, #theSticker do
        if tag == 'music' then
            playSound("credits/thank_you_for_playing", volume2, 'music')
        elseif tag == 'musicMuffled' then
            playSound("credits/thank_you_for_muffle_everything_omg_help", volume, 'musicMuffled')
        elseif tag == 'rag' then
            playAnim("ukiyo", "idle", true)
        elseif tag == 'code' and section == 0 then
            numPodeNaoMan = false
            soundFadeIn("music", 2, 0, 1)
        elseif tag == 'code' and section == 1 then
            numPodeNaoMan = false
            soundFadeIn("musicMuffled", 2, 0, 1)
        elseif tag == 'warp' then
            updateShit = true
            section = 1
            cut = false
            playAnim("sec", "bucks")
            setProperty("sec.y", 0)
            setProperty("camOther.y", 0)
            setProperty("camHUD.y", 0)
            setProperty("camOther.alpha", 0)
            setProperty("camHUD.alpha", 0)
            doTweenAlpha("omaga", "camOther", 1, 1, "linear")
            doTweenAlpha("omagah", "camHUD", 1, 1, "linear")
            setProperty("coiso.alpha", 0.0001)
            setProperty("coiso2.alpha", 1)
            setProperty("gra.alpha", 0.5)
            setProperty("cut.alpha", 0.5)
            setProperty("luz.alpha", 0.0001)
            setProperty(the[pos]..".alpha", 0.0001)
            setProperty(theSticker[i]..".visible", false)
            setProperty("box.visible", false)
            soundFadeIn("musicMuffled", 1, 0, volume2)
        elseif tag == 'praw' then
            updateShit = true
            cut = false
            section = 0
            playAnim("sec", "spe")
            setProperty("sec.y", 655)
            setProperty("camOther.y", 0)
            setProperty("camHUD.y", 0)
            setProperty("camOther.alpha", 0)
            setProperty("camHUD.alpha", 0)
            doTweenAlpha("omaga", "camOther", 1, 1, "linear")
            doTweenAlpha("omagah", "camHUD", 1, 1, "linear")
            setProperty("coiso.alpha", 1)
            setProperty("coiso2.alpha", 0.0001)
            setProperty("gra.alpha", 0.0001)
            setProperty("cut.alpha", 0.3)
            setProperty("luz.alpha", 0.3)
            setProperty("stuff.visible", true)
            setProperty("shortTxt.alpha", 1)
            soundFadeIn("music", 1, 0, volume)
        end
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