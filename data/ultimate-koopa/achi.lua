function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local parsed = parseJson('data/ultimate-koopa/songData-balls.json')

function onCountdownStarted()
    
    unlockAchievement("funny")
    saveFile("mods/KittyBucks/weeks/balls.json", '{\n"storyName": "Your New Week",\n"difficulties": "balls",\n"hideFreeplay": false,\n"weekBackground": "stage",\n"weekBefore": "tutorial",\n"freeplayColor": [\n146,\n113,\n253],\n"startUnlocked": true,\n"hideStoryMode": true,\n"songs": [\n[\n"Ultimate Koopa",\n"bf-pixel",\n[\n146,\n113,\n253\n]\n]\n],\n"weekCharacters": [\n"dad",\n"bf",\n"gf"\n],\n"hiddenUntilUnlocked": false,\n"weekName": "Custom Week"\n}', true)
end

function onEndSong()
    
    if not botPlay and not practice and misses == 0 and not parsed.fczado then
        setAchievementScore("truefc", getAchievementScore("truefc") + 1, false)
        saveFile('mods/KittyBucks/data/ultimate-koopa/songData-balls.json', '{\n    "rpcID": "1317230179084533850",\n    "rpcMiniIcon": "mini-icon-bf",\n    "rpcMiniIconPause": "mini-icon-bf"\n    "rpcTime": [2, 13],\n\n    "composer": "SiIvaGunner",\n    "artist": "Moawling",\n    "coder": "Shiho",\n    "charter": "Shiho",\n    "pauseTxtPos": -1710,\n    "pauseCover": "cover_siiva",\n\n    "fczado": true,\n\n    "leftNoteRGB": ["F634B5", "FFFFFF", "7A255C"],\n    "downNoteRGB": ["52465E", "FFFFFF", "2D1C3F"],\n    "upNoteRGB": ["F634B5", "FFFFFF", "7A255C"],\n    "rightNoteRGB": ["52465E", "FFFFFF", "2D1C3F"]\n}', true)
        saveFile("mods/KittyBucks/data/ultimate-koopa/save.txt", "essa música foi passada?: sim", true)
    end
end