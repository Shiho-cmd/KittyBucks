function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local mainArea = parseJson('data/_ROOMS/blackspace/mainArea.json')
local mainAreaDialogue = parseJson('data/_ROOMS/blackspace/mainArea-dialogue.json')

local path = 'backgrounds/omori/'
local pathBorder = 'backgrounds/omori/borders'
local pathBattle = 'backgrounds/omori/battleStuff'

luaDebugMode = true

local txtVelo = 0.04

local clicavel = false
local cutClicavel = false
local cutOver = false
local curDialogue = 1
local curDialogueName = nil
local onDialogue = false
local escolhendo = false

local sounds = {'[BA]stat_down', '[sfx]battle_ekg_beep', 'BA_battle_encounter_1', 'BA_CRITICAL_HIT', 'BA_heal_juice', 'BA_Heart_Heal', 'BA_miss', 'BA_release_energy', 'BA_run', 'BA_stat_up', 'GEN_stab', 'laptop_logoff', 'SE_dig', 'se_evil2', 'SE_horror', 'se_impact_double', 'SE_New_Skill', 'SE_Push', 'SE_spooks', 'Skill2', 'sys_blackletter1', 'sys_blackletter2', 'sys_buzzer', 'sys_cancel', 'SYS_move', 'SYS_select', 'SYS_text', 'SE_Laptop'}

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

    removeLuaScript(currentModDirectory.."/scripts/disabled/pauseSubState.lua")
    removeLuaScript(currentModDirectory.."/scripts/disabled/itsBingover.lua")
    removeLuaScript(currentModDirectory.."/scripts/gozadaInsana.lua")
    removeLuaScript(currentModDirectory.."/scripts/noteRGB.lua")
    --removeLuaScript("mods/KittyBucks/scripts/buildTargetReal.lua")
    removeLuaScript(currentModDirectory.."/scripts/noteSplashStuff.lua")
    --removeHScript(currentModDirectory.."/scripts/haxeShit.hx")
    setProperty("camGame.alpha", 0.0001)
    setProperty("camOther.alpha", 0.0001)

    precacheSound("omori/bgm/bs_entrance")
    precacheSound("omori/se/GEN_stab")
    precacheSound("omori/se/sys_blackletter1")
    precacheSound("omori/se/sys_blackletter2")
    precacheSound("omori/se/SYS_select")
    precacheSound("omori/se/SYS_move")
    precacheSound("omori/se/SE_Laptop")
    precacheSound("omori/se/laptop_logoff")
    precacheSound("omori/se/jermascare")

    setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Welcome to Black Space')

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
    addLuaSprite("tapa", false)

    makeAnimatedLuaSprite("lap", 'backgrounds/omori/blackspace/laptop', mainArea.laptop[1], mainArea.laptop[2])
    addAnimationByPrefix("lap", "idle", "static", 10, true)
    scaleObject("lap", 1, 1)
    addLuaSprite("lap")

    makeAnimatedLuaSprite("door-mago", 'backgrounds/omori/blackspace/door', mainArea.portaMago[1], mainArea.portaMago[2])
    addAnimationByPrefix("door-mago", "open", "daFunnyDoor", 7, false)
    addAnimationByIndices("door-mago", "close", "daFunnyDoor", '6,5,4,3,2,1', 7, false)
    addAnimationByIndices("door-mago", "idle", "daFunnyDoor", '1', 0, false)
    scaleObject("door-mago", 2, 2)
    addLuaSprite("door-mago")

    makeAnimatedLuaSprite("door-yume", 'backgrounds/omori/blackspace/door', mainArea.portaYume[1], mainArea.portaYume[2])
    addAnimationByPrefix("door-yume", "open", "daFunnyDoor", 3, false)
    addAnimationByIndices("door-yume", "close", "daFunnyDoor", '6,5,4,3,2,1', 5, false)
    addAnimationByIndices("door-yume", "idle", "daFunnyDoor", '1', 5, false)
    scaleObject("door-yume", 2, 2)
    addLuaSprite("door-yume")

    makeLuaSprite("fio", 'backgrounds/omori/blackspace/wire', mainArea.fio[1], mainArea.fio[2])
    scaleObject("fio", 2, 2)
    addLuaSprite("fio", true)

    makeLuaText("tuto", '', 450, 400, screenHeight - 213)
    setTextFont("tuto", "omori.ttf")
    setTextSize("tuto", 35)
    setTextAlignment("tuto", 'left')
    setObjectCamera("tuto", 'hud')
    addLuaText("tuto")

    makeAnimatedLuaSprite("closeup", 'backgrounds/omori/blackspace/doors_closeup', 0, 0)
    addAnimationByPrefix("closeup", "yume", "cold", 3, true)
    addAnimationByIndices("closeup", "mago", "mago", '1,2,3,2', 3, true)
    setObjectCamera("closeup", 'hud')
    scaleObject("closeup", 1.5, 1.5)
    screenCenter("closeup", 'xy')
    setProperty("closeup.alpha", 0.00001)
    addLuaSprite("closeup", false)

    makeLuaText("xddd", '', 0, 0.0, 0)
    setTextFont("xddd", "omori.ttf")
    setTextSize("xddd", 35)
    screenCenter("xddd", 'x')
    setObjectCamera("xddd", 'other')
    addLuaText("xddd")

    makeAnimatedLuaSprite("boxx", 'backgrounds/omori/blackspace/txtBox', 380, screenHeight - 250)
    addAnimationByPrefix("boxx", "default", "normal", 0, false)
    addAnimationByPrefix("boxx", "chonky", "chonky", 0, false)
    setObjectCamera("boxx", 'hud')
    scaleObject("boxx", 2.5, 2)
    setProperty("boxx.alpha", 0.00001)
    addLuaSprite("boxx", false)

    makeAnimatedLuaSprite("boxOpt", 'backgrounds/omori/blackspace/txtBox', 640, screenHeight - 310)
    addAnimationByPrefix("boxOpt", "opt", "options", 0, false)
    setObjectCamera("boxOpt", 'hud')
    scaleObject("boxOpt", 2, 2)
    setProperty("boxOpt.alpha", 0.00001)
    addLuaSprite("boxOpt", false)

    makeLuaText("opt", mainAreaDialogue.defaultOptions, 0, 540, screenHeight - 310)
    setTextFont("opt", "omori.ttf")
    setTextSize("opt", 35)
    screenCenter("opt", 'x')
    setTextAlignment("opt", 'left')
    setObjectCamera("opt", 'hud')
    setProperty("opt.alpha", 0.00001)
    addLuaText("opt")
    
    makeLuaSprite("hand", 'backgrounds/omori/blackspace/moes', 810, screenHeight - 90)
    scaleObject("hand", 1.3, 1.3)
    setObjectCamera("hand", 'hud')
    setProperty("hand.alpha", 0.00001)
    addLuaSprite("hand", false)
    doTweenX("loopInsano", "hand", getProperty("hand.x") - 5, 1, "quartInOut")

    makeLuaSprite("mouse", 'backgrounds/omori/blackspace/cursor', 0, 0)
    scaleObject("mouse", 1.3, 1.3)
    setObjectCamera("mouse", 'hud')
    setProperty("mouse.alpha", 0.00001)
    addLuaSprite("mouse", true)

    makeLuaSprite("lapBG", 'backgrounds/omori/blackspace/laptopBG', 0, 0)
    setObjectCamera("lapBG", 'hud')
    scaleObject("lapBG", 1.5, 1.5)
    screenCenter("lapBG")
    setProperty("lapBG.alpha", 0.00001)
    addLuaSprite("lapBG", false)

    makeLuaText("horario", "", 0, mainArea.relogio[1], mainArea.relogio[2])
    setObjectCamera("horario", 'hud')
    setTextFont("horario", "flipnote-hatena-font.ttf")
    setTextBorder("horario", 0, "000000")
    setTextSize("horario", 41)
    setTextColor("horario", "000000")
    setProperty("horario.alpha", 0.00001)
    addLuaText("horario")

    makeLuaSprite("jerma", 'Screenshot_45', 0, 0)
    setObjectCamera("jerma", 'other')
    screenCenter("jerma")
    setProperty("jerma.alpha", 0.00001)
    addLuaSprite("jerma", true)

    createHitbox()
