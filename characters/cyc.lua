function onUpdate(elapsed)
    
    if boyfriendName == 'cyc' and getProperty('boyfriend.animation.curAnim.name') == 'idle' then
        setProperty("boyfriend.color", getColorFromHex("FFFFFF"))
    end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    
    for i = 0, 3 do
        if noteData == i then
            setProperty("boyfriend.color", getColorFromHex("FFFFFF"))
        end
    end
end

function noteMiss(membersIndex, noteData, noteType, isSustainNote)
    
    if boyfriendName == 'cyc' and noteData == 0 then
        setProperty("boyfriend.color", FlxColor("BLUE"))
        playAnim("boyfriend", "singLEFT", true)
    elseif boyfriendName == 'cyc' and noteData == 1 then
        setProperty("boyfriend.color", FlxColor("BLUE"))
        playAnim("boyfriend", "singDOWN", true)
    elseif boyfriendName == 'cyc' and noteData == 2 then
        setProperty("boyfriend.color", FlxColor("BLUE"))
        playAnim("boyfriend", "singUP", true)
    elseif boyfriendName == 'cyc' and noteData == 3 then
        setProperty("boyfriend.color", FlxColor("BLUE"))
        playAnim("boyfriend", "singRIGHT", true)
    end
end

function noteMissPress(direction)
    
    if boyfriendName == 'cyc' and direction == 0 then
        setProperty("boyfriend.color", FlxColor("BLUE"))
        playAnim("boyfriend", "singLEFT", true)
    elseif boyfriendName == 'cyc' and direction == 1 then
        setProperty("boyfriend.color", FlxColor("BLUE"))
        playAnim("boyfriend", "singDOWN", true)
    elseif boyfriendName == 'cyc' and direction == 2 then
        setProperty("boyfriend.color", FlxColor("BLUE"))
        playAnim("boyfriend", "singUP", true)
    elseif boyfriendName == 'cyc' and direction == 3 then
        setProperty("boyfriend.color", FlxColor("BLUE"))
        playAnim("boyfriend", "singRIGHT", true)
    end
end