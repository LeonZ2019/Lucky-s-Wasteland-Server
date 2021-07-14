// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_Sniper.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "militaryMissionDefines.sqf";

private ["_positions", "_boxes1", "_currBox1", "_box1", "_box2"];

_setupVars =
{
	_missionType = "Sniper Nest";
	_locationsArray = SniperMissionMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_missionPos] spawn createsniperGroup;

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";
	
	_boxTypes = ["mission_USLaunchers","mission_RULaunchers","mission_USMachineguns","mission_RUMachineguns","mission_Main_A3snipers","mission_RUSniper","mission_Explosive"];
	_box1Type = _boxTypes call BIS_fnc_selectRandom;
	_boxes1 = ["Box_East_WpsSpecial_F","Box_IND_WpsSpecial_F"];
	_currBox1 = _boxes1 call BIS_fnc_selectRandom;
	_box1 = createVehicle [_currBox1, _missionPos, [], 5, "None"];
	[_box1, _box1Type] call fn_refillbox;

	_box2Type = _boxTypes call BIS_fnc_selectRandom;
	_currBox2 = _boxes1 call BIS_fnc_selectRandom;
	_box2 = createVehicle [_currBox2, _missionPos, [], 5, "None"];
	[_box2, _box2Type] call fn_refillbox;
	{ _x setVariable ["R3F_LOG_disabled", true, true]; _x setDir random 360; } forEach [_box1, _box2];
	
	_missionHintText = format ["A Sniper Nest has been spotted. Head to the marked area and Take them out! Be careful they are fully armed and dangerous!", militaryMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec = 
{
	// Mission failed
	deleteVehicle _box1;
};

_successExec =
{
	// Mission completed
	{ _x setVariable ["R3F_LOG_disabled", true, true];} forEach [_box1, _box2];
	_successHintMessage = format ["The snipers are dead! Well Done!"];
};

_this call militaryMissionProcessor;