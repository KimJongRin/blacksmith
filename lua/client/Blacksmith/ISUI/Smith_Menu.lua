SFBlacksmithMenu = {};
SFBlacksmithMenu.canDoSomething = false

SFBlacksmithMenu.doBuildMenu = function(player, context, worldobjects, test)

    if test and ISWorldObjectContextMenu.Test then return true end

    if getCore():getGameMode()=="LastStand" then
        return;
    end

	local lightContext = nil;
	local infoContext = nil;
	local bellowsContext = nil;
	local stopFireContext = nil;
	local addFuelContext = nil;
	local metalDrumContext = nil;
	local lightDrumContext = nil;

	for i,v in ipairs(context.options) do
		if v.name == getText("ContextMenu_LitStoneFurnace") then
			lightContext = v;
		elseif v.name == getText("ContextMenu_Furnace_Info") then
			infoContext = v;
		elseif v.name == getText("ContextMenu_UseBellows") then
			bellowsContext = v;
		elseif v.name == getText("ContextMenu_Put_out_fire") then
			stopFireContext = v;
		elseif v.name == getText("ContextMenu_Add_fuel_to_fire") then
			addFuelContext = v;
		elseif v.name == getText("ContextMenu_Metal_Drum") then
			metalDrumContext = v;
		elseif v.name == getText("ContextMenu_LitDrum") then
			lightDrumContext = v;
		end
	end

    if test then return ISWorldObjectContextMenu.setTest() end
    local playerObj = getSpecificPlayer(player)

    if playerObj:getVehicle() then return; end

    local doesntMatter = true;

    if doesntMatter == true then
        local buildOption = context:addOption(getText("ContextMenu_Blacksmith"), worldobjects, nil);
        local subMenu = ISContextMenu:getNew(context);
        context:addSubMenu(buildOption, subMenu);
		local keepMenu = false;

	if playerObj:getKnownRecipes():contains("Make Stone Furnace") then
	    keepMenu = true;
        local furnaceOption = subMenu:addOption(getText("ContextMenu_Stone_Furnace"), worldobjects, SFBlacksmithMenu.onStoneFurnace, player);
        local toolTip = ISToolTip:new();
        toolTip:initialise();
        toolTip:setVisible(false);
        -- add it to our current option
        furnaceOption.toolTip = toolTip;
        toolTip:setName(getText("ContextMenu_Stone_Furnace"));
        toolTip.description = getText("Tooltip_craft_stoneFurnaceDesc") .. " <LINE> ";
        toolTip:setTexture("crafted_01_16");
        if playerObj:getInventory():getItemCount("Base.Stone") < 15 then
            toolTip.description = toolTip.description .. " <LINE> <RGB:1,0,0> " .. getItemText("Stone") .. " " .. playerObj:getInventory():getItemCount("Base.Stone") .. "/15" ;
            furnaceOption.notAvailable = true;
        else
            toolTip.description = toolTip.description .. " <LINE> <RGB:1,1,1> " .. getItemText("Stone") .. " " .. playerObj:getInventory():getItemCount("Base.Stone") .. "/15" ;
        end
	end

	if playerObj:getKnownRecipes():contains("Make Anvil") then
	    keepMenu = true;
        local anvilOption = subMenu:addOption(getText("ContextMenu_Anvil"), worldobjects, SFBlacksmithMenu.onAnvil, player);
        local toolTip = ISToolTip:new();
        toolTip:initialise();
        toolTip:setVisible(false);
        -- add it to our current option
        anvilOption.toolTip = toolTip;
        toolTip:setName(getText("ContextMenu_Anvil"));
        toolTip.description = getText("Tooltip_craft_anvilDesc") .. " <LINE> ";
        toolTip:setTexture("crafted_01_19");
        -- check if the player have enough metal to make the anvil
        local canBeCrafted = playerObj:getInventory():contains("Hammer") and playerObj:getInventory():contains("Log");
        if not playerObj:getInventory():contains("Hammer") then
            toolTip.description = toolTip.description .. " <LINE> <RGB:1,0,0> " .. getItemText("Hammer") .. " 0/1" ;
            anvilOption.notAvailable = true;
        else
            toolTip.description = toolTip.description .. " <LINE> <RGB:1,1,1> " .. getItemText("Hammer") .. " 1/1" ;
        end
        if not playerObj:getInventory():contains("Log") then
            toolTip.description = toolTip.description .. " <LINE> <RGB:1,0,0> " .. getItemText("Log") .. " 0/1" ;
            anvilOption.notAvailable = true;
        else
            toolTip.description = toolTip.description .. " <LINE> <RGB:1,1,1> " .. getItemText("Log") .. " 1/1" ;
        end
        local ingots = nil;
        local metalAmount = nil;
		ingots, metalAmount = SFBlacksmithMenu.getMetal(playerObj, SFBlacksmithMenu.metalForAnvil);
		if not ingots then
			toolTip.description = toolTip.description .. " <LINE> <RGB:1,0,0> " .. getItemText("Workable Iron") .. " " .. (metalAmount/100) .. " / " .. (SFBlacksmithMenu.metalForAnvil/100);
			anvilOption.notAvailable = true;
		else
			toolTip.description = toolTip.description .. " <LINE> <RGB:1,1,1> " .. getItemText("Workable Iron") .. " " .. (metalAmount/100) .. " / " .. (SFBlacksmithMenu.metalForAnvil/100);
		end
	end

	if keepMenu or playerObj:getInventory():contains("MetalDrum") then
		keepMenu = true;
        local drumOption = subMenu:addOption(getText("ContextMenu_Metal_Drum"), worldobjects, SFBlacksmithMenu.onMetalDrum, player, "crafted_01_24");
        local toolTip = ISToolTip:new();
        toolTip:initialise();
        toolTip:setVisible(false);
        -- add it to our current option
        drumOption.toolTip = toolTip;
        toolTip:setName(getText("ContextMenu_Metal_Drum"));
        toolTip.description = getText("Tooltip_craft_metalDrumDesc") .. " <LINE> ";
        toolTip:setTexture("crafted_01_24");
        if not playerObj:getInventory():contains("MetalDrum") then
            toolTip.description = toolTip.description .. " <LINE> <RGB:1,0,0> " .. getItemText("Metal Drum") .. " 0/1" ;
            drumOption.notAvailable = true;
        else
            toolTip.description = toolTip.description .. " <LINE> <RGB:1,1,1> " .. getItemText("Metal Drum") .. " 1/1" ;
        end
	end

        if not keepMenu then
            context:removeLastOption()
        end
    end

    local playerInv = playerObj:getInventory();
