-- this code is held by glue and tape (sorry for the nightmares code experts)
luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

local the = {
    'Resume',
    'Restart song',
    'Exit to menu'
}

local pos = 0
local divi = 100

local frases = {
    {'"I CAN\'T STOP EATING SUSHI MAN!!!"', 34}, -- 1 -- sugestões do Ukiyo
    {'"Are you two the same?"', 23}, -- 2
    {'"The water\'s broken :["', 23}, -- 3
    {'"If you want to rob a bank, you gotta do some planning before you rob a bank"', 77}, -- 4
    {'"Don\'t be a coconut"', 20}, -- 5
    {'"Hello i\'m the EVIL pause menu message! MUAHAHA!!"', 50}, -- 6
    {'"There\'s only one beer left"', 28}, -- 7
    {'"Rollin\' marijuana, that\'s a cheap vacation"', 44}, -- 8
    {'"Don\'t drop the blunt and disrespect the weed"', 56}, -- 9
    {'"Livin\' off borrowed time, the clock ticks faster"', 60}, -- 10
    {'"More cheese than Doritos, Cheetos or Fritos"', 45}, -- 11
    {'"This mod has a Snoop Dogg Seal of Approval™"', 45}, -- 12
    {'𓀖𓀗 𓀘 𓀙 𓀚 𓀛 𓀜 𓀝 𓀞 𓀟 𓀠 𓀡 𓀢 𓀣 𓀤 𓀥 𓀦 𓀧 𓀨 𓀩 𓀪 𓀫 𓀬𓀭 𓀮 𓀯 𓀰', 52}, -- 13 -- isso nem funciona lol -- amigos do Ukiyo mandaram essas
    {'"Also try Terraria!"', 20}, -- 14
    {'"Also try Minecraft!"', 22}, -- 15
    {'"28 STABS!"', 11}, -- 16
    {'"For real life??"', 17}, -- 17 -- eu que escrevi essas B) (Shiho)
    {'"Oh biscuits..."', 16}, -- 18
    {'"I FUCKING LOVE AIR-CONDITIONING!!!"', 36}, -- 19
    {'"This mod is sponsored by Raid Shadow Legends!"', 47}, -- 20
    {'"DAMN DANIEL BACK AT IT AGAIN WITH THE WHITE VANS!!!"', 53}, -- 21
    {'ma balls itch.', 14}, -- 22
    {'"Lemonade... Lemonade... Lemonade... Lemonade... Le-"', 53}, -- 23
    {'"God I love the limited 3D they use for this game. It\'s so charming"', 67}, -- 24
    {'"I\'m kind of a Pokemon!"', 25}, -- 25
    {'"Tornado penis."', 16}, -- 26
    {'"Hello Kitty banger mod"', 24}, -- 27
    {'"num seio"', 10}, -- 28 -- amigos meus (Shiho) mandaram essas
    {'"Aos oprimidos é permitido uma vez a cada poucos anos decidir quais representantes específicos da classe opressora devem representá-los e reprimi-los."', 151}, -- 29
    {'Are you going to play seriously now?', 36}, -- 30 -- sugestões da Liz
    {'I love eating grass', 19}, -- 31
    {'Did the pizza arrive?? :D', 25}, -- 32
    {'It\'s ok to give up man, just relax and come back later ;)', 57}, -- 33 -- sugestões da Natzy
    {'WHY DID YOU PAUSE?!?! THIS IS THE BEST PART!!!!', 47}, -- 34 -- frases especiais
    {'Seriously? You\'re going to restart because you missed one note??? -_-', 69} -- 35
}

local special = false
local relax = 0 -- um dia eu descubro como fazer isso funfar
local spc = 0

local ogX = -1550
						    
-- I DIDN'T CODE THE DARK MODE WINDOW THING IT WAS MADE BY: T-Bar: https://www.youtube.com/@tbar7460 GO SUBSCRIBE TO THEM NOW!!!!!11

local ffi = nil
local dwmapi = nil
local addr = nil --Had to make a whole new libary to grab a variable's address...
    
