-- this code is held by glue and tape (sorry for the nightmares code experts)
luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

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
    {'Hello i\'m the EVIL pause menu message! MUAHAHA!!', 50}, -- 6
    {'"There\'s only one beer left"', 28}, -- 7
    {'"Rollin\' marijuana, that\'s a cheap vacation"', 44}, -- 8
    {'"Don\'t drop the blunt and disrespect the weed"', 56}, -- 9
    {'"Livin\' off borrowed time, the clock ticks faster"', 60}, -- 10
    {'"More cheese than Doritos, Cheetos or Fritos"', 45}, -- 11
    {'This mod has a Snoop Dogg Seal of Approval™', 45}, -- 12
    {'𓀖𓀗 𓀘 𓀙 𓀚 𓀛 𓀜 𓀝 𓀞 𓀟 𓀠 𓀡 𓀢 𓀣 𓀤 𓀥 𓀦 𓀧 𓀨 𓀩 𓀪 𓀫 𓀬𓀭 𓀮 𓀯 𓀰', 52}, -- 13 -- isso nem funciona lol -- amigos do Ukiyo mandaram essas
    {'Also try Terraria!', 20}, -- 14
    {'Also try Minecraft!', 22}, -- 15
    {'"28 STABS!"', 11}, -- 16
    {'"For real life??"', 17}, -- 17 -- eu que escrevi essas B) (Shiho)
    {'"Oh biscuits..."', 16}, -- 18
    {'"I FUCKING LOVE AIR-CONDITIONING!!!"', 36}, -- 19
    {'This mod is sponsored by Raid Shadow Legends!', 47}, -- 20
    {'"DAMN DANIEL BACK AT IT AGAIN WITH THE WHITE VANS!!!"', 53}, -- 21
    {'ma balls itch.', 14}, -- 22
    {'"Lemonade... Lemonade... Lemonade... Lemonade... Le-"', 53}, -- 23
    {'"God I love the limited 3D they use for this game. It\'s so charming"', 67}, -- 24
    {'"I\'m kind of a Pokemon!"', 25}, -- 25
    {'"Tornado penis."', 16}, -- 26
    {'Hello Kitty banger mod', 24}, -- 27
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

local ogX = -1550

local volte = false
local velocidade = nil

function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local parsed = parseJson('data/stuff.json')
local nameShit = parseJson('characters/'..dadName..'.json')

function onCreate()

    if songName == 'credits' then
        setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Credits Menu')
    else
        setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName)
    end

    if difficultyName == 'erect' then
        setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName..' Erect')
    else
        setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName)
    end

    --[[local var ShaderName = 'gray'
    if shadersEnabled then  
        initLuaShader(ShaderName)
        makeLuaSprite('camShader', nil)
        makeGraphic('camShader', screenWidth, screenHeight)
        setSpriteShader('camShader', ShaderName)
    else
        ShaderName = 'none'
    end]]

    saveFile("mods/KittyBucks/data/playbackRateSave.txt", playbackRate, true)

    velocidade = getTextFromFile("data/playbackRateSave.txt")
    
    makeLuaSprite("escu")
    makeGraphic("escu", screenWidth, screenHeight, '000000')
    setObjectCamera("escu", 'other')
    addLuaSprite("escu")
    setProperty("escu.alpha", 0)
    setProperty("escu.visible", false)

    makeLuaText("resu", the[1], 0, -310, 0.0)
    makeLuaText("resta", the[2], 0, -400, 0.0)
    makeLuaText("exit", the[3], 0, -380, 0.0)
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
    setTextSize("resu", 65)
    setTextSize("resta", 65)
    setTextSize("exit", 65)
    setTextSize("seta", 65)
    setTextSize("setaa", 65)
    screenCenter("resta", 'y')
    setProperty("resu.y", getGraphicMidpointY("escu") - 120)
    --[[screenCenter("resu", 'x')
    screenCenter("exit", 'x')]]
    setProperty("exit.y", getGraphicMidpointY("escu") + 60)

    makeLuaText("noWay", "- PAUSED -", 0, 0.0, 50)
    setObjectCamera("noWay", 'other')
    setTextSize("noWay", 70)
    screenCenter("noWay", 'x')
    addLuaText("noWay")

    makeLuaSprite("barr", '', 0, -20)
    makeGraphic("barr", screenWidth, 25, '000000')
    setObjectCamera("barr", 'other')
    addLuaSprite("barr", false)

    makeLuaSprite("balls", '', 0, 740)
    makeGraphic("balls", screenWidth, 25, '000000')
    setObjectCamera("balls", 'other')
    addLuaSprite("balls", false)

    makeLuaSprite('BGmoving','pause_score',0,0);
    setObjectCamera('BGmoving','other');
    setProperty("BGmoving.visible", false)
    addLuaSprite('BGmoving', false);

    makeLuaSprite("char", 'pause_'..nameShit.pauseImageName, screenWidth, 0)
    setObjectCamera("char", 'other')
    scaleObject("char", 0.55, 0.55)
    setProperty("char.angle", 90)
    screenCenter("char", 'y')
    addLuaSprite("char", true)

    setTextFont("resu", "drunkenhourDEMO.otf")
    setTextBorder("resu", 0, "FFFFFF")
    setTextFont("resta", "drunkenhourDEMO.otf")
    setTextBorder("resta", 0, "FFFFFF")
    setTextFont("exit", "drunkenhourDEMO.otf")
    setTextBorder("exit", 0, "FFFFFF")
    setTextFont("seta", "drunkenhourDEMO.otf")
    setTextBorder("seta", 0, "FFFFFF")
    setTextFont("setaa", "drunkenhourDEMO.otf")
    setTextBorder("setaa", 0, "FFFFFF")
    setTextFont("noWay", "drunkenhourDEMO.otf")
    setTextBorder("noWay", 0, "FFFFFF")

    if songName == 'KittyJam' and difficultyName == 'erect' then
        makeLuaText("compo", songName..' ('..difficultyName..')'.." by: "..parsed.composer[2]..' | Pause Theme by: LizNaithy'..' | Art by: '..parsed.artist[2]..' | Chart and Coding by: '..parsed.coder, 0, -1965, -20)
        setObjectCamera("compo", 'other')
        addLuaText("compo")
        setTextSize("compo", 25)
        --[[setTextFont("compo", "drunkenhourDEMO.otf")
        setTextBorder("compo", 0, "FFFFFF")]]
        ogX = -1965
    else
        makeLuaText("compo", songName..' ('..difficultyName..')'.." by: "..parsed.composer[1]..' | Pause Theme by: LizNaithy'..' | Art by: '..parsed.artist[1]..' | Chart and Coding by: '..parsed.coder, 0, -1550, -20)
        setObjectCamera("compo", 'other')
        addLuaText("compo")
        setTextSize("compo", 25)
        --[[setTextFont("compo", "drunkenhourDEMO.otf")
        setTextBorder("compo", 0, "FFFFFF")]]
        ogX = -1550
    end
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
    end
