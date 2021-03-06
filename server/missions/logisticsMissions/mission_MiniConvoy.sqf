// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 2.1
//	@file Name: mission_MiniConvoy.sqf
//	@file Author: JoSchaap / routes by Del1te - (original idea by Sanjo), AgentRev
//	@file Created: 31/08/2013 18:19

if (!isServer) exitwith {};
#include "logisticsMissionDefines.sqf";

private ["_convoyVeh", "_veh1", "_veh2", "_veh3", "_camo", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_box1", "_box2", "_boxTypes", "_box1Type", "_box2Type"];

_setupVars =
{
	_missionType = "Truck Convoy";
	_locationsArray = LandConvoyPaths;
};

_setupObjects =
{
	private ["_starts", "_startDirs", "_waypoints"];
	call compile preprocessFileLineNumbers format ["mapConfig\convoys\%1.sqf", _missionLocation];

	// pick the vehicles for the convoy
	_convoyVeh = if (missionDifficultyHard) then
	{
		["I_G_Offroad_01_armed_F", "I_Truck_02_transport_F", "I_G_Offroad_01_F"]
	}
	else
	{
		[
			["B_MRAP_01_hmg_F", "B_Truck_01_transport_F", "B_MRAP_01_hmg_F"],
			["O_MRAP_02_hmg_F", "O_Truck_02_transport_F", "O_MRAP_02_hmg_F"],
			["I_MRAP_03_hmg_F", "I_Truck_02_transport_F", "I_MRAP_03_hmg_F"]
		] call BIS_fnc_selectRandom;
	};

	_veh1 = _convoyVeh select 0;
	_veh2 = _convoyVeh select 1;
	_veh3 = _convoyVeh select 2;
	_camo = ["MTP", "Tropic", "CTRGUrban", "CTRGArid", "CTRGTropic", "Woodland", "GreenHex", "Hex", "Green", "Taiga", "Digital", "Geometric", "Guerilla"] call BIS_fnc_selectRandom;

	_createVehicle =
	{
		private ["_type", "_position", "_direction", "_vehicle", "_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "None"];
		_vehicle setVariable ["R3F_LOG_disabled", true, true];
		_vehicle setVariable ["A3W_skipAutoSave", true, true];
		[_vehicle] call vehicleSetup;

		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;

		_soldier = [_aiGroup, _position, _camo] call createRandomSoldier;
		_soldier moveInDriver _vehicle;

		_soldier = [_aiGroup, _position, _camo] call createRandomSoldier;
		_soldier moveInCargo [_vehicle, [0,3] select (_type == "I_G_Offroad_01_F")]; // FFV seat
		if !(_type isKindOf "Truck_F") then
		{
			_soldier = [_aiGroup, _position, _camo] call createRandomSoldier;
			_soldier moveInGunner _vehicle;
		};

		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;

		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;

	_vehicles =
	[
		[_veh1, _starts select 0, _startDirs select 0] call _createVehicle,
		[_veh2, _starts select 1, _startDirs select 1] call _createVehicle,
		[_veh3, _starts select 2, _startDirs select 2] call _createVehicle
	];

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;

	_aiGroup setCombatMode "YELLOW"; // units will defend themselves
	_aiGroup setBehaviour "SAFE"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "FILE";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	_aiGroup setSpeedMode _speedMode;

	{
		_waypoint = _aiGroup addWaypoint [_x, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 25;
		_waypoint setWaypointCombatMode "YELLOW";
		_waypoint setWaypointBehaviour "SAFE"; // safe is the best behaviour to make AI follow roads, as soon as they spot an enemy or go into combat they WILL leave the road for cover though!
		_waypoint setWaypointFormation "FILE";
		_waypoint setWaypointSpeed _speedMode;
	} forEach _waypoints;

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh2 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh2 >> "displayName");

	_missionHintText = format ["A <t color='%2'>%1</t> transporting 2 weapon crates is being escorted. Stop the convoy!", _vehicleName, logisticsMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome

_successExec =
{
	// Mission completed
	_boxTypes = ["mission_USRifles","mission_RURifles","mission_Explosive","mission_Gear","mission_Militia"];
	_box1Type = _boxTypes call BIS_fnc_selectRandom;
	_box1 = createVehicle ["Box_NATO_Wps_F", _lastPos, [], 2, "None"];
	_box1 setDir random 360;
	[_box1, _box1Type] call fn_refillbox;

	_box2Type = _boxTypes call BIS_fnc_selectRandom;
	_box2 = createVehicle ["Box_East_WpsSpecial_F", _lastPos, [], 2, "None"];
	_box2 setDir random 360;
	[_box2, _box2Type] call fn_refillbox;

	_successHintMessage = "The convoy has been stopped, the weapon crates and vehicles are now yours to take.";
};

_this call logisticsMissionProcessor;
