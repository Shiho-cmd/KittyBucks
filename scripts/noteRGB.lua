function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local parsed = parseJson('data/stuff.json')

--bf rgb
local bfRGBNr = { parsed.noteOrpleR, parsed.noteBlackR, parsed.noteOrpleR, parsed.noteBlackR }
local bfRGBNg = { parsed.noteOrpleG, parsed.noteBlackG, parsed.noteOrpleG, parsed.noteBlackG }
local bfRGBNb = { parsed.noteOrpleB, parsed.noteBlackB, parsed.noteOrpleB, parsed.noteBlackB }
-- dad rgb
local dadRGBNr = { parsed.noteOrpleR, parsed.noteBlackR, parsed.noteOrpleR, parsed.noteBlackR }
local dadRGBNg = { parsed.noteOrpleG, parsed.noteBlackG, parsed.noteOrpleG, parsed.noteBlackG }
local dadRGBNb = { parsed.noteOrpleB, parsed.noteBlackB, parsed.noteOrpleB, parsed.noteBlackB }

-- note   
function onSpawnNote(id, nd, nt, sus)
if getPropertyFromGroup('notes', id, 'mustPress') == true then
    setPropertyFromGroup('notes', id, 'rgbShader.r', getColorFromHex(bfRGBNr[getPropertyFromGroup('notes', id, 'noteData')+1]))
    setPropertyFromGroup('notes', id, 'rgbShader.g', getColorFromHex(bfRGBNg[getPropertyFromGroup('notes', id, 'noteData')+1]))      
    setPropertyFromGroup('notes', id, 'rgbShader.b', getColorFromHex(bfRGBNb[getPropertyFromGroup('notes', id, 'noteData')+1]))
else
    setPropertyFromGroup('notes', id, 'rgbShader.r', getColorFromHex(dadRGBNr[getPropertyFromGroup('notes', id, 'noteData')+1]))
    setPropertyFromGroup('notes', id, 'rgbShader.g', getColorFromHex(dadRGBNg[getPropertyFromGroup('notes', id, 'noteData')+1]))
    setPropertyFromGroup('notes', id, 'rgbShader.b', getColorFromHex(dadRGBNb[getPropertyFromGroup('notes', id, 'noteData')+1]))
end
end
-- strum note
function onUpdatePost(e)
for i=0, getProperty('playerStrums.length')-1 do
    setPropertyFromGroup('playerStrums', i, 'rgbShader.r', ((getPropertyFromGroup('playerStrums', i, 'animation.curAnim.name') == 'pressed' or getPropertyFromGroup('playerStrums', i, 'animation.curAnim.name') == 'confirm') and getColorFromHex(bfRGBNr[i+1]) or getColorFromHex(bfRGBNr[i+1])))
    setPropertyFromGroup('playerStrums', i, 'rgbShader.g', ((getPropertyFromGroup('playerStrums', i, 'animation.curAnim.name') == 'pressed' or getPropertyFromGroup('playerStrums', i, 'animation.curAnim.name') == 'confirm') and getColorFromHex(bfRGBNg[i+1]) or getColorFromHex(bfRGBNg[i+1])))
    setPropertyFromGroup('playerStrums', i, 'rgbShader.b', ((getPropertyFromGroup('playerStrums', i, 'animation.curAnim.name') == 'pressed' or getPropertyFromGroup('playerStrums', i, 'animation.curAnim.name') == 'confirm') and getColorFromHex(bfRGBNb[i+1]) or getColorFromHex(bfRGBNb[i+1])))
end
for i=0, getProperty('opponentStrums.length')-1 do
    setPropertyFromGroup('opponentStrums', i, 'rgbShader.r', ((getPropertyFromGroup('opponentStrums', i, 'animation.curAnim.name') == 'pressed' or getPropertyFromGroup('opponentStrums', i, 'animation.curAnim.name') == 'confirm') and getColorFromHex(dadRGBNr[i+1]) or getColorFromHex(dadRGBNr[i+1])))
    setPropertyFromGroup('opponentStrums', i, 'rgbShader.g', ((getPropertyFromGroup('opponentStrums', i, 'animation.curAnim.name') == 'pressed' or getPropertyFromGroup('opponentStrums', i, 'animation.curAnim.name') == 'confirm') and getColorFromHex(dadRGBNg[i+1]) or getColorFromHex(dadRGBNg[i+1])))
    setPropertyFromGroup('opponentStrums', i, 'rgbShader.b', ((getPropertyFromGroup('opponentStrums', i, 'animation.curAnim.name') == 'pressed' or getPropertyFromGroup('opponentStrums', i, 'animation.curAnim.name') == 'confirm') and getColorFromHex(dadRGBNb[i+1]) or getColorFromHex(dadRGBNb[i+1])))

end
end