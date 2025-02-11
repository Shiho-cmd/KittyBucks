function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local check = parseJson('data/friends/cameFromBS.json')

luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

local borders = {'border_default_handheld', 'border_omori_handheld', 'border_omori_redhand_handheld', 'border_aubrey_handheld', 'border_kel_handheld', 'border_hero_handheld', 'border_mari_handheld', 'border_basil_handheld', 'border_whitespace_handheld', 'border_solidblack_handheld', 'border_solidblack_handheld'}
local curBorder = 1
local pode = true
local txt = 'That\'s enough roblox for today...'
local clicavel = false
local cameFromBS = check.itDid

function onCountdownStarted()
    
    removeLuaScript("scripts/noteSplashStuff")
    setPropertyFromGroup('opponentStrums', 0, 'x', 410 - 900);
    setPropertyFromGroup('opponentStrums', 1, 'x', 532 - 900);
    setPropertyFromGroup('opponentStrums', 2, 'x', 653 - 900);
    setPropertyFromGroup('opponentStrums', 3, 'x', 770 - 900);

    setPropertyFromGroup('playerStrums', 0, 'x', 410);
    setPropertyFromGroup('playerStrums', 1, 'x', 532);
    setPropertyFromGroup('playerStrums', 2, 'x', 653);
    setPropertyFromGroup('playerStrums', 3, 'x', 770);
end

function onCreate()

    precacheImage('backgrounds/omori/borders/border_default_handheld')
    precacheImage('backgrounds/omori/borders/border_omori_handheld')
    precacheImage('backgrounds/omori/borders/border_omori_redhand_handheld')
    precacheImage('backgrounds/omori/borders/border_aubrey_handheld')
    precacheImage('backgrounds/omori/borders/border_kel_handheld')
    precacheImage('backgrounds/omori/borders/border_hero_handheld')
    precacheImage('backgrounds/omori/borders/border_mari_handheld')
    precacheImage('backgrounds/omori/borders/border_basil_handheld')
    precacheImage('backgrounds/omori/borders/border_whitespace_handheld')
    precacheImage('backgrounds/omori/borders/border_solidblack_handheld')

    setProperty('camGame.bgColor', getColorFromHex('000000'))
    makeLuaSprite("bg", 'backgrounds/roblox/crossroads', -800, -200)
    scaleObject("bg", 2, 2)

    makeAnimatedLuaSprite("johner", 'characters/johndoe', -340, 460)
    addAnimationByPrefix("johner", "chill", "jon", 12, true)
    addAnimationByPrefix("johner", "notChill", "johntransiiton", 24, false)
    setProperty("johner.flipX", true)
    addOffset("johner", "notChill", 6, 14)

    makeLuaSprite('bor', 'backgrounds/omori/borders/'..borders[curBorder])
    setObjectCamera('bor', 'other')
    scaleObject('bor', 0.67, 0.67)
    screenCenter('bor')
    setObjectOrder('bor', 0)
    setProperty("bor.alpha", 0.00001)
    addLuaSprite('bor', false)

    makeLuaSprite('bord', 'backgrounds/omori/borders/border_solidblack_handheld')
    setObjectCamera('bord', 'other')
    scaleObject('bord', 0.67, 0.67)
    screenCenter('bord')

    makeLuaText("aviso", "Press SHIFT/Select to change the borders!", 0, 0.0, screenHeight-35)
    setTextFont("aviso", "omori.ttf")
    setObjectCamera("aviso", 'other')
    setTextSize("aviso", 35)

    addLuaText("aviso")
    addLuaSprite('bord', false)
    addLuaSprite("bg", false)
    addLuaSprite("johner", true)

    if cameFromBS then
        makeLuaSprite("lapertoper", 'backgrounds/omori/blackspace/laptopRoblox', 0, 0)
        scaleObject("lapertoper", 2.5, 2.5)
        setObjectCamera("lapertoper", 'other')
        screenCenter("lapertoper")
        setProperty("lapertoper.alpha", 0.00001)

        makeLuaText("xtx", '', 450, 370, screenHeight - 150)
        setTextFont("xtx", "omori.ttf")
        setTextSize("xtx", 35)
        setTextAlignment("xtx", 'left')
        setObjectCamera("xtx", 'other')

        makeAnimatedLuaSprite("boxx", 'backgrounds/omori/blackspace/txtBox', 350, screenHeight - 150)
        addAnimationByPrefix("boxx", "default", "normal", 0, false)
        setObjectCamera("boxx", 'other')
        scaleObject("boxx", 2.5, 2)
        setProperty("boxx.alpha", 0.00001)
        
        makeLuaSprite("hand", 'backgrounds/omori/blackspace/moes', 860, screenHeight - 50)
        scaleObject("hand", 1.3, 1.3)
        setObjectCamera("hand", 'other')
        setProperty("hand.alpha", 0.00001)
    
        addLuaSprite('lapertoper', false)
        addLuaSprite("boxx", false)
        addLuaSprite("hand", false)
        addLuaSprite('xtx', false)
        doTweenX("loopInsano", "hand", getProperty("hand.x") - 5, 1, "quartInOut")
        setObjectOrder("lapertoper", getObjectOrder("bord"))
    end
