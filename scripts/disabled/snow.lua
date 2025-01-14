local path = 'backgrounds/omori/'
local pathBorder = 'backgrounds/omori/borders'
local pathBattle = 'backgrounds/omori/battleStuff'

local borders = {'border_default_handheld', 'border_omori_handheld', 'border_omori_redhand_handheld', 'border_aubrey_handheld', 'border_kel_handheld', 'border_hero_handheld', 'border_mari_handheld', 'border_basil_handheld', 'border_whitespace_handheld', 'border_solidblack_handheld',}

local noteY = 8
local emoX = 205
local emoY = 464

local curHP = 100
local curMP = 69
local maxHP = 100
local maxMP = 69

local curBorder = 1

luaDebugMode = false

function onCreate()
    
    precacheImage('backgrounds/omori/borders/border_default_handheld')
    precacheImage('backgrounds/omori/borders/border_omori_handheld')
    precacheImage('backgrounds/omori/borders/border_omori_redhand_handheld')
    precacheImage('backgrounds/omori/borders/border_aubrey_handheld')
    precacheImage('backgrounds/omori/borders/border_kel_handheld')
    precacheImage('backgrounds/omori/borders/border_hero_handheld')
    precacheImage('backgrounds/omori/borders/border_mari_handheld')
    precacheImage('backgrounds/omori/borders/border_basil_handheld')
    precacheImage('backgrounds/omori/borders/border_whitespace_handheld')
    precacheImage('backgrounds/omori/borders/border_solidblack_handheld')
    
    if buildTarget == 'android' then

        precacheImage("virtualpad")

        makeAnimatedLuaSprite("buttonA", 'virtualpad', 1145, 570)
        addAnimationByPrefix("buttonA", "pressed", "aPress", 10, false)
        addAnimationByPrefix("buttonA", "idle", "a", 0, false)
        setObjectCamera("buttonA", 'other')
        setProperty("buttonA.alpha", 0.5)
        setProperty("buttonA.color", FlxColor("RED"))
        setProperty("buttonA.alpha", 0)
        addLuaSprite("buttonA", true)
        
        makeLuaSprite("buttonChange", '', 1145, 10)
        loadGraphic("buttonChange", "specialpad", 132, 129)
        addAnimation("buttonChange", "pressed", {2, 1}, 10, false)
        addAnimation("buttonChange", "idle", {0}, 0, false)
        setObjectCamera("buttonChange", 'other')
        setProperty("buttonChange.alpha", 0.7)
        setProperty("buttonChange.color", FlxColor("CYAN"))
        addLuaSprite("buttonChange", true)
        
        makeLuaSprite("buttonHeal", '', 1145, 140)
        loadGraphic("buttonHeal", "specialpad", 132, 129)
        addAnimation("buttonHeal", "pressed", {5, 4}, 10, false)
        addAnimation("buttonHeal", "idle", {3}, 0, false)
        setObjectCamera("buttonHeal", 'other')
        setProperty("buttonHeal.alpha", 0.7)
        setProperty("buttonHeal.color", 0xFF7F6E)
        addLuaSprite("buttonHeal", true)
    
        --[[makeLuaSprite("buttonChange", '', 1000, 570)
        loadGraphic("buttonChange", "virtualPad", 132, 127)
        addAnimation("buttonChange", "pressed", {17}, 10, true)
        addAnimation("buttonChange", "idle", {16}, 0, true)
        setObjectCamera("buttonChange", 'other')
        setProperty("buttonChange.alpha", 0.5)
        setProperty("buttonChange.color", FlxColor("YELLOW"))
        setProperty("buttonChange.alpha", 0)
        addLuaSprite("buttonChange", true)]]
    end
    
    debugPrint(math.floor(1 * 1.5 + 2))
    
    makeLuaSprite('bor', pathBorder..'/'..borders[curBorder])
    setObjectCamera('bor', 'hud')
    scaleObject('bor', 0.67, 0.67)
    screenCenter('bor')
    addLuaSprite('bor', false)
    
    makeAnimatedLuaSprite('bg', path..'/battleback_ff_default')
    addAnimationByPrefix('bg', 'damage', 'hurt', 24, false)
    addAnimationByPrefix('bg', 'idle', 'static', 0, true)
    setObjectCamera('bg', 'hud')
    scaleObject('bg', 1.5, 1.5)
    screenCenter('bg')
    --setProperty('bg.alpha', 0.5)
    addLuaSprite('bg', false)
    
    makeLuaSprite('log', pathBattle..'/bsys_battlelog')
    setObjectCamera('log', 'hud')
    scaleObject('log', 1.5, 1.5)
    screenCenter('log', 'x')
    addLuaSprite('log', false)
    
    makeLuaSprite('port', pathBattle..'/player_box', 181.2, screenHeight - 263)
    setObjectCamera('port', 'hud')
    scaleObject('port', 1.5, 1.5)
   --setProperty('port.alpha', 0.5)
   
   makeLuaSprite('hpBar', pathBattle..'/healthDamage', 181.2, screenHeight - 263)
    setObjectCamera('port', 'hud')
    scaleObject('port', 1.5, 1.5)
    
    makeAnimatedLuaSprite('atlasRU', pathBattle..'/battleATLAS', 0, screenHeight + 150) -- - 70
    addAnimationByPrefix('atlasRU', 'run', 'run', 0, false)
    setObjectCamera('atlasRU', 'hud')
    scaleObject('atlasRU', 1.5, 1.5)
    screenCenter('atlasRU', 'x')
    addLuaSprite('atlasRU', true)
    
    makeAnimatedLuaSprite('atlasFI', pathBattle..'/battleATLAS', 0, getProperty('atlasRU.y') - 65)
    addAnimationByPrefix('atlasFI', 'fight', 'fight', 0, false)
    setObjectCamera('atlasFI', 'hud')
    scaleObject('atlasFI', 1.5, 1.5)
    screenCenter('atlasFI', 'x')
    addLuaSprite('atlasFI', true)
    
    makeAnimatedLuaSprite('atlasSB', pathBattle..'/battleATLAS', 0, getProperty('atlasFI.y') - 80)
    addAnimationByPrefix('atlasSB', 'stressIDK', 'stressBarNotLow', 0, false)
    addAnimationByPrefix('atlasSB', 'stressMedium', 'stressBarMedium', 0, false)
    addAnimationByPrefix('atlasSB', 'stressHigh', 'stressBarHigh', 0, false)
    addAnimationByPrefix('atlasSB', 'stressMegaHigh', 'stressBarMegaHigh', 0, false)
    addAnimationByPrefix('atlasSB', 'stressLow', 'stressBarLow', 0, false)
    setObjectCamera('atlasSB', 'hud')
    scaleObject('atlasSB', 1.5, 1.5)
    screenCenter('atlasSB', 'x')
    addLuaSprite('atlasSB', true)
    
    makeLuaSprite("emoBack", '', getProperty('port.x') + 10, getProperty('port.y') + 30)
    loadGraphic("emoBack", pathBattle.."/faceset_states", 100, 100)
    addAnimation("emoBack", "miserable", {7}, 0, false)
    addAnimation("emoBack", "happy", {2}, 0, false)
    addAnimation("emoBack", "neutral", {0}, 0, false)
    setObjectCamera("emoBack", 'hud')
    scaleObject("emoBack", 1.5, 1.5)
    
    makeAnimatedLuaSprite('emo', pathBattle..'/statelist', emoX, emoY)
    addAnimationByPrefix('emo', 'neutral', 'neutral', 0, false)
    addAnimationByPrefix('emo', 'miserable', 'miserable', 0, false)
    addOffset('emo', 'miserable', -15, -3)
    addAnimationByPrefix('emo', 'happy', 'happy', 0, false)
    addOffset('emo', 'happy', -37, -4)
    setObjectCamera('emo', 'hud')
    scaleObject('emo', 1.5, 1.5)
    
    makeLuaSprite('hp', pathBattle..'/bar_gradients', 223, 647.5)
    setObjectCamera('hp', 'hud')
    scaleObject('hp', 1.5, 1.5)
    
    makeLuaText('accu', '10', 0, getProperty('atlasSB.x') + 486, getProperty('atlasSB.y') + 10)
    setTextFont('accu', 'omori.ttf')
    setTextSize('accu', 43)
    setTextBorder('accu', 1, '000000')
    addLuaText('accu')
    
    makeLuaText('hpp', '', 0, getProperty('hp.x') + 50, getProperty('hp.y') - 5)
    setTextFont('hpp', 'omori.ttf')
    setTextSize('hpp', 25)
    setTextBorder('hpp', 1, '000000')
    addLuaText('hpp')
    
    makeLuaText('mp', '', 0, getProperty('hp.x') + 65, getProperty('hp.y') + 24)
    setTextFont('mp', 'omori.ttf')
    setTextSize('mp', 25)
    setTextBorder('mp', 1, '000000')
    addLuaText('mp')
    
    makeLuaText('resu', 'Results:', 0, 0, 0)
    setTextFont('resu', 'omori.ttf')
    setTextSize('resu', 35)
    setTextBorder('resu', 1, '000000')
    screenCenter('resu', 'x')
    addLuaText('resu')
    setProperty('resu.alpha', 0)
    
    makeLuaText('score', '', 0, 0, 40)
    setTextFont('score', 'omori.ttf')
    setTextSize('score', 35)
    setTextBorder('score', 1, '000000')
    screenCenter('score', 'x')
    addLuaText('score')
    setProperty('score.alpha', 0)
    
    makeLuaText('vaze', 'Press "A" to exit', 0, 0, 80)
    setTextFont('vaze', 'omori.ttf')
    setTextSize('vaze', 35)
    setTextBorder('vaze', 1, '000000')
    screenCenter('vaze', 'x')
    addLuaText('vaze')
    setProperty('vaze.alpha', 0)
    
    --[[makeLuaSprite('mp', pathBattle..'/bar', getProperty('hp.x'), getProperty('hp.y') + 33)
    setObjectCamera('mp', 'hud')
    scaleObject('mp', 1.5, 1.5)
    setProperty('mp.color', 0x15B3A9)]]

    makeAnimatedLuaSprite('kitty', 'characters/omori/kittymori', getMidpointX('emoBack') - 80, getMidpointY('emoBack') - 83)
    addAnimationByPrefix('kitty', 'misedle', 'miserable', 5, true)
    addAnimationByPrefix('kitty', 'happdle', 'happy', 5, true)
    addAnimationByPrefix('kitty', 'angrdle', 'angry', 5, true)
    addAnimationByIndices('kitty', 'hurdle', 'angry', '1,2,3,1,2,3,1,2,3',  5, false)
    addAnimationByPrefix('kitty', 'neudle', 'neutral', 5, true)
    setObjectCamera('kitty', 'hud')
    
    makeAnimatedLuaSprite('pica', 'characters/omori/snow_keroppica')
    addAnimationByIndices("pica", "dead", "defeat", "1, 2, 3, 2", 5, true)
    addAnimationByIndices("pica", "neudle", "neutral", "1, 2, 3, 2", 5, true)
    scaleObject('pica', 1.5, 1.5)
    screenCenter('pica')
    setObjectCamera('pica', 'hud')
    
    --[[makeLuaSprite('bolas', '')
    loadGraphic('bolas', pathBattle..'/stressThing', 6, 4)
    addAnimation('bolas', 'bolasLow', {0,1,2,3,4,5,6,7,8,9,10}, 5, true)
    setObjectCamera('bolas', 'hud')
    scaleObject('bolas', 1.5, 1.5)
    screenCenter('bolas', 'x')
    addLuaSprite('bolas', false)]]
    
    makeLuaSprite("heal", '', getProperty('port.x') - 23, getProperty('port.y') - 25)
    loadGraphic('heal', pathBattle.."/attackShit/u_healheart", 195, 190)
    addAnimation('heal', 'heal', {0, 1, 2, 3, 4, 5, 6, 7}, 12, false)
    scaleObject('heal', 1.3, 1.3)
    setObjectCamera('heal', 'hud')
    addLuaSprite('heal', true)
    
    makeLuaSprite("win", '', getProperty('port.x'), getProperty('port.y') + 30)
    loadGraphic("win", pathBattle.."/confetti", 106, 106)
    addAnimation("win", "idle", {0, 1, 2}, 5, true)
    setObjectCamera("win", 'hud')
    scaleObject("win", 1.5, 1.5)
    setProperty('win.visible', false)
    
    makeLuaSprite("numDamage", '', getProperty('port.x') + 58, getProperty('port.y') + 65)
    loadGraphic('numDamage', pathBattle.."/Damage", 32, 44)
    addAnimation('numDamage', 'damage3', {3}, 0, false)
    addAnimation('numDamage', 'damage1', {1}, 0, false)
    addAnimation('numDamage', 'none', {45}, 0, false)
    scaleObject('numDamage', 1.6, 1.6)
    setObjectCamera('numDamage', 'hud')
    addLuaSprite('numDamage', true)
    
    makeLuaSprite('9999', pathBattle..'/preguicei', 0, getMidpointY('pica') - 100)
    setObjectCamera('9999', 'hud')
    scaleObject('9999', 1.6, 1.6)
    screenCenter('9999', 'x')
    setProperty('9999.alpha', 0)
    
    makeLuaSprite("numHealUni", '', getProperty('port.x') + 58, getProperty('port.y') + 65)
    loadGraphic('numHealUni', pathBattle.."/Damage", 32, 44)
    addAnimation('numHealUni', 'heal1', {11}, 0, false)
    addAnimation('numHealUni', 'heal0', {10}, 0, false)
    addAnimation('numHealUni', 'none', {45}, 0, false)
    scaleObject('numHealUni', 1.6, 1.6)
    setObjectCamera('numHealUni', 'hud')
    addLuaSprite('numHealUni', true)
    
    makeLuaSprite("numHealDeze", '', getProperty('port.x') + 58, getProperty('port.y') + 65)
    loadGraphic('numHealDeze', pathBattle.."/Damage", 32, 44)
    addAnimation('numHealDeze', 'heal1', {11}, 0, false)
    addAnimation('numHealDeze', 'heal0', {10}, 0, false)
    addAnimation('numHealDeze', 'none', {45}, 0, false)
    scaleObject('numHealDeze', 1.6, 1.6)
    setObjectCamera('numHealDeze', 'hud')
    addLuaSprite('numHealDeze', true)
    
    addLuaSprite('pica', false)
    addLuaSprite('9999', false)
    addLuaSprite("emoBack", false)
    addLuaSprite('kitty', false)
    addLuaSprite('win', false)
    addLuaSprite('hp', false)
    addLuaSprite('hpBar', false)
    addLuaSprite('port', false)
    addLuaSprite('emo', false)
    --addLuaSprite('mp', false)
    
    setProperty('camHUD.alpha', 0)
    setProperty('boyfriendGroup.alpha', 0)
    setProperty('dadGroup.alpha', 0)

    setObjectOrder("atlasFI", getObjectOrder("pica"))
    setObjectOrder("atlasRU", getObjectOrder("pica"))
    setObjectOrder("atlasSB", getObjectOrder("pica"))
    
    if downscroll then
        noteY = screenHeight - 110
        setProperty('log.flipY', true)
        setProperty('log.y', screenHeight - 132)
        setProperty('atlasSB.y', 10)
        setProperty('atlasFI.y', 90)
        setProperty('atlasRU.y', 155)
        setProperty('accu.y', 20)
    end
