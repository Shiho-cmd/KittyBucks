-- THANKS TO JoaoVictor742 ON GITHUB FOR HELPING ME WITH THIS SCRIPT HOLY SHIT
luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local parsed = parseJson('data/stuff.json')

--bf rgb
local bfRGBNr = { parsed.purple[1], parsed.black[1], parsed.purple[1], parsed.black[1] }
local bfRGBNg = { parsed.purple[2], parsed.black[2], parsed.purple[2], parsed.black[2] }
local bfRGBNb = { parsed.purple[3], parsed.black[3], parsed.purple[3], parsed.black[3] }
-- dad rgb
local dadRGBNr = { parsed.purple[1], parsed.black[1], parsed.purple[1], parsed.black[1] }
local dadRGBNg = { parsed.purple[2], parsed.black[2], parsed.purple[2], parsed.black[2] }
local dadRGBNb = { parsed.purple[3], parsed.black[3], parsed.purple[3], parsed.black[3] }

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