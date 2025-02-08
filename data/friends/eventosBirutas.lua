local distortion = 0.01
local pode = false

function onCreate() 
    local var ShaderName = 'melt'
    if shadersEnabled then  
        initLuaShader(ShaderName)
        makeLuaSprite('camShader', nil)
        makeGraphic('camShader', screenWidth, screenHeight)
        setSpriteShader('camShader', ShaderName)
    else
        ShaderName = 'none'
    end

        function onUpdate(elapsed)
            if curStep == 1632 and shadersEnabled then
                pode = true
                runHaxeCode([[
                    trace(game.getLuaObject('camShader').shader + ' Has Been Loaded!');                      
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
    end

function onDestroy()
    if shadersEnabled then
        runHaxeCode([[
            FlxG.game.setFilters([]);
        ]])
    end
end