luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local stageShit = parseJson('stages/'..curStage..'.json')
local bfShit = parseJson('characters/'..boyfriendName..'.json')
local dadShit = parseJson('characters/'..dadName..'.json')

local xx = 340;
local yy = 520;
local xx2 = 900;
local yy2 = 490;
local ofs = 20;
local del = 0;
local del2 = 0;
local sim = false;

function onEvent(eventName, value1, value2, strumTime)
    
    if eventName == 'followNotes' then
        
        ofs = value2

        if value1 == 'on' then
            sim = true
        elseif value1 == 'off' then
            sim = false
        end
    end
end

function onUpdate()

    if boyfriendName == 'kuromi-erect' then
        bfCamX = getMidpointX("boyfriend") - 400 + bfShit.camera_position[1] - stageShit.camera_boyfriend[1]
        bfCamY = getMidpointY("boyfriend") - 100 + bfShit.camera_position[2] + stageShit.camera_boyfriend[2]
        dadCamX = getMidpointX("dad") + 150 + dadShit.camera_position[1] + stageShit.camera_opponent[1]
        dadCamY = getMidpointY("dad") - 100 + dadShit.camera_position[2] + stageShit.camera_opponent[2]
    else
        bfCamX = getMidpointX("boyfriend") - 100 + bfShit.camera_position[1] - stageShit.camera_boyfriend[1]
        bfCamY = getMidpointY("boyfriend") - 100 + bfShit.camera_position[2] + stageShit.camera_boyfriend[2]
        dadCamX = getMidpointX("dad") + 150 + dadShit.camera_position[1] + stageShit.camera_opponent[1]
        dadCamY = getMidpointY("dad") - 100 + dadShit.camera_position[2] + stageShit.camera_opponent[2]
    end

	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end

        if not mustHitSection and sim then
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',dadCamX-tonumber(ofs),dadCamY)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',dadCamX+tonumber(ofs),dadCamY)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',dadCamX,dadCamY-tonumber(ofs))
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',dadCamX,dadCamY+tonumber(ofs))
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',dadCamX-tonumber(ofs),dadCamY)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',dadCamX+tonumber(ofs),dadCamY)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',dadCamX,dadCamY-tonumber(ofs))
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',dadCamX,dadCamY+tonumber(ofs))
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',dadCamX,dadCamY)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',dadCamX,dadCamY)
            end
        elseif mustHitSection and sim then
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',bfCamX-tonumber(ofs),bfCamY)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',bfCamX+tonumber(ofs),bfCamY)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',bfCamX,bfCamY-tonumber(ofs))
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',bfCamX,bfCamY+tonumber(ofs))
            end
	    if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',bfCamX,bfCamY)
    else
        triggerEvent('Camera Follow Pos','','')
    end
end
end