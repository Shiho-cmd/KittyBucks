function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local parsed = parseJson('data/'..songName..'/songData-'..difficultyName..'.json')

function onEndSong()
    
    if not botPlay and not practice and misses == 0 and not parsed.fczado then
        setAchievementScore("fc", getAchievementScore("fc") + 1, false)
        setAchievementScore("truefc", getAchievementScore("truefc") + 1, false)
        saveFile('mods/KittyBucks/data/supernova/songData-buck.json', '{\n    "rpcID": "1328793685021954150",\n    "rpcMiniIcon": "mini-icon-placeholder",\n    "rpcMiniIconPause": "mini-icon-placeholder",\n    "rpcTime": [2, 32],\n\n    "composer": "LizNaithy",\n    "artist": "Bluck and Natzy",\n    "coder": "Shiho",\n    "charter": "Shiho",\n    "pauseCover": "cover_supernova",\n    "pauseTxtPos": -1710,\n\n    "fczado": true,\n\n    "leftNoteRGB": ["F634B5", "FFFFFF", "7A255C"],\n    "downNoteRGB": ["52465E", "FFFFFF", "2D1C3F"],\n    "upNoteRGB": ["F634B5", "FFFFFF", "7A255C"],\n    "rightNoteRGB": ["52465E", "FFFFFF", "2D1C3F"]\n}', true)
        saveFile("mods/KittyBucks/data/supernova/save.txt", "essa música foi passada?: sim", true)
    end
end