--    local square = nil;

    local lighter = nil
    local matches = nil
    local petrol = nil
    local percedWood = nil
    local branch = nil
    local stick = nil
    local lightFireList = {}
    local lightFromPetrol = nil;
    local lightFromKindle = nil
    local lightFromLiterature = nil
    local lightDrumFromPetrol = nil;
    local lightDrumFromKindle = nil
    local lightDrumFromLiterature = nil
    local metalFence;
    local bellows;
    local coal = nil;
    local containers = ISInventoryPaneContextMenu.getContainers(playerObj)
    for i=1,containers:size() do
        local container = containers:get(i-1)
        for j=1,container:getItems():size() do
            local item = container:getItems():get(j-1)
            local type = item:getType()
            if type == "Lighter" then
                lighter = item
            elseif type == "Matches" then
                matches = item
            elseif type == "PetrolCan" then
                petrol = item
            elseif type == "PercedWood" then
                percedWood = item
            elseif type == "TreeBranch" then
                branch = item
            elseif type == "WoodenStick" then
                stick = item
            elseif type == "MetalFence" then
                metalFence = item
            elseif type == "Coal" or type == "Charcoal" then
                coal = item
            elseif type == "Bellows" then
                bellows = item
            end

            if campingLightFireType[type] then
                if campingLightFireType[type] > 0 then
                    table.insert(lightFireList, item)
                end
            elseif campingLightFireCategory[item:getCategory()] then
                table.insert(lightFireList, item)
            end
        end
    end

    local furnace;
    local metalDrumIsoObj = nil
    local metalDrumLuaObj = nil
    local sq;
    for i,v in ipairs(worldobjects) do
        sq = v:getSquare();
        if instanceof(v, "BSFurnace") then
            furnace = v;
        end
        if CMetalDrumSystem.instance:isValidIsoObject(v) then
            metalDrumIsoObj = v
            metalDrumLuaObj = CMetalDrumSystem.instance:getLuaObjectOnSquare(v:getSquare())
        end

        if (lighter or matches) and petrol and furnace and furnace:getFuelAmount() > 0 and not furnace:isFireStarted() then
            lightFromPetrol = furnace;
        end

        if (lighter or matches) and petrol and metalDrumLuaObj and metalDrumLuaObj.haveLogs and not metalDrumLuaObj.isLit and not metalDrumLuaObj.haveCharcoal then
            lightDrumFromPetrol = metalDrumLuaObj;
        end

        if percedWood and (stick or branch) and furnace and furnace:getFuelAmount() > 0 and not furnace:isFireStarted() and playerObj:getStats():getEndurance() > 0 then
            lightFromKindle = furnace
        end
        if percedWood and (stick or branch) and metalDrumLuaObj and metalDrumLuaObj.haveLogs and not metalDrumLuaObj.isLit and not metalDrumLuaObj.haveCharcoal and playerObj:getStats():getEndurance() > 0 then
            lightDrumFromKindle = metalDrumLuaObj
        end
        if (lighter or matches) and furnace ~= nil and furnace:getFuelAmount() > 0 and not furnace:isFireStarted() then
            lightFromLiterature = furnace
        end
        if (lighter or matches) and metalDrumLuaObj and metalDrumLuaObj.haveLogs and not metalDrumLuaObj.isLit and not metalDrumLuaObj.haveCharcoal then
            lightDrumFromLiterature = metalDrumLuaObj
        end
    end

    if lightFromPetrol or lightFromKindle or (lightFromLiterature and #lightFireList > 0) then
        if test then return ISWorldObjectContextMenu.setTest() end

	local lightOption;
	if lightContext then
	    lightOption = context:replaceOption(lightContext, getText("ContextMenu_LightStoneFurnace"), worldobjects, nil);
	else
		lightOption = context:addOption(getText("ContextMenu_LightStoneFurnace"), worldobjects, nil);
	end

        local subMenuLight = ISContextMenu:getNew(context);
        context:addSubMenu(lightOption, subMenuLight);
        if lightFromPetrol then
            if lighter then
                subMenuLight:addOption(petrol:getName()..' + '..lighter:getName(), worldobjects, SFBlacksmithMenu.onLightFromPetrol, player, lighter, petrol, lightFromPetrol)
            end
            if matches then
                subMenuLight:addOption(petrol:getName()..' + '..matches:getName(), worldobjects, SFBlacksmithMenu.onLightFromPetrol, player, matches, petrol, lightFromPetrol)
            end
        end
        for i,v in pairs(lightFireList) do
            local label = v:getName()
            if lighter then
                subMenuLight:addOption(label..' + '..lighter:getName(), worldobjects, SFBlacksmithMenu.onLightFromLiterature, player, v, lighter, lightFromLiterature, coal)
            end
            if matches then
                subMenuLight:addOption(label..' + '..matches:getName(), worldobjects, SFBlacksmithMenu.onLightFromLiterature, player, v, matches, lightFromLiterature, coal)
            end
        end
        if lightFromKindle then
            if stick then
                subMenuLight:addOption(percedWood:getName()..' + '..stick:getName(), worldobjects, SFBlacksmithMenu.onLightFromKindle, player, percedWood, stick, lightFromKindle);
            elseif branch then
                subMenuLight:addOption(percedWood:getName()..' + '..branch:getName(), worldobjects, SFBlacksmithMenu.onLightFromKindle, player, percedWood, branch, lightFromKindle);
            end
        end
    end

    if lightDrumFromPetrol or lightDrumFromKindle or (lightDrumFromLiterature and #lightFireList > 0) then
        if test then return ISWorldObjectContextMenu.setTest() end
		
		local lightOption;

		if lightDrumContext then
			lightOption = context:replaceOption(lightDrumContext, getText("ContextMenu_LitDrum"), worldobjects, nil);
		else
			lightOption = context:addOption(getText("ContextMenu_LitDrum"), worldobjects, nil);
		end
        local subMenuLight = ISContextMenu:getNew(context);
        context:addSubMenu(lightOption, subMenuLight);
        if lightDrumFromPetrol then
            if lighter then
                local LitOption = subMenuLight:addOption(petrol:getName()..' + '..lighter:getName(), worldobjects, SFBlacksmithMenu.onLightDrumFromPetrol, player, lighter, petrol, lightDrumFromPetrol)
                local tooltip = ISWorldObjectContextMenu.addToolTip()
                tooltip:setName(getText("ContextMenu_LitDrum"))
                tooltip.description = getText("Tooltip_Charcoal");
                LitOption.toolTip = tooltip
            end
            if matches then
                local LitOption = subMenuLight:addOption(petrol:getName()..' + '..matches:getName(), worldobjects, SFBlacksmithMenu.onLightDrumFromPetrol, player, matches, petrol, lightDrumFromPetrol)
                local tooltip = ISWorldObjectContextMenu.addToolTip()
                tooltip:setName(getText("ContextMenu_LitDrum"))
                tooltip.description = getText("Tooltip_Charcoal");
                LitOption.toolTip = tooltip
            end
        end
        for i,v in pairs(lightFireList) do
            local label = v:getName()
            if lighter then
                local LitOption = subMenuLight:addOption(label..' + '..lighter:getName(), worldobjects, SFBlacksmithMenu.onLightDrumFromLiterature, player, v, lighter, lightDrumFromLiterature, coal)
                local tooltip = ISWorldObjectContextMenu.addToolTip()
                tooltip:setName(getText("ContextMenu_LitDrum"))
                tooltip.description = getText("Tooltip_Charcoal");
                LitOption.toolTip = tooltip
            end
            if matches then
                local LitOption = subMenuLight:addOption(label..' + '..matches:getName(), worldobjects, SFBlacksmithMenu.onLightDrumFromLiterature, player, v, matches, lightDrumFromLiterature, coal)
                local tooltip = ISWorldObjectContextMenu.addToolTip()
                tooltip:setName(getText("ContextMenu_LitDrum"))
                tooltip.description = getText("Tooltip_Charcoal");
                LitOption.toolTip = tooltip
            end
        end
        if lightDrumFromKindle then
            if stick then
                local LitOption = subMenuLight:addOption(percedWood:getName()..' + '..stick:getName(), worldobjects, SFBlacksmithMenu.onLightDrumFromKindle, player, percedWood, stick, lightDrumFromKindle);
                local tooltip = ISWorldObjectContextMenu.addToolTip()
                tooltip:setName(getText("ContextMenu_LitDrum"))
                tooltip.description = getText("Tooltip_Charcoal");
                LitOption.toolTip = tooltip
            elseif branch then
                local LitOption = subMenuLight:addOption(percedWood:getName()..' + '..branch:getName(), worldobjects, SFBlacksmithMenu.onLightDrumFromKindle, player, percedWood, branch, lightDrumFromKindle);
                local tooltip = ISWorldObjectContextMenu.addToolTip()
                tooltip:setName(getText("ContextMenu_LitDrum"))
                tooltip.description = getText("Tooltip_Charcoal");
                LitOption.toolTip = tooltip
            end
        end
    end

    if furnace then

	if infoContext then
	        context:replaceOption(infoContext, getText("ContextMenu_FurnaceInfo"), worldobjects, SFBlacksmithMenu.onInfo, furnace, playerObj);
	else
	        context:addOption(getText("ContextMenu_FurnaceInfo"), worldobjects, SFBlacksmithMenu.onInfo, furnace, playerObj);
	end

       if coal and furnace:getFuelAmount() < 100 then
	   if addFuelContext then
	           context:replaceOption(addFuelContext, getText("ContextMenu_GeneratorAddFuel"), worldobjects, SFBlacksmithMenu.onAddFuel, furnace, coal, playerObj);
	   else
	           context:addOption(getText("ContextMenu_GeneratorAddFuel"), worldobjects, SFBlacksmithMenu.onAddFuel, furnace, coal, playerObj);
	   end
       end
       if furnace:isFireStarted() then
           if furnace:getHeat() < 100 and bellows then

		if bellowsContext then
			context:replaceOption(bellowsContext, getText("ContextMenu_UseBellows"), worldobjects, SFBlacksmithMenu.onUseBellows, furnace, bellows, playerObj);
		else
			context:addOption(getText("ContextMenu_UseBellows"), worldobjects, SFBlacksmithMenu.onUseBellows, furnace, bellows, playerObj);
		end
           end

		if stopFireContext then
			context:replaceOption(stopFireContext, getText("ContextMenu_ExtinguishFire"), worldobjects, SFBlacksmithMenu.onStopFire, furnace, playerObj);
		else
			context:addOption(getText("ContextMenu_ExtinguishFire"), worldobjects, SFBlacksmithMenu.onStopFire, furnace, playerObj);
		end
       end
    end

    if metalDrumLuaObj and playerObj:DistToSquared(metalDrumIsoObj:getX() + 0.5, metalDrumIsoObj:getY() + 0.5) < 2 * 2 then
        local option;
		
		if metalDrumContext then
			option = context:replaceOption(metalDrumContext, getText("ContextMenu_Metal_Drum"), worldobjects, nil)
		else
			option = context:addOption(getText("ContextMenu_Metal_Drum"), worldobjects, nil)
		end
		
        local subMenuDrum = ISContextMenu:getNew(context);
        context:addSubMenu(option, subMenuDrum);
        local tooltip = ISWorldObjectContextMenu.addToolTip()
        tooltip:setName(getText("ContextMenu_Metal_Drum"))
        if metalDrumIsoObj:getWaterAmount() > 0 then
        	local tx = getTextManager():MeasureStringX(tooltip.font, getText("ContextMenu_WaterName") .. ":") + 20
        	tooltip.description = string.format("%s: <SETX:%d> %d / %d", getText("ContextMenu_WaterName"), tx, metalDrumIsoObj:getWaterAmount(), metalDrumLuaObj.waterMax);
        	if metalDrumIsoObj:isTaintedWater() then
            		tooltip.description = tooltip.description .. " <BR> <RGB:1,0.5,0.5> " .. getText("Tooltip_item_TaintedWater")
        	end
        	tooltip.maxLineWidth = 512
        elseif metalDrumLuaObj.haveLogs and metalDrumLuaObj.isLit then
            if not metalDrumLuaObj.charcoalTick then
                tooltip.description = getText("Tooltip_smith_CharcoalProgression") .. "0%";
            else
                tooltip.description = getText("Tooltip_smith_CharcoalProgression") .. (round((metalDrumLuaObj.charcoalTick / 12) * 100)) .. "%";
            end
        end
        if metalDrumIsoObj:getWaterAmount() > 0 or (metalDrumLuaObj.haveLogs and metalDrumLuaObj.isLit) then
            option.toolTip = tooltip
        end
        if metalDrumIsoObj:getWaterAmount() > 0 then
            subMenuDrum:addOption(getText("ContextMenu_Empty"), worldobjects, SFBlacksmithMenu.onEmptyDrum, metalDrumLuaObj, playerObj);
        else
            if not metalDrumLuaObj.haveLogs and not metalDrumLuaObj.haveCharcoal then
                subMenuDrum:addOption(getText("ContextMenu_Remove"), worldobjects, SFBlacksmithMenu.onRemoveDrum, metalDrumIsoObj, playerObj);
                local addWoodOption = subMenuDrum:addOption(getText("ContextMenu_AddLogs"), worldobjects, SFBlacksmithMenu.onAddLogs, metalDrumLuaObj, playerObj);
                local tooltip = ISWorldObjectContextMenu.addToolTip()
                tooltip:setName(getText("ContextMenu_AddLogs"))
                tooltip.description = getText("Tooltip_smith_AddLogs");
                addWoodOption.toolTip = tooltip
		local logCount = ISBuildMenu.countMaterial(player, "Base.Log")
                if logCount < 5 then
                   addWoodOption.notAvailable = true;
                end
            else
                if metalDrumLuaObj.isLit then
                    subMenuDrum:addOption(getText("ContextMenu_Put_out_fire"), worldobjects, SFBlacksmithMenu.onPutOutFireDrum, metalDrumLuaObj, playerObj);
                elseif not metalDrumLuaObj.isLit and not metalDrumLuaObj.haveCharcoal then
                    subMenuDrum:addOption(getText("ContextMenu_Remove"), worldobjects, SFBlacksmithMenu.onRemoveDrum, metalDrumLuaObj, playerObj);
                    subMenuDrum:addOption(getText("ContextMenu_RemoveLogs"), worldobjects, SFBlacksmithMenu.onRemoveLogs, metalDrumLuaObj, playerObj);
                end
            end
            if metalDrumLuaObj.haveCharcoal then
                subMenuDrum:addOption(getText("ContextMenu_RemoveCharcoal"), worldobjects, SFBlacksmithMenu.onRemoveCharcoal, metalDrumLuaObj, playerObj);
            end
        end
    end
end

SFBlacksmithMenu.onRemoveCharcoal = function(worldobjects, metalDrum, player)
    if luautils.walkAdj(player, metalDrum:getSquare()) then
        ISTimedActionQueue.add(ISRemoveCharcoal:new(player, metalDrum))
    end
end

SFBlacksmithMenu.onPutOutFireDrum = function(worldobjects, metalDrum, player)
    if luautils.walkAdj(player, metalDrum:getSquare()) then
        ISTimedActionQueue.add(ISPutOutFireDrum:new(player, metalDrum))
    end
end

SFBlacksmithMenu.onRemoveLogs = function(worldobjects, metalDrum, player)
    if luautils.walkAdj(player, metalDrum:getSquare()) then
        ISTimedActionQueue.add(ISAddLogsInDrum:new(player, metalDrum, false))
    end
end

SFBlacksmithMenu.onAddLogs = function(worldobjects, metalDrum, player)
    if luautils.walkAdj(player, metalDrum:getSquare()) then
        ISTimedActionQueue.add(ISAddLogsInDrum:new(player, metalDrum, true))
    end
end

SFBlacksmithMenu.onRemoveDrum = function(worldobjects, metalDrum, player)
    if luautils.walkAdj(player, metalDrum:getSquare()) then
        ISTimedActionQueue.add(ISRemoveDrum:new(player, metalDrum))
    end
end

SFBlacksmithMenu.onEmptyDrum = function(worldobjects, metalDrum, playerObj)
    if luautils.walkAdj(playerObj, metalDrum:getSquare()) then
        ISTimedActionQueue.add(ISEmptyDrum:new(playerObj, metalDrum))
    end
end

SFBlacksmithMenu.addToolTip = function(option, name, texture)
    local toolTip = ISToolTip:new();
    toolTip:initialise();
    toolTip:setVisible(false);
    option.toolTip = toolTip;
    toolTip:setName(name);
    toolTip.description = " ";
    toolTip:setTexture(texture);
    toolTip.footNote = getText("Tooltip_craft_pressToRotate", Keyboard.getKeyName(getCore():getKey("Rotate building")))
    return toolTip;
end

SFBlacksmithMenu.getMetal = function(player, amount)
    local totalMetal = 0;
    local ingots = {};
    local containers = ISInventoryPaneContextMenu.getContainers(player)
    for i=1,containers:size() do
        local container = containers:get(i-1)
        for j=1,container:getItems():size() do
            local item = container:getItems():get(j-1);
            if item:getType() == "IronIngot" then
                totalMetal = totalMetal + item:getUsedDelta() / item:getUseDelta();
                table.insert(ingots, item);
                if totalMetal >= amount then
                    return ingots, round(amount,0);
                end
            end
        end
    end
    return nil, round(totalMetal,0);
end

SFBlacksmithMenu.onInfo = function(worldobjects, furnace, player)
    if luautils.walkAdj(player, furnace:getSquare()) then
        ISTimedActionQueue.add(ISFurnaceInfoAction:new(player, furnace))
    end
end

SFBlacksmithMenu.onUseBellows = function(worldobjects, furnace, bellows, player)
    if luautils.walkAdj(player, furnace:getSquare()) then
        ISTimedActionQueue.add(ISUseBellows:new(furnace, bellows, player))
    end
end

SFBlacksmithMenu.onStopFire = function(worldobjects, furnace, playerObj)
    if luautils.walkAdj(playerObj, furnace:getSquare()) then
        ISTimedActionQueue.add(ISStopFurnaceFire:new(furnace, playerObj))
    end
end

SFBlacksmithMenu.onAddFuel = function(worldobjects, furnace, coal, playerObj)
	ISInventoryPaneContextMenu.transferIfNeeded(playerObj, coal)
	if not AdjacentFreeTileFinder.isTileOrAdjacent(playerObj:getCurrentSquare(), furnace:getSquare()) then
		local adjacent = AdjacentFreeTileFinder.Find(furnace:getSquare(), playerObj)
		if adjacent then
			ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, adjacent))
			ISTimedActionQueue.add(ISAddCoalInFurnace:new(furnace, coal, playerObj))
			return
		end
	else
		ISTimedActionQueue.add(ISAddCoalInFurnace:new(furnace, coal, playerObj))
	end
