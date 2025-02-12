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

local special = false
local relax = 0 -- um dia eu descubro como fazer isso funfar
local spc = 0

local volte = false
local velocidade = nil

function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local parsed = parseJson('data/stuff.json')
local rpc = parseJson('data/'..songPath..'/songData-'..difficultyName..'.json')
local minIcon = rpc.rpcMiniIconPause
local data = parseJson('data/'..songPath..'/songData-'..difficultyName..'.json')

local thingsON = nil

function onCreate()

    if instakillOnMiss and practice and botPlay then
        thingsON = 'INSTAKILL ON MISS > PRACTICE MODE > BOTPLAY'
    elseif instakillOnMiss and practice then
        thingsON = 'INSTAKILL ON MISS > PRACTICE MODE'
    elseif instakillOnMiss and botPlay then
        thingsON = 'INSTAKILL ON MISS > BOTPLAY'
    elseif instakillOnMiss then
        thingsON = 'INSTAKILL ON MISS'
    elseif practice and botPlay then
        thingsON = 'PRACTICE MODE > BOTPLAY'
    elseif practice then
        thingsON = 'PRACTICE MODE'
    elseif botPlay then
        thingsON = 'BOTPLAY'
    end

    if songPath == 'credits' then
        setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Credits Menu')
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
    addLuaText("noWay")

    makeLuaSprite("barr", '', 0, -20)
    makeGraphic("barr", screenWidth, 25, '000000')
    setObjectCamera("barr", 'other')
    addLuaSprite("barr", false)

    makeLuaSprite("balls", '', 0, 740)
    makeGraphic("balls", screenWidth, 25, '000000')
    setObjectCamera("balls", 'other')
    addLuaSprite("balls", false)

    makeLuaSprite('BGmoving','pause/pause_score',0,0);
    setObjectCamera('BGmoving','other');
    setProperty("BGmoving.alpha", 0.00001)
    addLuaSprite('BGmoving', false);

    makeLuaSprite("char", 'pause/covers/'..data.pauseCover, screenWidth, 0)
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

    makeLuaText("compo", songName..' ('..string.upper(difficultyName)..')'.." by: "..data.composer..' | Pause Theme by: LizNaithy'..' | Art by: '..data.artist..' | Chart and Coding by: '..data.coder, 0, data.pauseTxtPos, -20)
    setObjectCamera("compo", 'other')
    addLuaText("compo")
    setTextSize("compo", 25)

    makeLuaText("morri", '', 0, 1300, 740)
    setObjectCamera("morri", 'other')
    addLuaText("morri")
    setTextSize("morri", 25)

    setProperty("escu.alpha", 0.00001)
    setProperty("resu.alpha", 0.00001)
    setProperty("resta.alpha", 0.00001)
    setProperty("exit.alpha", 0.00001)
    setProperty("seta.alpha", 0.00001)
    setProperty("setaa.alpha", 0.00001)
    setProperty("compo.alpha", 0.00001)
    setProperty("barr.alpha", 0.00001)
    setProperty("balls.alpha", 0.00001)
    setProperty("morri.alpha", 0.00001)
    setProperty("noWay.x", -999)
    setProperty("BGmoving.alpha", 0.00001)
    setProperty("char.alpha", 0.00001)

    playSound("pause/pause-theme", 0, 'bah')
    pauseSound("bah")

    if thingsON ~= nil then
        makeLuaText("check", 'Gameplay modifiers: \n'..thingsON, 0, 0.0, 630)
        setTextSize("check", 30)
        screenCenter("check", 'x')
        setObjectCamera("check", 'other')
        addLuaText("check")
        setTextFont("check", "drunkenhourDEMO.otf")
        setTextBorder("check", 0.5, "000000")
        setProperty("check.alpha", 0.00001)
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

    if songPath == 'credits' then
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
        setProperty("playbackRate", playbackRate + 0.025)
    end

    if playbackRate >= tonumber(velocidade) and volte then
        setProperty("playbackRate", tonumber(velocidade))
        volte = false
    end
end

function onPause()

    openCustomSubstate('pauseShit', true);
    return Function_Stop;
end

--[[function onCustomSubstateUpdate(name, elapsed)
    
    if name == 'pauseShit' then
        setTextString('socorro', 'PAUSED')
        changeDiscordPresence(getTextString("presence"), getTextString("socorro"), minIcon)
    end
end]]

