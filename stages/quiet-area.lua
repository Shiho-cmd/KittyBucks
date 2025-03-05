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
local soundSpeed = 0.005
local moveDown = true
local moveUp = true
local moveRight = true
local moveLeft = true
local looking = 'down'
local the = false

local win = getTranslationPhrase('win_qa', 'Quiet Area')

local bct = 1
local quanto = 1
local ativado = false
local curTag = 1
local tags = {'bruhto', 'pier', 'pep', 'sprout'}
local maxTagNum = 4
local shader = 'none'

local tagsObjsAlpha = {'pier', 'pep', 'sprout', 'wter', 'boyfriend'}

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
    precacheSound(pathSE.."lemonade")

    removeLuaScript(currentModDirectory.."/scripts/gozadaInsana.lua")
    removeLuaScript(currentModDirectory.."/scripts/noteRGB.lua")
    removeLuaScript(currentModDirectory.."/scripts/noteSplashStuff.lua")
    if paus then
        removeLuaScript(currentModDirectory.."/scripts/disabled/pauseSubState.lua")
    elseif ovo then
        removeLuaScript(currentModDirectory.."/scripts/disabled/itsBingover.lua")
    end

    playSound(pathBGM.."xx_gibs_song", 1, 'bgm', true)
    playSound(pathSE.."lemonade", 0.5, 'lemon', true)
    setSoundPitch('bgm', 0.6)

    setCharacterX("boyfriend", quietArea.kittySpawn[1])
    setCharacterY("boyfriend", quietArea.kittySpawn[2])
    
    setProperty('camGame.bgColor', getColorFromHex('000000'))

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

    makeAnimatedLuaSprite('wter', pathQA..'water-overworld', quietArea.pier[1], quietArea.pier[2])
    scaleObject("wter", 2, 2)
    addAnimationByPrefix("wter", "idle", "loop", 5, true)
    addLuaSprite("wter", false)

    makeLuaSprite('pier', pathQA..'pier', quietArea.pier[1], quietArea.pier[2])
    scaleObject("pier", 2, 2)
    addLuaSprite("pier", false)

    makeLuaText("bucetas", "", 0, 0.0, 0.0)
    setObjectCamera("bucetas", 'other')
    setTextFont("bucetas", "omori.ttf")
    setTextSize("bucetas", 35)
    setTextAlignment("bucetas", 'left')
    addLuaText("bucetas")

    makeLuaSprite("water", pathQA..'waterBack', -130, -360)
    setScrollFactor("water", 0, 0)
    addLuaSprite("water", true)
    doTweenX("funny", "water", -30, 10, "linear")
    setProperty("water.alpha", 0.00001)

    makeAnimatedLuaSprite("bruhto", 'characters/omori/sprouter-closeup', 0, 326)
    addAnimationByPrefix("bruhto", "neutral", "neutral-alt", 0, false)
    scaleObject("bruhto", 2, 2)
    setScrollFactor("bruhto", 0, 0)
    addLuaSprite("bruhto", true)
    setProperty("bruhto.x", -getProperty("bruhto.width"))
    doTweenX("bro", "bruhto", screenWidth, 10, "quadInOut")
    doTweenY("bros", "bruhto", 316, 10, "quadInOut")
    setProperty("bruhto.alpha", 0.00001)

    makeLuaSprite("waterF", pathQA..'waterFront', -130, -360)
    setScrollFactor("waterF", 0, 0)
    addLuaSprite("waterF", true)
    doTweenX("unfunny", "waterF", -30, 15, "linear")
    setProperty("waterF.alpha", 0.00001)

    if shadersEnabled then
        precacheSound(pathBGS.."amb_rain_splatty")

        playSound(pathBGS.."amb_rain_splatty", 1, 'rain', true)
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
    setObjectOrder("sprout", getObjectOrder("pier"))

    makeAnimatedLuaSprite("pep", 'characters/omori/peppy_overworld', quietArea.peppy[1], quietArea.peppy[2])
    addAnimationByPrefix("pep", "idle-up", "looking-up-alt", 0, false)
    addAnimationByPrefix("pep", "idle-left", "looking-left-alt", 0, false)
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

