function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'shiho-laugh' then
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true); -- make it so original character doesn't sing these notes
			setPropertyFromGroup('unspawnNotes', i, 'noMissAnimation', true);
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has penalties
			end
		end
	end
end

function onUpdate()
	for i = 0, getProperty('notes.length') - 1 do
		if getPropertyFromGroup('notes', i, 'noteType') == 'shiho-laugh' then
			setPropertyFromGroup('notes', i, 'noAnimation', true);
		end
	end
end