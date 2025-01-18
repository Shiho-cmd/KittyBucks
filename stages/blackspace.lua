function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local mainArea = parseJson('data/_ROOMS/blackspace/mainArea.json')
local mainAreaDialogue = parseJson('data/_ROOMS/blackspace/mainArea-dialogue.json')

local path = 'backgrounds/omori/'
local pathBorder = 'backgrounds/omori/borders'
local pathBattle = 'backgrounds/omori/battleStuff'

luaDebugMode = true

local texto = "ISSO E UM TESTE INSANO PORRAAA"

local txtVelo = 0.04

local clicavel = false
local cutClicavel = false
local cutOver = false
local curDialogue = 1
local onDialogue = false

function onStartCountdown()
    
    triggerEvent("Camera Follow Pos", getGraphicMidpointX("boyfriend") + 18, getGraphicMidpointY("boyfriend") - 700)
    setProperty("dadGroup.visible", false)
    setProperty("botplayTxt.visible", false)
    setProperty("scoreTxt.visible", false)
    setProperty("healthBar.visible", false)
    setProperty("iconP1.visible", false)
    setProperty("iconP2.visible", false)
    return Function_Stop;
end

function onCreate()

    setProperty("camGame.alpha", 0.0001)
    setProperty("camOther.alpha", 0.0001)

    precacheSound("omori/bgm/bs_entrance")
    precacheSound("omori/se/GEN_stab")
    precacheSound("omori/se/sys_blackletter1")
    precacheSound("omori/se/sys_blackletter2")

    setProperty('camGame.bgColor', getColorFromHex('000000'))

    setCharacterX("boyfriend", mainArea.kittySpawn[1])
    setCharacterY("boyfriend", mainArea.kittySpawn[2])
    
    makeLuaSprite('bor', 'backgrounds/omori/borders/border_blackspace_handheld')
    setObjectCamera('bor', 'other')
    scaleObject('bor', 0.67, 0.67)
    screenCenter('bor')
    addLuaSprite('bor', false)

    makeLuaSprite("aviso", 'backgrounds/omori/blackspace/warning', 0, 0)
    setObjectCamera("aviso", 'hud')
    scaleObject("aviso", 1.5, 1.5)
    screenCenter("aviso", 'xy')
    setProperty("aviso.alpha", 0.0001)
    addLuaSprite("aviso", true)

    makeAnimatedLuaSprite("intro", 'backgrounds/omori/blackspace/welcum', 0, 0)
    addAnimationByPrefix("intro", "kit", "kitty", 2, true)
    addAnimationByPrefix("intro", "wel", "welcome", 3, true)
    setObjectCamera("intro", 'hud')
    scaleObject("intro", 1.5, 1.5)
    screenCenter("intro", 'xy')
    setProperty("intro.alpha", 0.0001)
    addLuaSprite("intro", true)
    doTweenAlpha("start", "intro", 1, 1.5, "linear")
    playSound("omori/se/sys_blackletter1", 1, 'fadeIn')

    makeLuaSprite("tapa", 'backgrounds/omori/blackspace/tapete', mainArea.tapete[1], mainArea.tapete[2])
    scaleObject("tapa", 2, 2)
    screenCenter("tapa")
    addLuaSprite("tapa", false)

    makeAnimatedLuaSprite("lap", 'backgrounds/omori/blackspace/laptop', mainArea.laptop[1], mainArea.laptop[2])
    addAnimationByPrefix("lap", "idle", "static", 3, true)
    scaleObject("lap", 1, 1)
    addLuaSprite("lap")

    makeAnimatedLuaSprite("door-mago", 'backgrounds/omori/blackspace/door', mainArea.portaMago[1], mainArea.portaMago[2])
    addAnimationByPrefix("door-mago", "open", "daFunnyDoor", 3, false)
    addAnimationByIndices("door-mago", "close", "daFunnyDoor", '6,5,4,3,2,1', 5, false)
    addAnimationByIndices("door-mago", "idle", "daFunnyDoor", '1', 5, false)
    scaleObject("door-mago", 2, 2)
    addLuaSprite("door-mago")

    makeAnimatedLuaSprite("door-snow", 'backgrounds/omori/blackspace/door', mainArea.portaKeroppi[1], mainArea.portaKeroppi[2])
    addAnimationByPrefix("door-snow", "open", "daFunnyDoor", 3, false)
    addAnimationByIndices("door-snow", "close", "daFunnyDoor", '6,5,4,3,2,1', 5, false)
    addAnimationByIndices("door-snow", "idle", "daFunnyDoor", '1', 5, false)
    scaleObject("door-snow", 2, 2)
    addLuaSprite("door-snow")

    makeLuaSprite("fio", 'backgrounds/omori/blackspace/wire', mainArea.fio[1], mainArea.fio[2])
    scaleObject("fio", 2, 2)
    addLuaSprite("fio", true)

    makeLuaText("tuto", '', 500, 0.0, screenHeight - 200)
    setTextFont("tuto", "omori.ttf")
    setTextSize("tuto", 35)
    screenCenter("tuto", 'x')
    setTextAlignment("tuto", 'left')
    addLuaText("tuto")

    makeLuaText("xddd", '', 0, 0.0, 0)
    setTextFont("xddd", "omori.ttf")
    setTextSize("xddd", 35)
    screenCenter("xddd", 'x')
    setObjectCamera("xddd", 'other')
    addLuaText("xddd")

    createHitbox()
