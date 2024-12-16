local curSong = 1

local min = nil
local sec = nil

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
end

function onUpdate(elapsed)

    if keyboardJustPressed("RIGHT") then
        curSong = curSong + 1
        playSound('jukebox/'..curSong, 1, 'mus')
        curSongName = getTextFromFile("sounds/jukebox/"..curSong..'.txt')
        debugPrint('Now playing: '..curSongName)
    elseif keyboardJustPressed("LEFT") then
        curSong = curSong - 1
        playSound('jukebox/'..curSong, 1, 'mus')
        curSongName = getTextFromFile("sounds/jukebox/"..curSong..'.txt') 
        debugPrint('Now playing: '..curSongName)
    elseif curSong > 5 then
        curSong = 1
        playSound('jukebox/'..curSong, 1, 'mus')
        curSongName = getTextFromFile("sounds/jukebox/"..curSong..'.txt') 
        debugPrint('Now playing: '..curSongName)
    elseif curSong < 1 then
        curSong = 5
        playSound('jukebox/'..curSong, 1, 'mus')
        curSongName = getTextFromFile("sounds/jukebox/"..curSong..'.txt') 
        debugPrint('Now playing: '..curSongName)
    elseif keyJustPressed('back') then
        exitSong(false)
    end
end

function onSoundFinished(tag)
    
    if tag == 'mus' then
        playSound('jukebox/'..curSong, 1, 'mus')
    end
end