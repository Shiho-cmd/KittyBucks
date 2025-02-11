import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;

function onCreate(){

        {
            var grid:FlxBackdrop = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x50000000, 0x0));
            grid.velocity.set(40, 40);
            grid.cameras = [game.camHUD];
            add(grid);
        }
}