--[=[ffi.cdef([[
    typedef void* CONST;
    typedef void* HWND;
    typedef unsigned long DWORD;
    typedef const void *LPCVOID;
    typedef int BOOL;
        
    typedef long LONG;
    typedef LONG HRESULT;
        
    HWND GetActiveWindow();
    HRESULT DwmSetWindowAttribute(HWND hwnd, DWORD dwAttribute, LPCVOID pvAttribute, DWORD cbAttribute);
    void UpdateWindow(HWND hWnd);
    int* get_address(int& var);
]])]=]
    
    local S_OK = nil;

---Internal function used to parse the weird BBGGRR format into a normal hexidecimal
---Made by Ghostglowdev
function _rgbHexToBGR(rgb)
    if buildTarget ~= 'andorid' then
	-- conv int hex to string hex
	if type(rgb) == 'number' then rgb = runHaxeCode('return StringTools.hex('.. rgb ..');') end
	-- discard if hex isn't string
	if type(rgb) ~= 'string' then 
		debugPrint('ERROR on loading: '.. scriptName ..': _rgbHexToBGR: Failed to parse into BGR format.') 
		return rgb
	end
	-- discard extras
	rgb = stringStartsWith(rgb, '0x') and rgb:sub(3,8) or stringStartsWith(rgb, '#') and rgb:sub(2,7) or rgb
	rgb = #rgb > 6 and rgb:sub(1,6) or rgb

	-- parse
	local b, g, r = rgb:sub(5,6), rgb:sub(3,4), rgb:sub(1,2)
	return b..g..r 
end
end

---Sets the window to dark mode
function setDarkMode()
    if buildTarget ~= 'andorid' then
	local window = ffi.C.GetActiveWindow();
	local isDark = dwmapi.DwmSetWindowAttribute(window, 19, addr.get_address(ffi.new("int[1]", 1)), ffi.sizeof(ffi.cast("DWORD", 1)));

	if isDark == 0 or isDark ~= S_OK then
		dwmapi.DwmSetWindowAttribute(window, 20, addr.get_address(ffi.new("int[1]", 1)), ffi.sizeof(ffi.cast("DWORD", 1)));
	end
	
	ffi.C.UpdateWindow(window);
end
end

---Sets the window to light mode
function setLightMode()
    if buildTarget ~= 'andorid' then
	local window = ffi.C.GetActiveWindow();
	local isLight = dwmapi.DwmSetWindowAttribute(window, 19, addr.get_address(ffi.new("int[1]", 0)), ffi.sizeof(ffi.cast("DWORD", 0)));

	if isLight == 0 or isLight ~= S_OK then
		dwmapi.DwmSetWindowAttribute(window, 20, addr.get_address(ffi.new("int[1]", 0)), ffi.sizeof(ffi.cast("DWORD", 0)));
	end
	
	ffi.C.UpdateWindow(window);
end
end

---Shortcut to both "setDarkMode" and "setLightMode", as one function
---@param isDark boolean Is the window dark mode?
function setWindowColorMode(isDark)
    if buildTarget ~= 'andorid' then
	local window = ffi.C.GetActiveWindow();
	local isDarkMode = (isDark and 1 or 0);
	local isColorMode = dwmapi.DwmSetWindowAttribute(window, 19, addr.get_address(ffi.new("int[1]", isDarkMode)), ffi.sizeof(ffi.cast("DWORD", isDarkMode)));

	if isColorMode == 0 or isColorMode ~= S_OK then
		dwmapi.DwmSetWindowAttribute(window, 20, addr.get_address(ffi.new("int[1]", isDarkMode)), ffi.sizeof(ffi.cast("DWORD", isDarkMode)));
	end
	
	ffi.C.UpdateWindow(window);
end
end

