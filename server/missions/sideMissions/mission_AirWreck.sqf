// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_AirWreck.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_wreck", "_box1", "_box2"];

_setupVars =
{
	_missionType = "Aircraft Wreck";
	_locationsArray = [ForestMissionMarkers, MissionSpawnMarkers] select (ForestMissionMarkers isEqualTo []);
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_wreckPos = _missionPos vectorAdd ([[random 10, 0, 0], random 360] call BIS_fnc_rotateVector2D);
	_types = ["B_T_VTOL_01_vehicle_F", "O_T_VTOL_02_infantry_dynamicLoadout_F", "I_Heli_Transport_02_F", "O_Heli_Light_02_unarmed_F"];
	_type = _types call BIS_fnc_selectRandom;

	_baseToDelete = nearestObjects [_wreckPos, ["All"], 10];
	{ deleteVehicle _x } forEach _baseToDelete;

	// Class, Position, Fuel, Ammo, Damage, Special
	_wreck = [_type, _wreckPos, 0, 0, 0] call createMissionVehicle;
	_wreck setDir random 360;
	_wreck setDamage 1;

	_boxTypes = ["mission_USLaunchers","mission_RULaunchers","mission_USSpecial","mission_USRifles","mission_RURifles","mission_Explosive","mission_Gear","mission_Militia"];
	_box1Type = _boxTypes call BIS_fnc_selectRandom;
	_box1 = createVehicle ["Box_NATO_WpsSpecial_F", _missionPos, [], 2, "None"];
	_box1 setDir random 360;
	[_box1, _box1Type] call fn_refillbox;

	_box2Type = _boxTypes call BIS_fnc_selectRandom;
	_box2 = createVehicle ["Box_East_WpsSpecial_F", _missionPos, [], 2, "None"];
	_box2 setDir random 360;
	[_box2, _box2Type] call fn_refillbox;

	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_box1, _box2];

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, _nbUnits] call createCustomGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> typeOf _wreck >> "picture");
	_missionHintText = "An aircraft has come down under enemy fire!";
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2, _wreck];
};

_successExec =
{
	// Mission completed
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];
	deleteVehicle _wreck;

	_successHintMessage = "The airwreck supplies have been collected, well done.";
};

_this call sideMissionProcessor;
