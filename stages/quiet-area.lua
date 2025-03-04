luaDebugMode = true

function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local quietArea = parseJson('data/_ROOMS/blackspace/quietArea.json')
local quietAreaDialogue = parseJson('data/_ROOMS/blackspace/quietArea-dialogue-EN.json')

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

local win = getTranslationPhrase('win_qa', 'Quiet Area')

local bct = 1
local quanto = 1
local ativado = false
local curTag = 1
local tags = {'pier', 'pep', 'upHB', 'downHB', 'rightHB', 'leftHB', 'sprout'}
local maxTagNum = 7
local shader = 'none'

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

    initLuaShader("water")

    setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | '..win)

    precacheSound(pathBGM.."bs_calm")
    precacheSound(pathBGM.."xx_gibs_song")
    precacheSound(pathSE.."GEN_stab")

    removeLuaScript(currentModDirectory.."/scripts/gozadaInsana.lua")
    removeLuaScript(currentModDirectory.."/scripts/noteRGB.lua")
    removeLuaScript(currentModDirectory.."/scripts/noteSplashStuff.lua")
    if paus then
        removeLuaScript(currentModDirectory.."/scripts/disabled/pauseSubState.lua")
    elseif ovo then
        removeLuaScript(currentModDirectory.."/scripts/disabled/itsBingover.lua")
    end

    playSound(pathBGM.."xx_gibs_song", 1, 'bgm', true)
    setSoundPitch('bgm', 0.6)

    setCharacterX("boyfriend", quietArea.kittySpawn[1])
    setCharacterY("boyfriend", quietArea.kittySpawn[2])
    
    setProperty('camGame.bgColor', getColorFromHex('FFFFFF'))

    makeLuaSprite('bor', pathBorder..'border_blackspace_handheld')
    setObjectCamera('bor', 'other')
    scaleObject('bor', 0.67, 0.67)
    screenCenter('bor')
    --setProperty("bor.alpha", 0.5)
    addLuaSprite("bor", false)

    makeLuaSprite('over', path..'SW_Ambience', 0, 0)
    setObjectCamera('over', 'hud')
    scaleObject('over', 1.6, 1.6)
    screenCenter('over')
    setProperty("over.alpha", 0.7)
    addLuaSprite("over", false)

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

    makeLuaText("bucetas", "", 0, 0.0, 0.0)
    setObjectCamera("bucetas", 'other')
    setTextFont("bucetas", "omori.ttf")
    setTextSize("bucetas", 35)
    setTextAlignment("bucetas", 'left')
    addLuaText("bucetas")

    makeAnimatedLuaSprite("refleKitty", 'characters/omori/kitty_overworld')
    addAnimationByIndices("refleKitty", "idle-down", "walk_down", '1', 0, false)
    addAnimationByIndices("refleKitty", "idle-up", "walk_up", '1', 0, false)
    addAnimationByIndices("refleKitty", "idle-left", "walk_left", '1', 0, false)
    addAnimationByIndices("refleKitty", "idle-right", "walk_right", '1', 0, false)
    addAnimationByIndices("refleKitty", "walk-down", "walk_down", '0, 1, 2, 1', 5, true)
    addAnimationByIndices("refleKitty", "walk-up", "walk_up", '0, 1, 2, 1', 5, true)
    addAnimationByIndices("refleKitty", "walk-left", "walk_left", '0, 1, 2, 1', 5, true)
    addAnimationByIndices("refleKitty", "walk-right", "walk_right", '0, 1, 2, 1', 5, true)
    addAnimationByIndices("refleKitty", "run-down", "run_down", '7, 6, 5, 4, 3, 2, 1, 0', 12, true)
    addAnimationByIndices("refleKitty", "run-up", "run_up", '7, 6, 5, 4, 3, 2, 1, 0', 12, true)
    addAnimationByIndices("refleKitty", "run-left", "run_left", '7, 6, 5, 4, 3, 2, 1, 0', 12, true)
    addAnimationByIndices("refleKitty", "run-right", "run_right", '7, 6, 5, 4, 3, 2, 1, 0', 12, true)
    addAnimationByIndices("refleKitty", "stab", "stab", '13, 12, 11, 10, 9, 8, 7, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 5, 4, 3, 2, 1, 0', 5, false)
    scaleObject("refleKitty", 2, 2)
    setProperty("refleKitty.flipY", true)
    setProperty("refleKitty.x", getProperty("boyfriend.x") - 14)
    setProperty("refleKitty.y", getProperty("boyfriend.y") + 110)
    setProperty("refleKitty.alpha", 0.5)
    addLuaSprite("refleKitty", false)

    if shadersEnabled then
        precacheSound(pathBGS.."amb_rain_splatty")

        playSound(pathBGS.."amb_rain_splatty", 1, 'rain', true)
        setSpriteShader("refleKitty", 'water')
    end

    createHitbox()
    createNPC()
