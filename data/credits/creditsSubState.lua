function onStartCountdown() 
    if not allowCountdown then
        return Function_Stop
    end
    if allowCountdown then
        return Function_Continue
    end 
end

function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local parsed = parseJson('data/stuff.json')

local creditsName = parsed.shihoCre[1]
local creditsShortTxt = parsed.shihoCre[2]
local creditsLongTxt = parsed.shihoCre[3]
local color = parsed.shihoCre[4]
local link = parsed.shihoCre[5]

local pos = 0

function onCreate()
    
    makeLuaText("name", creditsName, 0, 0.0, 0.0)
    makeLuaText("shortTxt", creditsShortTxt, 0, 0.0, 0.0)
    makeLuaText("longTxt", creditsLongTxt, 0, 700, 0.0)
    setObjectCamera("name", 'other')
    setObjectCamera("shortTxt", 'other')
    setObjectCamera("longTxt", 'other')
    setTextSize("name", 70)
    setTextSize("shortTxt", 25)
    setTextSize("longTxt", 25)
    setProperty("shortTxt.y", getProperty("name.y") + 70)
    screenCenter("name", 'x')
    screenCenter("shortTxt", 'x')
    screenCenter("longTxt", 'y')
    addLuaText("name")
    addLuaText("shortTxt")
    addLuaText("longTxt")
    setTextAlignment("longTxt", 'right')

    makeLuaText("placeholder", "Link button", 0, 0.0, 700)
    setObjectCamera("placeholder", 'other')
    addLuaText("placeholder")
    setTextSize("placeholder", 20)
    setTextBorder("placeholder", 100, "000000")

    makeLuaSprite("back", 'menuDesat', 0, 0)
    setObjectCamera("back", 'other')
    addLuaSprite("back", false)

    makeLuaSprite("placeholderImg", 'galaxy_pocket', 200, 300)
    setObjectCamera("placeholderImg", 'other')
    addLuaSprite("placeholderImg", false)
    setProperty("placeholderImg.visible", false)
    scaleObject("placeholderImg", 0.3, 0.3)

    makeLuaSprite("liz", 'credits/liz', 200, 300)
    setObjectCamera("liz", 'other')
    addLuaSprite("liz", false)
    setProperty("liz.visible", false)

    makeLuaSprite("natzy", 'credits/n4tzy', 200, 300)
    setObjectCamera("natzy", 'other')
    addLuaSprite("natzy", false)
    setProperty("natzy.visible", false)

    makeAnimatedLuaSprite("shi", 'programmerArt/Shilito', -100, 0)
    addAnimationByPrefix("shi", "idle", "idle", 12, true)
    setObjectCamera("shi", 'other')
    setProperty('shi.antialiasing', false)
    addLuaSprite("shi", false)

    playSound("funnyCredits", 1, 'music')

    setPropertyFromClass("flixel.FlxG", "mouse.visible", true)

    setProperty("camHUD.visible", false)
    setProperty("camGame.visible", false)
end

