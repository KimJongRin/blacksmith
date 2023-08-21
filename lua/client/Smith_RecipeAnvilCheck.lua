------------------------------------------------------------------------------------------------------------------
-- By Soul Filcher, modified from Blair Algol's code.
--
------------------------------------------------------------------------------------------------------------------

function AnvilCheck(recipe, playerObj)
	local anvil = nil;

	anvil = FindTileObject(playerObj, "Anvil")
	if anvil then return true end

	return false
end

function FindTileObject(playerObj, tileObj)
    local station = nil
    local CustomName = nil
    local cell = playerObj:getCell()
    local x, y, z = playerObj:getX(), playerObj:getY(), playerObj:getZ()
    local xx, yy, zz
    for xx =-1,1 do -- no rule says we need to start at index 1. skip the funky math
        for yy =-1,1 do
            local square = cell:getGridSquare(x+xx, y+yy, z)
            if square then
                local objects = square:getObjects()
                for index=0, objects:size()-1 do
                    local object = objects:get(index)
                    if object:getProperties():Val("CustomName") then
                        CustomName = object:getProperties():Val("CustomName")
                        if CustomName:contains(tileObj) or tileObj:contains(CustomName) then
                            station = object
                            return station
                        end
		    elseif object:getName() and object:getName() == tileObj then
                            station = object
                            return station
                    end
                end
            end
        end
    end
    return station
end