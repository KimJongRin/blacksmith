--***********************************************************
--**                    SOUL FILCHER                       **
--***********************************************************

Smith_Functions = {}

function Smith_Functions.getFurnaceItems(inventory)
	if isServer() then
		return inventory:getItems();
	end
	return nil
end