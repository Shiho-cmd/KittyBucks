luaDebugMode = true

function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local quietArea = parseJson('data/_ROOMS/blackspace/quietArea.json')
local quietAreaDialogue = parseJson('data/_ROOMS/blackspace/quietArea-dialogue-'..getTranslationPhrase('dia_trigger', 'EN')..'.json')

local path = 'backgrounds/omori/'
local pathBS = 'backgrounds/omori/blackspace/'
local pathQA = 'backgrounds/omori/blackspace/quiet-area/'
local pathBorder = 'backgrounds/omori/borders/'
local pathBattle = 'backgrounds/omori/battleStuff/'

local pathBGM = 'omori/bgm/'
local pathBGS = 'omori/bgs/'
local pathSE = 'omori/se/'

local paus = getModSetting("pause")
local ovo = getModSetting("over")

local clicavel = true
local moveAnim = 'walk'
local walkSpeed = 4
local moveDown = true
local moveUp = true
local moveRight = true
local moveLeft = true
local looking = 'down'

local quanto = 1
local ativado = false

local win = getTranslationPhrase('win_qa', 'Quiet Area')

function onStartCountdown()
    
    setProperty("dadGroup.visible", false)
    setProperty("botplayTxt.visible", false)
    setProperty("scoreTxt.visible", false)
    setProperty("healthBar.visible", false)
    setProperty("iconP1.visible", false)
    setProperty("iconP2.visible", false)
    return Function_Stop;
end

function onCreate()

    setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | '..win)

    precacheSound(pathBGM.."bs_calm")
    precacheSound(pathSE.."GEN_stab")

    removeLuaScript(currentModDirectory.."/scripts/gozadaInsana.lua")
    removeLuaScript(currentModDirectory.."/scripts/noteRGB.lua")
    removeLuaScript(currentModDirectory.."/scripts/noteSplashStuff.lua")
    if paus then
        removeLuaScript(currentModDirectory.."/scripts/disabled/pauseSubState.lua")
    elseif ovo then
        removeLuaScript(currentModDirectory.."/scripts/disabled/itsBingover.lua")
    end

    playSound(pathBGM.."bs_calm", 1, 'bgm', true)
    if shadersEnabled then
        precacheSound(pathBGS.."amb_rain_splatty")

        playSound(pathBGS.."amb_rain_splatty", 1, 'rain', true)
    end

    setCharacterX("boyfriend", quietArea.kittySpawn[1])
    setCharacterY("boyfriend", quietArea.kittySpawn[2])
    
    setProperty('camGame.bgColor', getColorFromHex('FFFFFF'))

    makeLuaSprite('bor', pathBorder..'border_blackspace_handheld')
    setObjectCamera('bor', 'other')
    scaleObject('bor', 0.67, 0.67)
    screenCenter('bor')
    --setProperty("bor.alpha", 0.5)
    addLuaSprite("bor", true)

    makeLuaSprite('clouds', pathQA..'!BS_cloud_parallax', 0, 0)
    screenCenter('clouds')
    setScrollFactor("clouds", 0, 0)
    addLuaSprite("clouds", false)

    makeLuaSprite('clouds2', pathQA..'!BS_cloud_parallax', 0, 0)
    screenCenter('clouds2', 'y')
    setScrollFactor("clouds2", 0, 0)
    addLuaSprite("clouds2", false)
    setProperty("clouds2.flipX", true)
    setProperty("clouds2.x", -getProperty("clouds2.width"))

    makeAnimatedLuaSprite('pier', pathQA..'quiet-bg', quietArea.pier[1], quietArea.pier[2])
    scaleObject("pier", 2, 2)
    addAnimationByPrefix("pier", "idle", "waterfunny", 5, true)
    addLuaSprite("pier", false)

    createHitbox()
end

function createHitbox()

    makeLuaSprite("playerHB", nil, getGraphicMidpointX("boyfriend") + 10, getGraphicMidpointY("boyfriend") + 16)
    makeGraphic("playerHB", 20, 25, '0000FF')
    setProperty("playerHB.alpha", 0)
    addLuaSprite("playerHB", true)
    updateHitbox("playerHB")
end

