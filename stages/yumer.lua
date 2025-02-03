function onCreate()

    removeLuaScript("mods/KittyBucks/scripts/noteSplashStuff.lua")

    setProperty('camGame.bgColor', getColorFromHex('000000'))

    setObjectCamera("boyfriendGroup", 'hud')
end

function onCountdownStarted()
    
    for i = 0, 3 do
    setProperty("boyfriend.y", screenHeight - 200)
    setProperty("boyfriend.x", 190)
    scaleObject("boyfriend", 0.8, 0.8)
    setProperty("healthBar.visible", false)
    setProperty("iconP1.visible", false)
    setProperty("iconP2.visible", false)
    setPropertyFromGroup('opponentStrums', i, 'x', -900);
    setPropertyFromGroup('playerStrums', 0, 'x', 410);
    setPropertyFromGroup('playerStrums', 1, 'x', 532);
    setPropertyFromGroup('playerStrums', 2, 'x', 653);
    setPropertyFromGroup('playerStrums', 3, 'x', 770);
end
end