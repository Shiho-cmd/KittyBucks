luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

function onCountdownStarted()
    
    for i = 0, 3 do
        removeLuaScript("scripts/noteSplashStuff")
        setPropertyFromGroup('opponentStrums', i, 'x', -900);
        setPropertyFromGroup('playerStrums', 0, 'x', 410);
        setPropertyFromGroup('playerStrums', 1, 'x', 532);
        setPropertyFromGroup('playerStrums', 2, 'x', 653);
        setPropertyFromGroup('playerStrums', 3, 'x', 770);
    end
end

function onCreate()

    setProperty('camGame.bgColor', getColorFromHex('000000'))
    makeLuaSprite("bg", 'backgrounds/roblox/crossroads', -800, -200)
    scaleObject("bg", 2, 2)

    makeAnimatedLuaSprite("johner", 'characters/johndoe', -340, 460)
    addAnimationByPrefix("johner", "chill", "jon", 12, true)
    addAnimationByPrefix("johner", "notChill", "johntransiiton", 24, false)
    setProperty("johner.flipX", true)
    addOffset("johner", "notChill", 6, 14)

    makeLuaSprite('bor', 'backgrounds/omori/borders/border_solidblack_handheld')
    setObjectCamera('bor', 'other')
    scaleObject('bor', 0.67, 0.67)
    screenCenter('bor')
    
    addLuaSprite('bor', false)
    addLuaSprite("johner", true)
    addLuaSprite("bg", false)
end

function onSongStart()
    
    setProperty("timeBar.visible", false)
    setProperty("timeTxt.visible", false)
end


function onStepHit()
	
	if curStep == 1273 then
        playAnim("johner", "notChill", false)
    elseif curStep == 1280 then
        removeLuaSprite("johner")
    end
end