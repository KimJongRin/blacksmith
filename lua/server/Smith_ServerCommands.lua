local Commands = {}

function Commands.syncFurnaceItems(player, args)
	local sq = getCell():getGridSquare(args.x, args.y, args.z)
	if sq and args.index >= 0 and args.index < sq:getObjects():size() then
		local o = sq:getObjects():get(args.index)
		if instanceof(o, 'BSFurnace') then
			local furnace = o
			local inv = o:getInventory();
			local temp = inv:getCustomTemperature();
			local items = inv:getItems();
			local args = { x=args.x, y=args.y, z=args.z, index=args.index, items = items, temp = temp };
			sendServerCommand('Smith', "setFurnaceItems", args);
		end
	end
end

Events.OnClientCommand.Add(function(module, command, player, args)
	if module == 'Smith' and Commands[command] then
		args = args or {}
		Commands[command](player, args)
    		sendServerCommand(module, command, args)
	end
end)