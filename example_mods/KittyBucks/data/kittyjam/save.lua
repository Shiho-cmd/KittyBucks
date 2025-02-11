function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local parsed = parseJson('data/'..songName..'/songData-'..difficultyName..'.json')

function onEndSong()
    
    if difficultyName == 'buck' and not botPlay and not practice and misses == 0 and not parsed.fczado then
        setAchievementScore("fc", getAchievementScore("fc") + 1, false)
        setAchievementScore("truefc", getAchievementScore("truefc") + 1, false)
        saveFile('mods/KittyBucks/data/kittyjam/songData-buck.json', '{\n    "rpcID": "1316587707945848842",\n    "rpcMiniIcon": "mini-icon-kitty",\n    "rpcMiniIconPause": "mini-icon-kitty-pause",\n    "rpcTime": [1, 33],\n\n    "composer": "LizNaithy",\n    "artist": "Natzy",\n    "coder": "Shiho",\n    "charter": "Shiho",\n    "pauseCover": "cover_kittyjam",\n    "pauseTxtPos": -1550,\n\n    "fczado": true,\n\n    "leftNoteRGB": ["F634B5", "FFFFFF", "7A255C"],\n    "downNoteRGB": ["52465E", "FFFFFF", "2D1C3F"],\n    "upNoteRGB": ["F634B5", "FFFFFF", "7A255C"],\n    "rightNoteRGB": ["52465E", "FFFFFF", "2D1C3F"]\n}', true)
        saveFile("mods/KittyBucks/data/kittyjam/save-buck.txt", "essa música foi passada?: sim", true)
    elseif difficultyName == 'erect' and not botPlay and not practice and misses == 0 and not parsed.fczado then
        setAchievementScore("fc", getAchievementScore("fc") + 1, false)
        setAchievementScore("truefc", getAchievementScore("truefc") + 1, false)
        saveFile("mods/KittyBucks/data/kittyjam/songData-erect.json", '{\n    "rpcID": "1317491150768046152",\n    "rpcMiniIcon": "mini-icon-kitty",\n    "rpcMiniIconPause": "mini-icon-kitty-pause",\n    "rpcTime": [2, 54],\n\n    "composer": "UKiYO (Feat. LizNaithy)",\n    "artist": "Natzy and LizNaithy",\n    "coder": "Shiho",\n    "charter": "Shiho",\n    "pauseCover": "cover_kittyjam_erect",\n    "pauseTxtPos": -1965,\n\n    "fczado": false,\n\n    "leftNoteRGB": ["F634B5", "FFFFFF", "7A255C"],\n    "downNoteRGB": ["52465E", "FFFFFF", "2D1C3F"],\n    "upNoteRGB": ["F634B5", "FFFFFF", "7A255C"],\n    "rightNoteRGB": ["52465E", "FFFFFF", "2D1C3F"]\n}', true)
        saveFile("mods/KittyBucks/data/kittyjam/save-erect.txt", "essa música foi passada?: sim", true)
    end

    if difficultyName == 'erect' and ratingFC == 'SFC' and not botPlay and not practice then
        saveFile("mods/KittyBucks/data/"..songName.."/save-perfect.txt", "foi feito 100% nessa música?: sim", true)
    end
end