---(Windows 11 ONLY) Sets the window border and header to a color of your choosing
---@param colorHex string The hexidecimal for the color. (The hex should be 0xRRGGBB, '0xRRGGBB', '#RRGGBB', 'RRGGBB')
---@param setHeader boolean Do you want to set the header's color?
---@param setBorder boolean Do you want to set the window border's color?
function setWindowBorderColor(colorHex, setHeader, setBorder)
    if buildTarget ~= 'andorid' then
	local window = ffi.C.GetActiveWindow();
	local strHex = (colorHex == nil or (type(colorHex) ~= 'number' and #colorHex < 6 or false)) and '0xFFFFFF' or _rgbHexToBGR(colorHex)
	local hex = tonumber('0x'..strHex)
	
	if setHeader == nil then setHeader = true end
	if setBorder == nil then setBorder = true end
	
	if setHeader then dwmapi.DwmSetWindowAttribute(window, 35, addr.get_address(ffi.new("int[1]", (hex))), ffi.sizeof(ffi.cast("DWORD", (hex)))); end
	if setBorder then dwmapi.DwmSetWindowAttribute(window, 34, addr.get_address(ffi.new("int[1]", (hex))), ffi.sizeof(ffi.cast("DWORD", (hex)))); end

	ffi.C.UpdateWindow(window);
end
end

---Resets the window. Be sure to run this after using "setDarkMode" to force the effect immediately
function redrawWindowHeader()
    if buildTarget ~= 'andorid' then
	setPropertyFromClass('flixel.FlxG', 'stage.window.borderless', true);
	setPropertyFromClass('flixel.FlxG', 'stage.window.borderless', false);
end
end

function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local parsed = parseJson('data/stuff.json')

function onCreate()

    if buildTarget == 'android' then
        precacheImage("virtualpad")

        makeAnimatedLuaSprite("buttonD", 'virtualpad', 0, 560)
        addAnimationByPrefix("buttonD", "pressed", "downPress", 0, false)
        addAnimationByPrefix("buttonD", "idle", "down", 0, false)
        setObjectCamera("buttonD", 'other')
        addLuaSprite("buttonD", true)
        setProperty("buttonD.alpha", 0)

        makeAnimatedLuaSprite("buttonU", 'virtualpad', 0, 430)
        addAnimationByPrefix("buttonU", "pressed", "upPress", 0, false)
        addAnimationByPrefix("buttonU", "idle", "up", 0, false)
        setObjectCamera("buttonU", 'other')
        addLuaSprite("buttonU", true)
        setProperty("buttonU.alpha", 0)

        makeAnimatedLuaSprite("buttonA", 'virtualpad', 1155, 560)
        addAnimationByPrefix("buttonA", "pressed", "aPress", 10, false)
        addAnimationByPrefix("buttonA", "idle", "a", 0, false)
        setObjectCamera("buttonA", 'other')
        addLuaSprite("buttonA", true)
        setProperty("buttonA.alpha", 0)
    elseif buildTarget ~= 'andorid' then
        ffi = require("ffi");
        dwmapi = ffi.load("dwmapi");
        addr = ffi.load("mods" ..((currentModDirectory == nil or currentModDirectory == "") and "/" or tostring("/" ..currentModDirectory.. "/")).. "include/AddressParser"); --Had to make a whole new libary to grab a variable's address...
        
        ffi.cdef([[
            typedef void* CONST;
            typedef void* HWND;
            typedef unsigned long DWORD;
            typedef const void *LPCVOID;
            typedef int BOOL;
            
            typedef long LONG;
            typedef LONG HRESULT;
            
            HWND GetActiveWindow();
            HRESULT DwmSetWindowAttribute(HWND hwnd, DWORD dwAttribute, LPCVOID pvAttribute, DWORD cbAttribute);
            void UpdateWindow(HWND hWnd);
            int* get_address(int& var);
        ]])
        
        S_OK = 0x00000000;
    end
    
    if songName == 'credits' then
        setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Credits Menu')
        setWindowColorMode(true)
        redrawWindowHeader();
    else
        setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName)
    end

    if difficultyName == 'erect' then
        setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName..' Erect')
    else
        setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName)
    end

    local var ShaderName = 'gray'
    if shadersEnabled then  
        initLuaShader(ShaderName)
        makeLuaSprite('camShader', nil)
        makeGraphic('camShader', screenWidth, screenHeight)
        setSpriteShader('camShader', ShaderName)
    else
        ShaderName = 'none'
    end
    
    makeLuaSprite("escu")
    makeGraphic("escu", screenWidth, screenHeight, '000000')
    setObjectCamera("escu", 'other')
    addLuaSprite("escu")
    setProperty("escu.alpha", 0)
    setProperty("escu.visible", false)

    makeLuaText("resu", the[1], 0, 0.0, 0.0)
    makeLuaText("resta", the[2], 0, 0.0, 0.0)
    makeLuaText("exit", the[3], 0, 0.0, 0.0)
    makeLuaText("seta", ">", 0, 0.0, 0.0)
    makeLuaText("setaa", "<", 0, 0.0, 0.0)
    setObjectCamera("resu", 'other')
    setObjectCamera("resta", 'other')
    setObjectCamera("exit", 'other')
    setObjectCamera("seta", 'other')
    setObjectCamera("setaa", 'other')
    addLuaText("resu")
    addLuaText("resta")
    addLuaText("exit")
    addLuaText("seta")
    addLuaText("setaa")
    setTextSize("resu", 50)
    setTextSize("resta", 50)
    setTextSize("exit", 50)
    setTextSize("seta", 50)
    setTextSize("setaa", 50)
    screenCenter("resu", 'x')
    setProperty("resu.y", getGraphicMidpointY("escu") - divi)
    screenCenter("resta")
    screenCenter("exit", 'x')
    setProperty("exit.y", getGraphicMidpointY("escu") + divi - 50)

    makeLuaText("noWay", "- PAUSED -", 0, 0.0, 100)
    setObjectCamera("noWay", 'other')
    setTextSize("noWay", 70)
    screenCenter("noWay", 'x')
    addLuaText("noWay")

    makeLuaSprite("barr", '', 0, -20)
    makeGraphic("barr", screenWidth, 25, '000000')
    setObjectCamera("barr", 'other')
    addLuaSprite("barr", false)

    makeLuaSprite("balls", '', 0, 740)
    makeGraphic("balls", screenWidth, 25, '000000')
    setObjectCamera("balls", 'other')
    addLuaSprite("balls", false)

    if songName == 'KittyJam' and difficultyName == 'erect' then
        makeLuaText("compo", songName..' ('..difficultyName..')'.." by: "..parsed.composer[2]..' | Pause Theme by: LizNaithy'..' | Art by: '..parsed.artist[2]..' | Chart and Coding by: '..parsed.coder, 0, -1965, -20)
        setObjectCamera("compo", 'other')
        addLuaText("compo")
        setTextSize("compo", 25)
        ogX = -1965
    else
        makeLuaText("compo", songName..' ('..difficultyName..')'.." by: "..parsed.composer[1]..' | Pause Theme by: LizNaithy'..' | Art by: '..parsed.artist[1]..' | Chart and Coding by: '..parsed.coder, 0, -1550, -20)
        setObjectCamera("compo", 'other')
        addLuaText("compo")
        setTextSize("compo", 25)
        ogX = -1550
    end
