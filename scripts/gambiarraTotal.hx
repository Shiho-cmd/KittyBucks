// isso aqui é uma gambiarra pra fazer as cores das notas não bugarem antes delas serem apertadas
// foi a única solução que eu achei beleza não me matem isso é escondido mesmo por causa das introduções fodas XD

function onCountdownStarted(){

    for(note in playerStrums){
        note.playAnim("pressed");
    }

    for(note in opponentStrums){
        note.playAnim("pressed");
    }
}

function onSongStart(){

    for(note in playerStrums){
        note.playAnim("static");
    }

    for(note in opponentStrums){
        note.playAnim("static");
    }
}