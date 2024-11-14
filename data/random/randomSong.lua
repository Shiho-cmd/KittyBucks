local songs = {
    'KittyJam',
    'SuperNova',
    'SexoDURO'
}

function onCountdownStarted()
    
    if difficultyName == 'buck' then
        loadSong(songs[getRandomInt(1, 3)], difficulty)
    else
        loadSong(songs[1], 1)
    end
end