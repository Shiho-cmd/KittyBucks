function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local parsed = parseJson('pack.json')

function onCreate()
    
    makeLuaText("wtrmrk", 'KittyBucks '..parsed.buildVersion, 0, screenWidth - 310, 0)
    setTextSize("wtrmrk", 20)
    setProperty("wtrmrk.alpha", 0.5)
    setObjectCamera("wtrmrk", 'other')
    addLuaText("wtrmrk")
end