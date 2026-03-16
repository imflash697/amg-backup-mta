function getNearPlayers(element)
	local TP = {}
	local x, y, z = getElementPosition(element)
	for i, player in ipairs(getElementsByType("player")) do
		local px, py, pz = getElementPosition(player)
		if player ~= element and getDistanceBetweenPoints3D(x, y, z, px, py, pz) <= 50 then
			table.insert(TP, player)
		end
	end
	return TP
end

setTimer(function()
	for i, player in ipairs(getElementsByType("player")) do
		setPlayerVoiceBroadcastTo(player, getNearPlayers(player))
	end
end, 1500, 0) 