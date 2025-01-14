function onCreate()
    
    if buildTarget ~= 'android' then
        addLuaScript("scripts/disabled/pauseSubState")
    else
        addLuaScript("scripts/disabled/pauseSubStateMobile")
    end
end