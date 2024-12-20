function onCountdownStarted()
    
    unlockAchievement("funny")
    saveFile("mods/KittyBucks/weeks/balls.json", '{\n"storyName": "Your New Week",\n"difficulties": "balls",\n"hideFreeplay": false,\n"weekBackground": "stage",\n"weekBefore": "tutorial",\n"freeplayColor": [\n146,\n113,\n253],\n"startUnlocked": true,\n"hideStoryMode": true,\n"songs": [\n[\n"Ultimate Koopa",\n"bf-pixel",\n[\n146,\n113,\n253\n]\n]\n],\n"weekCharacters": [\n"dad",\n"bf",\n"gf"\n],\n"hiddenUntilUnlocked": false,\n"weekName": "Custom Week"\n}', true)
end