end

function createHitbox()

    makeLuaSprite("ht", nil, mainArea.laptopHB[1], mainArea.laptopHB[2])
    makeGraphic("ht", 32, 17, 'FF0000')
    setProperty("ht.alpha", 0)
    addLuaSprite("ht", false)
    updateHitbox("ht")

    makeLuaSprite("yumeHB", nil, mainArea.portaYumeHB[1], mainArea.portaYumeHB[2])
    makeGraphic("yumeHB", 41, 25, 'FF0000')
    setProperty("yumeHB.alpha", 0)
    addLuaSprite("yumeHB", false)
    updateHitbox("yumeHB")

    makeLuaSprite("magoHB", nil, mainArea.portaMagoHB[1], mainArea.portaMagoHB[2])
    makeGraphic("magoHB", 41, 25, 'FF0000')
    setProperty("magoHB.alpha", 0)
    addLuaSprite("magoHB", false)
    updateHitbox("magoHB")

    makeLuaSprite("robloHB", nil, mainArea.robloxHB[1], mainArea.robloxHB[2])
    makeGraphic("robloHB", 96, 96, 'FFFFFF')
    setProperty("robloHB.alpha", 0.00001)
    setObjectCamera("robloHB", 'hud')
    addLuaSprite("robloHB", false)
    updateHitbox("robloHB")

    makeLuaSprite("shihoHB", nil, mainArea.trashHB[1], mainArea.trashHB[2])
    makeGraphic("shihoHB", 73, 85, 'FFFFFF')
    setProperty("shihoHB.alpha", 0.00001)
    setObjectCamera("shihoHB", 'hud')
    addLuaSprite("shihoHB", false)
    updateHitbox("shihoHB")

    makeLuaSprite("logHB", nil, mainArea.logoffHB[1], mainArea.logoffHB[2])
    makeGraphic("logHB", 136, 30, 'FF0000')
    setProperty("logHB.alpha", 0)
    setObjectCamera("logHB", 'hud')
    addLuaSprite("logHB", false)
    updateHitbox("logHB")

    makeLuaSprite("playerHB", nil, getGraphicMidpointX("boyfriend") + 10, getGraphicMidpointY("boyfriend") + 16)
    makeGraphic("playerHB", 20, 25, '0000FF')
    setProperty("playerHB.alpha", 0)
    addLuaSprite("playerHB", true)
    updateHitbox("playerHB")
