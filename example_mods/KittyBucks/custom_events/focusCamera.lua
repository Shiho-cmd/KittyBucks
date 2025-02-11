luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local parsed = parseJson('stages/'..curStage..'.json')

function onEvent(eventName, value1, value2, strumTime)

    if eventName == 'focusCamera' then
        if value2 == '' or value2 == nil then
            setProperty("cameraSpeed", 1)
        else
            setProperty("cameraSpeed", value2)
        end

        if value1 == 'bf' then
            triggerEvent('Camera Follow Pos', '', '')
            cameraSetTarget("boyfriend")
        elseif value1 == 'dad' then
            triggerEvent('Camera Follow Pos', '', '')
            cameraSetTarget("dad")
        elseif value1 == 'shiho' then
            triggerEvent('Camera Follow Pos', '890', '480')
        elseif value1 == 'mongus' then
            triggerEvent('Camera Follow Pos', '910', '600')
        elseif value1 == 'bluck' then
            triggerEvent('Camera Follow Pos', '680', '390')
        elseif value1 == 'john' then
            triggerEvent('Camera Follow Pos', '-50', '550')
        elseif value1 == 'center' then
            triggerEvent('Camera Follow Pos', parsed.cameraCenter[1], parsed.cameraCenter[2])
        elseif value1 == '' or value1 == nil then
            triggerEvent('Camera Follow Pos', '', '')
        end
    end
end