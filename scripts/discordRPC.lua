function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local parsed = parseJson('data/stuff.json')

local miniIcon = 'mini-icon-kitty'

function onCreate()

    if songName == 'KittyJam' and difficultyName == 'buck' then
        min = parsed.kittyjam[1]
        sec = parsed.kittyjam[2]
    else
        min = parsed.kittyjamErect[1]
        sec = parsed.kittyjamErect[2]
    end

    if songName == 'SuperNova' then
        min = parsed.supernova[1]
        sec = parsed.supernova[2]
    end

    if songName == 'credits' then
        min = parsed.credits[1]
        sec = parsed.credits[2]
    end
    
    makeLuaText("socorro")
    addLuaText("socorro")
    setProperty("socorro.visible", false)

    if songName == 'credits' then
        makeLuaText("presence", 'In the credits menu')
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
    changeDiscordPresence(getTextString("presence"), getTextString("socorro"), miniIcon)
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

function onDestroy()
    
    changeDiscordClientID('863222024192262205')
end

function onUpdatePost()

    if songName == 'credits' then
        setTextString("socorro", "")
        miniIcon = 'mini-icon-pog'
    else
        setTextString('socorro', min .. ':' .. sec..' Left')
    end
end