end

function createNPC()

    makeAnimatedLuaSprite("sprout", 'characters/omori/sprouter-overworld', quietArea.sprouter[1], quietArea.sprouter[2])
    addAnimationByPrefix("sprout", "idle", "idle-water-alt",  5, true)
    addAnimationByPrefix("sprout", "talk", "talk-water-alt", 5, true)
    scaleObject("sprout", 2, 2)
    addLuaSprite("sprout", false)
    doTweenX("VAIIII", "sprout", 1508, 10, "quadInOut")

    makeAnimatedLuaSprite("pep", 'characters/omori/peppy_overworld', quietArea.peppy[1], quietArea.peppy[2])
    addAnimationByPrefix("pep", "idle-up", "looking-up-alt", 0, false)
    scaleObject("pep", 2, 2)
    addLuaSprite("pep", false)
end

function createHitbox()

    makeLuaSprite("playerHB", nil, getGraphicMidpointX("boyfriend") + 10, getGraphicMidpointY("boyfriend") + 16)
    makeGraphic("playerHB", 20, 10, '0000FF')
    setProperty("playerHB.alpha", 0)
    addLuaSprite("playerHB", true)
    updateHitbox("playerHB")

    makeLuaSprite("upHB", nil, quietArea.upHB[1], quietArea.upHB[2])
    makeGraphic("upHB", 509, 50, 'FF0000')
    setProperty("upHB.alpha", 0)
    addLuaSprite("upHB", true)
    updateHitbox("upHB")

    makeLuaSprite("downHB", nil, quietArea.downHB[1], quietArea.downHB[2])
    makeGraphic("downHB", 509, 50, 'FF0000')
    setProperty("downHB.alpha", 0)
    addLuaSprite("downHB", true)
    updateHitbox("downHB")

    makeLuaSprite("rightHB", nil, quietArea.rightHB[1], quietArea.rightHB[2])
    makeGraphic("rightHB", 50, 168, 'FF0000')
    setProperty("rightHB.alpha", 0)
    addLuaSprite("rightHB", true)
    updateHitbox("rightHB")

    makeLuaSprite("leftHB", nil, quietArea.leftHB[1], quietArea.leftHB[2])
    makeGraphic("leftHB", 50, 168, 'FF0000')
    setProperty("leftHB.alpha", 0)
    addLuaSprite("leftHB", true)
    updateHitbox("leftHB")
end

local funny = 0.01
local kittyAlpha = 0

