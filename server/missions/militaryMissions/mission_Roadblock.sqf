// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright � 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_Roadblock.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "militaryMissionDefines.sqf";

private [ "_markerDir", "_baseToDelete", "_boxTypes", "_box2Type", "_box1", "_box2", "_outpost", "_objects"];

_setupVars =
{
	_missionType = "Roadblock";
	_locationsArray = RoadblockMissionMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_markerDir = markerDir _missionLocation;

	//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 25];
	{ deleteVehicle _x } forEach _baseToDelete;
	
	_outpost = (call compile preprocessFileLineNumbers "server\missions\outposts\roadblocksList.sqf") call BIS_fnc_selectRandom;
	_objects = [_outpost, _missionPos, _markerDir] call createOutpost;

	_boxTypes = ["mission_USRifles","mission_RURifles","mission_PDW","mission_Explosive","mission_Gear","mission_Militia"];
	_box1Type = _boxTypes call BIS_fnc_selectRandom;
	_box1 = createVehicle ["Box_NATO_Wps_F", _missionPos, [], 5, "None"];
	_box1 setDir random 360;
	[_box1, _box1Type] call fn_refillbox;

	_box2Type = _boxTypes call BIS_fnc_selectRandom;
	_box2 = createVehicle ["Box_NATO_Wps_F", _missionPos, [], 5, "None"];
	_box2 setDir random 360;
	[_box2, _box2Type] call fn_refillbox;
	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach _objects;
	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_box1, _box2];

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM }, 15] spawn createpoliceGroup;
	
	_missionHintText = format ["Enemies have set up an illegal roadblock and are stopping all vehicles! They need to be stopped!", militaryMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach _objects;
	
};

_successExec =
{
	// Mission completed
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach _objects;
	[_locationsArray, _missionLocation, _objects] call setLocationObjects;

	_successHintMessage = format ["The roadblock has been dismantled."];
};

_this call militaryMissionProcessor;