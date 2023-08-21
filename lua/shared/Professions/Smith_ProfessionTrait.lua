function Smith_AddProfession()
	local smither = ProfessionFactory.addProfession("smither", getText("UI_prof_Smither"), "profession_smither", -6);
	smither:addXPBoost(Perks.Smithing, 3);
	smither:getFreeRecipes():add("Make Stone Furnace");
	smither:getFreeRecipes():add("Make Anvil");
	smither:getFreeRecipes():add("Make Baking Tray");
	smither:getFreeRecipes():add("Make Bread Knife");
	smither:getFreeRecipes():add("Make Butter Knife");
	smither:getFreeRecipes():add("Make Can Opener");
	smither:getFreeRecipes():add("Make Cooking Pot");
	smither:getFreeRecipes():add("Make Fork");
	smither:getFreeRecipes():add("Make Griddle Pan");
	smither:getFreeRecipes():add("Make Hammer");
	smither:getFreeRecipes():add("Make Hinge");
	smither:getFreeRecipes():add("Make Ice Pick");
	smither:getFreeRecipes():add("Make Jar Lid");
	smither:getFreeRecipes():add("Make Kettle");
	smither:getFreeRecipes():add("Make Metal Bar");
	smither:getFreeRecipes():add("Make Metal Pipe");
	smither:getFreeRecipes():add("Make Nails");
	smither:getFreeRecipes():add("Make Tongs");
	smither:getFreeRecipes():add("Make Pan");
	smither:getFreeRecipes():add("Make Roasting Pan");
	smither:getFreeRecipes():add("Make Saucepan");
	smither:getFreeRecipes():add("Make Scissors");
	smither:getFreeRecipes():add("Make Screwdriver");
	smither:getFreeRecipes():add("Make Spoon");
	smither:getFreeRecipes():add("Make Tent Peg");

	local profList = ProfessionFactory.getProfessions()
	for i=1,profList:size() do
		local prof = profList:get(i-1)
		BaseGameCharacterDetails.SetProfessionDescription(prof)
	end
end

Events.OnGameBoot.Add(Smith_AddProfession);