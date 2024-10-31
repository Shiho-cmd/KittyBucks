luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

local curYear = os.date ("%Y")
local canRestart = false

function onCreate()
    
    makeLuaSprite("bruh", '', -500, -300)
    makeGraphic("bruh", 2250, 1600, '000000')
    setProperty("bruh.alpha", 0)
    setObjectOrder("bruh", getObjectOrder("boyfriendGroup"))
    addLuaSprite("bruh", false)

    makeAnimatedLuaSprite("lol", 'Explosion', 650, 210)
    scaleObject("lol", 1.3, 1.3)
    addAnimationByPrefix("lol", "explodiu", "boom", 12, false)
    setProperty("lol.alpha", 0)
    addLuaSprite("lol", true)

    makeLuaSprite("kurodead", 'kuromi_rip', 270, 420)
    setObjectCamera("kurodead", 'other')
    setProperty("kurodead.alpha", 0)
    scaleObject("kurodead", 1.7, 1.7)
    addLuaSprite("kurodead", true)

    makeLuaSprite("skipBar", '', 100, 650)
    makeGraphic("skipBar", 1, 20, 'FFFFFF')
    setObjectCamera("skipBar", 'other')
    setProperty("skipBar.alpha", 0)
    addLuaSprite("skipBar", true)

    makeLuaText("ano", "2024 - "..curYear, 0, 700, 600)
    makeLuaText("piss", "Rest In Piss", 0, 670, 470)
    makeLuaText("nome", boyfriendName, 0, 765, 532)
    makeLuaText("retry", "PRESS \"ACCEPT\" TO TRY AGAIN OR \"BACK\" TO GO BACK TO THE MAIN MENU", 0, 0, 100)
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
end

function onGameOver()
    
    return Function_Stop;
end

function onUpdate(elapsed)
    
    if getHealth() <= 0.0001 then
        openCustomSubstate('gayover', true)
    end
end

function onCustomSubstateCreatePost(name)
    
    if name == 'gayover' then

        doTweenAlpha("morraHUD", "camHUD", 0, 2, "linear")
        doTweenAlpha("bruhmoment", "bruh", 0.8, 3, "linear")
        doTweenZoom('camz', 'camGame', 1.3, 3, 'quadOut')

        playSound("missnote"..getRandomInt(1, 3), 1, 'start')

        doTweenX('move1','camGame.scroll', getGraphicMidpointX('boyfriend') - 630, 3, 'quadOut')
        doTweenY('move2','camGame.scroll', getGraphicMidpointY('boyfriend') - 370, 3, 'quadOut')

        runTimer("XD", 4)

        runHaxeCode([[
            game.KillNotes();
		]])
    end
end

local getBack = false
function onCustomSubstateUpdate(name, elapsed)
    
    if name == 'gayover' then

        if getProperty("skipBar.scale.x") > 200 then
            restartSong(false)
        elseif getProperty("skipBar.scale.x") < 1 then
            setProperty("skipBar.scale.x", 1)
        elseif getProperty("skipBar.scale.x") < 0 then
            setProperty("skipBar.alpha", 0)
        end

        if keyboardPressed('ENTER') and not canRestart or keyboardPressed("SPACE") and not canRestart then
            setProperty("skipBar.scale.x", getProperty("skipBar.scale.x") + 5)
            setProperty("skipBar.alpha", getProperty("skipBar.alpha") + 0.03)
            getBack = false
        elseif keyboardReleased("ENTER") and not canRestart or keyboardReleased("ENTER") and not canRestart then
            getBack = true
        elseif keyJustPressed('accept') and canRestart then
            restartSong(false)
        elseif keyJustPressed('back') and canRestart then
            exitSong(false)
        end
    end
end

function onCustomSubstateUpdatePost(name, elapsed)
    
    if getBack then
        setProperty("skipBar.scale.x", getProperty("skipBar.scale.x") - 5)
        setProperty("skipBar.alpha", getProperty("skipBar.alpha") - 0.03)
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
        playMusic("overplaceholder", 0, true)
        doTweenAlpha("rumbora", "retry", 1, 0.5, "linear")
        soundFadeIn("", 10, 0, 1)
        runTimer("brilho", 0.5)
        canRestart = true
    end
end