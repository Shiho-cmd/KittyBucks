luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

local borders = {'border_default_handheld', 'border_omori_handheld', 'border_omori_redhand_handheld', 'border_aubrey_handheld', 'border_kel_handheld', 'border_hero_handheld', 'border_mari_handheld', 'border_basil_handheld', 'border_whitespace_handheld', 'border_solidblack_handheld', 'border_solidblack_handheld'}
local curBorder = 1

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
    addLuaSprite("johner", true)
    addLuaSprite("bg", false)
end

function onSongStart()
    
    setProperty("timeBar.visible", false)
    setProperty("timeTxt.visible", false)
    doTweenAlpha("adios", "aviso", 0, 1, "linear")
end

function onUpdate(elapsed)
    
    if keyboardJustPressed("SHIFT") then
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