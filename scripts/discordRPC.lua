function onCreate()
    min = getJsonContent("data/"..songName..'/stuff.json', 'minbuck')
    sec = getJsonContent("data/"..songName..'/stuff.json', 'secbuck')
    
    makeLuaText("socorro")
    addLuaText("socorro")
    setProperty("socorro.visible", true)

    if botPlay then
        makeLuaText("presence", 'Playing: '..songName..' '..'('..difficultyName..')'..' With BotPlay on (skill issue)')
        addLuaText("presence")
        setProperty("presence.visible", false)
    else
        makeLuaText("presence", 'Playing: '..songName..' '..'('..difficultyName..')')
        addLuaText("presence")
        setProperty("presence.visible", false)
    end
end

function onUpdate(elapsed)

    changeDiscordClientID('1246615253203288165')
    changeDiscordPresence(getTextString("presence"), getTextString("socorro")..' Left', "mini-icon-kitty")

    if getTextString("socorro") == '0:-1' then
        endSong()
    end
end

function onSongStart()

    runTimer('countdown', 1, 9999)
end

function onTimerCompleted(tag)

    if tag == 'countdown' then
        if sec ~= -1 then
            sec = sec - 1
        end

        if sec == -1 then
            if min ~= 0 then
                min = min - 1
                sec = 59
            end
            
            if min == 0 and sec == 0 then
                return
            end
        end
    end
end

function onEndSong()
    
    changeDiscordClientID('863222024192262205')
end

function onUpdatePost()

    setTextString('socorro', min .. ':' .. sec)
end