// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_AbandonedJet.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "militaryMissionDefines.sqf";

private ["_vehicle", "_variant", "_safePos", "_vehicleName", "_vehDeterminer", "_vehicleClass"];

_setupVars =
{
	_vehicleClass = if (random 100 >= 80) then
	{
		[["B_Plane_Fighter_01_F","blackwaspCAS"],["O_Plane_Fighter_02_F","shikraCAS"],["I_Plane_Fighter_04_F","gryphonCAS"]] call BIS_fnc_selectRandom;
	} else
	{
		[["I_Plane_Fighter_03_dynamicLoadout_F", "buzzardCAS"], ["B_Plane_CAS_01_dynamicLoadout_F", "wipeoutCAS"],["O_Plane_CAS_02_dynamicLoadout_F", "neophronCAS"]] call BIS_fnc_selectRandom;
	};
	_missionType = "Abandoned Jet";
	_locationsArray = JetMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_variant = _vehicleClass select 1;
	_vehicleClass = _vehicleClass select 0;
	_safePos = [_missionPos, 0, 30, 5, 0, 0, 0] call findSafePos;
	_vehicle = [_vehicleClass, _safePos, 0.5, 1, 0.25, "NONE", _variant] call createMissionVehicle;
	_vehicle setDir (markerDir _missionLocation);
	reload _vehicle;

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_safePos,12,15] spawn createCustomGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _vehicleClass >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _vehicleClass >> "displayName");

	_vehDeterminer = if ("AEIMO" find (_vehicleName select [0,1]) != -1) then { "An" } else { "A" };

	_missionHintText = format ["%1 <t color='%3'>%2</t> has been immobilized, go get it for your team!", _vehDeterminer, _vehicleName, militaryMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = {!alive _vehicle};

_failedExec =
{
	// Mission failed
	deleteVehicle _vehicle;
};

_successExec =
{
	// Mission completed
	[_vehicle, 1] call A3W_fnc_setLockState;
	_successHintMessage = format ["The %1 has been captured, well done.", _vehicleName];
};

_this call militaryMissionProcessor;