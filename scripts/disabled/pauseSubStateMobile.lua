-- this code is shit but idc

--[[
    makeLuaText("", "", 0, 0.0, 0.0)
    setObjectCamera("", '')
    addLuaText("")
    setTextSize("", )
]]

local the = {
    'Resume',
    'Restart song',
    'Exit to menu'
}

local pos = 0
local divi = 100

local frases = {
    {'"I CAN\'T STOP EATING SUSHI MAN!!!"', 34}, -- 1 -- sugestões do Ukiyo
    {'"Are you two the same?"', 23}, -- 2
    {'"The water\'s broken :["', 23}, -- 3
    {'"If you want to rob a bank, you gotta do some planning before you rob a bank"', 77}, -- 4
    {'"Don\'t be a coconut"', 20}, -- 5
    {'"Hello i\'m the EVIL pause menu message! MUAHAHA!!"', 50}, -- 6
    {'"There\'s only one beer left"', 28}, -- 7
    {'"Rollin\' marijuana, that\'s a cheap vacation"', 44}, -- 8
    {'"Don\'t drop the blunt and disrespect the weed"', 56}, -- 9
    {'"Livin\' off borrowed time, the clock ticks faster"', 60}, -- 10
    {'"More cheese than Doritos, Cheetos or Fritos"', 45}, -- 11
    {'"This mod has a Snoop Dogg Seal of Approval™"', 45}, -- 12
    {'𓀖𓀗 𓀘 𓀙 𓀚 𓀛 𓀜 𓀝 𓀞 𓀟 𓀠 𓀡 𓀢 𓀣 𓀤 𓀥 𓀦 𓀧 𓀨 𓀩 𓀪 𓀫 𓀬𓀭 𓀮 𓀯 𓀰', 52}, -- 13 -- isso nem funciona lol -- amigos do Ukiyo mandaram essas
    {'"Also try Terraria!"', 20}, -- 14
    {'"Also try Minecraft!"', 22}, -- 15
    {'"28 STABS!"', 11}, -- 16
    {'"For real life??"', 17}, -- 17 -- eu que escrevi essas B) (Shiho)
    {'"Oh biscuits..."', 16}, -- 18
    {'"I FUCKING LOVE AIR-CONDITIONING!!!"', 36}, -- 19
    {'"This mod is sponsored by Raid Shadow Legends!"', 47}, -- 20
    {'"DAMN DANIEL BACK AT IT AGAIN WITH THE WHITE VANS!!!"', 53}, -- 21
    {'ma balls itch.', 14}, -- 22
    {'"Lemonade... Lemonade... Lemonade... Lemonade... Le-"', 53}, -- 23
    {'"God I love the limited 3D they use for this game. It\'s so charming"', 67}, -- 24
    {'"I\'m kind of a Pokemon!"', 25}, -- 25
    {'"Tornado penis."', 16}, -- 26
    {'"Hello Kitty banger mod"', 24}, -- 27
    {'"num seio"', 10}, -- 28 -- amigos meus (Shiho) mandaram essas
    {'"Aos oprimidos é permitido uma vez a cada poucos anos decidir quais representantes específicos da classe opressora devem representá-los e reprimi-los."', 151}, -- 29
    {'Are you going to play seriously now?', 36}, -- 30 -- sugestões da Liz
    {'I love eating grass', 19}, -- 31
    {'Did the pizza arrive?? :D', 25}, -- 32
    {'It\'s ok to give up man, just relax and come back later ;)', 57}, -- 33 -- sugestões da Natzy
    {'WHY DID YOU PAUSE?!?! THIS IS THE BEST PART!!!!', 47}, -- 34 -- frases especiais
    {'Seriously? You\'re going to restart because you missed one note??? -_-', 69} -- 35
}

local special = false
local relax = 0 -- um dia eu descubro como fazer isso funfar
local spc = 0

function onCreate()

    local var ShaderName = 'gray'
    if shadersEnabled then  
        initLuaShader(ShaderName)
        makeLuaSprite('camShader', nil)
        makeGraphic('camShader', screenWidth, screenHeight)
        setSpriteShader('camShader', ShaderName)
    else
        ShaderName = 'none'
    end
end

function onCountdownStarted()
    
    setPropertyFromClass("flixel.FlxG", "mouse.visible", false)
end

