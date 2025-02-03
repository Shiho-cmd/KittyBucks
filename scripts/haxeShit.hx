import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import shaders.RGBPalette;

var rgbs:Array = [];
var holdCovers:Array = [];
var heldNotes:Array = [];
var inputs:Array = [];

var velo:Int = 40;

// isso aqui é uma gambiarra pra fazer as cores das notas não bugarem antes delas serem apertadas
// foi a única solução que eu achei beleza não me matem isso é escondido mesmo por causa das introduções fodas XD
function onCountdownTick(tick:Countdown, counter:Int)
    {
        switch(tick)
        {
            case Countdown.THREE:
                for(note in playerStrums){
                    note.playAnim("pressed");
                }

                for(note in opponentStrums){
                    note.playAnim("pressed");
                }
            case Countdown.TWO:
                for(note in playerStrums){
                    note.playAnim("static");
                }
            
                for(note in opponentStrums){
                    note.playAnim("static");
                }
        }
    }
    
// cria a grid irada que fica no fundo dos créditos (eu num ia programar isso em lua mas nem fudendo lol)
function onCreate(){

	if (ClientPrefs.data.flashing)
		{
			velo = 40;
		}
	else
		{
			velo = 20;
		}

    if (songName == 'credits')
        {
            var grid:FlxBackdrop = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x50000000, 0x0));
            grid.velocity.set(velo, velo);
            grid.cameras = [game.camHUD];
            add(grid);
        }
}

function onUpdate(){
	for(note in game.grpNoteSplashes){
		note.scale.set(0.5, 0.5);
	 }
}

// hold cover stuff yayayayay (eu não programei isso se eu achar a pessoa pra dar os créditos eu boto aqui)
function onCountdownStarted() {
	var m = (ClientPrefs.data.downScroll ? -1 : 1);
	var i = 0;
	for (strum in game.strumLineNotes.members) {
		var cover = new FlxSprite(strum.x, strum.y);
		cover.frames = Paths.getSparrowAtlas('noteSplashes/holdCover/holdCoverShader');
		cover.cameras = [game.camHUD];
		cover.antialiasing = ClientPrefs.data.antialiasing;
		cover.animation.addByPrefix('start', 'holdCoverStart', 24, false);
		cover.animation.addByPrefix('loop', 'holdCover0', 24, true);
		cover.animation.addByPrefix('end', 'holdCoverEnd', 24, false);
		cover.animation.play('loop', true);
		cover.offset.set(cover.width * .36, cover.height * .25);
		cover.visible = false;
		var rgb = new RGBPalette();
		cover.shader = rgb.shader;
		rgbs.push(rgb);
		holdCovers.push(cover);
		game.add(cover);
		
	}
	
	return Function_Continue;
}

function goodNoteHitPre(note) if (!note.isSustainNote) inputs.push(note.noteData);

function onKeyRelease(k) {
	var cover = holdCovers[k + game.opponentStrums.length];
	if (cover != null && cover.animation.curAnim.name != 'end') cover.visible = false;
	var note = heldNotes[k];
	if (note != null) {
		for (child in note.tail) {
			child.kill(child);
			game.notes.remove(child, true);
			child.destroy();
		}
		note.tail = [];
		heldNotes[note.noteData] = null;
	}
}

function coverLogic(note) {
	var data = note.noteData;
	if (note.mustPress) data += game.opponentStrums.length;
	var cover = holdCovers[data];
	var rgb = rgbs[data];
	if (cover != null && note.isSustainNote) {
		cover.visible = true;
		if (rgbs != null) {
			rgb.r = note.rgbShader.r;
			rgb.g = note.rgbShader.g; //blue color channel is not used
		}
		if (!cover.visible || cover.animation.curAnim.name == 'end') cover.animation.play('start');
		if (StringTools.endsWith(note.animation.curAnim.name, 'holdend')) {
			cover.animation.play('end', true);
			}
			}
		}

function opponentNoteHit(note) {
	coverLogic(note);
}

function goodNoteHit(note) {
	coverLogic(note);
	if (note.tail.length > 0) heldNotes[note.noteData] = note;
	}

function onUpdatePost(e) {
	for (cover in holdCovers) {
		if (cover.animation.curAnim.finished) {
			if (cover.animation.curAnim.name == 'end') cover.visible = false;
			else cover.animation.play('loop', true);
		}
	}
}

function int2rgb(col) return {red: (col >> 16) & 0xff, green: (col >> 8) & 0xff, blue: col & 0xff}; 
function rgb2hsv(col) {
	var hueRad = Math.atan2(Math.sqrt(3) * (col.green - col.blue), 2 * col.red - col.green - col.blue);
	var hue:Float = 0;
	if (hueRad != 0) hue = 180 / Math.PI * hueRad;
	hue = hue < 0 ? hue + 360 : hue;
	var bright:Float = Math.max(col.red, Math.max(col.green, col.blue));
	var sat:Float = (bright - Math.min(col.red, Math.min(col.green, col.blue))) / bright;
	return {hue: hue, saturation: sat, brightness: bright};
}
function hsv2rgb(col) {
	var chroma = col.brightness * col.saturation;
	var match = col.brightness - chroma;
	
	var hue:Float = col.hue % 360;
	var hueD = hue / 60;
	var mid = chroma * (1 - Math.abs(hueD % 2 - 1)) + match;
	chroma += match;
	
	chroma /= 255; 
	mid /= 255;
	match /= 255;

	switch (Std.int(hueD)) {
		case 0: return {red: chroma, green: mid, blue: match};
		case 1: return {red: mid, green: chroma, blue: match};
		case 2: return {red: match, green: chroma, blue: mid};
		case 3: return {red: match, green: mid, blue: chroma};
		case 4: return {red: mid, green: match, blue: chroma};
		case 5: return {red: chroma, green: match, blue: mid};
	}
}