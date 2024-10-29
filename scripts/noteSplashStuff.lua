function onCreate()
    
    makeAnimatedLuaSprite("splash-right", 'noteSplashes/noteSplashes-sparkles', 375, -10)
    makeAnimatedLuaSprite("splash-left", 'noteSplashes/noteSplashes-sparkles', 38, -10)
    makeAnimatedLuaSprite("splash-down", 'noteSplashes/noteSplashes-sparkles', 150, -10)
    makeAnimatedLuaSprite("splash-up", 'noteSplashes/noteSplashes-sparkles', 263, -10)
    addAnimationByPrefix("splash-right", "splashed", "splash sparkles red 1", 19, false)
    addAnimationByPrefix("splash-left", "splashed", "splash sparkles purple 1", 19, false)
    addAnimationByPrefix("splash-down", "splashed", "splash sparkles blue 1", 19, false)
    addAnimationByPrefix("splash-up", "splashed", "splash sparkles green 1", 19, false)
    setObjectCamera("splash-right", 'other')
    setObjectCamera("splash-left", 'other')
    setObjectCamera("splash-down", 'other')
    setObjectCamera("splash-up", 'other')
    scaleObject("splash-right", 0.9, 0.9)
    scaleObject("splash-left", 0.9, 0.9)
    scaleObject("splash-down", 0.9, 0.9)
    scaleObject("splash-up", 0.9, 0.9)
    setProperty("splash-right.alpha", splashAlpha)
    setProperty("splash-left.alpha", splashAlpha)
    setProperty("splash-down.alpha", splashAlpha)
    setProperty("splash-up.alpha", splashAlpha)
    addLuaSprite("splash-right", true)
    addLuaSprite("splash-left", true)
    addLuaSprite("splash-down", true)
    addLuaSprite("splash-up", true)
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    
    if noteData == 3 and not isSustainNote then
        playAnim("splash-right", "splashed", true)
    elseif noteData == 0 and not isSustainNote then
        playAnim("splash-left", "splashed", true)
    elseif noteData == 1 and not isSustainNote then
        playAnim("splash-down", "splashed", true)
    elseif noteData == 2 and not isSustainNote then
        playAnim("splash-up", "splashed", true)
    end
end