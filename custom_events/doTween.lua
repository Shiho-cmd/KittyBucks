function onEvent(eventName, value1, value2, strumTime)
	
	coiso = stringSplit(value2, ', ')
	
    if eventName == 'doTween' then
        if value1 == 'alpha' then
            doTweenAlpha(coiso[1],coiso[2],coiso[3],coiso[4],coiso[5])
        elseif value1 == 'x' then
            doTweenX(coiso[1],coiso[2],coiso[3],coiso[4],coiso[5])
        elseif value1 == 'y' then
            doTweenY(coiso[1],coiso[2],coiso[3],coiso[4],coiso[5])
        elseif value1 == 'angle' then
            doTweenAngle(coiso[1],coiso[2],coiso[3],coiso[4],coiso[5])
        elseif value1 == 'zoom' then
            doTweenZoom(coiso[1],coiso[2],coiso[3],coiso[4],coiso[5])
        elseif value1 == 'color' then
            doTweenColor(coiso[1],coiso[2],coiso[3],coiso[4],coiso[5])
        end
	end
end