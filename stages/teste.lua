local path = 'backgrounds/omori/'
local pathBorder = 'backgrounds/omori/borders'
local pathBattle = 'backgrounds/omori/battleStuff'

local x = 0
local y = 0

function onStartCountdown() 

    return Function_Stop;
end

function onCreate()
    
    
    if buildTarget == 'android' then

        precacheImage("virtualpad")

        makeLuaSprite("buttonL", '', 0, screenHeight - 253)
        loadGraphic("buttonL", "virtualPad", 132, 127)
        addAnimation("buttonL", "pressed", {2}, 10, false)
        addAnimation("buttonL", "idle", {1}, 0, true)
        setObjectCamera("buttonL", 'other')
        setProperty("buttonL.alpha", 0.5)
        setProperty("buttonL.alpha", 0.5)
        addLuaSprite("buttonL", true)

        makeLuaSprite("buttonR", '', 235, screenHeight - 253)
        loadGraphic("buttonR", "virtualPad", 132, 127)
        addAnimation("buttonR", "pressed", {11}, 10, false)
        addAnimation("buttonR", "idle", {10}, 0, true)
        setObjectCamera("buttonR", 'other')
        setProperty("buttonR.alpha", 0.5)
        setProperty("buttonR.alpha", 0.5)
        addLuaSprite("buttonR", true)
        
        makeAnimatedLuaSprite("buttonD", 'virtualpad', 120, screenHeight - 130)
        addAnimationByPrefix("buttonD", "pressed", "downPress", 0, false)
        addAnimationByPrefix("buttonD", "idle", "down", 0, false)
        setObjectCamera("buttonD", 'other')
        addLuaSprite("buttonD", true)
        setProperty("buttonD.alpha", 0.5)
        
        makeAnimatedLuaSprite("buttonU", 'virtualpad', 120, 343)
        addAnimationByPrefix("buttonU", "pressed", "upPress", 0, false)
        addAnimationByPrefix("buttonU", "idle", "up", 0, false)
        setObjectCamera("buttonU", 'other')
        addLuaSprite("buttonU", true)
        setProperty("buttonU.alpha", 0.5)
    
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
    
    makeLuaSprite('eita')
    makeGraphic('eita', screenWidth, screenHeight, '000000')
    setObjectCamera('eita', 'other')
    --setBlendMode('eita', 'ADD')
    addLuaSprite('eita', true)
    doTweenAlpha('eitaporra', 'eita', 0, 3, 'linear')
    
    makeLuaSprite('bor', pathBorder..'/border_blackspace_handheld')
    setObjectCamera('bor', 'other')
    scaleObject('bor', 0.67, 0.67)
    screenCenter('bor')
    addLuaSprite('bor', false)
    
    makeLuaSprite('bg', path..'/!BG_REMINA', 0, 0)
    setObjectCamera('bg', 'hud')
    --scaleObject('bg', 1.5, 1.5)
    screenCenter('bg')
    --setProperty('bg.alpha', 0.5)
    addLuaSprite('bg', false)
    
    makeLuaSprite('bg2', path..'/!BG_REMINA', 0, -1024)
    setObjectCamera('bg2', 'hud')
    --scaleObject('bg2', 1.68, 1.68)
    screenCenter('bg2', 'x')
    --setProperty('bg.alpha', 0.5)
    addLuaSprite('bg2', false)
    
    --[[makeLuaText('xy', 'x: '..x..'\n y: '..y, 0, 0, 0)
    setTextFont('xy', 'OMORI_GAME2.ttf')
    setTextSize('xy', 30)
    setObjectCamera('xy', 'other')
    screenCenter('xy', 'x')
    addLuaText('xy')]]
    
    makeAnimatedLuaSprite('kitty', 'characters/omori/kitty_overworld')
    addAnimationByPrefix('kitty', 'walk-down', 'walkDown', 5, false)
    addAnimationByPrefix('kitty', 'walk-up', 'walkUp', 5, false)
    addAnimationByPrefix('kitty', 'walk-right', 'walkRight', 5, false)
    addAnimationByPrefix('kitty', 'walk-left', 'walkLeft', 5, false)
    addAnimationByPrefix('kitty', 'idle-up', 'idleUp', 0, false)
    addAnimationByPrefix('kitty', 'idle-left', 'idleLeft', 0, false)
    addAnimationByPrefix('kitty', 'idle-right', 'idleRight', 0, false)
    addAnimationByPrefix('kitty', 'idle-down', 'idleDown', 0, false)
    setObjectCamera('kitty', 'hud')
    scaleObject('kitty', 2, 2)
    screenCenter('kitty')
    addLuaSprite('kitty', false)
    
    makeLuaSprite('bah', path..'/horror_mari', 0, -800)
    setObjectCamera('bah', 'hud')
    scaleObject('bah', 1.5, 1.5)
    screenCenter('bah', 'x')
    setProperty('bah.alpha', 0)
    addLuaSprite('bah', true)
    
    makeLuaSprite('overlay', path..'/SW_Ambience')
    setObjectCamera('overlay', 'hud')
    scaleObject('overlay', 1.339, 1.339)
    screenCenter('overlay')
    --setProperty('overlay.alpha', 1)
    addLuaSprite('overlay', true)
    
    playSound('omori/bs_numbered', 0, 'bgm')
    soundFadeIn('bgm', 3, 0, 1)
    
    doTweenY('loop', 'bg', screenHeight, 15 / 2, 'linear')
    doTweenY('loop2', 'bg2', screenHeight, 15, 'linear')