end

SFBlacksmithMenu.onStoneFurnace = function(worldobjects, player)
    local furniture = ISBSFurnace:new("Stone Furnace", "crafted_01_42", "crafted_01_43");
    furniture.modData["need:Base.Stone"] = "15";
    furniture.player = player
    getCell():setDrag(furniture, player);
end

SFBlacksmithMenu.onAnvil = function(worldobjects, player)
    local furniture = ISAnvil:new("Anvil", getSpecificPlayer(player), "crafted_01_19", "crafted_01_19");
    furniture.modData["need:Base.Log"] = "1";
    furniture.player = player
    furniture.completionSound = "BuildWoodenStructureLarge";
    getCell():setDrag(furniture, player);
end

SFBlacksmithMenu.onMetalDrum = function(worldobjects, player, sprite)
    local barrel = ISMetalDrum:new(player, sprite);
    barrel.modData["need:Base.MetalDrum"] = "1";
    barrel.player = player
    getCell():setDrag(barrel, player);
end

SFBlacksmithMenu.onLightFromPetrol = function(worldobjects, player, lighter, petrol, furnace)
    local playerObj = getSpecificPlayer(player)
    ISCampingMenu.toPlayerInventory(playerObj, lighter)
    ISCampingMenu.toPlayerInventory(playerObj, petrol)
    if luautils.walkAdj(playerObj, furnace:getSquare(), true) then
        ISTimedActionQueue.add(ISFurnaceLightFromPetrol:new(playerObj, furnace, lighter, petrol, 20));
    end
