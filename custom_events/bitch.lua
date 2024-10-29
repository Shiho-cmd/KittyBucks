luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

local on1 = false
local on2 = false

function onBeatHit()
    if on1 == true then
        triggerEvent('Add Camera Zoom', '', '')
    elseif on2 == true and curBeat % 2 == 0 then
        triggerEvent('Add Camera Zoom', '', '')
    end
end

function onEvent(name,value1,value2)
    if name == 'bitch' then
        if value1 == '1' then
            on1 = true
            on2 = false
        elseif value1 == '2' then
            on2 = true
            on1 = false
        elseif value1 == '0' then
            on1 = false
            on2 = false
        end
    end
end