end

function onDestroy()
    
    saveFile("mods/KittyBucks/data/friends/cameFromBS.json", "{\n    \"itDid\": false\n}", true)
end

function onSongStart()
    
    setProperty("timeBar.visible", false)
    setProperty("timeTxt.visible", false)
    doTweenAlpha("adios", "aviso", 0, 1, "linear")
end

function onUpdate(elapsed)

    if keyboardJustPressed("Z") and clicavel then
        clicavel = false
        doTweenY("tesao", "boxx.scale", 0.1, 0.2, "linear")
        doTweenAlpha("e", "boxx", 0.00001, 0.2, "linear")
        removeLuaText("xtx")
        setProperty("hand.alpha", 0)
        loadSong('bruh', -1)
    end
    
    if keyboardJustPressed("SHIFT") and pode then
        curBorder = curBorder + 1
        makeLuaSprite('bor', 'backgrounds/omori/borders/'..borders[curBorder])
        setObjectCamera('bor', 'other')
        scaleObject('bor', 0.67, 0.67)
        screenCenter('bor')
        setObjectOrder('bor', 0)
        addLuaSprite('bor', false)
        setObjectOrder("bor", getObjectOrder("bord")+1)
        setProperty('bor.alpha', 0.0001)
        doTweenAlpha('bumchacalaca', 'bor', 1, 0.5, 'linear')
    elseif curBorder > 10 then
        curBorder = 1
        makeLuaSprite('bor', 'backgrounds/omori/borders/'..borders[1])
        setObjectCamera('bor', 'other')
        scaleObject('bor', 0.67, 0.67)
        screenCenter('bor')
        setObjectOrder('bor', 0)
        addLuaSprite('bor', false)
        setObjectOrder("bor", getObjectOrder("bord")+1)
        setProperty('bor.alpha', 0.0001)
        doTweenAlpha('bumchacalaca', 'bor', 1, 0.5, 'linear')
    end
end

function onTweenCompleted(tag, vars)
    
    if tag == 'adios' then
        removeLuaText("aviso", true)
    end
end

function onStepHit()
	
	if curStep == 1273 then
        playAnim("johner", "notChill", false)
    elseif curStep == 1280 then
        removeLuaSprite("johner")
    end
end

function onEndSong()
    

    if cameFromBS then
        playSound("error", 1, 'bam')
        setProperty("camGame.alpha", 0)
        setProperty("camHUD.alpha", 0)
        setProperty("lapertoper.alpha", 1)
        return Function_Stop;
    else
        return Function_Continue;
    end
end

function onSoundFinished(tag)
    
    if tag == 'bam' then
        doTweenAlpha("bumchacalaca", "bor", 0, 1, "linear")
        doTweenX("scaleX", "lapertoper.scale", 1.5, 2, "quartInOut")
        doTweenY("scaleY", "lapertoper.scale", 1.5, 2, "quartInOut")
    end
end

function onTweenCompleted(tag, vars)
    
    if tag == 'scaleX' then
        runTimer("dia", 1)
    elseif tag == 'loopInsano' then
        doTweenX("insanoLoop", "hand", getProperty("hand.x") + 5, 0.5, "quartInOut")
    elseif tag == 'insanoLoop' then
        doTweenX("loopInsano", "hand", getProperty("hand.x") - 5, 0.5, "quartInOut")
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    
    if tag == 'dia' then
        clicavel = true
        scaleObject("boxx", 2.5, 0.1, false)
        doTweenY("tesao", "boxx.scale", 2.5, 0.2, "linear")
        doTweenAlpha("e", "boxx", 1, 0.2, "linear")
        setProperty("hand.alpha", 1)
        runTimer('escreve', 0.04, string.len(txt)+1)
    elseif tag == 'escreve' then
        setTextString('xtx', string.sub(txt, 0, (loops - loopsLeft)))
        playSound('omori/se/SYS_text', 0.5)
    end
end