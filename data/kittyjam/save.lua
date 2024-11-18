function onEndSong()
    
    if difficultyName == 'buck' and not botPlay then
        saveFile("mods/KittyBucks/data/"..songName.."/save.txt", "essa música foi passada?: sim", true)
    elseif difficultyName == 'erect' and not botPlay then
        saveFile("mods/KittyBucks/data/"..songName.."/save-erect.txt", "essa música foi passada?: sim", true)
    end

    if difficultyName == 'erect' and ratingFC == 'SFC' and not botPlay then
        saveFile("mods/KittyBucks/data/"..songName.."/save-perfect.txt", "foi feito 100% nessa música?: sim", true)
    end
end