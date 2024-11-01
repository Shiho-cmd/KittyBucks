function onCreate()
    
    makeAnimatedLuaSprite("splash-right", 'noteSplashes/noteSplashes-sparkles-black', 365, -25)
    makeAnimatedLuaSprite("splash-left", 'noteSplashes/noteSplashes-sparkles-pink', 28, -25)
    makeAnimatedLuaSprite("splash-down", 'noteSplashes/noteSplashes-sparkles-black', 140, -25)
    makeAnimatedLuaSprite("splash-up", 'noteSplashes/noteSplashes-sparkles-pink', 253, -25)
    
    addAnimationByPrefix("splash-right", "splashed", "splash sparkles red ", 22, false)
    addAnimationByPrefix("splash-left", "splashed", "splash sparkles purple ", 22, false)
    addAnimationByPrefix("splash-down", "splashed", "splash sparkles blue ", 22, false)
    addAnimationByPrefix("splash-up", "splashed", "splash sparkles green ", 22, false)

    setObjectCamera("splash-right", 'hud')
    setObjectCamera("splash-left", 'hud')
    setObjectCamera("splash-down", 'hud')
    setObjectCamera("splash-up", 'hud')

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

    if middlescroll then
        setProperty("splash-up.x", 905)
        setProperty("splash-right.x", 1020)
        setProperty("splash-left.x", 14)
        setProperty("splash-down.x", 127)
        setProperty("splash-up.alpha", splashAlpha / 2)
        setProperty("splash-right.alpha", splashAlpha / 2)
        setProperty("splash-down.alpha", splashAlpha / 2)
        setProperty("splash-left.alpha", splashAlpha / 2)
    end
end

function onSongStart()
    
    -- the splashes glitch when the y position becomes a postive number for some weird reason so the splashes are disabled for downscroll sorry downscroll users
    if not downscroll then
        setProperty("splash-right.visible", true)
        setProperty("splash-left.visible", true)
        setProperty("splash-down.visible", true)
        setProperty("splash-up.visible", true)
    end
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