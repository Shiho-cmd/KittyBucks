luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local parsed = parseJson('data/'..songName..'/songData-'..difficultyName..'.json')

local min = parsed.rpcTime[1]
local sec = parsed.rpcTime[2]
local miniIcon = parsed.rpcMiniIcon
local id = parsed.rpcID

function onCreate()
    
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

    changeDiscordClientID(id)
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

function onUpdatePost()

    if songName == 'credits' then
        setTextString("socorro", "")
    else
        setTextString('socorro', min .. ':' .. sec..' Left')
    end

    if sec < 10 then
        setTextString('socorro', min .. ':' .. "0"..sec..' Left')
    else
        setTextString('socorro', min .. ':' .. sec..' Left')
    end
end

function onDestroy()
    
    changeDiscordClientID('863222024192262205')
end