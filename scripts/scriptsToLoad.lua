local gameOver = getModSetting("over")
local pause = getModSetting("pause")
local discord = getModSetting("rpc")

function onCreate()
    
    if gameOver then
        addLuaScript(currentModDirectory.."/scripts/disabled/itsBingover.lua")
    end

    if pause then
        addLuaScript(currentModDirectory.."/scripts/disabled/pauseSubstate.lua")
    end

    if discord then
        addLuaScript(currentModDirectory.."/scripts/disabled/discordRPC.lua")
    end

    if songName ~= 'bruh' or songName ~= 'quiet' then
        addHScript(currentModDirectory.."/scripts/disabled/haxeShit.hx")
    end
end