function onTimerCompleted(tag)

    --[[if tag == 'beat' then
        setProperty("camOther.zoom", 1.05)
        doTweenZoom("zoom", "camOther", 1, 0.8, "quartOut")
        setProperty("camGame.zoom", 1.05)
        doTweenZoom("zoo", "camGame", 1, 0.8, "quartOut")
    end]]

    if tag == 'boom' then
        doTweenAlpha("a", "noWay", 0, 0.6, "linear")
        runTimer("moob", 0.6)
    elseif tag == 'moob' then
        doTweenAlpha("a", "noWay", 1, 0.6, "linear")
        runTimer("boom", 0.6)
    elseif tag == 'reset' then
        objectPlayAnimation("buttonD", "idle")
        objectPlayAnimation("buttonU", "idle")
    end
end

function onUpdate(elapsed)
    
    if misses == 1 then
        spc = 35
    elseif special == true then
        spc = 34
    elseif relax > 20 then
        spc = 33
    end
end

function onPause()
    
    openCustomSubstate('pauseShit', true);
    return Function_Stop;
end

function onCustomSubstateCreate(name)
    
    if name == 'pauseShit' then

        setPropertyFromClass("flixel.FlxG", "mouse.visible", true)

        if special or misses == 1 or relax > 20 then
            curFrase = frases[spc][1]
        else
            curFrase = frases[getRandomInt(0, 33)][1]
        end
        
        playSound("pause-theme", 0, 'bah')
        soundFadeIn("bah", 5, 0, 0.2)
        characterPlayAnim("boyfriend", "singDOWNmiss", true)

        makeLuaSprite("escu")
        makeGraphic("escu", screenWidth, screenHeight, '000000')
        setObjectCamera("escu", 'other')
        addLuaSprite("escu")
        setProperty("escu.alpha", 0)
        setProperty("escu.visible", false)

        makeLuaText("resu", the[1], 0, 0.0, 0.0)
        makeLuaText("resta", the[2], 0, 0.0, 0.0)
        makeLuaText("exit", the[3], 0, 0.0, 0.0)
        makeLuaText("seta", ">", 0, 0.0, 0.0)
        makeLuaText("setaa", "<", 0, 0.0, 0.0)
        setObjectCamera("resu", 'other')
        setObjectCamera("resta", 'other')
        setObjectCamera("exit", 'other')
        setObjectCamera("seta", 'other')
        setObjectCamera("setaa", 'other')
        addLuaText("resu")
        addLuaText("resta")
        addLuaText("exit")
        addLuaText("seta")
        addLuaText("setaa")
        setTextSize("resu", 50)
        setTextSize("resta", 50)
        setTextSize("exit", 50)
        setTextSize("seta", 50)
        setTextSize("setaa", 50)
        screenCenter("resu", 'x')
        setProperty("resu.y", getGraphicMidpointY("escu") - divi)
        screenCenter("resta")
        screenCenter("exit", 'x')
        setProperty("exit.y", getGraphicMidpointY("escu") + divi - 50)

        makeLuaText("compo", songName..' ('..difficultyName..')'.." by: "..getTextFromFile('data/'..songName..'/composer-'..difficultyName..'.txt')..' | Pause Theme by: LizNaithy'..' | Art by: '..getTextFromFile('data/'..songName..'/artist-'..difficultyName..'.txt')..' | Chart and Coding by: '..getTextFromFile('data/'..songName..'/charter-coder-'..difficultyName..'.txt'), 0, -1800, -20)
        setObjectCamera("compo", 'other')
        addLuaText("compo")
        setTextSize("compo", 25)
        doTweenY("lol", "compo", 0, 0.5, "quartOut")

        makeLuaText("morri", curFrase, 0, 1300, 740)
        setObjectCamera("morri", 'other')
        addLuaText("morri")
        setTextSize("morri", 25)
        doTweenY("lololol", "morri", 694.6, 0.5, "quartOut")

        makeLuaText("noWay", "- PAUSED -", 0, 0.0, 100)
        setObjectCamera("noWay", 'other')
        addLuaText("noWay")
        setTextSize("noWay", 70)
        screenCenter("noWay", 'x')
        setTextAlignment("noWay", 'center')

        makeLuaSprite("barr", '', 0, -20)
        makeGraphic("barr", screenWidth, 25, '000000')
        setObjectCamera("barr", 'other')
        addLuaSprite("barr", false)
        doTweenY("xd", "barr", 0, 0.5, "quartOut")

        makeLuaSprite("balls", '', 0, 740)
        makeGraphic("balls", screenWidth, 25, '000000')
        setObjectCamera("balls", 'other')
        addLuaSprite("balls", false)
        doTweenY("xdd", "balls", 694.6, 0.5, "quartOut")

        --runTimer("beat", 0.85, 0)
        runTimer("boom", 0.5)

        makeAnimatedLuaSprite("buttonD", 'virtualpad', 0, 560)
        addAnimationByPrefix("buttonD", "pressed", "downPress", 0, false)
        addAnimationByPrefix("buttonD", "idle", "down", 0, false)
        setObjectCamera("buttonD", 'other')
        addLuaSprite("buttonD", true)
        setProperty("buttonD.alpha", 0.5)

        makeAnimatedLuaSprite("buttonU", 'virtualpad', 0, 430)
        addAnimationByPrefix("buttonU", "pressed", "upPress", 0, false)
        addAnimationByPrefix("buttonU", "idle", "up", 0, false)
        setObjectCamera("buttonU", 'other')
        addLuaSprite("buttonU", true)
        setProperty("buttonU.alpha", 0.5)

        makeAnimatedLuaSprite("buttonA", 'virtualpad', 1155, 560)
        addAnimationByPrefix("buttonA", "pressed", "aPress", 10, false)
        addAnimationByPrefix("buttonA", "idle", "a", 0, false)
        setObjectCamera("buttonA", 'other')
        addLuaSprite("buttonA", true)
        setProperty("buttonA.alpha", 0.5)
    end
