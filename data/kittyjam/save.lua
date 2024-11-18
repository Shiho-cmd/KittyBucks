local numPode = false

function onCreate()
    
    initSaveData("charm")
end

function onEndSong()

    setDataFromSave("charm", "pintos", true)
end