function onUpdate(elapsed)

    if pos == 0 then
        creditsName = parsed.shihoCre[1]
        creditsShortTxt = parsed.shihoCre[2]
        creditsLongTxt = parsed.shihoCre[3]
        color = parsed.shihoCre[4]
        link = parsed.shihoCre[5]
        setProperty("shi.visible", true)
        setProperty("placeholderImg.visible", false)
        setProperty("liz.visible", false)
        setProperty("natzy.visible", false)
        doTweenColor("corYay", "back", color, 0.5, "linear")
        setTextString("name", creditsName)
        setTextString("shortTxt", creditsShortTxt)
        setTextString("longTxt", creditsLongTxt)
        screenCenter("name", 'x')
        screenCenter("shortTxt", 'x')
    elseif pos == 1 then
        creditsName = parsed.lizCre[1]
        creditsShortTxt = parsed.lizCre[2]
        creditsLongTxt = parsed.lizCre[3]
        color = parsed.lizCre[4]
        link = parsed.lizCre[5]
        setProperty("shi.visible", false)
        setProperty("placeholderImg.visible", false)
        setProperty("liz.visible", true)
        setProperty("natzy.visible", false)
        doTweenColor("corYay", "back", color, 0.5, "linear")
        setTextString("name", creditsName)
        setTextString("shortTxt", creditsShortTxt)
        setTextString("longTxt", creditsLongTxt)
        screenCenter("name", 'x')
        screenCenter("shortTxt", 'x')
    elseif pos == 2 then
        creditsName = parsed.ukiyoCre[1]
        creditsShortTxt = parsed.ukiyoCre[2]
        creditsLongTxt = parsed.ukiyoCre[3]
        color = parsed.ukiyoCre[4]
        link = parsed.ukiyoCre[5]
        setProperty("shi.visible", false)
        setProperty("placeholderImg.visible", true)
        setProperty("liz.visible", false)
        setProperty("natzy.visible", false)
        doTweenColor("corYay", "back", color, 0.5, "linear")
        setTextString("name", creditsName)
        setTextString("shortTxt", creditsShortTxt)
        setTextString("longTxt", creditsLongTxt)
        screenCenter("name", 'x')
        screenCenter("shortTxt", 'x')
    elseif pos == 3 then
        creditsName = parsed.natzyCre[1]
        creditsShortTxt = parsed.natzyCre[2]
        creditsLongTxt = parsed.natzyCre[3]
        color = parsed.natzyCre[4]
        link = parsed.natzyCre[5]
        setProperty("shi.visible", false)
        setProperty("placeholderImg.visible", false)
        setProperty("liz.visible", false)
        setProperty("natzy.visible", true)
        doTweenColor("corYay", "back", color, 0.5, "linear")
        setTextString("name", creditsName)
        setTextString("shortTxt", creditsShortTxt)
        setTextString("longTxt", creditsLongTxt)
        screenCenter("name", 'x')
        screenCenter("shortTxt", 'x')
    elseif pos > 3 then
        pos = 0
    elseif pos < 0 then
        pos = 3
    end

    if keyboardJustPressed("D") or keyboardJustPressed("RIGHT") or gamepadJustPressed(1, "DPAD_RIGHT") or gamepadJustPressed(1, "LEFT_STICK_DIGITAL_RIGHT") then
        pos = pos + 1
    elseif keyboardJustPressed("A") or keyboardJustPressed("LEFT") or gamepadJustPressed(1, "DPAD_LEFT") or gamepadJustPressed(1, "LEFT_STICK_DIGITAL_LEFT") then
        pos = pos - 1
    end
    
    if keyJustPressed('back') then
        exitSong(false)
    elseif getMouseX('camOther') > getProperty('shi.x') and getMouseY('camOther') > getProperty('shi.y') and getMouseX('camOther') < getProperty('shi.x') + getProperty('shi.width') and getMouseY('camOther') < getProperty('shi.y') + getProperty('shi.height') and mouseReleased() then
        playSound("honk", 1, 'honk')
        doTweenX("boom", "shi.scale", 1.3, 0.5, "elasticOut")
        doTweenY("moob", "shi.scale", 0.8, 0.5, "elasticOut")
        runTimer("xd", 0.1)
    elseif getMouseX('camOther') > getProperty('placeholder.x') and getMouseY('camOther') > getProperty('placeholder.y') and getMouseX('camOther') < getProperty('placeholder.x') + getProperty('placeholder.width') and getMouseY('camOther') < getProperty('placeholder.y') + getProperty('placeholder.height') and mouseReleased() then
        local function open_link()
            os.execute("start "..link)
        end
        open_link()
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    
    if tag == 'xd' then
        doTweenX("boom", "shi.scale", 1, 0.5, "elasticOut")
        doTweenY("moob", "shi.scale", 1, 0.5, "elasticOut")
    end
end

function onUpdatePost(elapsed)
    
    setProperty("shi.angle", getProperty("shi.angle") + 0.5)
end

function onSoundFinished(tag)
    
    if tag == 'music' then
        playSound("funnyCredits", 1, 'music')
    end 
end