end

function createHitbox()

    makeLuaSprite("ht", nil, mainArea.laptopHB[1], mainArea.laptopHB[2])
    makeGraphic("ht", 32, 17, 'FF0000')
    setProperty("ht.alpha", 0.5)
    addLuaSprite("ht", false)
    updateHitbox("ht")

    makeLuaSprite("playerHB", nil, getGraphicMidpointX("boyfriend") + 10, getGraphicMidpointY("boyfriend") + 16)
    makeGraphic("playerHB", 20, 25, '0000FF')
    setProperty("playerHB.alpha", 0.5)
    addLuaSprite("playerHB", true)
    updateHitbox("playerHB")
end

local quanto = 1

local moveDown = true
local moveUp = true
local moveRight = true
local moveLeft = true
local looking = 'down'

function onUpdate(elapsed)

    if cutOver then
        triggerEvent("Camera Follow Pos", getGraphicMidpointX("boyfriend") + 18, getGraphicMidpointY("boyfriend"))
    end

    setProperty("playerHB.x", getGraphicMidpointX("boyfriend") - 3)
    setProperty("playerHB.y", getGraphicMidpointY("boyfriend") + 2)

    if getProperty("playerHB.y") < getProperty("ht.y") then
        setObjectOrder("lap", 99)
    else
        setObjectOrder("lap", 6)
    end
    
    if clicavel then
        if keyboardJustPressed('ESCAPE') then
            clicavel = false
            playAnim("boyfriend", "stab", true)
        elseif keyboardPressed("DOWN") and moveDown then
            playAnim("boyfriend", "walk-down")
            setProperty("boyfriend.y", getProperty("boyfriend.y") + 2)
            looking = 'down'
        elseif keyboardReleased("DOWN") then
            playAnim("boyfriend", "idle-down")
        elseif keyboardPressed("UP") and moveUp then
            playAnim("boyfriend", "walk-up")
            setProperty("boyfriend.y", getProperty("boyfriend.y") - 2)
            looking = 'up'
        elseif keyboardReleased("UP") then
            playAnim("boyfriend", "idle-up")
        elseif keyboardPressed("RIGHT") and moveRight then
            playAnim("boyfriend", "walk-right")
            setProperty("boyfriend.x", getProperty("boyfriend.x") + 2)
            looking = 'right'
        elseif keyboardReleased("RIGHT") then
            playAnim("boyfriend", "idle-right")
        elseif keyboardPressed("LEFT") and moveLeft then
            playAnim("boyfriend", "walk-left")
            setProperty("boyfriend.x", getProperty("boyfriend.x") - 2)
            looking = 'left'
        elseif keyboardReleased("LEFT") then
            playAnim("boyfriend", "idle-left")
        end
    end

    if objectsOverlap("playerHB", "ht") and looking == 'down' and getProperty("playerHB.y") < getProperty("ht.y") then
        moveDown = false
        playAnim("boyfriend", "idle-down")
    elseif objectsOverlap("playerHB", "ht") and looking == 'up' and getProperty("playerHB.y") > getProperty("ht.y") then
        moveUp = false
        playAnim("boyfriend", "idle-up")
    elseif objectsOverlap("playerHB", "ht") and looking == 'right' and getProperty("playerHB.x") < getProperty("ht.x") then
        moveRight = false
        playAnim("boyfriend", "idle-right")
    elseif objectsOverlap("playerHB", "ht") and looking == 'left' and getProperty("playerHB.x") > getProperty("ht.x") then
        moveLeft = false
        playAnim("boyfriend", "idle-left")
    else
        moveDown = true
        moveUp = true
        moveRight = true
        moveLeft = true
    end

    if cutClicavel then
        if keyboardJustPressed("ENTER") then
            cutClicavel = false
            playSound("omori/se/SYS_select", 1)
            removeLuaSprite("aviso")
            runTimer("vaiLogo", 2)
        elseif keyPressed('back') then
            cutClicavel = false
            exitSong(false)
        end
    end

    if onDialogue then
        if keyboardJustPressed('Z') then
            curDialogue = curDialogue + 1
            runTimer('escreve', txtVelo, string.len(mainAreaDialogue.tutorial[curDialogue])+1)
        end
    end

    if curDialogue == 3 and onDialogue then
        onDialogue = false
        clicavel = true
    end

    if keyboardJustPressed("A") then
        setProperty("ht.x", getProperty("ht.x") - quanto)
    elseif keyboardJustPressed("D") then
        setProperty("ht.x", getProperty("ht.x") + quanto)
    elseif keyboardJustPressed("W") then
        setProperty("ht.y", getProperty("ht.y") - quanto)
    elseif keyboardJustPressed("S") then
        setProperty("ht.y", getProperty("ht.y") + quanto)
    elseif keyboardJustPressed("SPACE") then
        saveFile('mods/KittyBucks/data/_ROOMS/blackspace/mainArea.json', '{\n    // player\n   "kittySpawn": [618, 334],\n\n    // obj\n    "tapete": ['..getProperty("tapa.x")..', '..getProperty("tapa.y")..'],\n    "laptop": ['..getProperty("lap.x")..', '..getProperty("lap.y")..'],\n    "portaMago": ['..getProperty("door-mago.x")..', '..getProperty("door-mago.y")..'],\n    "portaKeroppi": ['..getProperty("door-snow.x")..', '..getProperty("door-snow.y")..'],\n    "fio": ['..getProperty("fio.x")..', '..getProperty("fio.y")..'],\n\n    "laptopHB": ['..getProperty("ht.x")..', '..getProperty("ht.y")..'],\n    "portalMagHB": [0, 0],\n    "portalKeroppiHB": [0, 0]\n}', true)
        debugPrint('Arquivo salvo')
    end

    if keyboardPressed("SHIFT") then
        quanto = 10
    else
        quanto = 1
    end

    setTextString("xddd", 'x: '..getProperty("boyfriend.x")..'\n y: '..getProperty("boyfriend.y")..'\n Colidindo com o notebook: '..tostring(objectsOverlap("playerHB", "ht")))

    if getProperty('boyfriend.animation.curAnim.name') == 'stab' then
        if getProperty('boyfriend.animation.curAnim.curFrame') == 21 then
            runTimer("vish", 0.1)
        elseif getProperty('boyfriend.animation.curAnim.curFrame') == 25 then
            runTimer("morreu", 1)
        end
    end
