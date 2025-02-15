local gameOver = getPropertyFromClass('backend.ClientPrefs', 'data.over')
local pause = getPropertyFromClass('backend.ClientPrefs', 'data.pause')

function onCreate()
    
    if gameOver then
        addLuaScript(currentModDirectory.."/scripts/disabled/itsBingover.lua")
    end

    if pause then
        addLuaScript(currentModDirectory.."/scripts/disabled/pauseSubstate.lua")
    end

    if songName ~= 'bruh' then
        addHScript(currentModDirectory.."/scripts/disabled/haxeShit.hx")
    end
end