end

function onTimerCompleted(tag)

    --[[if tag == 'beat' then
        setProperty("camOther.zoom", 1.05)
        doTweenZoom("zoom", "camOther", 1, 0.8, "quartOut")
        setProperty("camGame.zoom", 1.05)
        doTweenZoom("zoo", "camGame", 1, 0.8, "quartOut")
    end]]

    if tag == 'boom' then
        doTweenAlpha("a", "noWay", 0, 0.6, "linear")
        runTimer("moob", 0.6)
    elseif tag == 'moob' then
        doTweenAlpha("a", "noWay", 1, 0.6, "linear")
        runTimer("boom", 0.6)
    elseif tag == 'reset' and buildTarget == 'android' then
        playAnim("buttonD", "idle")
        playAnim("buttonU", "idle")
    end
end

function onUpdate(elapsed)

    setProperty("escu.visible", false)
    setProperty("resu.visible", false)
    setProperty("resta.visible", false)
    setProperty("exit.visible", false)
    setProperty("seta.visible", false)
    setProperty("setaa.visible", false)
    setProperty("compo.visible", false)
    setProperty("barr.visible", false)
    setProperty("balls.visible", false)
    setProperty("morri.visible", false)
    setProperty("noWay.visible", false)

    if songName == 'credits' then
        setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Credits Menu')
    end
    
    if misses == 1 then
        spc = 35
    elseif special == true then
        spc = 34
    elseif relax > 20 then
        spc = 33
    end