end

function onSoundFinished(tag)
        
    if tag == 'bgm' then
        playSound("omori/bgm/bs_entrance", 1, 'bgm')
    elseif tag == 'fadeIn' then
        runTimer("opa", 2)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    
    if tag == 'escreve' then
        setTextString('tuto', string.sub(mainAreaDialogue.tutorial[curDialogue], 0, (loops - loopsLeft)))
        playSound('omori/se/SYS_text', 0.8)
    elseif tag == 'vish' then
        playSound("omori/se/GEN_stab", 1, 'aaa')
        stopSound("bgm")
    elseif tag == 'morreu' then
        setProperty("camGame.alpha", 0)
        setProperty("camHUD.alpha", 0)
        setProperty("camOther.alpha", 0)
        runTimer("agoraVaza", 2)
    elseif tag == 'agoraVaza' then
        exitSong(false)
    elseif tag == 'opa' then
        playSound("omori/se/sys_blackletter2", 1, 'fadeOut')
        doTweenAlpha("sumiu", "intro", 0.0001, 1.5, "linear")
        doTweenAlpha("apareceu", "aviso", 1, 1.5, "linear")
        cutClicavel = true
    elseif tag == 'vaiLogo' then
        setProperty("intro.alpha", 1)
        playAnim("intro", "kit")
        playSound("omori/bgm/bs_entrance", 1, 'bgm')
        runTimer("denovoPorra", 7)
    elseif tag == 'denovoPorra' then
        doTweenAlpha("bahMeu", "intro", 0, 1, "linear")
        doTweenAlpha("bahM", "camGame", 1, 1, "linear")
        doTweenAlpha("bah", "camOther", 1, 1, "linear")
        setProperty("cameraSpeed", 0.1)
        runTimer("numAguentoMaisTimers", 5)
        cutOver = true
        --clicavel = true
    elseif tag == 'numAguentoMaisTimers' then
        setProperty("cameraSpeed", 0.15)
        runTimer("PORRAAA", 3)
    elseif tag == 'PORRAAA' then
        setProperty("cameraSpeed", 0.25)
        runTimer("BCT", 5)
    elseif tag == 'BCT' then
        onDialogue = true
        setProperty("cameraSpeed", 99)
        runTimer('escreve', txtVelo, string.len(mainAreaDialogue.tutorial[curDialogue])+1)
    end
end

function onTweenCompleted(tag, vars)
    
    if tag == 'bahMeu' then
        removeLuaSprite("intro")
    end
end