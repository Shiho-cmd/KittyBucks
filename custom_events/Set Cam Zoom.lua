luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

function onEvent(name,value1,value2)

    if name == "Set Cam Zoom" then

	split = stringSplit(value2, ", ")
	split2 = stringSplit(value1, ", ")
        
    if value2 == '' then
		setProperty("defaultCamZoom", value1)
	else
		doTweenZoom('camz', split2[2], tonumber(split2[1]), tonumber(split[1]), split[2])
		end
	end
end

function onTweenCompleted(name)

	if name == 'camz' then
		setProperty("defaultCamZoom",getProperty('camGame.zoom')) 
	end
end