end

function onPause()
    
    openCustomSubstate('pauseShit', true);
    return Function_Stop;
end

function onCustomSubstateCreatePost(name)
    
    if name == 'pauseShit' then

        setWindowColorMode(true)
        redrawWindowHeader();

        playSound("pause/pause-theme", 0, 'bah')
        soundFadeIn("bah", 5, 0, 0.2)
        playAnim("boyfriend", "singDOWNmiss", true)

        doTweenY("lol", "compo", 0, 0.5, "quartOut")
        doTweenY("xdd", "balls", 694.6, 0.5, "quartOut")
        doTweenY("xd", "barr", 0, 0.5, "quartOut")

        --runTimer("beat", 0.85, 0)
        runTimer("boom", 0.5)

        if special or misses == 1 or relax > 20 then
            curFrase = frases[spc][1]
        else
            curFrase = frases[getRandomInt(0, 33)][1]
        end

        makeLuaText("morri", curFrase, 0, 1300, 740)
        setObjectCamera("morri", 'other')
        addLuaText("morri")
        setTextSize("morri", 25)
        doTweenY("lololol", "morri", 694.6, 0.5, "quartOut")

        if difficultyName == 'erect' then
            setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName..' Erect (PAUSED)')
        else
            setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName..' (PAUSED)')
        end
    end
end

