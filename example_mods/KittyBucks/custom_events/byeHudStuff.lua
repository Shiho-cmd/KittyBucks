luaDebugMode = getModSetting("debug")
luaDeprecatedWarnings = getModSetting("deprecated")

function onEvent(eventName, value1, value2, strumTime)

    bruh = stringSplit(value1, ", ")
    
    if eventName == 'byeHudStuff' then
        if not middlescroll then
            doTweenAlpha('a', 'healthBar', bruh[1], bruh[2], bruh[3])
            doTweenAlpha('aa', 'iconP1', bruh[1], bruh[2], bruh[3])
            doTweenAlpha('aaa', 'iconP2', bruh[1], bruh[2], bruh[3])
            doTweenAlpha('aaaa', 'scoreTxt', bruh[1], bruh[2], bruh[3])
            noteTweenAlpha("morra1", 0, bruh[1], bruh[2], bruh[3])
            noteTweenAlpha("morra2", 1, bruh[1], bruh[2], bruh[3])
            noteTweenAlpha("morra3", 2, bruh[1], bruh[2], bruh[3])
            noteTweenAlpha("morra4", 3, bruh[1], bruh[2], bruh[3])
            noteTweenAlpha("morra5", 4, bruh[1], bruh[2], bruh[3])
            noteTweenAlpha("morra6", 5, bruh[1], bruh[2], bruh[3])
            noteTweenAlpha("morra7", 6, bruh[1], bruh[2], bruh[3])
            noteTweenAlpha("morra8", 7, bruh[1], bruh[2], bruh[3])
        elseif middlescroll then
            doTweenAlpha('a', 'healthBar', bruh[1], bruh[2], bruh[3])
            doTweenAlpha('aa', 'iconP1', bruh[1], bruh[2], bruh[3])
            doTweenAlpha('aaa', 'iconP2', bruh[1], bruh[2], bruh[3])
            doTweenAlpha('aaaa', 'scoreTxt', bruh[1], bruh[2], bruh[3])
            noteTweenAlpha("morra1", 0, bruh[1]/2, bruh[2], bruh[3])
            noteTweenAlpha("morra2", 1, bruh[1]/2, bruh[2], bruh[3])
            noteTweenAlpha("morra3", 2, bruh[1]/2, bruh[2], bruh[3])
            noteTweenAlpha("morra4", 3, bruh[1]/2, bruh[2], bruh[3])
            noteTweenAlpha("morra5", 4, bruh[1], bruh[2], bruh[3])
            noteTweenAlpha("morra6", 5, bruh[1], bruh[2], bruh[3])
            noteTweenAlpha("morra7", 6, bruh[1], bruh[2], bruh[3])
            noteTweenAlpha("morra8", 7, bruh[1], bruh[2], bruh[3])
        end
    end
end