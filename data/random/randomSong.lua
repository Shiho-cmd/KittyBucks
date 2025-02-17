local songs = {
    'kityjam',
    'sexoduro',
    'the-guy',
    'supernova'
}

function onStartCountdown()
    
    if difficultyName == 'buck' then
        loadSong(songs[getRandomInt(1, #songs)], difficulty)
    else
        loadSong(songs[1], 1)
    end
end