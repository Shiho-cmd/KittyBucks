--Orignal script by ItsCapp, don't steal, its dumb.
	--major overhaul by TheConcealedCow
		--updates:
			--[[
			-completely rewrote the entire script
			-added support for danceLeft and danceRight
			-added support for animations and animations outside of the character's spritesheet
			-added events to trigger character idles and play animations
			-fixed characters idling midway through a sustain note
			]]--

function getFileName()
	local funny = debug.getinfo(2, "S").source:sub(2)
	return funny:match("^.*/(.*).lua$")
end

function parseJson(file)
	return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local parsed = parseJson('characters/'..getFileName()..'.json')
local extraInfo = parseJson('characters/data/'..getFileName()..'_DATA.json')

--offsets, first value is irrelevant, just to prevent confustion
offsets = {
	{left, parsed.animations[5].offsets[1], parsed.animations[5].offsets[2]},
	{down, parsed.animations[2].offsets[1], parsed.animations[2].offsets[2]},
	{up, parsed.animations[3].offsets[1], parsed.animations[3].offsets[2]},
	{right, parsed.animations[4].offsets[1], parsed.animations[4].offsets[2]},
	{idle, parsed.animations[1].offsets[1], parsed.animations[1].offsets[2]}
}

useDanceLeftRight = extraInfo.danceLR; --if your character uses danceLeft and danceRight

--change these to the name in the xml of your character
leftXml = parsed.animations[5].name;
downXml = parsed.animations[2].name;
upXml = parsed.animations[3].name;
rightXml = parsed.animations[4].name;
idleXml = parsed.animations[1].name;--you can leave this blank if you're using danceLeft and danceRight

danceLeftXml = nil; --for danceLeft and danceRight if you're using those
danceRightXml = nil;

danceLeftIndices = ''; --leave these 2 blank if danceLeft and danceRight use seperate xml names
danceRightIndices = '';

danceLeftOffset = {parsed.animations[1].offsets[1], parsed.animations[1].offsets[2]};
danceRightOffset = {parsed.animations[2].offsets[1], parsed.animations[2].offsets[2]};

