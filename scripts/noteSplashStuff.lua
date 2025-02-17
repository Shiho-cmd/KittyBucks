function onCreate()
    
    makeAnimatedLuaSprite("splash-right", 'noteSplashes/noteSplashes-star-colored', -999, -999)
    makeAnimatedLuaSprite("splash-left", 'noteSplashes/noteSplashes-star-colored', -999, -999)
    makeAnimatedLuaSprite("splash-down", 'noteSplashes/noteSplashes-star-colored', -999, -999)
    makeAnimatedLuaSprite("splash-up", 'noteSplashes/noteSplashes-star-colored', -999, -999)
    
    addAnimationByPrefix("splash-right", "splashed", "black", 22, false)
    addAnimationByPrefix("splash-left", "splashed", "pink", 22, false)
    addAnimationByPrefix("splash-down", "splashed", "black", 22, false)
    addAnimationByPrefix("splash-up", "splashed", "pink", 22, false)

    setObjectCamera("splash-right", 'hud')
    setObjectCamera("splash-left", 'hud')
    setObjectCamera("splash-down", 'hud')
    setObjectCamera("splash-up", 'hud')

    scaleObject("splash-right", 0.5, 0.5)
    scaleObject("splash-left", 0.5, 0.5)
    scaleObject("splash-down", 0.5, 0.5)
    scaleObject("splash-up", 0.5, 0.5)

    setProperty("splash-right.alpha", splashAlpha)
    setProperty("splash-left.alpha", splashAlpha)
    setProperty("splash-down.alpha", splashAlpha)
    setProperty("splash-up.alpha", splashAlpha)
    
    addLuaSprite("splash-right", true)
    addLuaSprite("splash-left", true)
    addLuaSprite("splash-down", true)
    addLuaSprite("splash-up", true)
end

function onSongStart()
    
    setProperty("splash-left.x", defaultOpponentStrumX0 - 70)
    setProperty("splash-left.y", defaultOpponentStrumY0 - 70)
    setProperty("splash-down.x", defaultOpponentStrumX1 - 70)
    setProperty("splash-down.y", defaultOpponentStrumY1 - 70)
    setProperty("splash-up.x", defaultOpponentStrumX2 - 70)
    setProperty("splash-up.y", defaultOpponentStrumY2 - 70)
    setProperty("splash-right.x", defaultOpponentStrumX3 - 70)
    setProperty("splash-right.y", defaultOpponentStrumY3 - 70)
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

--[[local quanto = 1

function onUpdate(elapsed)
    
    if keyboardJustPressed("A") then
        setProperty("splash-left.x", getProperty("splash-left.x") - quanto)
    elseif keyboardJustPressed("D") then
        setProperty("splash-left.x", getProperty("splash-left.x") + quanto)
    elseif keyboardJustPressed("S") then
        setProperty("splash-left.y", getProperty("splash-left.y") - quanto)
    elseif keyboardJustPressed("W") then
        setProperty("splash-left.y", getProperty("splash-left.y") + quanto)
    elseif keyboardJustPressed("SPACE") then
        debugPrint(getProperty("splash-left.x")..' '..getProperty("splash-left.y"))
    end

    if keyboardPressed("SHIFT") then
        quanto = 10
    else
        quanto = 1
    end
end]]