import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;

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

    if (songName == 'credits')
        {
            var grid:FlxBackdrop = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x50000000, 0x0));
            grid.velocity.set(40, 40);
            grid.cameras = [game.camHUD];
            add(grid);
        }
}

function onUpdate(elapsed:Float){

}