function onUpdate(elapsed)

    if keyboardPressed("X") then
        walkSpeed = 6
        soundSpeed = 0.015
        moveAnim = 'run'
    else
        walkSpeed = 2
        soundSpeed = 0.005
        moveAnim = 'walk'
    end
    
    if clicavel then
        if keyboardJustPressed('ESCAPE') then
            clicavel = false
            playAnim("boyfriend", "stab", true)
        elseif keyboardPressed("DOWN") and moveDown then
            looking = 'down'
            playAnim("boyfriend", moveAnim.."-down")
            setProperty("boyfriend.y", getProperty("boyfriend.y") + walkSpeed)
        elseif keyboardReleased("DOWN") then
            playAnim("boyfriend", "idle-down")
        elseif keyboardPressed("UP") and moveUp then
            looking = 'up'
            playAnim("boyfriend", moveAnim.."-up")
            setProperty("boyfriend.y", getProperty("boyfriend.y") - walkSpeed)
        elseif keyboardReleased("UP") then
            playAnim("boyfriend", "idle-up")
        elseif keyboardPressed("RIGHT") and moveRight then
            looking = 'right'
            setSoundVolume("null", 0)
            playAnim("boyfriend", moveAnim.."-right")
            setProperty("boyfriend.x", getProperty("boyfriend.x") + walkSpeed)
            setSoundVolume("lemon", getSoundVolume("lemon") + soundSpeed)
        elseif keyboardReleased("RIGHT") then
            playAnim("boyfriend", "idle-right")
        elseif keyboardPressed("LEFT") and moveLeft then
            looking = 'left'
            setSoundVolume("null", 0)
            playAnim("boyfriend", moveAnim.."-left")
            setProperty("boyfriend.x", getProperty("boyfriend.x") - walkSpeed)
            setSoundVolume("lemon", getSoundVolume("lemon") - soundSpeed)
        elseif keyboardReleased("LEFT") then
            playAnim("boyfriend", "idle-left")
        end
    end

    if getSoundVolume("lemon") > 1 then
        setSoundVolume("lemon", 1)
    elseif getSoundVolume("lemon") < 0.2 then
        setSoundVolume("lemon", 0.2)
    end

    if getProperty("boyfriend.x") >= getProperty("rightHB.x") - getProperty("rightHB.width") + 20 then -- right
        playAnim("boyfriend", "idle-right")
        setProperty("boyfriend.x", getProperty("rightHB.x") - getProperty("rightHB.width") + 19)

    elseif getProperty("boyfriend.x") <= getProperty("leftHB.x") + getProperty("leftHB.width") - 5 then -- left
        playAnim("boyfriend", "idle-left")
        setProperty("boyfriend.x", getProperty("leftHB.x") + getProperty("leftHB.width") - 4)
        
    elseif getProperty("boyfriend.y") >= getProperty("downHB.y") - getProperty("downHB.height") + 5 then -- down
        playAnim("boyfriend", "idle-down")
        setProperty("boyfriend.y", getProperty("downHB.y") - getProperty("downHB.height") + 4)
    
    elseif getProperty("boyfriend.y") <= getProperty("upHB.y") + getProperty("upHB.height") - 30 then -- up
        playAnim("boyfriend", "idle-up")
        setProperty("boyfriend.y", getProperty("upHB.y") + getProperty("upHB.height") - 29)
    end

    if getProperty("boyfriend.y") == 1043 and keyboardJustPressed("Z") and clicavel and looking == 'up' then
        clicavel = false
        doTweenAlpha("pinto", "camGame", 0.00001, 1, "linear")
    elseif keyboardJustPressed("C") and the then
        clicavel = true
        the = false
        doTweenAlpha("xibiu", "camGame", 0.00001, 1, "linear")
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
        --[[stopSound("lemon")
        playAnim("pep", "idle-left")]]
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
   
    for i = 1,#tagsObjsAlpha do
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
    elseif tag == 'VAIIIIi' then
        doTweenX("VOLTAAAAa", "refleSprout", 1070, 10, "quadInOut")
    elseif tag == 'VOLTAAAAa' then
        doTweenX("VAIIIIi", "refleSprout", 1508, 10, "quadInOut")

    elseif tag == 'funny' then
        doTweenX("funner", "water", -130, 10, "quadInOut")
    elseif tag == 'funner' then
        doTweenX("funny", "water", -30, 10, "quadInOut")
    elseif tag == 'unfunny' then
        doTweenX("unfunner", "waterF", -130, 10, "quadInOut")
    elseif tag == 'unfunner' then
        doTweenX("unfunny", "waterF", -30, 15, "quadInOut")

    elseif tag == 'bro' then
        doTweenX("orb", "bruhto", -getProperty("bruhto.width"), 10, "quadInOut")
    elseif tag == 'orb' then
        doTweenX("bro", "bruhto", screenWidth, 10, "quadInOut")

    elseif tag == 'bros' then
        doTweenY("sorb", "bruhto", 316, 1, "quadInOut")
    elseif tag == 'sorb' then
        doTweenY("bros", "bruhto", 326, 1, "quadInOut")

        elseif tag == 'pinto' then
            the = true
            setProperty(tagsObjsAlpha[i]..'.alpha', 0.0001)
            setProperty("water.alpha", 1)
            setProperty("waterF.alpha", 1)
            setProperty("bruhto.alpha", 1)
            doTweenAlpha("penis", "camGame", 1, 1, "linear")
        elseif tag == 'xibiu' then
            the = false
            setProperty(tagsObjsAlpha[i]..'.alpha', 1)
            setProperty("water.alpha", 0.00001)
            setProperty("waterF.alpha", 0.00001)
            setProperty("bruhto.alpha", 0.00001)
            doTweenAlpha("vagina", "camGame", 1, 1, "linear")
        end
    end
end