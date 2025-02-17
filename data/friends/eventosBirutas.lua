local distortion = 0.01
local pode = false
local voltarProBS = false

function onCreate()

    saveFile("mods/KittyBucks/weeks/robloqui.json", '{\n\n	"songs": [\n		[\n			"Friends",\n			"face",\n			[\n				146,\n				113,\n				253\n			]\n		]\n	],\n	"hiddenUntilUnlocked": false,\n	"hideFreeplay": false,\n	"weekBackground": "stage",\n	"difficulties": "buck",\n	"weekCharacters": [\n		"dad",\n		"bf",\n		"gf"\n	],\n	"storyName": "Your New Week",\n	"weekName": "Custom Week",\n	"freeplayColor": [\n		146,\n		113,\n		253\n	],\n	"hideStoryMode": true,\n	"weekBefore": "tutorial",\n	"startUnlocked": true\n}', true)

    local var ShaderName = 'melt'

    if shadersEnabled then  
        initLuaShader(ShaderName)
        makeLuaSprite('camShader', nil)
        makeGraphic('camShader', screenWidth, screenHeight)
        setSpriteShader('camShader', ShaderName)
    end
end

function onUpdate(elapsed)

    noteTweenAlpha("lmaololxwvd", 0, 0.7, 0.01, "linear")
    noteTweenAlpha("lmaewvwvolol", 1, 0.7, 0.01, "linear")
    noteTweenAlpha("rvvlmao", 2, 0.7, 0.01, "linear")
    noteTweenAlpha("lwevwev", 3, 0.7, 0.01, "linear")

    if curStep == 1632 and shadersEnabled then
        pode = true
        runHaxeCode([[                  
            FlxG.game.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
        ]])
        elseif curStep == 1664 and shadersEnabled then
            pode = false
            runHaxeCode([[
                FlxG.game.setFilters([]);
            ]])
        end

        if pode and shadersEnabled then
            distortion = distortion - 0.03
            setShaderFloat('camShader', 'iTime', distortion)
        end
    end

function onCreatePost()

    for i = 0, getProperty('unspawnNotes.length') - 1 do
        if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false and getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'ukiyo-ghost' or getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false and getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'natzy-ghost' or getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false and getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'liz-ghost' or getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false and getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'bluck-ghost' then
            setPropertyFromGroup('unspawnNotes', i, 'offsetX', getPropertyFromGroup('unspawnNotes', i, 'offsetX') + 900)
        end
    end
end

function onSpawnNote(membersIndex, noteData, noteType, isSustainNote, strumTime)
    
    if getPropertyFromGroup('notes', i, 'mustPress') == false then
        setPropertyFromGroup('notes', membersIndex, 'rgbShader.b', getColorFromHex('929292'))
        setPropertyFromGroup('notes', membersIndex, 'rgbShader.g', getColorFromHex('FFFFFF'))
        setPropertyFromGroup('notes', membersIndex, 'rgbShader.r', getColorFromHex('D8D8D8'))
    end
end

function onDestroy()
    
    if voltarProBS then
        loadSong('bruh', -1)
    end

    if shadersEnabled then
        runHaxeCode([[
            FlxG.game.setFilters([]);
        ]])
    end
end