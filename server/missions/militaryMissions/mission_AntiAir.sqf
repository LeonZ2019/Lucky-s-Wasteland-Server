// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright � 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_AntiAir.sqf

if (!isServer) exitwith {};
#include "militaryMissionDefines.sqf";

private [ "_markerDir", "_baseToDelete", "_boxTypes", "_box2Type", "_box1", "_box2", "_outpost", "_objects", "_antiAirVehicles", "_soldier"];

_setupVars =
{
	_missionType = "Anti Aircraft Bunker";
	_locationsArray = MissionSpawnMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_markerDir = markerDir _missionLocation;

	//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 25];
	{ deleteVehicle _x } forEach _baseToDelete;
	
	_bunker = (call compile preprocessFileLineNumbers "server\missions\outposts\antiAircraftBunkerList.sqf") call BIS_fnc_selectRandom;
	_objects = [_bunker, _missionPos, _markerDir] call createOutpost;
	_antiAirVehicles = ["B_APC_Tracked_01_AA_F", "O_APC_Tracked_02_AA_F", "I_LT_01_AA_F", "B_Radar_System_01_F", "I_E_Radar_System_01_F", "O_Radar_System_02_F", "B_SAM_System_03_F", "I_E_SAM_System_03_F", "O_SAM_System_04_F", "B_SAM_System_02_F", "B_SAM_System_01_F", "B_AAA_System_01_F"];
	_boxTypes = ["mission_USRifles","mission_RURifles"];
	_box1Type = _boxTypes call BIS_fnc_selectRandom;
	_box1 = createVehicle ["Box_NATO_Wps_F", _missionPos, [], 5, "None"];
	_box1 setDir random 360;
	[_box1, _box1Type] call fn_refillbox;
	_box1 addItemCargoGlobal ["FileTopSecret", 1];
	_box2Type = _boxTypes call BIS_fnc_selectRandom;
	_box2 = createVehicle ["Box_NATO_Wps_F", _missionPos, [], 5, "None"];
	_box2 setDir random 360;
	[_box2, _box2Type] call fn_refillbox;
	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_box1, _box2];
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, 20, 30] spawn createCustomGroup;
    _aiGroup setBehaviour "COMBAT";
	{
		_x setVariable ["R3F_LOG_disabled", true, true];
		if (typeOf _x in _antiAirVehicles) then
		{
			if (!(_x isKindOf "StaticWeapon") && _x isKindOf "LandVehicle") then
			{
				_soldier = [_aiGroup, _missionPos] call createRandomPolice;
				_aiGroup addVehicle _x;
				_soldier moveInGunner _x;
			};
			[_x, _aiGroup] spawn checkMissionVehicleLock;
			_x setUnloadInCombat [false, false];
		};
	} forEach _objects;
	_missionHintText = format ["Enemies have set up an anti aircraft bunker, go destroy them!", militaryMissionColor];
};

_ignoreAiDeaths = true;
_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;
_waitUntilSuccessCondition = {
    { typeOf _x in _antiAirVehicles && alive _x } count _objects == 0
};

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach _objects;
    { deleteVehicle _x } forEach [_box1, _box2];
};

_successExec =
{
	// Mission completed
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];
	if ((_box2 getVariable ["artillery", 0]) == 0) then
	{
		_box2 setVariable ["artillery", 1, true];
	};
	[_locationsArray, _missionLocation, _objects] call setLocationObjects;

	_successHintMessage = format ["The bunker has been abandoned."];
};

_this call militaryMissionProcessor;