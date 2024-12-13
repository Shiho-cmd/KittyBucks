function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local parsed = parseJson('pack.json')
local ogCam = parseJson('stages/'..curStage..'.json')

function onCreate()
    
    makeLuaText("wtrmrk", 'KittyBucks '..parsed.buildVersion, 0, screenWidth - 300, screenHeight - 20)
    setTextSize("wtrmrk", 20)
    setProperty("wtrmrk.alpha", 0.5)
    setObjectCamera("wtrmrk", 'other')
    addLuaText("wtrmrk")

    if getModSetting("info") then
    makeLuaText("debug", "", 0, 0.0, 15)
    setTextSize("debug", 20)
    addLuaText("debug")
end
end

function onCountdownStarted()
    
    if getModSetting("butt") then
    debugPrint([[
        butões de debug:
] - aumenta a velocidade (se segurar SHIFT irá aumentar menos 0.05 ao invés de 0.1)
[ - diminui a velocidade (se segurar SHIFT irá diminuir menos 0.05 ao invés de 0.1)
1 - mostra todos os scripts rodando
2 - esconde a hud
I - dá zoom in (se a opção de câmera livre tiver ativada)
O - dá zoom out (se a opção de câmera livre tiver ativada)
W, A, S, D - movimenta a câmera (se a opção de câmera livre tiver ativada)
BACKSPACE - reseta velocidade, zoom e câmera
ESPAÇO - mostra essa mensagem de instrução novamente
    ]])
end
end

local num = 0.1
local n = 0
local camX = nil
local camY = nil

function onUpdate(elapsed)

    camX = cameraX -- x da camera
    camY = cameraY

    velo = getTextFromFile("data/playbackRateSave.txt")
    
    if keyboardPressed("SHIFT") then
        num = 0.05
    else
        num = 0.1
    end

    if keyboardJustPressed("LBRACKET") and getModSetting("butt") then
        setProperty("playbackRate", playbackRate - num)
        debugPrint('velocidade agora está em: '..playbackRate..'x')
    elseif keyboardJustPressed("RBRACKET") and getModSetting("butt") then
        setProperty("playbackRate", playbackRate + num)
        debugPrint('velocidade agora está em: '..playbackRate..'x')
    elseif keyboardJustPressed("BACKSPACE") and getModSetting("butt") then
        setProperty("playbackRate", tonumber(velo))
        setProperty("defaultCamZoom", ogCam.ogZoom)
        triggerEvent("Camera Follow Pos", '', '')
        debugPrint('velocidade, zoom e câmera foram resetados')
    elseif keyboardJustPressed("ONE") and getModSetting("butt") then
        debugPrint(getRunningScripts())
    elseif keyboardJustPressed("TWO") and getModSetting("butt") then
        n = n + 1
    elseif keyboardPressed("I") and getModSetting("butt") and getModSetting("livre") then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.01)
    elseif keyboardPressed("O") and getModSetting("butt") and getModSetting("livre") then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.01)
    elseif keyboardPressed("W") and getModSetting("butt") and getModSetting("livre") then
        camY = camY - 10
        triggerEvent("Camera Follow Pos", camX, camY) -- move a camera pra cima
    elseif keyboardPressed("A") and getModSetting("butt") and getModSetting("livre") then
        camX = camX - 10
        triggerEvent("Camera Follow Pos", camX, camY) -- move a camera pra cima
    elseif keyboardPressed("S") and getModSetting("butt") and getModSetting("livre") then
        camY = camY + 10
        triggerEvent("Camera Follow Pos", camX, camY) -- move a camera pra cima
    elseif keyboardPressed("D") and getModSetting("butt") and getModSetting("livre") then
        camX = camX + 10
        triggerEvent("Camera Follow Pos", camX, camY) -- move a camera pra cima
    elseif keyboardJustPressed("L") and getModSetting("butt") then
        debugPrint(getTextString("socorro"))
    end

    if playbackRate < 0.1 then
        setProperty("playbackRate", 0.1)
    elseif n == 0 then
        setProperty("camHUD.visible", true)
    elseif n == 1 then
        setProperty("camHUD.visible", false)
    elseif n > 1 then
        n = 0
    end
end

function onUpdatePost(elapsed)
    
    if getModSetting("info") and getModSetting("livre") then
    setTextString("debug", 'curSection: '..curSection.." | curStep: "..curStep..' | curBeat: '..curBeat..' | defaultCamZoom: '..getProperty("defaultCamZoom")..' | cameraX: '..cameraX..' | cameraY: '..cameraY)
    screenCenter("debug", 'x')
    elseif getModSetting("info") and not getModSetting("livre") then
    setTextString("debug", 'curSection: '..curSection.." | curStep: "..curStep..' | curBeat: '..curBeat)
    screenCenter("debug", 'x')
end
end