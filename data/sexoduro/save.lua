function onEndSong()
    
    if not botPlay then
        saveFile("mods/KittyBucks/data/"..songName.."/save.txt", "essa música foi passada?: sim", true)
    end
end