extraAnimations = {
--	{name, xmlName, loops(true or false), indices(optional)
		--name will be used to find the name of the png lol
		--set indices to '' or "" if you're not using them
		--loops is irrelevant if you have indices lol
}

extraAnimationStuff = {
--	[name] = {xOffet, yOffset, idleWhenDone(true or false), inSpriteSheet(true or false), fps}
		--if idleWhenDone is false, you will have to make the character idle with an event
		--if inSpriteSheet is set to false, the name will be used as the tag for the new animation
}

otherAnimationAddons = { --this is if you have more than one animation in another spritesheet
--	{tag of extra animation that you are reusing, newAnimationName, xmlName, loops (true or false), indices(optional)}
		--set indices to '' or "" if you're not using them
		--loops is irrelevant if you have indices lol
}

otherAnimationStuff = {
--	[newAnimationName] = {xOffset, yOffset, idleWhenDone, fps}
		--if idleWhenDone is false, you will have to make the character idle with an event
}
--character positions
xPos = parsed.position[1];
YPos = parsed.position[2];

--scale Character
xScale = parsed.scale;
yScale = parsed.scale;

--character naming stuff
nameOfPng = parsed.image;
tagForChar = extraInfo.tag;
noteTypeForChar = extraInfo.noteTag;

--some extra things 
inFront = extraInfo.front;
flipX = parsed.flip_x;

--dont try to edit anything under this line unless you know what you're doing :)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

charCanIdle = true;
inEvent = false;

function onCreate()
	luaDebugMode = true
	makeAnimatedLuaSprite(tagForChar, nameOfPng, xPos, YPos);
	
	addAnimationByPrefix(tagForChar, 'singLEFT', leftXml, parsed.animations[5].fps, false);
	addAnimationByPrefix(tagForChar, 'singDOWN', downXml, parsed.animations[2].fps, false);
	addAnimationByPrefix(tagForChar, 'singUP', upXml, parsed.animations[3].fps, false);
	addAnimationByPrefix(tagForChar, 'singRIGHT', rightXml, parsed.animations[4].fps, false);

	addAnimationByPrefix(tagForChar, 'singLEFT-mongus', parsed.animations[13].name, parsed.animations[13].fps, false);
	addAnimationByPrefix(tagForChar, 'singDOWN-mongus', parsed.animations[10].name, parsed.animations[10].fps, false);
	addAnimationByPrefix(tagForChar, 'singUP-mongus', parsed.animations[11].name, parsed.animations[11].fps, false);
	addAnimationByPrefix(tagForChar, 'singRIGHT-mongus', parsed.animations[12].name, parsed.animations[12].fps, false);

	addAnimationByPrefix(tagForChar, 'XD', parsed.animations[14].name, parsed.animations[12].fps, false);
	
	addOffset(tagForChar, 'singLEFT', offsets[1][2], offsets[1][3]);
	addOffset(tagForChar, 'singDOWN', offsets[2][2], offsets[2][3]);
	addOffset(tagForChar, 'singUP', offsets[3][2], offsets[3][3]);
	addOffset(tagForChar, 'singRIGHT', offsets[4][2], offsets[4][3]);
	
	if not useDanceLeftRight then
		addAnimationByPrefix(tagForChar, 'idle', idleXml, parsed.animations[1].fps, false);
		addOffset(tagForChar, 'idle', offsets[5][2], offsets[5][3]);
		playAnim(tagForChar, 'idle');
	else
		if danceLeftIndices == '' or danceLeftIndices == "" then
			addAnimationByPrefix(tagForChar, 'danceLeft', danceLeftXml, parsed.animations[1].fps, false);
		else
			addAnimationByIndices(tagForChar, 'danceLeft', danceLeftXml, danceLeftIndices, parsed.animations[1].fps);
		end
		if danceRightIndices == '' or danceRightIndices == "" then
			addAnimationByPrefix(tagForChar, 'danceRight', danceRightXml, parsed.animations[2].fps, false);
		else
			addAnimationByIndices(tagForChar, 'danceRight', danceRightXml, danceRightIndices, parsed.animations[2].fps);
		end
		addOffset(tagForChar, 'danceLeft', danceRightOffset[1], danceRightOffset[2]);
		addOffset(tagForChar, 'danceRight', danceLeftOffset[1], danceLeftOffset[2]);
		playAnim(tagForChar, 'danceLeft');
	end
	scaleObject(tagForChar, xScale, yScale);
	addLuaSprite(tagForChar, inFront);
	setProperty(tagForChar..".flipX", flipX)
	createAnimCases()
	extraAnimCases()
end

function opponentNoteHit(id, dir, nt, sus)
	if nt == noteTypeForChar then
		playAnim(tagForChar, getProperty('singAnimations['..dir..']'), true); --thank you shadowMario
		runTimer('canIdle', 0.1);
		charCanIdle = false
	end
end

function goodNoteHit(id, dir, nt, sus)
	if nt == noteTypeForChar then
		playAnim(tagForChar, getProperty('singAnimations['..dir..']'), true);
		runTimer('canIdle', 0.1);
		--debugPrint(getProperty('singAnimations['..dir..']')..'-mongus')
		charCanIdle = false
	end

	if nt == 'mongus' then
		playAnim(tagForChar, getProperty('singAnimations['..dir..']')..'-mongus', true);
		runTimer('canIdle', 0.1);
		charCanIdle = false
	end

	if nt == 'shiho-laugh' then
		playAnim(tagForChar, 'XD', true);
		runTimer('canIdle', 0.1);
		charCanIdle = false
	end
end

danceDir = true;
function onBeatHit()
	if curBeat % 2 == 0 and charCanIdle and not inEvent then
		if not useDanceLeftRight then
			playAnim(tagForChar, 'idle', true);
		end
	end
	if useDanceLeftRight and charCanIdle and not inEvent then
		if danceDir then
			danceDir = false;
			playAnim(tagForChar, 'danceLeft', true);
		else
			danceDir = true;
			playAnim(tagForChar, 'danceRight', true);
		end
	end
end

function onCountdownTick(counter)
	if counter % 2 == 0 and charCanIdle and not inEvent then
		if not useDanceLeftRight then
			playAnim(tagForChar, 'idle', true);
		end
	end
	if useDanceLeftRight and charCanIdle and not inEvent then
		if danceDir then
			danceDir = false;
			playAnim(tagForChar, 'danceLeft', true);
		else
			danceDir = true;
			playAnim(tagForChar, 'danceRight', true);
		end
	end
end

function onTimerCompleted(t)
	if t == 'canIdle' and not inEvent then
		charCanIdle = true;
	end
	if t == 'eventTimer' then
		for a = 1, table.maxn(extraAnimations) do
			nameE = extraAnimations[a][1];
			setProperty(nameE .. '.alpha', 0.0001);
			setProperty(tagForChar .. '.alpha', 1);
			inEvent = false;
			charCanIdle = true;
		end
	end
end

function onEvent(n, v1, v2) -- events to do cool shit
	if n == 'charPlayAnim ' .. tagForChar then
		for b = 1, table.maxn(extraAnimations) do
			namea = extraAnimations[b][1];
			idleDoned = extraAnimationStuff[v1][3];
			spriteSheete = extraAnimationStuff[v1][4];
			fpse = extraAnimationStuff[v1][5];
			
			if not spriteSheete then
				setProperty(tagForChar .. '.alpha', 0.0001);
				setProperty(v1 .. '.alpha', 1);
				playAnim(v1, v1, true);
			else
				charCanIdle = false;
				inEvent = true;
				playAnim(tagForChar, v1, true);
			end
			if idleDoned then
				if not spriteSheete then
					runTimer('eventTimer', tonumber(getProperty(v1 .. '.animation.curAnim.frames.length')) / fpse);
				else
					runTimer('eventTimer', tonumber(getProperty(tagForChar .. '.animation.curAnim.frames.length')) / fpse);
				end
			end
			if namea ~= v1 then
				setProperty(namea .. '.alpha', 0.0001);
			end
		end
	end
	if n == 'charPlayExtraAnim ' .. tagForChar then
		for k = 1, table.maxn(extraAnimations) do 
			namen = extraAnimations[k][1];
			idleDont = otherAnimationStuff[v2][3];
			fpsy = otherAnimationStuff[v2][4];
			
			setProperty(tagForChar .. '.alpha', 0.0001);
			setProperty(v1 .. '.alpha', 1);
			playAnim(v1, v2, true);
			if namen ~= v1 then
				setProperty(namen .. '.alpha', 0.0001);
			end
			if idleDont then
				runTimer('eventTimer', tonumber(getProperty(v1 .. '.animation.curAnim.frames.length')) / fpsy);
			end
		end
	end
	if n == 'charIdle ' .. tagForChar then
		for y = 1, table.maxn(extraAnimations) do 
			nameU = extraAnimations[y][1];
			isSpriteA = extraAnimationStuff[nameU][3];
			charCanIdle = true;
			inEvent = false;
			if useDanceLeftRight then
				if danceDir then
					danceDir = false;
					playAnim(tagForChar, 'danceLeft', true);
				else
					danceDir = true;
					playAnim(tagForChar, 'danceRight', true);
				end
			else
				playAnim(tagForChar, 'idle', true);
			end
			if not isSpriteA then
				setProperty(nameU .. '.alpha', 0.0001);
				setProperty(tagForChar .. '.alpha', 1);
			end
		end
	end
end

function onUpdatePost()
	for e = 1, table.maxn(extraAnimations) do
		nameD = extraAnimations[e][1];
		setProperty(nameD .. '.x', getProperty(tagForChar .. '.x'));
		setProperty(nameD .. '.y', getProperty(tagForChar .. '.y'));
	end
end

function createAnimCases()
	for b = 1, table.maxn(extraAnimations) do
		name = extraAnimations[b][1];
		xml = extraAnimations[b][2];
		loops = extraAnimations[b][3];
		indices = extraAnimations[b][4];
		offX = extraAnimationStuff[name][1];
		offY = extraAnimationStuff[name][2];
		idleDone = extraAnimationStuff[name][3];
		spriteSheet = extraAnimationStuff[name][4];
		fps = extraAnimationStuff[name][5];
		if not spriteSheet then
			makeAnimatedLuaSprite(name, 'characters/' .. name, XPos, YPos);
			if indices ~= '' or indices ~= "" then
				addAnimationByIndices(name, name, xml, indices, fps);
			else
				addAnimationByPrefix(name, name, xml, fps, loops);
			end
			addOffset(name, name, offX, offY);
			addLuaSprite(name, inFront);
			setProperty(name .. '.alpha', 0.0001);
			setObjectOrder(name, getObjectOrder(tagForChar) + 1);
			scaleObject(name, xScale, yScale);
		else
			if indices ~= '' or indices ~= "" then
				addAnimationByIndices(tagForChar, name, xml, indices, fps);
			else
				addAnimationByPrefix(tagForChar, name, xml, fps, loops);
			end
			addOffset(tagForChar, name, offX, offY);
		end
	end
end

function extraAnimCases()
	for c = 1, table.maxn(otherAnimationAddons) do
		orignalTag = otherAnimationAddons[c][1];
		newThing = otherAnimationAddons[c][2];
		newXml = otherAnimationAddons[c][3];
		doesLoop = otherAnimationAddons[c][4];
		daIndices = otherAnimationAddons[c][5];
		daX = otherAnimationStuff[newThing][1];
		daY = otherAnimationStuff[newThing][2];
		IdleWDone = otherAnimationStuff[newThing][3];
		daFps = otherAnimationStuff[newThing][4];
		
		if daIndices ~= '' or daIndices ~= "" then
			addAnimationByIndices(orignalTag, newThing, newXml, daIndices, daFps);
		else
			addAnimationByPrefix(orignalTag, newThing, newXml, daFps, doesLoop);
		end
		addOffset(orignalTag, newThing, daX, daY);
	end
end