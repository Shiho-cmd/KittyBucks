function parseJson(file)
	return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local gfDATA = parseJson('characters/data/girlf_DATA.json')
local bfDATA = parseJson('characters/data/boyf_DATA.json')
local hkDATA = parseJson('characters/data/hello-kitty_DATA.json')
local kuroDATA = parseJson('characters/data/kuromi-opponent_DATA.json')
local wsPlayer = getTextFromFile("data/the-guy/whosSingingPLAYER.txt")
local wsOpp = getTextFromFile("data/the-guy/whosSingingOPP.txt")
local playerColor = bfDATA.healthHex
local oppColor = hkDATA.healthHex

local onCutscene = true
local both = false
local bothOpp = false

function onStartCountdown()
	
	if onCutscene then
		startVideo("the_cut")
		onCutscene = false
		return Function_Stop;
	end
	return Function_Continue;
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    
    if noteType == 'gf' and not both then
        playerColor = gfDATA.healthHex
		callMethod('iconP1.changeIcon', {'girlf'})
		setHealthBarColors(oppColor, playerColor)
	elseif noteType ~= 'gf' and not both then
        playerColor = bfDATA.healthHex
		callMethod('iconP1.changeIcon', {"boyf"})
		setHealthBarColors(oppColor, playerColor)
    end
	
	if both then
		playerColor = '905B9D'
		callMethod('iconP1.changeIcon', {'boygirlff'})
		setHealthBarColors(oppColor, playerColor)
	end
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    
    if noteType == 'kuromi' and not bothOpp then
        oppColor = kuroDATA.healthHex
		callMethod('iconP2.changeIcon', {'kuromi'})
		setHealthBarColors(oppColor, playerColor)
	elseif noteType ~= 'kuromi' and not bothOpp then
        oppColor = hkDATA.healthHex
		callMethod('iconP2.changeIcon', {'kitty'})
		setHealthBarColors(oppColor, playerColor)
	end

	if bothOpp then
		oppColor = '6F4C8B'
		callMethod('iconP2.changeIcon', {'kurokitty'})
		setHealthBarColors(oppColor, playerColor)
	end
end

function onStepHit()
	
	if curStep == 1280 then
		bothOpp = true
	elseif curStep == 1344 then
		bothOpp = false
		both = true
	elseif curStep == 1408 then
		both = false
		playerColor = bfDATA.healthHex
		callMethod('iconP1.changeIcon', {"boyf"})
		setHealthBarColors(oppColor, playerColor)
	end
end