end

local aJustPressed = nil
local changeJustPressed = nil
local healJustPressed = nil
function onUpdate(elapsed)
    
    
    setHealth(2)
    playAnim('emo', 'neutral')
    
    if buildTarget == 'android' then
        aJustPressed = getMouseX('camOther') > getProperty('buttonA.x') and getMouseY('camOther') > getProperty('buttonA.y') and getMouseX('camOther') < getProperty('buttonA.x') + getProperty('buttonA.width') and getMouseY('camOther') < getProperty('buttonA.y') + getProperty('buttonA.height') and mouseClicked()
        changeJustPressed = getMouseX('camOther') > getProperty('buttonChange.x') and getMouseY('camOther') > getProperty('buttonChange.y') and getMouseX('camOther') < getProperty('buttonChange.x') + getProperty('buttonChange.width') and getMouseY('camOther') < getProperty('buttonChange.y') + getProperty('buttonChange.height') and mouseClicked()
        healJustPressed = getMouseX('camOther') > getProperty('buttonHeal.x') and getMouseY('camOther') > getProperty('buttonHeal.y') and getMouseX('camOther') < getProperty('buttonHeal.x') + getProperty('buttonHeal.width') and getMouseY('camOther') < getProperty('buttonHeal.y') + getProperty('buttonHeal.height') and mouseClicked()
    end
    
    if healJustPressed and curMP > 10 or keyboardJustPressed("SPACE") and curMP > 10 then
        curHP = curHP + 10
        curMP = curMP - 10
        playAnim('buttonHeal', 'pressed', true)
        runTimer('atumalaca', 1.5)
        playSound('omori/BA_Heart_Heal', 1, 'hpHeal')
        playAnim('heal', 'heal', true)
        playAnim('numHealUni', 'heal0', true)
        playAnim('numHealDeze', 'heal1', true)
        setProperty('numHealUni.y', getProperty('port.y') + 65)
        setProperty('numHealUni.x', getProperty('port.x') + 80)
        setProperty('numHealUni.alpha', 0.3)
        doTweenY('funny2', 'numHealUni', getProperty('port.y') + 120, 0.3, 'quadOut')
        doTweenAlpha('fun2', 'numHealUni', 1, 0.3, 'linear')
        setProperty('numHealDeze.y', getProperty('port.y') + 65)
        setProperty('numHealDeze.x', getProperty('numHealUni.x') - 35)
        setProperty('numHealDeze.alpha', 0.3)
        doTweenY('funny3', 'numHealDeze', getProperty('port.y') + 120, 0.3, 'quadOut')
        doTweenAlpha('fun3', 'numHealDeze', 1, 0.3, 'linear')
    end
    
    if getProperty('kitty.animation.curAnim.name') == 'hurdle' and getProperty('kitty.animation.curAnim.finished') then
        setProperty('kitty.color', 0xFFFFFF)
        playAnim('kitty', 'neudle', true)
    end
    
    if curHP > maxHP then
        curHP = maxHP
    end
    
    if aJustPressed and getProperty('buttonA.alpha') == 0.7 then
        playAnim('buttonA', 'pressed', true)
        exitSong(false)
    elseif keyJustPressed('accept') then
        exitSong(false)
    elseif changeJustPressed then
        curBorder = curBorder + 1
        playAnim('buttonChange', 'pressed', true)
        makeLuaSprite('bor', pathBorder..'/'..borders[curBorder])
        setObjectCamera('bor', 'hud')
        scaleObject('bor', 0.67, 0.67)
        screenCenter('bor')
        setObjectOrder('bor', 0)
        addLuaSprite('bor', false)
        setProperty('bor.alpha', 0.0001)
        doTweenAlpha('bumchacalaca', 'bor', 1, 0.5, 'linear')
    elseif keyboardJustPressed("SHIFT") then
        curBorder = curBorder + 1
        playAnim('buttonChange', 'pressed', true)
        makeLuaSprite('bor', pathBorder..'/'..borders[curBorder])
        setObjectCamera('bor', 'hud')
        scaleObject('bor', 0.67, 0.67)
        screenCenter('bor')
        setObjectOrder('bor', 0)
        addLuaSprite('bor', false)
        setProperty('bor.alpha', 0.0001)
        doTweenAlpha('bumchacalaca', 'bor', 1, 0.5, 'linear')
    elseif curBorder > 10 then
        curBorder = 1
        makeLuaSprite('bor', pathBorder..'/'..borders[curBorder])
        setObjectCamera('bor', 'hud')
        scaleObject('bor', 0.67, 0.67)
        screenCenter('bor')
        setObjectOrder('bor', 0)
        addLuaSprite('bor', false)
        setProperty('bor.alpha', 0.0001)
        doTweenAlpha('bumchacalaca', 'bor', 1, 0.5, 'linear')
    end
    
    if rating >= 0 and rating < 0.2 then
        playAnim('atlasSB', 'stressLow')
    elseif rating >= 0.2 and rating < 0.4 then
        playAnim('atlasSB', 'stressIDK')
    elseif rating >= 0.4 and rating < 0.6 then
        playAnim('atlasSB', 'stressMedium')
    elseif rating >= 0.6 and rating < 0.8 then
        playAnim('atlasSB', 'stressHigh')
    elseif rating >= 0.8 then
        playAnim('atlasSB', 'stressMegaHigh')
    end
