function onCreate()
    
    setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName)
end

function onPause()
    
    setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName..' (PAUSED)')
end

function onResume()
    
    setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName)
end

function onGameOver()
    
    setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Game Over')
end

function onDestroy()
    
    setPropertyFromClass("openfl.Lib", "application.window.title", 'Friday Night Funkin\': Psych Engine')
end