local hit = false

function onCreate()

    setProperty('camGame.bgColor', getColorFromHex('000000'))

    precacheImage("castle")
    precacheImage("bowserthing")

    makeAnimatedLuaSprite("bg", 'castle', 0, 0)
    addAnimationByPrefix("bg", "loop", "idk", 12, true)
    setObjectCamera("bg", 'hud')
    scaleObject("bg", 3, 3)
    screenCenter("bg")
    addLuaSprite("bg", false)
    setProperty("bg.alpha", 0)

    makeAnimatedLuaSprite("bow", 'bowserthing', 0, 0)
    addAnimationByPrefix("bow", "trans", "funny", 24, false)
    setObjectCamera("bow", 'other')
    scaleObject("bow", 3, 3)
    screenCenter("bow")
    addLuaSprite("bow", false)
    setProperty("bow.visible", false)

    setObjectCamera("boyfriendGroup", 'hud')
    setObjectOrder("boyfriendGroup", 99)
    setCharacterX("boyfriend", 620)
    setCharacterY("boyfriend", -50)
    setProperty("boyfriendGroup.alpha", 0)
    
    setProperty("dadGroup.visible", false)
end

function onSongStart()
    
    doTweenAlpha("eitaPorra", "boyfriend", 1, 8, "linear")
    doTweenAlpha("eitaCaralho", "bg", 1, 8, "linear")
end

function onCountdownStarted()
   
    noteTweenX("bah", 0, -999, 0.01, "linear")
    noteTweenX("ba", 1, -999, 0.01, "linear")
    noteTweenX("b", 2, -999, 0.01, "linear")
    noteTweenX("hab", 3, -999, 0.01, "linear")
    setProperty("iconP1.visible", false)
    setProperty("iconP2.visible", false)
    setProperty("healthBar.visible", false)
    setProperty("timeBar.visible", false)
    setProperty("timeTxt.visible", false)
end

function onUpdatePost(elapsed)
    
    if not botPlay and hit then
        setTextString("scoreTxt", "Score: "..score..' | Misses: '..misses..' | Health: '..math.floor(getProperty("health") * 50)..'% | Rating: '..ratingName..' ('..round(rating * 100, 2)..'%) '..'- '..ratingFC)
    elseif botPlay or not hit then
        setTextString("scoreTxt", "Score: "..score..' | Misses: '..misses..' | Health: '..math.floor(getProperty("health") * 50)..'% | Rating: '..ratingName)
    end
end

function round(x, n)
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
    return x / n
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    
    for i = 0,3 do 
        if noteData == i then
            hit = true
        end
    end
end

function onStepHit()
    
    if curStep == 1640 then
        setProperty("bow.visible", true)
        playAnim("bow", "trans")
    end
end