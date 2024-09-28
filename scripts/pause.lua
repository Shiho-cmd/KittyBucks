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

-- discord rpc stuff --

function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local parsed = parseJson('data/stuff.json')

function onCreate()

    if songName == 'KittyJam' and difficultyName == 'buck' then
        min = parsed.kittyjam[1]
        sec = parsed.kittyjam[2]
    else
        min = parsed.kittyjamErect[1]
        sec = parsed.kittyjamErect[2]
    end

    if songName == 'SuperNova' then
        min = parsed.supernova[1]
        sec = parsed.supernova[2]
    end

        makeLuaText("socorro")
        addLuaText("socorro")
        setProperty("socorro.visible", false)

        initSaveData("morteMorrida")
        deathCounter = getDataFromSave("morteMorrida", "atumalaca")

        local var ShaderName = 'gray'
        if shadersEnabled then  
            initLuaShader(ShaderName)
            makeLuaSprite('camShader', nil)
            makeGraphic('camShader', screenWidth, screenHeight)
            setSpriteShader('camShader', ShaderName)
        else
            ShaderName = 'none'
        end

    if botPlay then
        makeLuaText("presence", 'Playing: '..songName..' '..'('..difficultyName..')'..' With BotPlay on (skill issue)')
        addLuaText("presence")
        setProperty("presence.visible", false)
    else
        makeLuaText("presence", 'Playing: '..songName..' '..'('..difficultyName..')')
        addLuaText("presence")
        setProperty("presence.visible", false)
    end
end

function onUpdate(elapsed)

    changeDiscordClientID('1246615253203288165')
    changeDiscordPresence(getTextString("presence"), getTextString("socorro"), "mini-icon-kitty")
end

function onSongStart()

    runTimer('countdown', 1, 9999)
end

function onTimerCompleted(tag)

    --[[if tag == 'beat' then
        setProperty("camOther.zoom", 1.05)
        doTweenZoom("zoom", "camOther", 1, 0.8, "quartOut")
        setProperty("camGame.zoom", 1.05)
        doTweenZoom("zoo", "camGame", 1, 0.8, "quartOut")
    end]]

    if tag == 'countdown' then
        if sec ~= -1 then
            sec = sec - 1
        end

        if sec == -1 then
            if min ~= 0 then
                min = min - 1
                sec = 59
            end
            
            if min == 0 and sec == 0 then
                return
            end
        end
    end
end

function onEndSong()
    
    changeDiscordClientID('863222024192262205')
    setDataFromSave("morteMorrida", "atumalaca", 0)
end

function onUpdatePost()

    setTextString('socorro', min .. ':' .. sec..' Left')
end

-- pause stuff --

function onPause()
    
    openCustomSubstate('pauseShit', true);
    return Function_Stop;
end

function onCustomSubstateCreatePost(name)
    
    if name == 'pauseShit' then

        playSound("placeholder", 0, 'bah')
        soundFadeIn("bah", 3, 0, 1)
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

        makeLuaText("compo", songName..' ('..difficultyName..')'.." by: "..getTextFromFile('data/'..songName..'/composer-'..difficultyName..'.txt')..' | Art by: '..getTextFromFile('data/'..songName..'/artist-'..difficultyName..'.txt')..' | Chart and Coding by: '..getTextFromFile('data/'..songName..'/charter-coder-'..difficultyName..'.txt'), 0, -1300, -20)
        setObjectCamera("compo", 'other')
        addLuaText("compo")
        setTextSize("compo", 25)
        doTweenY("lol", "compo", 0, 0.5, "quartOut")

        makeLuaText("morri", 'Blueballed: '..getDataFromSave("morteMorrida", "atumalaca"), 0, 1300, 740)
        setObjectCamera("morri", 'other')
        addLuaText("morri")
        setTextSize("morri", 25)
        doTweenY("lololol", "morri", 694.6, 0.5, "quartOut")

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

        setProperty("compo.x", getProperty("compo.x") + 1)
        setProperty("morri.x", getProperty("morri.x") - 1)
        
        if getProperty("compo.x") == screenWidth then
            setProperty("compo.x", -1300)
        end
        
        if getProperty("morri.x") == -200 then
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

        if keyboardJustPressed("S") or keyboardJustPressed("DOWN") then
            pos = pos + 1
            playSound("Metronome_Tick", 0.5, 'tick')
        elseif keyboardJustPressed("W") or keyboardJustPressed("UP") then
            pos = pos - 1
            playSound("Metronome_Tick", 0.5, 'tick')
        end

        if shadersEnabled then
            runHaxeCode([[
                trace(game.getLuaObject('camShader').shader + ' Has Been Loaded!');                      
                FlxG.game.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
            ]])
        setShaderFloat('camShader', 'iTime', os.clock())
    end

        if keyJustPressed("accept") and pos == 0 then
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
            runHaxeCode([[
                FlxG.game.setFilters([]);
            ]])
            paused = false
        elseif keyJustPressed('accept') and pos == 1 then
            restartSong(false)
        elseif keyJustPressed('accept') and pos == 2 then
            exitSong(false)
        end
    end
end

function onSoundFinished(tag)
    
    if tag == 'bah' then
        playSound("placeholder", 1, 'bah')
    end
end

function onDestroy()
    --setDataFromSave("morteMorrida", "atumalaca", 0)
    if shadersEnabled then
        runHaxeCode([[
            FlxG.game.setFilters([]);
        ]])
    end
end

function onGameOverStart()
    
    setDataFromSave("morteMorrida", "atumalaca", deathCounter + 1)
end