function onCustomSubstateCreatePost(name)
    
    if name == 'pauseShit' then

        doTweenAlpha("ven", "escu", 0.5, 0.5, "linear")
        setProperty("resu.alpha", 1)
        setProperty("resta.alpha", 1)
        setProperty("exit.alpha", 1)
        setProperty("seta.alpha", 1)
        setProperty("setaa.alpha", 1)
        setProperty("compo.alpha", 1)
        setProperty("barr.alpha", 1)
        setProperty("balls.alpha", 1)
        setProperty("balls.alpha", 1)
        setProperty("noWay.alpha", 1)
        setProperty("BGmoving.alpha", 1)
        setProperty("char.alpha", 1)
        setProperty("check.alpha", 1)
        setProperty("morri.alpha", 1)
        setProperty("buttonA.alpha", 0.5)
        setProperty("buttonD.alpha", 0.5)
        setProperty("buttonU.alpha", 0.5)
        screenCenter("noWay", 'x')

        random = getRandomInt(0, 33)

        resumeSound("bah")
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
            curFrase = parsed.frases[spc][1]
        else
            curFrase = parsed.frases[random][1]
        end

        setTextString("morri", curFrase)

        doTweenY("lololol", "morri", 694.6, 0.5, "quartOut")
        setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName..' (PAUSED)')
    end
end

local aah = 1

function onCustomSubstateUpdatePost(name, elapsed)
    
    if name == 'pauseShit' then

        if not flashingLights then
            aah = 2
        end

        setProperty("compo.x", getProperty("compo.x") + 1)
        setProperty("morri.x", getProperty("morri.x") - 1)

        setProperty('BGmoving.x',getProperty('BGmoving.x') - 1 / aah);
        setProperty('BGmoving.y',getProperty('BGmoving.y') - screenHeight/screenWidth / aah);
        if getProperty('BGmoving.x') <= -screenWidth + 1 then
            setProperty('BGmoving.x',0);
        end

        if getProperty('BGmoving.y') <= -screenHeight + 1 then
            setProperty('BGmoving.y',0);
        end
        
        if getProperty("compo.x") == screenWidth then
            setProperty("compo.x", data.pauseTxtPos)
        end
        
        if getProperty("morri.x") == parsed.frases[random][2] then
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

        if keyboardJustPressed("S") or keyboardJustPressed("DOWN") or anyGamepadJustPressed("DPAD_DOWN") or anyGamepadJustPressed("LEFT_STICK_DIGITAL_DOWN") or downJustPressed and buildTarget == 'windows' then
            pos = pos + 1
            playSound("scrollMenu", 0.5, 'tick')
            runTimer("reset", 0.1)
        elseif keyboardJustPressed("W") or keyboardJustPressed("UP") or anyGamepadJustPressed("DPAD_UP") or anyGamepadJustPressed("LEFT_STICK_DIGITAL_UP") or upJustPressed and buildTarget == 'windows' then
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

        if keyJustPressed('accept') and pos == 0 and not getVar("inGameOver") then
            closeCustomSubstate()
            setProperty("escu.alpha", 0.00001)
            setProperty("resu.alpha", 0.00001)
            setProperty("resta.alpha", 0.00001)
            setProperty("exit.alpha", 0.00001)
            setProperty("seta.alpha", 0.00001)
            setProperty("setaa.alpha", 0.00001)
            setProperty("compo.alpha", 0.00001)
            setProperty("barr.alpha", 0.00001)
            setProperty("balls.alpha", 0.00001)
            setProperty("morri.alpha", 0.00001)
            setProperty("noWay.alpha", 0.00001)
            setProperty("BGmoving.alpha", 0.00001)
            setProperty("char.alpha", 0.00001)
            setProperty("check.alpha", 0.00001)
            setProperty("noWay.x", -999)
            --[=[runHaxeCode([[
                FlxG.game.setFilters([]);
            ]])]=]
            setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName)
            setProperty("barr.y", -20)
            setProperty("compo.y", -20)
            setProperty("balls.y", 740)
            setProperty("morri.y", 740)
            setProperty("playbackRate", 0.15)
            volte = true
            pauseSound("bah")
            cancelTween("ven")
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
    setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks')
end
    --[=[if shadersEnabled then
        runHaxeCode([[
            FlxG.game.setFilters([]);
        ]])
    end
end]=]

function onCountdownStarted()

    if songPath == 'credits' then
        setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Credits Menu')
    else
        setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName)
    end
end

function onGameOver()
    
    setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Game Over')
end

function onSectionHit()

    if curSection == 24 and songPath == 'kittyjam' and difficultyName == 'buck' then
        special = true
    elseif curSection == 32 and songPath == 'kittyjam' and difficultyName == 'buck' then
        special = false
    elseif curSection == 48 and songPath == 'kittyjam' and difficultyName == 'buck' then
        special = true
    elseif curSection == 64 and songPath == 'kittyjam' and difficultyName == 'buck' then
        special = false
    elseif curSection == 36 and songPath == 'kittyjam' and difficultyName == 'erect' then
        special = true
    elseif curSection == 54 and songPath == 'kittyjam' and difficultyName == 'erect' then
        special = false
    elseif curSection == 117 and songPath == 'kittyjam' and difficultyName == 'erect' then
        special = true
    end
end