function onCreate()
    
    makeAnimatedLuaSprite("splash-right", 'noteSplashes/noteSplashes-star-colored', 307, -66)
    makeAnimatedLuaSprite("splash-left", 'noteSplashes/noteSplashes-star-colored', -26, -66)
    makeAnimatedLuaSprite("splash-down", 'noteSplashes/noteSplashes-star-colored', 86, -66)
    makeAnimatedLuaSprite("splash-up", 'noteSplashes/noteSplashes-star-colored', 199, -66)
    
    addAnimationByPrefix("splash-right", "splashed", "black", 22, false)
    addAnimationByPrefix("splash-left", "splashed", "pink", 22, false)
    addAnimationByPrefix("splash-down", "splashed", "black", 22, false)
    addAnimationByPrefix("splash-up", "splashed", "pink", 22, false)

    setObjectCamera("splash-right", 'hud')
    setObjectCamera("splash-left", 'hud')
    setObjectCamera("splash-down", 'hud')
    setObjectCamera("splash-up", 'hud')

    scaleObject("splash-right", 0.7, 0.7)
    scaleObject("splash-left", 0.7, 0.7)
    scaleObject("splash-down", 0.7, 0.7)
    scaleObject("splash-up", 0.7, 0.7)

    setProperty("splash-right.alpha", splashAlpha)
    setProperty("splash-left.alpha", splashAlpha)
    setProperty("splash-down.alpha", splashAlpha)
    setProperty("splash-up.alpha", splashAlpha)
    setProperty("splash-right.visible", false)
    setProperty("splash-left.visible", false)
    setProperty("splash-down.visible", false)
    setProperty("splash-up.visible", false)
    
    addLuaSprite("splash-right", true)
    addLuaSprite("splash-left", true)
    addLuaSprite("splash-down", true)
    addLuaSprite("splash-up", true)

    setProperty("splash-right.visible", false)
    setProperty("splash-left.visible", false)
    setProperty("splash-down.visible", false)
    setProperty("splash-up.visible", false)

    if middlescroll then
        setProperty("splash-up.x", 854)
        setProperty("splash-right.x", 961)
        setProperty("splash-left.x", -36)
        setProperty("splash-down.x", 75)
        setProperty("splash-up.alpha", splashAlpha / 2)
        setProperty("splash-right.alpha", splashAlpha / 2)
        setProperty("splash-down.alpha", splashAlpha / 2)
        setProperty("splash-left.alpha", splashAlpha / 2)
    end
    
    if downscroll then
        setProperty("splash-up.y", 454)
        setProperty("splash-right.y", 454)
        setProperty("splash-left.y", 454)
        setProperty("splash-down.y", 454)
    end
end

function onSongStart()
    
    setProperty("splash-right.visible", true)
    setProperty("splash-left.visible", true)
    setProperty("splash-down.visible", true)
    setProperty("splash-up.visible", true)
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    
    if noteData == 3 and not isSustainNote then
        playAnim("splash-right", "splashed", true)
        setObjectOrder("splash-right", 99)     
    elseif noteData == 0 and not isSustainNote then
        playAnim("splash-left", "splashed", true)
        setObjectOrder("splash-left", 99)
    elseif noteData == 1 and not isSustainNote then
        playAnim("splash-down", "splashed", true)
        setObjectOrder("splash-down", 99)
    elseif noteData == 2 and not isSustainNote then
        playAnim("splash-up", "splashed", true)
        setObjectOrder("splash-up", 99)
    end
end

--[[[local quanto = 1

function onUpdate(elapsed)
    
    if keyboardJustPressed("A") then
        setProperty("splash-right.x", getProperty("splash-right.x") - quanto)
    elseif keyboardJustPressed("D") then
        setProperty("splash-right.x", getProperty("splash-right.x") + quanto)
    elseif keyboardJustPressed("SPACE") then
        debugPrint(getProperty("splash-right.x")..' '..getProperty("splash-up.y"))
    end

    if keyboardPressed("SHIFT") then
        quanto = 10
    else
        quanto = 1
    end
end]]