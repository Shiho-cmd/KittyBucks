function onUpdate(elapsed)
    
    if boyfriendName == 'my-melody' and getProperty('boyfriend.animation.curAnim.name') == 'idle' then
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
    
    for i = 0,3 do
        if boyfriendName == 'my-melody' and noteData == i then
            setProperty("boyfriend.color", FlxColor("BLUE"))
        end
    end
end

function noteMissPress(direction)
    
    for i = 0,3 do
        if boyfriendName == 'my-melody' and direction == i then
            setProperty("boyfriend.color", FlxColor("BLUE"))
        end
    end
end