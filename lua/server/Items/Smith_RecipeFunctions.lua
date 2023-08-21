require 'recipecode'

function Gunpowder_OnCreate(items, result, player)
	result:setUsedDelta(result:getUseDelta());
end

-- OnCreate for weapons

function SFWeapon_OnCreate(items, result, player)
    local ballPeen = player:getInventory():contains("BallPeenHammer");

    if instanceof(result, "HandWeapon") then
        local condPerc = ZombRand(5 + (player:getPerkLevel(Perks.Smithing) * 5), 10 + (player:getPerkLevel(Perks.Smithing) * 10));
        if not ballPeen then
            condPerc = condPerc - 20;
        end
        if condPerc < 5 then
            condPerc = 5;
        elseif condPerc > 100 then
            condPerc = 100;
        end
        result:setCondition(round(result:getConditionMax() * (condPerc/100)));
    end
end


--Smithing XP Functions

function Recipe.OnGiveXP.Smithing5(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Smithing, 5);
end

function Recipe.OnGiveXP.Smithing10(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Smithing, 10);
end

function Recipe.OnGiveXP.Smithing15(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Smithing, 15);
end

function Recipe.OnGiveXP.Smithing20(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Smithing, 20);
end

function Recipe.OnGiveXP.Smithing25(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Smithing, 25);
end