local aJustPressed = nil
local upJustPressed = nil
local downJustPressed = nil
function onCustomSubstateUpdatePost(name, elapsed)
    
    if name == 'pauseShit' then

        if buildTarget == 'android' then
            aJustPressed = getMouseX('camOther') > getProperty('buttonA.x') and getMouseY('camOther') > getProperty('buttonA.y') and getMouseX('camOther') < getProperty('buttonA.x') + getProperty('buttonA.width') and getMouseY('camOther') < getProperty('buttonA.y') + getProperty('buttonA.height') and mouseClicked()
            downJustPressed = getMouseX('camOther') > getProperty('buttonD.x') and getMouseY('camOther') > getProperty('buttonD.y') and getMouseX('camOther') < getProperty('buttonD.x') + getProperty('buttonD.width') and getMouseY('camOther') < getProperty('buttonD.y') + getProperty('buttonD.height') and mouseClicked()
            upJustPressed = getMouseX('camOther') > getProperty('buttonU.x') and getMouseY('camOther') > getProperty('buttonU.y') and getMouseX('camOther') < getProperty('buttonU.x') + getProperty('buttonU.width') and getMouseY('camOther') < getProperty('buttonU.y') + getProperty('buttonU.height') and mouseClicked()
        end

        doTweenAlpha("ven", "escu", 0.5, 0.5, "linear")
        setProperty("escu.visible", true)
        setProperty("resu.visible", true)
        setProperty("resta.visible", true)
        setProperty("exit.visible", true)
        setProperty("seta.visible", true)
        setProperty("setaa.visible", true)
        setProperty("compo.visible", true)
        setProperty("barr.visible", true)
        setProperty("balls.visible", true)
        setProperty("balls.visible", true)
        setProperty("noWay.visible", true)
        setProperty("buttonA.alpha", 0.5)
        setProperty("buttonD.alpha", 0.5)
        setProperty("buttonU.alpha", 0.5)

        setProperty("compo.x", getProperty("compo.x") + 1)
        setProperty("morri.x", getProperty("morri.x") - 1)
        
        if getProperty("compo.x") == screenWidth then
            setProperty("compo.x", ogX)
        end
        
        if getProperty("morri.x") == -450 and getTextString("morri") == frases[2][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[3][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[5][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[7][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[14][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[15][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[16][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[17][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[18][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[22][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[25][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[26][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[28][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[27][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[31][1] or getProperty("morri.x") == -450 and getTextString("morri") == frases[32][1] then -- 🤮
            setProperty("morri.x", 1300)
        elseif getProperty("morri.x") == -1100 and getTextString("morri") == frases[33][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[24][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[6][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[7][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[8][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[9][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[10][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[11][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[12][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[13][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[20][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[21][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[23][1] or getProperty("morri.x") == -1100 and getTextString("morri") == frases[34][1] then -- 🤮🤮
            setProperty("morri.x", 1300)
        elseif getProperty("morri.x") == -570 and getTextString("morri") == frases[30][1] or getProperty("morri.x") == -570 and getTextString("morri") == frases[19][1] then
            setProperty("morri.x", 1300)
        elseif getProperty("morri.x") == -1200 and getTextString("morri") == frases[4][1] or getProperty("morri.x") == -1200 and getTextString("morri") == frases[35][1] then
            setProperty("morri.x", 1300)
        elseif getProperty("morri.x") == -2280 and getTextString("morri") == frases[29][1] then
            setProperty("morri.x", 1300)
        end

        if pos == 0 then
            setProperty("seta.x", getProperty("resu.x") - 50)
            setProperty("seta.y", getProperty("resu.y"))
            setProperty("setaa.x", getProperty("resu.x") + 190)
            setProperty("setaa.y", getProperty("resu.y"))
            setProperty("resta.alpha", 0.5)
            setProperty("exit.alpha", 0.5)
            setProperty("resu.alpha", 1)
        elseif pos == 1 then
            setProperty("seta.x", getProperty("resta.x") - 50)
            screenCenter("seta", 'y')
            setProperty("setaa.x", getProperty("resta.x") + 365)
            screenCenter("setaa", 'y')
            setProperty("resu.alpha", 0.5)
            setProperty("exit.alpha", 0.5)
            setProperty("resta.alpha", 1)
        elseif pos == 2 then
            setProperty("seta.x", getProperty("exit.x") - 50)
            setProperty("seta.y", getProperty("exit.y"))
            setProperty("setaa.x", getProperty("exit.x") + 365)
            setProperty("setaa.y", getProperty("exit.y"))
            setProperty("resta.alpha", 0.5)
            setProperty("resu.alpha", 0.5)
            setProperty("exit.alpha", 1)
        elseif pos > 2 then
            pos = 0
        elseif pos < 0 then
            pos = 2
        end

        if keyboardJustPressed("S") or keyboardJustPressed("DOWN") or gamepadJustPressed(1, "DPAD_DOWN") or gamepadJustPressed(1, "LEFT_STICK_DIGITAL_DOWN") or downJustPressed and buildTarget == 'android' then
            pos = pos + 1
            playSound("scrollMenu", 0.5, 'tick')
            runTimer("reset", 0.1)
        elseif keyboardJustPressed("W") or keyboardJustPressed("UP") or gamepadJustPressed(1, "DPAD_UP") or gamepadJustPressed(1, "LEFT_STICK_DIGITAL_UP") or upJustPressed and buildTarget == 'android' then
            pos = pos - 1
            playSound("scrollMenu", 0.5, 'tick')
            runTimer("reset", 0.1)
        end

        if shadersEnabled then
            runHaxeCode([[                    
                FlxG.game.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
            ]])
        setShaderFloat('camShader', 'iTime', os.clock())
    end

        if keyboardJustPressed("ENTER") and pos == 0 and difficultyName == 'erect' or keyboardJustPressed("SPACE") and pos == 0 and difficultyName == 'erect' or gamepadJustPressed(1, "A") and pos == 0 and difficultyName == 'erect' or aJustPressed and pos == 0 and buildTarget == 'android' and difficultyName == 'erect' then
            closeCustomSubstate()
            stopSound("bah")
            setProperty("escu.visible", false)
            setProperty("resu.visible", false)
            setProperty("resta.visible", false)
            setProperty("exit.visible", false)
            setProperty("seta.visible", false)
            setProperty("setaa.visible", false)
            setProperty("compo.visible", false)
            setProperty("barr.visible", false)
            setProperty("balls.visible", false)
            setProperty("morri.visible", false)
            setProperty("noWay.visible", false)
            runHaxeCode([[
                FlxG.game.setFilters([]);
            ]])
            setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName..' Erect')
            setWindowColorMode(false)
            redrawWindowHeader();
            setProperty("barr.y", -20)
            setProperty("compo.y", -20)
            setProperty("balls.y", 740)
            setProperty("morri.y", 740)
            setProperty("buttonA.alpha", 0)
            setProperty("buttonD.alpha", 0)
            setProperty("buttonU.alpha", 0)
        elseif keyboardJustPressed("ENTER") and pos == 0 or keyboardJustPressed("SPACE") and pos == 0 or gamepadJustPressed(1, "A") and pos == 0 or aJustPressed and pos == 0 and buildTarget == 'android' then
            closeCustomSubstate()
            stopSound("bah")
            setProperty("escu.visible", false)
            setProperty("resu.visible", false)
            setProperty("resta.visible", false)
            setProperty("exit.visible", false)
            setProperty("seta.visible", false)
            setProperty("setaa.visible", false)
            setProperty("compo.visible", false)
            setProperty("barr.visible", false)
            setProperty("balls.visible", false)
            setProperty("morri.visible", false)
            setProperty("noWay.visible", false)
            runHaxeCode([[
                FlxG.game.setFilters([]);
            ]])
            setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName)
            setWindowColorMode(false)
            redrawWindowHeader();
            setProperty("barr.y", -20)
            setProperty("compo.y", -20)
            setProperty("balls.y", 740)
            setProperty("morri.y", 740)
            setProperty("buttonA.alpha", 0)
            setProperty("buttonD.alpha", 0)
            setProperty("buttonU.alpha", 0)
        elseif keyJustPressed('accept') and pos == 1 or aJustPressed and pos == 1 and buildTarget == 'android' then
            restartSong(false)
            playAnim("buttonA", "pressed")
        elseif keyJustPressed('accept') and pos == 2 or aJustPressed and pos == 2 and buildTarget == 'android' then
            exitSong(false)
            playAnim("buttonA", "pressed")
        end
    end
end

function onSoundFinished(tag)
    
    if tag == 'bah' then
        playSound("pause/pause-theme", 0.2, 'bah')
    end
end

function onDestroy()
    setWindowColorMode(false)
    redrawWindowHeader();
    setPropertyFromClass("openfl.Lib", "application.window.title", 'Friday Night Funkin\': Psych Engine')
    if shadersEnabled then
        runHaxeCode([[
            FlxG.game.setFilters([]);
        ]])
    end
end

function onCountdownStarted()

    setWindowColorMode(false)

    if songName == 'credits' then
        setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Credits Menu')
    else
        setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName)
    end

    if difficultyName == 'erect' then
        setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName..' Erect')
    else
        setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Playing: '..songName)
    end
end

function onGameOver()
    
    setWindowColorMode(true)
    redrawWindowHeader();
    setPropertyFromClass("openfl.Lib", "application.window.title", 'KittyBucks | Game Over')
end

function onSectionHit()

    if curSection == 24 and songName == 'KittyJam' and difficultyName == 'buck' then
        special = true
    elseif curSection == 32 and songName == 'KittyJam' and difficultyName == 'buck' then
        special = false
    elseif curSection == 48 and songName == 'KittyJam' and difficultyName == 'buck' then
        special = true
    elseif curSection == 64 and songName == 'KittyJam' and difficultyName == 'buck' then
        special = false
    elseif curSection == 36 and songName == 'KittyJam' and difficultyName == 'erect' then
        special = true
    elseif curSection == 54 and songName == 'KittyJam' and difficultyName == 'erect' then
        special = false
    elseif curSection == 117 and songName == 'KittyJam' and difficultyName == 'erect' then
        special = true
    end
end