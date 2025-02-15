luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

local instant = getPropertyFromClass('backend.ClientPrefs', 'data.quickReset')

local curYear = os.date ("%Y")
local canRestart = false

local retryTxt = "PRESS \"ACCEPT\" TO TRY AGAIN OR \"BACK\" TO GO BACK TO THE MAIN MENU"

function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local parsed = parseJson('characters/data/'..boyfriendName..'_DATA.json')
local rpc = parseJson('data/'..songPath..'/songData-'..difficultyName..'.json')
local minIcon = rpc.rpcMiniIconPause

function onCreate()
    
    makeLuaSprite("bruh", '', -500, -300)
    makeGraphic("bruh", 2250, 1600, '000000')
    setProperty("bruh.alpha", 0)
    setObjectOrder("bruh", getObjectOrder("boyfriendGroup"))
    addLuaSprite("bruh", false)

    makeAnimatedLuaSprite("lol", 'gameOver/Explosion', parsed.explosionX, parsed.explosionY)
    scaleObject("lol", 1.3, 1.3)
    addAnimationByPrefix("lol", "explodiu", "boom", 12, false)
    setProperty("lol.alpha", 0)
    addLuaSprite("lol", true)

    makeLuaSprite("kurodead", 'gameOver/rip/'..parsed.gameOverImage, 270, 420)
    setObjectCamera("kurodead", 'other')
    setProperty("kurodead.alpha", 0)
    scaleObject("kurodead", 1.7, 1.7)
    addLuaSprite("kurodead", true)

    makeLuaSprite("skipBack", '', 200, 620)
    makeGraphic("skipBack", 1, 20, '000000')
    setProperty("skipBack.scale.x", 307)
    setObjectCamera("skipBack", 'other')
    setProperty("skipBack.alpha", 0)
    addLuaSprite("skipBack", true)

    makeLuaSprite("skipBar", '', 200, 620)
    makeGraphic("skipBar", 1, 20, 'FFFFFF')
    setObjectCamera("skipBar", 'other')
    setProperty("skipBar.alpha", 0)
    addLuaSprite("skipBar", true)

    makeLuaText("res", "Restarting", 0, 100, 580)
    setTextSize("res", 25)
    setObjectCamera("res", 'other')
    setProperty("res.alpha", 0)
    addLuaText("res")

    makeLuaText("ex", "Exiting", 0, 120, 580)
    setTextSize("ex", 25)
    setObjectCamera("ex", 'other')
    setProperty("ex.alpha", 0)
    addLuaText("ex")

    makeLuaText("ano", parsed.yearThing.." - "..curYear, 0, 700, 600)
    makeLuaText("piss", "Rest In Piss", 0, 670, 470)
    makeLuaText("nome", parsed.gameOverName, 0, parsed.gameOverNameX, parsed.gameOverNameY)
    makeLuaText("retry", retryTxt, 0, 0, 100)
    setObjectCamera("ano", 'other')
    setObjectCamera("piss", 'other')
    setObjectCamera("nome", 'other')
    setObjectCamera("retry", 'other')
    setTextSize("ano", 45)
    setTextSize("piss", 50)
    setTextSize("nome", 45)
    setTextSize("retry", 25)
    setProperty("ano.alpha", 0)
    setProperty("piss.alpha", 0)
    setProperty("nome.alpha", 0)
    setProperty("retry.alpha", 0)
    screenCenter("retry", 'x')
    addLuaText("ano")
    addLuaText("piss")
    addLuaText("nome")
    addLuaText("retry")

    setVar("inGameOver", false)
end

function onGameOver()
    
    return Function_Stop;
end

function onUpdate(elapsed)
    
    if getHealth() <= 0.0001 and not practice and songName ~= 'RANDOM' then
        --[[setTextString('socorro', 'Game Over')
        changeDiscordPresence(getTextString("presence"), getTextString("socorro"), minIcon)]]
        openCustomSubstate('gayover', true)
        setVar("inGameOver", true)
    end

    if instakillOnMiss and misses == 1 then
        setHealth(0.0001)
    end
end

function onCustomSubstateCreatePost(name)
    
    if name == 'gayover' then

        doTweenAlpha("morraHUD", "camHUD", 0, 2, "linear")
        doTweenAlpha("bruhmoment", "bruh", 0.8, 3, "linear")
        doTweenZoom('camz', 'camGame', 1.3, 3, 'quadOut')
        runTimer("tart", 0.1)
        runTimer("it", 0.1)

        playSound("missnote"..getRandomInt(1, 3), 1, 'start')

        doTweenX('move1','camGame.scroll', getGraphicMidpointX('boyfriend') - parsed.cameraPosX, 3, 'quadOut')
        doTweenY('move2','camGame.scroll', getGraphicMidpointY('boyfriend') - parsed.cameraPosY, 3, 'quadOut')

        runTimer("XD", 4)

        runHaxeCode([[
            game.KillNotes();
		]])
    end
end