end

local leftPressed = nil
local rightPressed = nil
local upPressed = nil
local downPressed = nil
local leftReleased = nil
local rightReleased = nil
local upReleased = nil
local downReleased = nil

function onUpdate(elapsed)
    
if buildTarget == 'android' then
    leftPressed = getMouseX('camOther') > getProperty('buttonL.x') and getMouseY('camOther') > getProperty('buttonL.y') and getMouseX('camOther') < getProperty('buttonL.x') + getProperty('buttonL.width') and getMouseY('camOther') < getProperty('buttonL.y') + getProperty('buttonL.height') and mousePressed()
    rightPressed = getMouseX('camOther') > getProperty('buttonR.x') and getMouseY('camOther') > getProperty('buttonR.y') and getMouseX('camOther') < getProperty('buttonR.x') + getProperty('buttonR.width') and getMouseY('camOther') < getProperty('buttonR.y') + getProperty('buttonR.height') and mousePressed()
    upPressed = getMouseX('camOther') > getProperty('buttonU.x') and getMouseY('camOther') > getProperty('buttonU.y') and getMouseX('camOther') < getProperty('buttonU.x') + getProperty('buttonU.width') and getMouseY('camOther') < getProperty('buttonU.y') + getProperty('buttonU.height') and mousePressed()
    downPressed = getMouseX('camOther') > getProperty('buttonD.x') and getMouseY('camOther') > getProperty('buttonD.y') and getMouseX('camOther') < getProperty('buttonD.x') + getProperty('buttonD.width') and getMouseY('camOther') < getProperty('buttonD.y') + getProperty('buttonD.height') and mousePressed()
    
    leftReleased = getMouseX('camOther') > getProperty('buttonL.x') and getMouseY('camOther') > getProperty('buttonL.y') and getMouseX('camOther') < getProperty('buttonL.x') + getProperty('buttonL.width') and getMouseY('camOther') < getProperty('buttonL.y') + getProperty('buttonL.height') and mouseReleased()
    rightReleased = getMouseX('camOther') > getProperty('buttonR.x') and getMouseY('camOther') > getProperty('buttonR.y') and getMouseX('camOther') < getProperty('buttonR.x') + getProperty('buttonR.width') and getMouseY('camOther') < getProperty('buttonR.y') + getProperty('buttonR.height') and mouseReleased()
    upReleased = getMouseX('camOther') > getProperty('buttonU.x') and getMouseY('camOther') > getProperty('buttonU.y') and getMouseX('camOther') < getProperty('buttonU.x') + getProperty('buttonU.width') and getMouseY('camOther') < getProperty('buttonU.y') + getProperty('buttonU.height') and mouseReleased()
    downReleased = getMouseX('camOther') > getProperty('buttonD.x') and getMouseY('camOther') > getProperty('buttonD.y') and getMouseX('camOther') < getProperty('buttonD.x') + getProperty('buttonD.width') and getMouseY('camOther') < getProperty('buttonD.y') + getProperty('buttonD.height') and mouseReleased()
end
    
    
    if downPressed then
        playAnim('kitty', 'walk-down')
        playAnim('buttonD', 'pressed')
        y = y + 1
        setProperty('bah.alpha', getProperty('bah.alpha') + 0.0001)
    elseif downReleased then
        playAnim('kitty', 'idle-down', true)
        playAnim('buttonD', 'idle', true)
    elseif upPressed then
        playAnim('kitty', 'walk-up')
        playAnim('buttonU', 'pressed')
        y = y - 1
    elseif upReleased then
        playAnim('kitty', 'idle-up', true)
        playAnim('buttonU', 'idle', true)
    elseif rightPressed then
        playAnim('kitty', 'walk-right')
        playAnim('buttonR', 'pressed')
        x = x + 1
    elseif rightReleased then
        playAnim('kitty', 'idle-right', true)
        playAnim('buttonR', 'idle', true)
    elseif leftPressed then
        playAnim('kitty', 'walk-left')
        playAnim('buttonL', 'pressed')
        x = x - 1
    elseif leftReleased then
        playAnim('kitty', 'idle-left', true)
        playAnim('buttonL', 'idle', true)
    end
    
    if y == 5400 then
        playSound('omori/SE_spooks', 1, 'boo')
        setSoundVolume('bgm', 0)
    end
    
    --setTextString('xy', 'x: '..x..'\n y: '..y, 0)
    
    setProperty('iconP1.visible', false)
    setProperty('iconP2.visible', false)
    setProperty('scoreTxt.visible', false)
    setProperty('healthBar.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('timeTxt.visible', false)
    setProperty('botplayTxt.visible', false)
    --setProperty('camGame.visible', false)
end

function onSoundFinished(tag)
    
    if tag == 'bgm' then
        playSound('omori/bs_numbered', 1, 'bgm')
    elseif tag == 'boo' then
        close();
        os.exit();
    end
end

function onTweenCompleted(tag)
    
    if tag == 'loop' then
        setProperty('bg.y', -1024)
        doTweenY('loop', 'bg', screenHeight, 15, 'linear')
    elseif tag == 'loop2' then
        setProperty('bg2.y', -1024)
        doTweenY('loop2', 'bg2', screenHeight, 15, 'linear')
    end
end