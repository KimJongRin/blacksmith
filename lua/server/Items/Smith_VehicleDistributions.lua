require 'Vehicles/VehicleDistributions'

VehicleDistributions.SmitherTruckBed = {
	rolls = 4,
	items = {
		"ScrapMetal", 1,
		"ScrapMetal", 1,
		"filcher.SFIronIngot", 2,
		"filcher.SFIronIngot", 2,
		"filcher.SFIronIngot", 2,
		"BallpeenHammer", 5,
		"Hammer", 2,
		"Tongs", 5,
		"Tongs", 0.5,
		"SheetMetal", 2,
		"SheetMetal", 2,
		"SmallSheetMetal", 2,
		"SmallSheetMetal", 2,
		"SmallSheetMetal", 2,
		"Charcoal", 3,
		"Charcoal", 2,
		"BookMetalWelding1", 1,
		"BookMetalWelding2", 0.5,
		"BookMetalWelding3", 0.4,
		"BookMetalWelding4", 0.3,
		"BookMetalWelding5", 0.1,
	}
}

VehicleDistributions.Smither = {
	TruckBed = VehicleDistributions.SmitherTruckBed;
	
	TruckBedOpen = VehicleDistributions.SmitherTruckBed;
	
	GloveBox = {
		rolls = 1,
		items = {
			"Wallet", 1,
			"BookMetalWelding1", 5,
			"BookMetalWelding2", 4,
			"BookMetalWelding3", 3,
			"BookMetalWelding4", 1.5,
			"BookMetalWelding5", 1,
			"SmithingMag1", 2,
			"SmithingMag2", 2,
			"SmithingMag3", 2,
			"SmithingMag4", 2,
			"filcher.SmithingMag5", 2,
			"filcher.SmithingMag6", 2,
			"filcher.SmithingMag7", 2,
			"filcher.SmithingMag9", 1,
			"filcher.SmithingMag11", 1,
		}
	},
	
	SeatRearLeft = VehicleDistributions.Seat;
	SeatRearRight = VehicleDistributions.Seat;
}

--Metal Welder
table.insert(VehicleDistributions["MetalWelderTruckBed"].items, "filcher.SFIronIngot");
table.insert(VehicleDistributions["MetalWelderTruckBed"].items, 1);
table.insert(VehicleDistributions["MetalWelderTruckBed"].items, "filcher.SFIronIngot");
table.insert(VehicleDistributions["MetalWelderTruckBed"].items, 1);

--Postal
table.insert(VehicleDistributions["Postal"]["TruckBed"].items, "SmithingMag1");
table.insert(VehicleDistributions["Postal"]["TruckBed"].items, 1);
table.insert(VehicleDistributions["Postal"]["TruckBed"].items, "SmithingMag2");
table.insert(VehicleDistributions["Postal"]["TruckBed"].items, 1);
table.insert(VehicleDistributions["Postal"]["TruckBed"].items, "SmithingMag3");
table.insert(VehicleDistributions["Postal"]["TruckBed"].items, 1);
table.insert(VehicleDistributions["Postal"]["TruckBed"].items, "SmithingMag4");
table.insert(VehicleDistributions["Postal"]["TruckBed"].items, 1);
table.insert(VehicleDistributions["Postal"]["TruckBed"].items, "filcher.SmithingMag5");
table.insert(VehicleDistributions["Postal"]["TruckBed"].items, 1);
table.insert(VehicleDistributions["Postal"]["TruckBed"].items, "filcher.SmithingMag6");
table.insert(VehicleDistributions["Postal"]["TruckBed"].items, 1);
table.insert(VehicleDistributions["Postal"]["TruckBed"].items, "filcher.SmithingMag7");
table.insert(VehicleDistributions["Postal"]["TruckBed"].items, 1);
table.insert(VehicleDistributions["Postal"]["TruckBed"].items, "filcher.SmithingMag9");
table.insert(VehicleDistributions["Postal"]["TruckBed"].items, 1);
table.insert(VehicleDistributions["Postal"]["TruckBed"].items, "filcher.SmithingMag11");
table.insert(VehicleDistributions["Postal"]["TruckBed"].items, 1);

--Distributions
table.insert(VehicleDistributions[1]["CarStationWagon"].Specific, VehicleDistributions.Smither); --throwing an error, nontable null?
--[[
table.insert(VehicleDistributions[1]["CarStationWagon"].Specific, VehicleDistributions.Smither);
table.insert(VehicleDistributions[1]["CarStationWagon2"].Specific, VehicleDistributions.Smither);
table.insert(VehicleDistributions[1]["Van"].Specific, VehicleDistributions.Smither);
table.insert(VehicleDistributions[1]["StepVan"].Specific, VehicleDistributions.Smither);
table.insert(VehicleDistributions[1]["OffRoad"].Specific, VehicleDistributions.Smither);
table.insert(VehicleDistributions[1]["SUV"].Specific, VehicleDistributions.Smither);
table.insert(VehicleDistributions[1]["PickUpVan"].Specific, VehicleDistributions.Smither);
table.insert(VehicleDistributions[1]["PickUpVanLights"].Specific, VehicleDistributions.Smither);
table.insert(VehicleDistributions[1]["PickUpTruck"].Specific, VehicleDistributions.Smither);
table.insert(VehicleDistributions[1]["PickUpTruckLights"].Specific, VehicleDistributions.Smither);
]]--