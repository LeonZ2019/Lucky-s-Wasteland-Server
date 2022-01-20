// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2015 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: fn_ejectCorpse.sqf
//	@file Author: AgentRev

private ["_corpse", "_veh", "_pos"];
_corpse = _this;
_veh = vehicle _corpse;

waitUntil
{
	sleep 0.1;

	_veh = objectParent _corpse;
	if (isNull _veh) then { _veh = _corpse };

	_pos = getPos _veh;
	((isTouchingGround _veh || _pos select 2 < 5) && vectorMagnitude velocity _veh < [1,5] select surfaceIsWater _pos)
};

moveOut _corpse;
_corpse setVariable ["A3W_corpseEjected", true, true];