luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

local curYear = os.date ("%Y")
local canRestart = false

local retryTxt = ''

function onCreate()

    if buildTarget == 'android' then
        retryTxt = "PRESS \"A\" TO TRY AGAIN OR \"B\" TO GO BACK TO THE MAIN MENU"

        precacheImage("virtualpad")

        makeAnimatedLuaSprite("buttonA", 'virtualpad', 1145, 570)
        addAnimationByPrefix("buttonA", "pressed", "aPress", 10, false)
        addAnimationByPrefix("buttonA", "idle", "a", 0, false)
        setObjectCamera("buttonA", 'other')
        setProperty("buttonA.alpha", 0.5)
        setProperty("buttonA.color", FlxColor("RED"))
        setProperty("buttonA.alpha", 0)
        addLuaSprite("buttonA", true)
    
        makeLuaSprite("buttonB", '', 1000, 570)
        loadGraphic("buttonB", "virtualPad", 132, 127)
        addAnimation("buttonB", "pressed", {17}, 10, true)
        addAnimation("buttonB", "idle", {16}, 0, true)
        setObjectCamera("buttonB", 'other')
        setProperty("buttonB.alpha", 0.5)
        setProperty("buttonB.color", FlxColor("YELLOW"))
        setProperty("buttonB.alpha", 0)
        addLuaSprite("buttonB", true)
    else
        retryTxt = "PRESS \"ACCEPT\" TO TRY AGAIN OR \"BACK\" TO GO BACK TO THE MAIN MENU"
    end
    
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

    --[[makeLuaSprite('cool')
    loadGraphic('cool', 'reallyCool', 1136, 640)
    addAnimation('cool', 'trans', {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50}, 24, false)
    scaleObject('cool', 1.13, 1.13)
    setObjectCamera('cool', 'other')
    setProperty("cool.alpha", 0)
    addLuaSprite('cool', true)]]

    makeLuaText("ano", "2024 - "..curYear, 0, 700, 600)
    makeLuaText("piss", "Rest In Piss", 0, 670, 470)
    makeLuaText("nome", boyfriendName, 0, 765, 532)
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

        if buildTarget == 'android' then
            doTweenAlpha("rumbor", "buttonA", 0.5, 0.5, "linear")
            doTweenAlpha("rumbora", "buttonB", 0.5, 0.5, "linear")
        end

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
local aJustPressed = nil
local bJustPressed = nil
local aPressed = nil
local bPressed = nil
local aReleased = nil
local bReleased = nil
function onCustomSubstateUpdate(name, elapsed)

    if buildTarget == 'android' then
        aJustPressed = getMouseX('camOther') > getProperty('buttonA.x') and getMouseY('camOther') > getProperty('buttonA.y') and getMouseX('camOther') < getProperty('buttonA.x') + getProperty('buttonA.width') and getMouseY('camOther') < getProperty('buttonA.y') + getProperty('buttonA.height') and mouseClicked()
        bJustPressed = getMouseX('camOther') > getProperty('buttonB.x') and getMouseY('camOther') > getProperty('buttonB.y') and getMouseX('camOther') < getProperty('buttonB.x') + getProperty('buttonB.width') and getMouseY('camOther') < getProperty('buttonB.y') + getProperty('buttonB.height') and mouseClicked()
        aPressed = getMouseX('camOther') > getProperty('buttonA.x') and getMouseY('camOther') > getProperty('buttonA.y') and getMouseX('camOther') < getProperty('buttonA.x') + getProperty('buttonA.width') and getMouseY('camOther') < getProperty('buttonA.y') + getProperty('buttonA.height') and mousePressed()
        bPressed = getMouseX('camOther') > getProperty('buttonB.x') and getMouseY('camOther') > getProperty('buttonB.y') and getMouseX('camOther') < getProperty('buttonB.x') + getProperty('buttonB.width') and getMouseY('camOther') < getProperty('buttonB.y') + getProperty('buttonB.height') and mousePressed()
        aReleased = getMouseX('camOther') > getProperty('buttonA.x') and getMouseY('camOther') > getProperty('buttonA.y') and getMouseX('camOther') < getProperty('buttonA.x') + getProperty('buttonA.width') and getMouseY('camOther') < getProperty('buttonA.y') + getProperty('buttonA.height') and mouseReleased()
        bReleased = getMouseX('camOther') > getProperty('buttonB.x') and getMouseY('camOther') > getProperty('buttonB.y') and getMouseX('camOther') < getProperty('buttonB.x') + getProperty('buttonB.width') and getMouseY('camOther') < getProperty('buttonB.y') + getProperty('buttonB.height') and mouseReleased()
    end
    
    if name == 'gayover' then

        if getProperty("skipBar.scale.x") > 200 then
            restartSong(false)
        elseif getProperty("skipBar.scale.x") < 1 then
            setProperty("skipBar.scale.x", 1)
        elseif getProperty("skipBar.scale.x") < 0 then
            setProperty("skipBar.alpha", 0)
        end

        if keyboardPressed('ENTER') and not canRestart or keyboardPressed("SPACE") and not canRestart or gamepadPressed(1, "A") and not canRestart or gamepadPressed(1, "START") and not canRestart then
            setProperty("skipBar.scale.x", getProperty("skipBar.scale.x") + 5)
            setProperty("skipBar.alpha", getProperty("skipBar.alpha") + 0.03)
            getBack = false
        elseif aPressed and not canRestart and buildTarget == 'android' then
            setProperty("skipBar.scale.x", getProperty("skipBar.scale.x") + 5)
            setProperty("skipBar.alpha", getProperty("skipBar.alpha") + 0.03)
            playAnim("buttonA", "pressed", true)
            getBack = false
        elseif keyboardReleased("ENTER") and not canRestart or keyboardReleased("SPACE") and not canRestart or gamepadReleased(1, "A") and not canRestart or gamepadReleased(1, "START") and not canRestart then
            getBack = true
        elseif aReleased and not canRestart and buildTarget == 'android' then
            getBack = true
            playAnim("buttonA", "idle", true)
        elseif keyJustPressed('accept') and canRestart then
            restartSong(false)
        elseif aJustPressed and canRestart and buildTarget == 'android' then
            playAnim("buttonA", "pressed", true)
            restartSong(false)
        elseif keyJustPressed('back') and canRestart then
            exitSong(false)
        elseif bJustPressed and canRestart and buildTarget == 'android' then
            playAnim("buttonB", "pressed", true)
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
    elseif tag == 'trans' then
        restartSong(false)
    end
end