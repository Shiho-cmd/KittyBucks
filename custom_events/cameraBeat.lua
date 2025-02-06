luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

local valor = '0'
local valor2 = nil

function onEvent(name,value1,value2)

    if name == 'cameraBeat' then
        valor = value1
        valor2 = value2
    end
end

function onBeatHit()

    split = stringSplit(valor2, ", ")
    
    if curBeat % tonumber(valor) == 0 and valor ~= 0 then
        triggerEvent('Add Camera Zoom', split[1], split[2])
    elseif curBeat % tonumber(valor) == 0 and valor2 == nil and valor ~= 0 then
        triggerEvent('Add Camera Zoom', '', '')
    end
end