end

local quanto = 1

local moveDown = true
local moveUp = true
local moveRight = true
local moveLeft = true
local looking = 'down'

local objHB = {'ht', 'yumeHB', 'magoHB'}
local obj = {'lap', 'door-yume', 'door-mago'}

local lapColiDown = nil
local doorYumeColiDown = nil
local doorMagoColiDown = nil
local lapColiUp = nil
local doorYumeColiUp = nil
local doorMagoColiUp = nil
local lapColiLeft = nil
local doorYumeColiLeft = nil
local doorMagoColiLeft = nil
local lapColiRight = nil
local doorYumeColiRight = nil
local doorMagoColiRight = nil

local walkSpeed = 4

local optPos = 1

local onLaptop = false
local songToLoad = nil

--local sla = os.date ('%p')

function onUpdate(elapsed)

    if getProperty("boyfriend.x") == 68 and getProperty("boyfriend.y") == 68 then
        setProperty("jerma.alpha", 1)
        doTweenAlpha("wornorjn", "jerma", 0.00001, 0.5, "linear")
        playSound("omori/se/jermascare", 1, 'jumpma')
    end

    setProperty("mouse.x", getMouseX("hud"))
    setProperty("mouse.y", getMouseY("hud"))

    setTextString("horario", os.date ('%H')..":"..os.date ('%M'))

    if onLaptop then
        robloxJustPressed = getMouseX('camOther') > getProperty('robloHB.x') and getMouseY('camOther') > getProperty('robloHB.y') and getMouseX('camOther') < getProperty('robloHB.x') + getProperty('robloHB.width') and getMouseY('camOther') < getProperty('robloHB.y') + getProperty('robloHB.height') and mouseClicked()
        trashJustPressed = getMouseX('camOther') > getProperty('shihoHB.x') and getMouseY('camOther') > getProperty('shihoHB.y') and getMouseX('camOther') < getProperty('shihoHB.x') + getProperty('shihoHB.width') and getMouseY('camOther') < getProperty('shihoHB.y') + getProperty('shihoHB.height') and mouseClicked()
        logoffJustPressed = getMouseX('camOther') > getProperty('logHB.x') and getMouseY('camOther') > getProperty('logHB.y') and getMouseX('camOther') < getProperty('logHB.x') + getProperty('logHB.width') and getMouseY('camOther') < getProperty('logHB.y') + getProperty('logHB.height') and mouseClicked()
        robloxMouseOver = getMouseX('camOther') > getProperty('robloHB.x') and getMouseY('camOther') > getProperty('robloHB.y') and getMouseX('camOther') < getProperty('robloHB.x') + getProperty('robloHB.width') and getMouseY('camOther') < getProperty('robloHB.y') + getProperty('robloHB.height')
        trashMouseOver = getMouseX('camOther') > getProperty('shihoHB.x') and getMouseY('camOther') > getProperty('shihoHB.y') and getMouseX('camOther') < getProperty('shihoHB.x') + getProperty('shihoHB.width') and getMouseY('camOther') < getProperty('shihoHB.y') + getProperty('shihoHB.height')
    end

    if cutOver then
        triggerEvent("Camera Follow Pos", getGraphicMidpointX("boyfriend") + 18, getGraphicMidpointY("boyfriend"))
    end

    setProperty("playerHB.x", getGraphicMidpointX("boyfriend") - 3)
    setProperty("playerHB.y", getGraphicMidpointY("boyfriend") + 2)

    for i = 1, #objHB do
        if getProperty("playerHB.y") < getProperty(objHB[i]..".y") then
            setObjectOrder(obj[i], 99)
        else
            setObjectOrder(obj[i], 6)
        end
    end

    if getProperty("boyfriend.x") > 3000 then
        setProperty("boyfriend.x", 0)
    elseif getProperty("boyfriend.y") > 3000 then
        setProperty("boyfriend.y", 0)
    elseif getProperty("boyfriend.x") < 0 then
        setProperty("boyfriend.x", 3000)
    elseif getProperty("boyfriend.y") < 0 then
        setProperty("boyfriend.y", 3000)
    end
    
    if clicavel then
        if keyboardJustPressed('ESCAPE') then
            clicavel = false
            playAnim("boyfriend", "stab", true)
        elseif keyboardPressed("DOWN") and moveDown then
            playAnim("boyfriend", "walk-down")
            setProperty("boyfriend.y", getProperty("boyfriend.y") + walkSpeed)
            looking = 'down'
        elseif keyboardReleased("DOWN") then
            playAnim("boyfriend", "idle-down")
        elseif keyboardPressed("UP") and moveUp then
            playAnim("boyfriend", "walk-up")
            setProperty("boyfriend.y", getProperty("boyfriend.y") - walkSpeed)
            looking = 'up'
        elseif keyboardReleased("UP") then
            playAnim("boyfriend", "idle-up")
        elseif keyboardPressed("RIGHT") and moveRight then
            playAnim("boyfriend", "walk-right")
            setProperty("boyfriend.x", getProperty("boyfriend.x") + walkSpeed)
            looking = 'right'
        elseif keyboardReleased("RIGHT") then
            playAnim("boyfriend", "idle-right")
        elseif keyboardPressed("LEFT") and moveLeft then
            playAnim("boyfriend", "walk-left")
            setProperty("boyfriend.x", getProperty("boyfriend.x") - walkSpeed)
            looking = 'left'
        elseif keyboardReleased("LEFT") then
            playAnim("boyfriend", "idle-left")
        end
    end

    lapColiDown = objectsOverlap("playerHB", "ht") and getProperty("playerHB.y") < getProperty("ht.y")
    doorYumeColiDown = objectsOverlap("playerHB", "yumeHB") and getProperty("playerHB.y") < getProperty("yumeHB.y")
    doorMagoColiDown = objectsOverlap("playerHB", "magoHB") and getProperty("playerHB.y") < getProperty("magoHB.y")

    lapColiUp = objectsOverlap("playerHB", "ht") and getProperty("playerHB.y") > getProperty("ht.y")
    doorYumeColiUp = objectsOverlap("playerHB", "yumeHB") and getProperty("playerHB.y") > getProperty("yumeHB.y")
    doorMagoColiUp = objectsOverlap("playerHB", "magoHB") and getProperty("playerHB.y") > getProperty("magoHB.y")

    lapColiLeft = objectsOverlap("playerHB", "ht") and getProperty("playerHB.x") > getProperty("ht.x")
    doorYumeColiLeft = objectsOverlap("playerHB", "yumeHB") and getProperty("playerHB.x") > getProperty("yumeHB.x")
    doorMagoColiLeft = objectsOverlap("playerHB", "magoHB") and getProperty("playerHB.x") > getProperty("magoHB.x")

    lapColiRight = objectsOverlap("playerHB", "ht") and getProperty("playerHB.x") < getProperty("ht.x")
    doorYumeColiRight = objectsOverlap("playerHB", "yumeHB") and getProperty("playerHB.x") < getProperty("yumeHB.x")
    doorMagoColiRight = objectsOverlap("playerHB", "magoHB") and getProperty("playerHB.x") < getProperty("magoHB.x")

    if lapColiDown and looking == 'down' or doorYumeColiDown and looking == 'down' or doorMagoColiDown and looking == 'down' then
        moveDown = false
        playAnim("boyfriend", "idle-down")
    elseif lapColiUp and looking == 'up' or doorYumeColiUp and looking == 'up' or doorMagoColiUp and looking == 'up' then
        moveUp = false
        playAnim("boyfriend", "idle-up")
    elseif lapColiRight and looking == 'right' or doorYumeColiRight and looking == 'right' or doorMagoColiRight and looking == 'right' then
        moveRight = false
        playAnim("boyfriend", "idle-right")
    elseif lapColiLeft and looking == 'left' or doorYumeColiLeft and looking == 'left' or doorMagoColiLeft and looking == 'left' then
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

    if keyboardJustPressed('Z') and onDialogue and not escolhendo then
        curDialogue = curDialogue + 1
        runTimer('escreve', txtVelo, string.len(curDialogueName[curDialogue])+1)
    end
    
    if keyboardJustPressed("Z") and clicavel then
        if doorMagoColiUp and looking == 'up' then
            clicavel = false
            doTweenAlpha("dava", "camGame", 0.00001, 1, "linear")
        elseif doorYumeColiUp and looking == 'up' then
            clicavel = false
            doTweenAlpha("yumer", "camGame", 0.00001, 1, "linear")
        elseif lapColiUp and looking == 'up' then
            clicavel = false
            doTweenAlpha("laper", "camGame", 0.00001, 1, "linear")
            playSound("omori/se/SE_Laptop", 1, 'lapON')
            doTweenAlpha("apareceuMeu", "lapBG", 1, 1, "linear")
            doTweenAlpha("deiMeuCu", "horario", 1, 1, "linear")
        end
    end

    if onLaptop and robloxMouseOver then
        setProperty("robloHB.alpha", 0.5)
    elseif onLaptop and trashMouseOver then
        setProperty("shihoHB.alpha", 0.5)
    else
        setProperty("shihoHB.alpha", 0.00001)
        setProperty("robloHB.alpha", 0.00001)
    end

    if onLaptop and trashJustPressed then
        playSound('omori/se/'..sounds[getRandomInt(1, #sounds)], 1, 'randomSound')
    elseif onLaptop and robloxJustPressed then
        onLaptop = false
        loadSong('friends', -1)
    elseif onLaptop and logoffJustPressed or keyboardJustPressed("C") and onLaptop then
        onLaptop = false
        playSound("omori/se/laptop_logoff", 1, 'lapOFF')
        doTweenAlpha("cumInMaAss", "lapBG", 0.00001, 1, "linear")
        doTweenAlpha("damnDaniel", "horario", 0.00001, 1, "linear")
        doTweenAlpha("ruuwrhrb", "camGame", 1, 1, "linear")
        setProperty("mouse.alpha", 0.0001)
    end

    if keyboardPressed("X") then
        walkSpeed = 4
    else
        walkSpeed = 2
    end

    if curDialogue == 3 and onDialogue and curDialogueName == mainAreaDialogue.tutorial then
        onDialogue = false
        doTweenY("s", "boxx.scale", 0.1, 0.2, "linear")
        doTweenAlpha("a", "boxx", 0.00001, 0.2, "linear")
        setProperty("hand.alpha", 0.00001)
    elseif curDialogue == 2 and onDialogue and curDialogueName == mainAreaDialogue.mago or curDialogue == 2 and onDialogue and curDialogueName == mainAreaDialogue.yume then
        onDialogue = false
        setProperty("opt.x", 720)
        setProperty("opt.y", screenHeight - 290)
        scaleObject("boxOpt", 2, 0.1, false)
        doTweenX("loopInsano", "hand", 665, 0.01, "linear")
        doTweenX("insanoLoop", "hand", 665, 0.01, "linear")
        setProperty("hand.y", screenHeight - 275)
        doTweenY("tetas", "boxOpt.scale", 2, 0.2, "linear")
        doTweenAlpha("bunda", "boxOpt", 1, 0.2, "linear")
        doTweenAlpha("anus", "opt", 1, 0.2, "linear")
    elseif curDialogue == 2 and onDialogue and curDialogueName == mainAreaDialogue.stare then
        onDialogue = false
        doTweenY("sexooooo", "boxx.scale", 0.1, 0.2, "linear")
        doTweenAlpha("caralhoooo", "boxx", 0.00001, 0.2, "linear")
        setProperty("hand.alpha", 0.00001)
    end

    if keyboardJustPressed("DOWN") and escolhendo then
        optPos = optPos + 1
        playSound("omori/se/SYS_move", 1, 'move')
    elseif keyboardJustPressed("UP") and escolhendo then
        optPos = optPos - 1
        playSound("omori/se/SYS_move", 1, 'move')
    elseif optPos > 2 then
        optPos = 1
    elseif optPos < 1 then
        optPos = 2
    end

    if optPos == 1 and escolhendo then
        setProperty("hand.y", screenHeight - 275)
    elseif optPos == 2 and escolhendo then
        setProperty("hand.y", screenHeight - 247)
    end

    if keyboardJustPressed("Z") and optPos == 1 and escolhendo then
        escolhendo = false
        playSound("omori/se/SYS_select", 1, 'select')
        doTweenAlpha("oruuwr", "camHUD", 0, 1, "linear")
        doTweenAlpha("oruuwrhrb", "camGame", 1, 1, "linear")
    elseif keyboardJustPressed("Z") and optPos == 2 and escolhendo then
        escolhendo = false
        onDialogue = true
        curDialogue = 1
        curDialogueName = mainAreaDialogue.stare
        runTimer('escreve', txtVelo, string.len(curDialogueName[curDialogue])+1)
        playSound("omori/se/SYS_select", 1, 'select')
        doTweenY("tetas", "boxOpt.scale", 0.1, 0.2, "linear")
        doTweenAlpha("bunda", "boxOpt", 0.00001, 0.2, "linear")
        doTweenAlpha("anusProlapsado", "opt", 0.00001, 0.2, "linear")
        doTweenX("loopInsano", "hand", 860, 0.01, "linear")
        doTweenX("insanoLoop", "hand", 860, 0.01, "linear")
        setProperty("hand.y", screenHeight - 50)
    end


    if keyboardJustPressed("A") then
        setProperty("logHB.x", getProperty("logHB.x") - quanto)
    elseif keyboardJustPressed("D") then
        setProperty("logHB.x", getProperty("logHB.x") + quanto)
    elseif keyboardJustPressed("W") then
        setProperty("logHB.y", getProperty("logHB.y") - quanto)
    elseif keyboardJustPressed("S") then
        setProperty("logHB.y", getProperty("logHB.y") + quanto)
    elseif keyboardJustPressed("SPACE") then
        saveFile('mods/KittyBucks/data/_ROOMS/blackspace/mainArea.json', '{\n    // player\n   "kittySpawn": [1104, 1068],\n\n    // obj\n    "tapete": ['..getProperty("tapa.x")..', '..getProperty("tapa.y")..'],\n    "laptop": ['..getProperty("lap.x")..', '..getProperty("lap.y")..'],\n    "portaMago": ['..getProperty("door-mago.x")..', '..getProperty("door-mago.y")..'],\n    "portaYume": ['..getProperty("door-yume.x")..', '..getProperty("door-yume.y")..'],\n    "fio": ['..getProperty("fio.x")..', '..getProperty("fio.y")..'],\n    "relogio": ['..getProperty("horario.x")..', '..getProperty("horario.y")..'],\n\n    "laptopHB": ['..getProperty("ht.x")..', '..getProperty("ht.y")..'],\n    "portaMagoHB": ['..getProperty("magoHB.x")..', '..getProperty("magoHB.y")..'],\n    "portaYumeHB": ['..getProperty("yumeHB.x")..', '..getProperty("yumeHB.y")..'],\n    "robloxHB": ['..getProperty("robloHB.x")..', '..getProperty("robloHB.y")..'],\n    "trashHB": ['..getProperty("shihoHB.x")..', '..getProperty("shihoHB.y")..'],\n    "logoffHB": ['..getProperty("logHB.x")..', '..getProperty("logHB.y")..']\n}', true)
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
        setTextString('tuto', string.sub(curDialogueName[curDialogue], 0, (loops - loopsLeft)))
        playSound('omori/se/SYS_text', 0.5)
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
        scaleObject("boxx", 2.5, 0.1, false)
        doTweenY("t", "boxx.scale", 2, 0.2, "linear")
        doTweenAlpha("e", "boxx", 1, 0.2, "linear")
    elseif tag == 'diaDava' then
        songToLoad = 'MAGO'
        curDoor = 'door-mago'
        playAnim("boxx", "default", true)
        scaleObject("boxx", 2.5, 0.1, false)
        doTweenY("tesao", "boxx.scale", 2.5, 0.2, "linear")
        doTweenAlpha("e", "boxx", 1, 0.2, "linear")
        setTextWidth("tuto", 500)
        setProperty("boxx.x", 350)
        setProperty("boxx.y", screenHeight - 150)
        setProperty("tuto.x", 370)
        setProperty("tuto.y", screenHeight - 150)
        setProperty("hand.alpha", 1)
        doTweenX("loopInsano", "hand", 860, 0.01, "linear")
        doTweenX("insanoLoop", "hand", 860, 0.01, "linear")
        setProperty("hand.y", screenHeight - 50)
        curDialogue = 1
        curDialogueName = mainAreaDialogue.mago
        onDialogue = true
        runTimer('escreve', txtVelo, string.len(curDialogueName[curDialogue])+1)
    elseif tag == 'diaYumer' then
        songToLoad = 'fever-dream'
        curDoor = 'door-yume'
        playAnim("boxx", "default", true)
        scaleObject("boxx", 2.5, 0.1, false)
        doTweenY("tesao", "boxx.scale", 2.5, 0.2, "linear")
        doTweenAlpha("e", "boxx", 1, 0.2, "linear")
        setTextWidth("tuto", 500)
        setProperty("boxx.x", 350)
        setProperty("boxx.y", screenHeight - 150)
        setProperty("tuto.x", 370)
        setProperty("tuto.y", screenHeight - 150)
        setProperty("hand.alpha", 1)
        doTweenX("loopInsano", "hand", 860, 0.01, "linear")
        doTweenX("insanoLoop", "hand", 860, 0.01, "linear")
        setProperty("hand.y", screenHeight - 50)
        curDialogue = 1
        curDialogueName = mainAreaDialogue.yume
        onDialogue = true
        runTimer('escreve', txtVelo, string.len(curDialogueName[curDialogue])+1)
    elseif tag == 'portaAbrida' then
        doTweenAlpha("byebye", "boyfriend", 0, 1, "linear")
    elseif tag == 'portaFechuda' then
        loadSong(songToLoad, -1)
    end
end

function onTweenCompleted(tag, vars)
    
    if tag == 'bahMeu' then
        removeLuaSprite("intro")
    elseif tag == 'dava' then
        playAnim("closeup", "mago")
        doTweenAlpha("naCozinha", "closeup", 1, 1, "linear")
    elseif tag == 'yumer' then
        playAnim("closeup", "yume")
        doTweenAlpha("nickels", "closeup", 1, 1, "linear")
    elseif tag == 'naCozinha' then
        runTimer("diaDava", 1)
    elseif tag == 'nickels' then
        runTimer("diaYumer", 1)
    elseif tag == 't' then
        onDialogue = true
        curDialogueName = mainAreaDialogue.tutorial
        setProperty("cameraSpeed", 99999)
        setProperty("hand.alpha", 1)
        runTimer('escreve', txtVelo, string.len(curDialogueName[curDialogue])+1)
    elseif tag == 's' then
        clicavel = true
        setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Black Space')
    elseif tag == 'loopInsano' then
        doTweenX("insanoLoop", "hand", getProperty("hand.x") + 5, 0.5, "quartInOut")
    elseif tag == 'insanoLoop' then
        doTweenX("loopInsano", "hand", getProperty("hand.x") - 5, 0.5, "quartInOut")
    elseif tag == 'anus' then
        escolhendo = true
    elseif tag == 'caralhoooo' then
        doTweenAlpha("ruuwrhrb", "camGame", 1, 1, "linear")
        doTweenAlpha("wovinwovndwrionwriouwrio", "closeup", 0.00001, 1, "linear")
    elseif tag == 'ruuwrhrb' then
        clicavel = true
    elseif tag == 'oruuwrhrb' then
        playAnim(curDoor, "open")
        runTimer("portaAbrida", 1)
    elseif tag == 'byebye' then
        playAnim(curDoor, "close")
        runTimer("portaFechuda", 1)
    elseif tag == 'deiMeuCu' then
        setProperty("mouse.alpha", 1)
        onLaptop = true
    end
end