end

SFBlacksmithMenu.onLightFromLiterature = function(worldobjects, player, literature, lighter, furnace, fuelAmt)
    local playerObj = getSpecificPlayer(player)
    ISCampingMenu.toPlayerInventory(playerObj, literature)
    ISCampingMenu.toPlayerInventory(playerObj, lighter)
    if luautils.walkAdj(playerObj, furnace:getSquare(), true) then
        if playerObj:isEquipped(literature) then
            ISTimedActionQueue.add(ISUnequipAction:new(playerObj, literature, 50));
        end
        ISTimedActionQueue.add(ISFurnaceLightFromLiterature:new(playerObj, literature, lighter, furnace, fuelAmt, 100));
    end
end

SFBlacksmithMenu.onLightFromKindle = function(worldobjects, player, percedWood, stickOrBranch, furnace)
    local playerObj = getSpecificPlayer(player)
    ISCampingMenu.toPlayerInventory(playerObj, percedWood)
    ISCampingMenu.toPlayerInventory(playerObj, stickOrBranch)
    if luautils.walkAdj(playerObj, furnace:getSquare(), true) then
        ISTimedActionQueue.add(ISFurnaceLightFromKindle:new(playerObj, percedWood, stickOrBranch, furnace, 1500));
    end
end

SFBlacksmithMenu.onLightDrumFromPetrol = function(worldobjects, player, lighter, petrol, metalDrum)
    local playerObj = getSpecificPlayer(player)
    ISCampingMenu.toPlayerInventory(playerObj, lighter)
    ISCampingMenu.toPlayerInventory(playerObj, petrol)
    if luautils.walkAdj(playerObj, metalDrum:getSquare(), true) then
        ISTimedActionQueue.add(ISDrumLightFromPetrol:new(playerObj, metalDrum, lighter, petrol, 20));
    end