local getBack = false
local exit = false
function onCustomSubstateUpdate(name, elapsed)
    
    if name == 'gayover' then

        if getProperty("skipBar.scale.x") > 300 and not exit then
            restartSong(false)
        elseif getProperty("skipBar.scale.x") > 299 and exit then
            exitSong(false)
        elseif getProperty("skipBar.scale.x") < 1 then
            setProperty("skipBar.scale.x", 1)
        elseif getProperty("skipBar.scale.x") < 0 then
            setProperty("skipBar.alpha", 0)
        end

        if keyboardPressed('ENTER') and not canRestart and not instant or keyboardPressed("SPACE") and not canRestart and not instant or gamepadPressed(1, "A") and not canRestart or gamepadPressed(1, "START") and not canRestart then
            setProperty("skipBar.scale.x", getProperty("skipBar.scale.x") + 5)
            setProperty("skipBar.alpha", getProperty("skipBar.alpha") + 0.03)
            setProperty("res.alpha", getProperty("res.alpha") + 0.03)
            setProperty("res.visible", true)
            setProperty("ex.visible", false)
            doTweenAlpha("bah", "skipBack", 0.5, 0.5, "linear")
            getBack = false
            exit = false
        elseif keyboardReleased("ENTER") and not canRestart and not instant or keyboardReleased("SPACE") and not canRestart and not instant or gamepadReleased(1, "A") and not canRestart or gamepadReleased(1, "START") and not canRestart then
            getBack = true
            doTweenAlpha("bah", "skipBack", 0, 0.5, "linear")

        elseif keyboardPressed('BACKSPACE') and not canRestart and not instant or keyboardPressed("ESCAPE") and not canRestart and not instant or gamepadPressed(1, "B") and not canRestart or gamepadPressed(1, "SELECT") and not canRestart then
            setProperty("skipBar.scale.x", getProperty("skipBar.scale.x") + 5)
            setProperty("skipBar.alpha", getProperty("skipBar.alpha") + 0.03)
            setProperty("ex.alpha", getProperty("ex.alpha") + 0.03)
            setProperty("res.visible", false)
            setProperty("ex.visible", true)
            doTweenAlpha("bah", "skipBack", 0.5, 0.5, "linear")
            getBack = false
            exit = true
        elseif keyboardReleased("BACKSPACE") and not canRestart and not instant or keyboardReleased("ESCAPE") and not canRestart and not instant or gamepadReleased(1, "B") and not canRestart or gamepadReleased(1, "SELECT") and not canRestart then
            getBack = true
            doTweenAlpha("bah", "skipBack", 0, 0.5, "linear")

        elseif keyJustPressed('accept') and canRestart or keyJustPressed('accept') and instant then
            restartSong(false)
        elseif keyJustPressed('back') and canRestart or keyJustPressed('back') and instant then
            exitSong(false)
        end
    end
end

function onCustomSubstateUpdatePost(name, elapsed)
    
    if name == 'gayover' then
        if getBack then
            setProperty("skipBar.scale.x", getProperty("skipBar.scale.x") - 5)
            setProperty("skipBar.alpha", getProperty("skipBar.alpha") - 0.03)
            setProperty("res.alpha", getProperty("res.alpha") - 0.03)
            setProperty("ex.alpha", getProperty("ex.alpha") - 0.03)
        elseif canRestart then
            setProperty("skipBar.scale.x", getProperty("skipBar.scale.x") - 5)
            setProperty("skipBar.alpha", getProperty("skipBar.alpha") - 0.03)
            setProperty("res.alpha", getProperty("res.alpha") - 0.03)
            setProperty("ex.alpha", getProperty("ex.alpha") - 0.03)
        end
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    
    if tag == 'XD' then
        playAnim("lol", "explodiu", true)
        setProperty("lol.alpha", 1)
        playSound("game-over/boom", 1, 'vish')
        runTimer("rip", 0.13)
    elseif tag == 'rip' then
        setObjectCamera("bruh", 'other')
        setProperty("bruh.alpha", 1)
        stopSound("vish")
        doTweenAlpha("lmao", "kurodead", 1, 1, "linear")
        playSound("game-over/dead", 1, 'morreulis')
    elseif tag == 'brilho' then
        doTweenColor("ui", "retry", "C4EBFF", 0.5, "linear")
        runTimer("bri", 0.5)
    elseif tag == 'bri' then
        doTweenColor("iu", "retry", "FFFFFF", 0.5, "linear")
        runTimer("brilho", 0.5)
    elseif tag == 'tart' then
        setTextString("res", "Restarting.")
        runTimer("rese", 0.1)
    elseif tag == 'rese' then
        setTextString("res", "Restarting..")
        runTimer("t", 0.1)
    elseif tag == 't' then
        setTextString("res", "Restarting...")
        runTimer("buceta", 0.1)
    elseif tag == 'buceta' then
        setTextString("res", "Restarting")
        runTimer("tart", 0.1)

    elseif tag == 'it' then
        setTextString("ex", "Exiting.")
        runTimer("br", 0.1)
    elseif tag == 'br' then
        setTextString("ex", "Exiting..")
        runTimer("tp", 0.1)
    elseif tag == 'tp' then
        setTextString("ex", "Exiting...")
        runTimer("penis", 0.1)
    elseif tag == 'penis' then
        setTextString("ex", "Exiting")
        runTimer("it", 0.1)
    end
end

function onTweenCompleted(tag, vars)
    
    if tag == 'lmao' then
        doTweenAlpha("nemsei", "ano", 1, 1, "linear")
        doTweenAlpha("nemseio", "piss", 1, 1, "linear")
        doTweenAlpha("nemseios", "nome", 1, 1, "linear")
    end
end

function onSoundFinished(tag)
    
    if tag == 'morreulis' then
        playMusic("gameOver", 0, true)
        doTweenAlpha("rumbora", "retry", 1, 0.5, "linear")
        doTweenAlpha("bah", "skipBack", 0, 0.5, "linear")
        soundFadeIn("", 10, 0, 1)
        runTimer("brilho", 0.5)
        canRestart = true
    end
end