end

function onUpdate(elapsed)

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
    setProperty("BGmoving.visible", false)
    setProperty("char.visible", false)

    if songName == 'credits' then
        setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Credits Menu')
    end
    
    if misses == 1 then
        spc = 35
    elseif special == true then
        spc = 34
    elseif relax > 20 then
        spc = 33
    end
end

function onUpdatePost(elapsed)
    
    if volte then
        setProperty("playbackRate", playbackRate + 0.01)
    end

    if playbackRate >= 1 then
        setProperty("playbackRate", velocidade)
        volte = false
    end
end

function onPause()
    
    openCustomSubstate('pauseShit', true);
    return Function_Stop;
end

function onCustomSubstateCreatePost(name)
    
    if name == 'pauseShit' then

        playSound("pause/pause-theme", 0, 'bah')
        soundFadeIn("bah", 5, 0, 0.2)
        --playAnim("boyfriend", "singDOWNmiss", true)

        doTweenY("lol", "compo", 0, 0.5, "quartOut")
        doTweenY("xdd", "balls", 694.6, 0.5, "quartOut")
        doTweenY("xd", "barr", 0, 0.5, "quartOut")
        doTweenX("resuX", "resu", 190, 1, "quartOut")
        doTweenX("restaX", "resta", 100, 1, "quartOut")
        doTweenX("exitX", "exit", 80, 1, "quartOut")
        doTweenX("charX", "char", 800, 1, "quartOut")
        doTweenAngle("charAngle", "char", 10, 1, "quartOut")

        --runTimer("beat", 0.85, 0)
        runTimer("boom", 0.5)

        if special or misses == 1 or relax > 20 then
            curFrase = frases[spc][1]
        else
            curFrase = frases[getRandomInt(0, 33)][1]
        end

        makeLuaText("morri", curFrase, 0, 1300, 740)
        setObjectCamera("morri", 'other')
        addLuaText("morri")
        setTextSize("morri", 25)
        --[[setTextFont("morri", "drunkenhourDEMO.otf")
        setTextBorder("morri", 0, "FFFFFF")]]
        doTweenY("lololol", "morri", 694.6, 0.5, "quartOut")

        if difficultyName == 'erect' then
            setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName..' Erect (PAUSED)')
        else
            setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName..' (PAUSED)')
        end
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
        setProperty("balls.visible", true)
        setProperty("noWay.visible", true)
        setProperty("BGmoving.visible", true)
        setProperty("char.visible", true)
        setProperty("buttonA.alpha", 0.5)
        setProperty("buttonD.alpha", 0.5)
        setProperty("buttonU.alpha", 0.5)

        setProperty("compo.x", getProperty("compo.x") + 1)
        setProperty("morri.x", getProperty("morri.x") - 1)

        setProperty('BGmoving.x',getProperty('BGmoving.x') - 1);
        setProperty('BGmoving.y',getProperty('BGmoving.y') - screenHeight/screenWidth);
        if getProperty('BGmoving.x') <= -screenWidth + 1 then
            setProperty('BGmoving.x',0);
        end

        if getProperty('BGmoving.y') <= -screenHeight + 1 then
            setProperty('BGmoving.y',0);
        end
        
        if getProperty("compo.x") == screenWidth then
            setProperty("compo.x", ogX)
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
            setProperty("setaa.x", getProperty("resu.x") + 265)
            setProperty("setaa.y", getProperty("resu.y"))
            setProperty("resta.alpha", 0.5)
            setProperty("exit.alpha", 0.5)
            setProperty("resu.alpha", 1)
            setTextColor("resu", "FFFFFF")
            setTextColor("resta", "000000")
            setTextColor("exit", "000000")
        elseif pos == 1 then
            setProperty("seta.x", getProperty("resta.x") - 50)
            screenCenter("seta", 'y')
            setProperty("setaa.x", getProperty("resta.x") + 460)
            screenCenter("setaa", 'y')
            setProperty("resu.alpha", 0.5)
            setProperty("exit.alpha", 0.5)
            setProperty("resta.alpha", 1)
            setTextColor("resu", "000000")
            setTextColor("resta", "FFFFFF")
            setTextColor("exit", "000000")
        elseif pos == 2 then
            setProperty("seta.x", getProperty("exit.x") - 50)
            setProperty("seta.y", getProperty("exit.y"))
            setProperty("setaa.x", getProperty("exit.x") + 515)
            setProperty("setaa.y", getProperty("exit.y"))
            setProperty("resta.alpha", 0.5)
            setProperty("resu.alpha", 0.5)
            setProperty("exit.alpha", 1)
            setTextColor("resu", "000000")
            setTextColor("resta", "000000")
            setTextColor("exit", "FFFFFF")
        elseif pos > 2 then
            pos = 0
        elseif pos < 0 then
            pos = 2
        end

        if keyboardJustPressed("S") or keyboardJustPressed("DOWN") or gamepadJustPressed(1, "DPAD_DOWN") or gamepadJustPressed(1, "LEFT_STICK_DIGITAL_DOWN") or downJustPressed and buildTarget == 'windows' then
            pos = pos + 1
            playSound("scrollMenu", 0.5, 'tick')
            runTimer("reset", 0.1)
        elseif keyboardJustPressed("W") or keyboardJustPressed("UP") or gamepadJustPressed(1, "DPAD_UP") or gamepadJustPressed(1, "LEFT_STICK_DIGITAL_UP") or upJustPressed and buildTarget == 'windows' then
            pos = pos - 1
            playSound("scrollMenu", 0.5, 'tick')
            runTimer("reset", 0.1)
        end
    end

       --[=[ if shadersEnabled then
            runHaxeCode([[                    
                FlxG.game.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
            ]])
        setShaderFloat('camShader', 'iTime', os.clock())
    end]=]

        if keyboardJustPressed("ENTER") and pos == 0 and difficultyName == 'erect' or keyboardJustPressed("SPACE") and pos == 0 and difficultyName == 'erect' or gamepadJustPressed(1, "A") and pos == 0 and difficultyName == 'erect' then
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
            setProperty("BGmoving.visible", false)
            setProperty("char.visible", false)
            --[=[runHaxeCode([[
                FlxG.game.setFilters([]);
            ]])]=]
            setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName..' Erect')
            setProperty("barr.y", -20)
            setProperty("compo.y", -20)
            setProperty("balls.y", 740)
            setProperty("morri.y", 740)
            setProperty("playbackRate", 0.1)
            volte = true
        elseif keyboardJustPressed("ENTER") and pos == 0 or keyboardJustPressed("SPACE") and pos == 0 or gamepadJustPressed(1, "A") and pos == 0 then
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
            setProperty("BGmoving.visible", false)
            setProperty("char.visible", false)
            --[=[runHaxeCode([[
                FlxG.game.setFilters([]);
            ]])]=]
            setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName)
            setProperty("barr.y", -20)
            setProperty("compo.y", -20)
            setProperty("balls.y", 740)
            setProperty("morri.y", 740)
            setProperty("playbackRate", 0.1)
            volte = true
        elseif keyJustPressed('accept') and pos == 1 then
            restartSong(false)
        elseif keyJustPressed('accept') and pos == 2 then
            exitSong(false)
        end
    end
--end

function onSoundFinished(tag)
    
    if tag == 'bah' then
        playSound("pause/pause-theme", 0.2, 'bah')
    end
end

function onDestroy()
    setPropertyFromClass("openfl.Lib", "application.window.title", 'Friday Night Funkin\': Psych Engine')
end
    --[=[if shadersEnabled then
        runHaxeCode([[
            FlxG.game.setFilters([]);
        ]])
    end
end]=]

function onCountdownStarted()

    if songName == 'credits' then
        setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Credits Menu')
    else
        setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName)
    end

    if difficultyName == 'erect' then
        setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName..' Erect')
    else
        setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName)
    end
end

function onGameOver()
    
    setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Game Over')
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