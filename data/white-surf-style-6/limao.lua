local day = os.date ("%d")
local month = os.date ("%m")

function onCreate()
    
    if tonumber(day) ~= 25 and tonumber(month) ~= 12 then
        addLuaScript("scripts/disabled/snow")
    else
        addLuaScript("scripts/disabled/snow")
    end
end