end

function onUpdatePost(elapsed)
    
    setTextString('hpp', curHP..'/100')
    if curMP < 10 then
        setTextString('mp', '0'..curMP..'/69')
    else
        setTextString('mp', curMP..'/69')
    end
    
    if rating < 1 then
        setTextString('accu', '0'..math.floor(rating * 10))
        setProperty('accu.x', getProperty('atlasSB.x') + 487.7)
    else
        setTextString('accu', math.floor(rating * 10))
        setProperty('accu.x', getProperty('atlasSB.x') + 490)
    end
end

function onCountdownStarted()
    for i = 0, 3 do
	setPropertyFromGroup('opponentStrums', i, 'x', -900);
    setProperty('iconP1.visible', false)
    setProperty('comboGroup.visible', false)
    setProperty('iconP2.visible', false)
    setProperty('scoreTxt.visible', false)
    setProperty('healthBar.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('timeTxt.visible', false)
    setProperty('botplayTxt.visible', false)
    
    setPropertyFromGroup('playerStrums', 0, 'x', 410);
    setPropertyFromGroup('playerStrums', 1, 'x', 532);

    setPropertyFromGroup('playerStrums', 2, 'x', 653);
    setPropertyFromGroup('playerStrums', 3, 'x', 770);
    setPropertyFromGroup('playerStrums', i, 'y', noteY);
end
end

function onCountdownTick(counter)
    
    if counter == 0 then
        doTweenY('suba', 'atlasRU', screenHeight - 70, 0.7, 'quartIn')
        doTweenY('sub', 'atlasFI', screenHeight - 70 - 65, 0.7, 'quartIn')
        doTweenY('su', 'atlasSB', screenHeight - 70 - 65 - 80, 0.7, 'quartIn')
        doTweenY('s', 'accu', screenHeight - 70 - 65 - 80 + 10, 0.7, 'quartIn')
        doTweenAlpha('pinto', 'camHUD', 1, 0.5, 'linear')
    end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    
    for i = 0,3 do
        if noteData == i then
            
        end
    end
end

function noteMiss(membersIndex, noteData, noteType, isSustainNote)
    
    for i = 0,3 do
        if noteData == i then
            curHP = curHP - 1
            runTimer('atuma', 1.5)
            playAnim('numDamage', 'damage1', true)
            playAnim('bg', 'damage', true)
            playAnim('kitty', 'hurdle', true)
            setProperty('kitty.color', 0xFF9191)
            playSound('omori/SE_dig', 1, 'hurt')
            setProperty('numDamage.y', getProperty('port.y') + 65)
            setProperty('numDamage.alpha', 0.3)
            doTweenY('funny', 'numDamage', getProperty('port.y') + 120, 0.3, 'quadOut')
            doTweenAlpha('fun', 'numDamage', 1, 0.3, 'linear')
            scaleObject('hpBar', -1.165 * curHP, .035)
        end
    end
end

function noteMissPress(direction)

    for i = 0,3 do
        if direction == i then
            curHP = curHP - 1
        end
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    
    if tag == 'atuma' then
        doTweenAlpha('funny', 'numDamage', 0, 0.3, 'linear')
    end
    
    if tag == 'atumalaca' then
        doTweenAlpha('funny2', 'numHealUni', 0, 0.3, 'linear')
        doTweenAlpha('funny3', 'numHealDeze', 0, 0.3, 'linear')
    end
    
    if tag == 'simbora' then
        doTweenY('morreulis', 'pica', screenHeight, 0.8, 'linear')
        doTweenAlpha('pintosdepaus', '9999', 0, 0.3, 'linear')
    end
end

function onEndSong()
    
    
    doTweenY('suba', 'atlasRU', screenHeight + 70, 0.3, 'quartIn')
    doTweenY('sub', 'atlasFI', screenHeight + 70 - 65, 0.3, 'quartIn')
    doTweenY('su', 'atlasSB', screenHeight - 80, 0.3, 'quartIn')
    doTweenY('s', 'accu', screenHeight - 80 + 10, 0.3, 'quartIn')
    playSound('omori/se_impact_double', 1)
    playAnim('bg', 'damage')
    playAnim('pica', 'dead')
    setProperty('9999.alpha', 0.3)
    doTweenY('jaera', '9999', getMidpointY('pica'), 0.3, 'quadOut')
    doTweenAlpha('eraja', '9999', 1, 0.3, 'linear')
    runTimer('simbora', 1.5)
    setTextString('score', "Score: "..score..' | Misses: '..misses..' | Rating: '..round(rating * 100, 2)..'%')
    screenCenter('score', 'x')
    return Function_Stop;
end

function round(x, n)
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
    return x / n
end

function onTweenCompleted(tag)
	
	if tag == 'morreulis' then
	    playAnim('kitty', 'neudle')
	    setProperty('kitty.color', 0xFFFFFF)
	    setProperty('win.visible', true)
	    playSound('omori/xx_victory', 1, 'vic')
	    noteTweenAlpha('vaza', 4, 0, 0.5, 'linear')
	    noteTweenAlpha('vaz', 5, 0, 0.5, 'linear')
	    noteTweenAlpha('va', 6, 0, 0.5, 'linear')
	    noteTweenAlpha('v', 7, 0, 0.5, 'linear')
	elseif tag == 'vaza' then
	    doTweenAlpha('resusmond', 'resu', 1, 0.5, 'linear')
	elseif tag == 'resusmond' then
	    doTweenAlpha('scorejlv', 'score', 1, 0.5, 'linear')
	elseif tag == 'scorejlv' then
	    doTweenAlpha('podevazar', 'buttonA', 0.7, 0.5, 'linear')
	    doTweenAlpha('vazeoyxotd', 'vaze', 1, 0.5, 'linear')
	end
end

function onSoundFinished(tag)
	
	if tag == 'vic' then
	    playSound('omori/xx_victory', 1, 'vic')
	end
end