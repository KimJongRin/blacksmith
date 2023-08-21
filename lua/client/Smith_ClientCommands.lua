local Commands = {}

function Commands.setFurnaceItems(player, args)
	local sq = getCell():getGridSquare(args.x, args.y, args.z)
	if sq and args.index >= 0 and args.index < sq:getObjects():size() then
		local o = sq:getObjects():get(args.index)
		if instanceof(o, 'BSfurnace') then
			local inv = o:getInventory();
			inv:setCustomTemperature(args.temp);
			inv:setItems(args.items);
		end
	end
end

Events.OnServerCommand.Add(function(module, command, args)
	if not isClient() then return end
	if module == "Smith" and Commands[command] then
		args = args or {}
		Commands[command](player, args)
	end
end)