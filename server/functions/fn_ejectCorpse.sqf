// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2015 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: fn_ejectCorpse.sqf
//	@file Author: AgentRev

private ["_corpse", "_veh", "_pos", "_targetPos"];
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

_targetPos = getPosWorld _veh;
_targetPos set [2, ((_corpse modelToWorld [0,0,0]) select 2)];

if (_veh != _corpse && !(alive _veh)) then
{
	_targetPos = _targetPos vectorAdd ([[0, _veh call fn_vehSafeDistance, 1], -([_veh, _corpse] call BIS_fnc_dirTo)] call BIS_fnc_rotateVector2D);
};

_targetPos = [_targetPos, 1, 6, 1, 1, 10, 0] call BIS_fnc_findSafePos; 
_targetPos set [2, ((_corpse modelToWorld [0,0,0]) select 2)];
_corpse setPos _targetPos;
_corpse setVariable ["A3W_corpseEjected", true, true];