end

SFBlacksmithMenu.onLightDrumFromLiterature = function(worldobjects, player, literature, lighter, metalDrum, fuelAmt)
    local playerObj = getSpecificPlayer(player)
    ISCampingMenu.toPlayerInventory(playerObj, literature)
    ISCampingMenu.toPlayerInventory(playerObj, lighter)
    if luautils.walkAdj(playerObj, metalDrum:getSquare(), true) then
        if playerObj:isEquipped(literature) then
            ISTimedActionQueue.add(ISUnequipAction:new(playerObj, literature, 50));
        end
        ISTimedActionQueue.add(ISDrumLightFromLiterature:new(playerObj, literature, lighter, metalDrum, fuelAmt, 100));
    end
end

SFBlacksmithMenu.onLightDrumFromKindle = function(worldobjects, player, percedWood, stickOrBranch, metalDrum)
    local playerObj = getSpecificPlayer(player)
    ISCampingMenu.toPlayerInventory(playerObj, percedWood)
    ISCampingMenu.toPlayerInventory(playerObj, stickOrBranch)
    if luautils.walkAdj(playerObj, metalDrum:getSquare(), true) then
        ISTimedActionQueue.add(ISDrumLightFromKindle:new(playerObj, percedWood, stickOrBranch, metalDrum, 1500));
    end
end

Events.OnFillWorldObjectContextMenu.Add(SFBlacksmithMenu.doBuildMenu);
SFBlacksmithMenu.metalForAnvil = 500;
