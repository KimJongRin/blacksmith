--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISStopFurnaceFire = ISBaseTimedAction:derive("ISStopFurnaceFire");

function ISStopFurnaceFire:isValid()
	return true;
end

function ISStopFurnaceFire:update()
	self.character:faceThisObject(self.furnace)
end

function ISStopFurnaceFire:start()
	self:setActionAnim("Loot");
end

function ISStopFurnaceFire:stop()
	ISBaseTimedAction.stop(self);
end

function ISStopFurnaceFire:perform()
	self.furnace:setFireStarted(false);
    	self.furnace:syncFurnace();
	self.furnace:getContainer():requestSync();

	ISBaseTimedAction.perform(self);
end

function ISStopFurnaceFire:new(furnace, character)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.stopOnWalk = true;
	o.stopOnRun = true;
    	o.character = character;
	o.maxTime = 30;
	o.furnace = furnace
	return o;
end
