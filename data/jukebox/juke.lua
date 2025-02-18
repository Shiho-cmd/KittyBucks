local curSong = 1
local pause = 0

function onStartCountdown() 
    if not allowCountdown then
        return Function_Stop
    end
    if allowCountdown then
        return Function_Continue
    end
end

function onCreate()
    
    playSound('jukebox/'..curSong, 1, 'mus')

    makeLuaText("blah", [[
    CIMA - Próxima música
    BAIXO - Música anterior
    DIREITA - Pula 5 segundos
    ESQUERDA - Volta 5 segundos
    ESPAÇO - Pausa
    ] - Aumenta a velocidade
    [ - Diminue a velocidade
    R - Reinicia]], 0, 0.0, 0.0)
    setObjectCamera("blah", 'other')
    setTextSize("blah", 25)
    screenCenter("blah")
    addLuaText("blah")

    makeLuaText("bla", '', 0, 0.0, 0.0)
    setObjectCamera("bla", 'other')
    setTextSize("bla", 25)
    screenCenter("bla", 'x')
    addLuaText("bla")

    makeLuaSprite("fundo", 'menuDesat')
    setObjectCamera("fundo", 'other')
    setProperty("fundo.color", 0x353639)
    addLuaSprite("fundo", false)

    runHaxeCode([[
        import flixel.addons.display.FlxBackdrop;
        import flixel.addons.display.FlxGridOverlay;
        
        var grid:FlxBackdrop = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x50000000, 0x0));
        grid.velocity.set(20, 20);
        grid.cameras = [game.camOther];
        addBehindGF(grid);
    ]])
end

function onUpdate(elapsed)

    if keyboardJustPressed("UP") then
        curSong = curSong + 1
        playSound('jukebox/'..curSong, 1, 'mus', true)
        curSongName = getTextFromFile("sounds/jukebox/"..curSong..'.txt')
        debugPrint('Tocando: '..curSongName)
    elseif keyboardJustPressed("DOWN") then
        curSong = curSong - 1
        playSound('jukebox/'..curSong, 1, 'mus', true)
        curSongName = getTextFromFile("sounds/jukebox/"..curSong..'.txt') 
        debugPrint('Tocando: '..curSongName)
    elseif curSong > 6 then
        curSong = 1
        playSound('jukebox/'..curSong, 1, 'mus', true)
        curSongName = getTextFromFile("sounds/jukebox/"..curSong..'.txt') 
        debugPrint('Tocando: '..curSongName)
    elseif curSong < 1 then
        curSong = 6
        playSound('jukebox/'..curSong, 1, 'mus', true)
        curSongName = getTextFromFile("sounds/jukebox/"..curSong..'.txt') 
        debugPrint('Tocando: '..curSongName)
    elseif keyJustPressed('back') then
        exitSong(false)
    elseif keyboardJustPressed("SPACE") and pause == 0 then
        pauseSound("mus")
        debugPrint(curSongName..' foi pausado')
        pause = pause + 1
    elseif keyboardJustPressed("SPACE") and pause == 1 then
        resumeSound("mus")
        debugPrint(curSongName..' foi despausado')
        pause = pause - 1
    elseif keyboardJustPressed("RIGHT") then
        setSoundTime("mus", getSoundTime("mus") + 5000)
        setSoundVolume("null", 0)
        debugPrint('Foram pulados 5 segundos')
    elseif keyboardJustPressed("LEFT") then
        setSoundTime("mus", getSoundTime("mus") - 5000)
        setSoundVolume("null", 0)
        debugPrint('Foram voltados 5 segundos')
    elseif keyboardJustPressed("R") then
        setSoundTime("mus", 0)
        debugPrint('Música foi reiniciada')
    elseif keyboardJustPressed("RBRACKET") then
        setSoundPitch('mus', getSoundPitch('mus') + 0.05, true)
        debugPrint('Velocidade agora está em: '..getSoundPitch('mus'))
    elseif keyboardJustPressed("LBRACKET") then
        setSoundPitch('mus', getSoundPitch('mus') - 0.05, true)
        debugPrint('Velocidade agora está em: '..getSoundPitch('mus'))
    end
end

function onUpdatePost(elapsed)
    
    setTextString("bla", "Música: "..curSongName..' | Velocidade: '..getSoundPitch('mus')..'x')
    screenCenter("bla", 'x')
end