function onUpdate(elapsed)

    if shadersEnabled then
        funny = funny + 0.05
        setShaderFloat("refleKitty", "iTime", funny)
    end

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
            playAnim("refleKitty", "stab", true)
        elseif keyboardPressed("DOWN") and moveDown then
            looking = 'down'
            playAnim("boyfriend", moveAnim.."-down")
            playAnim("refleKitty", moveAnim.."-down")
            kittyAlpha = kittyAlpha + 0.05
            setProperty("boyfriend.y", getProperty("boyfriend.y") + walkSpeed)
        elseif keyboardReleased("DOWN") then
            playAnim("boyfriend", "idle-down")
            playAnim("refleKitty", "idle-down")
        elseif keyboardPressed("UP") and moveUp then
            looking = 'up'
            playAnim("boyfriend", moveAnim.."-up")
            playAnim("refleKitty", moveAnim.."-up")
            kittyAlpha = kittyAlpha - 0.05
            setProperty("boyfriend.y", getProperty("boyfriend.y") - walkSpeed)
        elseif keyboardReleased("UP") then
            playAnim("boyfriend", "idle-up")
            playAnim("refleKitty", "idle-up")
        elseif keyboardPressed("RIGHT") and moveRight then
            looking = 'right'
            setSoundVolume("null", 0)
            playAnim("boyfriend", moveAnim.."-right")
            playAnim("refleKitty", moveAnim.."-right")
            setProperty("boyfriend.x", getProperty("boyfriend.x") + walkSpeed)
        elseif keyboardReleased("RIGHT") then
            playAnim("boyfriend", "idle-right")
            playAnim("refleKitty", "idle-right")
        elseif keyboardPressed("LEFT") and moveLeft then
            looking = 'left'
            setSoundVolume("null", 0)
            playAnim("boyfriend", moveAnim.."-left")
            playAnim("refleKitty", moveAnim.."-left")
            setProperty("boyfriend.x", getProperty("boyfriend.x") - walkSpeed)
        elseif keyboardReleased("LEFT") then
            playAnim("boyfriend", "idle-left")
            playAnim("refleKitty", "idle-left")
        end
    end

    if kittyAlpha > 0.5 then
        kittyAlpha = 0.5
    elseif kittyAlpha < 0 then
        kittyAlpha = 0
    end

    if getProperty("boyfriend.x") >= getProperty("rightHB.x") - getProperty("rightHB.width") + 20 then -- right
        playAnim("boyfriend", "idle-right")
        playAnim("refleKitty", "idle-right")
        setProperty("boyfriend.x", getProperty("rightHB.x") - getProperty("rightHB.width") + 19)

    elseif getProperty("boyfriend.x") <= getProperty("leftHB.x") + getProperty("leftHB.width") - 5 then -- left
        playAnim("boyfriend", "idle-left")
        playAnim("refleKitty", "idle-left")
        setProperty("boyfriend.x", getProperty("leftHB.x") + getProperty("leftHB.width") - 4)
        
    elseif getProperty("boyfriend.y") >= getProperty("downHB.y") - getProperty("downHB.height") + 5 then -- down
        playAnim("boyfriend", "idle-down")
        playAnim("refleKitty", "idle-down")
        setProperty("boyfriend.y", getProperty("downHB.y") - getProperty("downHB.height") + 4)
    
    elseif getProperty("boyfriend.y") <= getProperty("upHB.y") + getProperty("upHB.height") - 30 then -- up
        playAnim("boyfriend", "idle-up")
        playAnim("refleKitty", "idle-up")
        setProperty("boyfriend.y", getProperty("upHB.y") + getProperty("upHB.height") - 29)
    end

    setProperty("playerHB.x", getGraphicMidpointX("boyfriend") - 6)
    setProperty("playerHB.y", getGraphicMidpointY("boyfriend") + 18)
    setProperty("refleKitty.x", getProperty("boyfriend.x") - 14)
    setProperty("refleKitty.alpha", kittyAlpha)
    triggerEvent("Camera Follow Pos", getGraphicMidpointX("boyfriend") + 18, getGraphicMidpointY("boyfriend"))

    if keyboardJustPressed("Q") then
        bct = bct + 1
        playSound(pathSE.."SYS_select", 0.5, 'move')
    elseif keyboardJustPressed("W") then
        curTag = curTag - 1
        playSound(pathSE.."SYS_move", 0.5, 'move')
    elseif keyboardJustPressed("E") then
        curTag = curTag + 1
        playSound(pathSE.."SYS_move", 0.5, 'move')
    end

    if bct == 2 then
        ativado = true
    elseif bct == 1 then
        ativado = false
    elseif bct > 2 then
        bct = 1
    end

    if curTag > maxTagNum then
        curTag = 1
    elseif curTag < 1 then
        curTag = maxTagNum
    end

    if keyboardJustPressed("J") and ativado then
        setProperty(tags[curTag]..".x", getProperty(tags[curTag]..".x") - quanto)
    elseif keyboardJustPressed("L") and ativado then
        setProperty(tags[curTag]..".x", getProperty(tags[curTag]..".x") + quanto)
    elseif keyboardJustPressed("I") and ativado then
        setProperty(tags[curTag]..".y", getProperty(tags[curTag]..".y") - quanto)
    elseif keyboardJustPressed("K") and ativado then
        setProperty(tags[curTag]..".y", getProperty(tags[curTag]..".y") + quanto)
    elseif keyboardJustPressed("R") and ativado then
        setProperty("pier.x", quietArea.pier[1])
        setProperty("pier.y", quietArea.pier[2])
        setProperty("pep.x", quietArea.peppy[1])
        setProperty("pep.y", quietArea.peppy[2])
        setProperty("upHB.x", quietArea.upHB[1])
        setProperty("upHB.y", quietArea.upHB[2])
        debugPrint('                                                             Posições resetadas', 'ff0000')
        playSound(pathSE.."sys_cancel", 0.5, 'reset')
    elseif keyboardPressed("CONTROL") and keyboardJustPressed("S") and ativado then
        saveFile('mods/KittyBucks/data/_ROOMS/blackspace/quietArea.json', '{\n\n    // player\n   "kittySpawn": [1294, 1068],\n\n   // npc\n   "peppy": ['..getProperty("pep.x")..', '..getProperty("pep.y")..'],\n   "sprouter": ['..getProperty("sprout.x")..', '..getProperty("sprout.y")..'],\n\n    // obj\n    "pier": ['..getProperty("pier.x")..', '..getProperty("pier.y")..'],\n\n    // hitbox\n    "upHB": ['..getProperty("upHB.x")..', '..getProperty("upHB.y")..'],\n    "downHB": ['..getProperty("downHB.x")..', '..getProperty("downHB.y")..'],\n    "rightHB": ['..getProperty("rightHB.x")..', '..getProperty("rightHB.y")..'],\n    "leftHB": ['..getProperty("leftHB.x")..', '..getProperty("leftHB.y")..']\n}', true)
        debugPrint('                                                               Arquivo salvo', '00ff00')
        playSound(pathSE.."BA_Heart_Heal", 0.3, 'saved')
    end

    if keyboardPressed("SHIFT") then
        quanto = 10
    else
        quanto = 1
    end

    if ativado then
        setTextString("bucetas", "Debug info:\nEdit mode: "..string.upper(tostring(ativado))..'\nObj selecionado: '..string.upper(tags[curTag])..'\nObj X: '..getProperty(tags[curTag]..".x")..'\nObj Y: '..getProperty(tags[curTag]..".y")..'\n\nPlayer info:\nBF X: '..getProperty("boyfriend.x")..'\nBF Y: '..getProperty("boyfriend.y")..'\n\nCamera info:\nCam X: '..getCameraFollowX()..'\nCam Y: '..getCameraFollowY())
        screenCenter("bucetas", 'y')
    else
        setTextString("bucetas", '')
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
    elseif tag == 'VAIIII' then
        doTweenX("VOLTAAAA", "sprout", 1070, 10, "quadInOut")
    elseif tag == 'VOLTAAAA' then
        doTweenX("VAIIII", "sprout", 1508, 10, "quadInOut")
    end
end