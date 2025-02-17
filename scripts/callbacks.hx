function onCreatePost(){

    createGlobalCallback("setSongPosition", function(time:Int) {PlayState.instance.clearNotesBefore(time); PlayState.instance.setSongTime(time);});
}