function onUpdate(elapsed)

    setProperty("playerHB.x", getGraphicMidpointX("boyfriend") - 3)
    setProperty("playerHB.y", getGraphicMidpointY("boyfriend") + 2)
    triggerEvent("Camera Follow Pos", getGraphicMidpointX("boyfriend") + 18, getGraphicMidpointY("boyfriend"))

    if keyboardPressed("X") then
        walkSpeed = 6
        moveAnim = 'run'
    else
        walkSpeed = 2
        moveAnim = 'walk'
    end
    
    if clicavel then
        if keyboardJustPressed('ESCAPE') then
            clicavel = false
            playAnim("boyfriend", "stab", true)
        elseif keyboardPressed("DOWN") and moveDown then
            playAnim("boyfriend", moveAnim.."-down")
            setProperty("boyfriend.y", getProperty("boyfriend.y") + walkSpeed)
            looking = 'down'
        elseif keyboardReleased("DOWN") then
            playAnim("boyfriend", "idle-down")
        elseif keyboardPressed("UP") and moveUp then
            playAnim("boyfriend", moveAnim.."-up")
            setProperty("boyfriend.y", getProperty("boyfriend.y") - walkSpeed)
            looking = 'up'
        elseif keyboardReleased("UP") then
            playAnim("boyfriend", "idle-up")
        elseif keyboardPressed("RIGHT") and moveRight then
            setSoundVolume("null", 0)
            playAnim("boyfriend", moveAnim.."-right")
            setProperty("boyfriend.x", getProperty("boyfriend.x") + walkSpeed)
            looking = 'right'
        elseif keyboardReleased("RIGHT") then
            playAnim("boyfriend", "idle-right")
        elseif keyboardPressed("LEFT") and moveLeft then
            setSoundVolume("null", 0)
            playAnim("boyfriend", moveAnim.."-left")
            setProperty("boyfriend.x", getProperty("boyfriend.x") - walkSpeed)
            looking = 'left'
        elseif keyboardReleased("LEFT") then
            playAnim("boyfriend", "idle-left")
        end
    end

    if keyboardJustPressed("J") and ativado then
        setProperty("clouds2.x", getProperty("clouds2.x") - quanto)
    elseif keyboardJustPressed("L") and ativado then
        setProperty("clouds2.x", getProperty("clouds2.x") + quanto)
    elseif keyboardJustPressed("I") and ativado then
        setProperty("clouds2.y", getProperty("clouds2.y") - quanto)
    elseif keyboardJustPressed("K") and ativado then
        setProperty("clouds2.y", getProperty("clouds2.y") + quanto)
    elseif keyboardPressed("CONTROL") and keyboardJustPressed("S") and ativado then
        saveFile('mods/KittyBucks/data/_ROOMS/blackspace/quietArea.json', '{\n    // player\n   "kittySpawn": ['..getProperty("boyfriend.x")..', '..getProperty("boyfriend.y")..'],\n\n    // obj\n    "pier": [1000, 1000]\n}', true)
        debugPrint('                                                               Arquivo salvo', '00ff00')
        playSound(pathSE.."BA_Heart_Heal", 0.3, 'saved')
    end

    if keyboardPressed("SHIFT") then
        quanto = 10
    else
        quanto = 1
    end

    if getProperty('boyfriend.animation.curAnim.name') == 'stab' then
        if getProperty('boyfriend.animation.curAnim.curFrame') == 21 then
            runTimer("vish", 0.1)
        elseif getProperty('boyfriend.animation.curAnim.curFrame') == 25 then
            runTimer("morreu", 1)
        end
    end
end

function onUpdatePost(elapsed)
    
    setProperty("clouds2.x", getProperty("clouds2.x")+1)
    setProperty("clouds.x", getProperty("clouds.x")+1)

    if getProperty("clouds2.x") >= screenWidth then
        setProperty("clouds2.x", -getProperty("clouds2.width"))
    elseif getProperty("clouds.x") >= screenWidth then
        setProperty("clouds.x", -getProperty("clouds.width"))
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    
    if tag == 'vish' then
        playSound(pathSE.."GEN_stab", 1, 'aaa')
        stopSound("bgm")
    elseif tag == 'morreu' then
        setProperty("camGame.alpha", 0)
        setProperty("camHUD.alpha", 0)
        setProperty("camOther.alpha", 0)
        runTimer("agoraVaza", 2)
    elseif tag == 'agoraVaza' then
        exitSong(false)
    end
end

function onTweenCompleted(tag, vars)
    
    if tag == 'loop1' then
        setProperty("clouds.x", -getProperty("clouds.width"))
        doTweenX("loop1", "clouds", screenWidth, 10, "linear")
    elseif tag == 'loop2' then
        setProperty("clouds2.x", -getProperty("clouds2.width"))
        doTweenX("loop2", "clouds2", screenWidth, 10, "linear")
    end
end