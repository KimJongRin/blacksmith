local manager = ScriptManager.instance

function SFSmith_Tweaks()

-- Changes to weight
manager:getItem("Base.IronIngot"):DoParam("Weight".." = ".."2");

-- Changes to metal value
manager:getItem("Base.BarBell"):DoParam("MetalValue".." = ".."100");
manager:getItem("Base.Bell"):DoParam("MetalValue".." = ".."20");
manager:getItem("Base.Belt2"):DoParam("MetalValue".." = ".."5");
manager:getItem("Base.BreadKnife"):DoParam("MetalValue".." = ".."15");
manager:getItem("Base.ButterKnife"):DoParam("MetalValue".." = ".."10");
manager:getItem("Base.ClosedUmbrellaBlack"):DoParam("MetalValue".." = ".."20");
manager:getItem("Base.ClosedUmbrellaBlue"):DoParam("MetalValue".." = ".."20");
manager:getItem("Base.ClosedUmbrellaRed"):DoParam("MetalValue".." = ".."20");
manager:getItem("Base.ClosedUmbrellaWhite"):DoParam("MetalValue".." = ".."20");
manager:getItem("Base.DumbBell"):DoParam("MetalValue".." = ".."75");
manager:getItem("Base.Fork"):DoParam("MetalValue".." = ".."10");
manager:getItem("Base.GardenHoe"):DoParam("MetalValue".." = ".."40");
manager:getItem("Base.Golfclub"):DoParam("MetalValue".." = ".."75");
manager:getItem("Base.HandAxe"):DoParam("MetalValue".." = ".."30");
manager:getItem("Base.HandFork"):DoParam("MetalValue".." = ".."10");
manager:getItem("Base.HandScythe"):DoParam("MetalValue".." = ".."20");
manager:getItem("Base.HolePuncher"):DoParam("MetalValue".." = ".."10");
manager:getItem("Base.IcePick"):DoParam("MetalValue".." = ".."20");
manager:getItem("Base.Jack"):DoParam("MetalValue".." = ".."80");
manager:getItem("Base.Katana"):DoParam("MetalValue".." = ".."60");
manager:getItem("Base.KitchenKnife"):DoParam("MetalValue".." = ".."15");
manager:getItem("Base.KitchenTongs"):DoParam("MetalValue".." = ".."15");
manager:getItem("Base.LeadPipe"):DoParam("MetalValue".." = ".."60");
manager:getItem("Base.LeafRake"):DoParam("MetalValue".." = ".."30");
manager:getItem("Base.LugWrench"):DoParam("MetalValue".." = ".."50");
manager:getItem("Base.Machete"):DoParam("MetalValue".." = ".."50");
manager:getItem("Base.MeatCleaver"):DoParam("MetalValue".." = ".."30");
manager:getItem("Base.MetalBar"):DoParam("MetalValue".." = ".."60");
manager:getItem("Base.MetalPipe"):DoParam("MetalValue".." = ".."60");
manager:getItem("Base.PaintbucketEmpty"):DoParam("MetalValue".." = ".."40");
manager:getItem("Base.PipeWrench"):DoParam("MetalValue".." = ".."60");
manager:getItem("Base.Rake"):DoParam("MetalValue".." = ".."30");
manager:getItem("Base.Saxophone"):DoParam("MetalValue".." = ".."50");
manager:getItem("Base.Scalpel"):DoParam("MetalValue".." = ".."10");
manager:getItem("Base.Scissors"):DoParam("MetalValue".." = ".."10");
manager:getItem("Base.Spatula"):DoParam("MetalValue".." = ".."10");
--manager:getItem("Base.Spanner"):DoParam("MetalValue".." = ".."40");
manager:getItem("Base.Spoon"):DoParam("MetalValue".." = ".."10");
manager:getItem("Base.TinOpener"):DoParam("MetalValue".." = ".."15");
manager:getItem("Base.Toolbox"):DoParam("MetalValue".." = ".."50");
manager:getItem("Base.Trumpet"):DoParam("MetalValue".." = ".."30");
manager:getItem("Base.Tweezers"):DoParam("MetalValue".." = ".."1");
manager:getItem("Base.WoodAxe"):DoParam("MetalValue".." = ".."30");
manager:getItem("Base.Wrench"):DoParam("MetalValue".." = ".."30");
manager:getItem("Base.UnusableMetal"):DoParam("MetalValue".." = ".."15");

manager:getItem("camping.CampingTent"):DoParam("MetalValue".." = ".."40"); 
manager:getItem("camping.TentPeg"):DoParam("MetalValue".." = ".."10");

manager:getItem("farming.HandShovel"):DoParam("MetalValue".." = ".."10");
end

Events.OnGameBoot.Add(SFSmith_Tweaks)