end

function onCustomSubstateUpdatePost(name, elapsed)
    
    if name == 'pauseShit' then

        doTweenAlpha("ven", "escu", 0.5, 0.5, "linear")
        setProperty("escu.visible", true)
        setProperty("resu.visible", true)
        setProperty("resta.visible", true)
        setProperty("exit.visible", true)
        setProperty("seta.visible", true)
        setProperty("setaa.visible", true)
        setProperty("compo.visible", true)
        setProperty("barr.visible", true)
        setProperty("balls.visible", true)
        setProperty("noWay.visible", true)
        setProperty("buttonD.visible", true)
        setProperty("buttonU.visible", true)
        setProperty("buttonA.visible", true)

        setProperty("compo.x", getProperty("compo.x") + 1)
        setProperty("morri.x", getProperty("morri.x") - 1)
        
        if getProperty("compo.x") == screenWidth then
            setProperty("compo.x", -1800)
        end
        
        if getProperty("morri.x") == -450 and getTextString("morri") == frases[2][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[3][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[5][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[7][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[14][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[15][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[16][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[17][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[18][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[22][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[25][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[26][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[28][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[27][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[31][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[32][1] then -- 🤮
            setProperty("morri.x", 1300)
        elseif getProperty("morri.x") == -1100 and getTextString("morri") == frases[33][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[24][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[6][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[7][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[8][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[9][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[10][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[11][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[12][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[13][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[20][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[21][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[23][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[34][1] then -- 🤮🤮
            setProperty("morri.x", 1300)
        elseif getProperty("morri.x") == -570 and getTextString("morri") == frases[30][1] or getProperty("morri.x") == -570 and getTextString("morri") == frases[19][1] then
            setProperty("morri.x", 1300)
        elseif getProperty("morri.x") == -1200 and getTextString("morri") == frases[4][1] or getProperty("morri.x") == -1200 and getTextString("morri") == frases[35][1] then
            setProperty("morri.x", 1300)
        elseif getProperty("morri.x") == -2280 and getTextString("morri") == frases[29][1] then
            setProperty("morri.x", 1300)
        end

        if pos == 0 then
            setProperty("seta.x", getProperty("resu.x") - 50)
            setProperty("seta.y", getProperty("resu.y"))
            setProperty("setaa.x", getProperty("resu.x") + 190)
            setProperty("setaa.y", getProperty("resu.y"))
            setProperty("resta.alpha", 0.5)
            setProperty("exit.alpha", 0.5)
            setProperty("resu.alpha", 1)
        elseif pos == 1 then
            setProperty("seta.x", getProperty("resta.x") - 50)
            screenCenter("seta", 'y')
            setProperty("setaa.x", getProperty("resta.x") + 365)
            screenCenter("setaa", 'y')
            setProperty("resu.alpha", 0.5)
            setProperty("exit.alpha", 0.5)
            setProperty("resta.alpha", 1)
        elseif pos == 2 then
            setProperty("seta.x", getProperty("exit.x") - 50)
            setProperty("seta.y", getProperty("exit.y"))
            setProperty("setaa.x", getProperty("exit.x") + 365)
            setProperty("setaa.y", getProperty("exit.y"))
            setProperty("resta.alpha", 0.5)
            setProperty("resu.alpha", 0.5)
            setProperty("exit.alpha", 1)
        elseif pos > 2 then
            pos = 0
        elseif pos < 0 then
            pos = 2
        end

        if getMouseX('camOther') > getProperty('buttonD.x') and getMouseY('camOther') > getProperty('buttonD.y') and getMouseX('camOther') < getProperty('buttonD.x') + getProperty('buttonD.width') and getMouseY('camOther') < getProperty('buttonD.y') + getProperty('buttonD.height') and mouseReleased() then
            pos = pos + 1
            playSound("Metronome_Tick", 0.5, 'tick')
            objectPlayAnimation("buttonD", "pressed")
            runTimer("reset", 0.1)
        elseif getMouseX('camOther') > getProperty('buttonU.x') and getMouseY('camOther') > getProperty('buttonU.y') and getMouseX('camOther') < getProperty('buttonU.x') + getProperty('buttonU.width') and getMouseY('camOther') < getProperty('buttonU.y') + getProperty('buttonU.height') and mouseReleased() then
            pos = pos - 1
            playSound("Metronome_Tick", 0.5, 'tick')
            objectPlayAnimation("buttonU", "pressed")
            runTimer("reset", 0.1)
        end

        if shadersEnabled then
            runHaxeCode([[
                trace(game.getLuaObject('camShader').shader + ' Has Been Loaded!');                      
                FlxG.game.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
            ]])
        setShaderFloat('camShader', 'iTime', os.clock())
    end

        if getMouseX('camOther') > getProperty('buttonA.x') and getMouseY('camOther') > getProperty('buttonA.y') and getMouseX('camOther') < getProperty('buttonA.x') + getProperty('buttonA.width') and getMouseY('camOther') < getProperty('buttonA.y') + getProperty('buttonA.height') and mouseReleased() and pos == 0 then
            closeCustomSubstate()
            stopSound("bah")
            setProperty("escu.visible", false)
            setProperty("resu.visible", false)
            setProperty("resta.visible", false)
            setProperty("exit.visible", false)
            setProperty("seta.visible", false)
            setProperty("setaa.visible", false)
            setProperty("compo.visible", false)
            setProperty("barr.visible", false)
            setProperty("balls.visible", false)
            setProperty("morri.visible", false)
            setProperty("noWay.visible", false)
            setProperty("buttonD.visible", false)
            setProperty("buttonU.visible", false)
            setProperty("buttonA.visible", false)
            setPropertyFromClass("flixel.FlxG", "mouse.visible", false)
            objectPlayAnimation("buttonA", "pressed")
            runHaxeCode([[
                FlxG.game.setFilters([]);
            ]])
        elseif getMouseX('camOther') > getProperty('buttonA.x') and getMouseY('camOther') > getProperty('buttonA.y') and getMouseX('camOther') < getProperty('buttonA.x') + getProperty('buttonA.width') and getMouseY('camOther') < getProperty('buttonA.y') + getProperty('buttonA.height') and mouseReleased() and pos == 1 then
            restartSong(false)
            objectPlayAnimation("buttonA", "pressed")
            setPropertyFromClass("flixel.FlxG", "mouse.visible", false)
        elseif getMouseX('camOther') > getProperty('buttonA.x') and getMouseY('camOther') > getProperty('buttonA.y') and getMouseX('camOther') < getProperty('buttonA.x') + getProperty('buttonA.width') and getMouseY('camOther') < getProperty('buttonA.y') + getProperty('buttonA.height') and mouseReleased() and pos == 2 then
            exitSong(false)
            objectPlayAnimation("buttonA", "pressed")
            setPropertyFromClass("flixel.FlxG", "mouse.visible", false)
        end
    end
end

function onSoundFinished(tag)
    
    if tag == 'bah' then
        playSound("pause-theme", 0.2, 'bah')
    end
end

function onDestroy()
    setDataFromSave("giveUp", "relax", 0)
    if shadersEnabled then
        runHaxeCode([[
            FlxG.game.setFilters([]);
        ]])
    end
end

function onSectionHit()

    if curSection == 24 and songName == 'KittyJam' and difficultyName == 'buck' then
        special = true
    elseif curSection == 32 and songName == 'KittyJam' and difficultyName == 'buck' then
        special = false
    elseif curSection == 48 and songName == 'KittyJam' and difficultyName == 'buck' then
        special = true
    elseif curSection == 64 and songName == 'KittyJam' and difficultyName == 'buck' then
        special = false
    elseif curSection == 36 and songName == 'KittyJam' and difficultyName == 'erect' then
        special = true
    elseif curSection == 54 and songName == 'KittyJam' and difficultyName == 'erect' then
        special = false
    elseif curSection == 117 and songName == 'KittyJam' and difficultyName == 'erect' then
        special = true
    end
end