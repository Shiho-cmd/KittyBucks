function onCreate()
    
    setProperty("camGame.visible", false)
    setProperty('camGame.bgColor', getColorFromHex('000000'))

    if songName == 'credits' then
        setProperty("camHUD.visible", true)
    else
        setProperty("camHUD.visible", false)
    end
end