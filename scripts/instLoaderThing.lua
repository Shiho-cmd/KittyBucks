function onSongStart()
    
    playMusic('instrumentals/'..songName..'/Inst-'..difficultyName, 1, false)
end

function onCreate()
    
    precacheMusic('instrumentals/'..songName..'/Inst-'..difficultyName)
end