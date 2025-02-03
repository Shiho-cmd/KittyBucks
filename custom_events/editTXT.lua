luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

function onEvent(eventName, value1, value2, strumTime)
    
    if eventName == 'editTXT' then
        saveFile(value1..'.txt', value2, true)
    end
end