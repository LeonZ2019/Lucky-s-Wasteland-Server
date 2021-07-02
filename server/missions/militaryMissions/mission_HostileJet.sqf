// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HostileJet.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "militaryMissionDefines.sqf";

private ["_planeChoices", "_convoyVeh", "_veh1", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_cash", "_boxes1", "_currBox1", "_boxes2", "_currBox2", "_box1", "_box2"];

_setupVars =
{
	_missionType = "Hostile Jet";
	_locationsArray = nil; // locations are generated on the fly from towns
};

_setupObjects =
{
	_missionPos = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);

	_planeChoices =
	[
		"B_Plane_CAS_01_F",
		"O_Plane_CAS_02_F"
	];

	_veh1 = _planeChoices call BIS_fnc_selectRandom;

	_createVehicle = 
	{
		private ["_type","_position","_direction","_vehicle","_soldier"];
		
		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;
		

		_vehicle = createVehicle [_type, _position, [], 0, "FLY"]; // Added to make it fly
		_vehicle setVariable ["R3F_LOG_disabled", true, true];
		_vel = [velocity _vehicle, -(_direction)] call BIS_fnc_rotateVector2D; // Added to make it fly
		_vehicle setDir _direction;
		_vehicle setVelocity _vel; // Added to make it fly
		_vehicle setVariable [call vChecksum, true, false];
		_aiGroup addVehicle _vehicle;

		// add pilot
		_soldier = [_aiGroup, _position] call createRandomPilot; 
		_soldier moveInDriver _vehicle;
		// lock the vehicle untill the mission is finished and initialize cleanup on it
		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
		_vehicle
	};
	
	_aiGroup = createGroup CIVILIAN;
	
	_vehicle = [_veh1, _missionPos vectorAdd ([[random 50, 0, 0], random 360] call BIS_fnc_rotateVector2D), 0] call _createVehicle;
	_vehicle allowCrewInImmobile true;
	_leader = effectiveCommander _vehicle;
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";
	
	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";
	_aiGroup setFormation "STAG COLUMN";
	
	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };
	
	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 55;
		_waypoint setWaypointCombatMode "RED";
		_waypoint setWaypointBehaviour "COMBAT";
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh1 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh1 >> "displayName");
	_missionHintText = format ["An armed <t color='%2'>%1</t> is patrolling the island. Shoot it down and kill the pilot to recover the money and weapons!", _vehicleName, militaryMissionColor];

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

	for "_i" from 1 to 5 do
	{
		_cash = createVehicle ["Land_Money_F", _lastPos, [], 5, "None"];
		_cash setPos ([_lastPos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash setDir random 360;
		_cash setVariable ["cmoney", 5000, true];
		_cash setVariable ["owner", "world", true];
	};

	_Boxes = ["Box_IND_Wps_F","Box_East_Wps_F","Box_NATO_Wps_F","Box_NATO_AmmoOrd_F","Box_NATO_Grenades_F","Box_East_WpsLaunch_F","Box_NATO_WpsLaunch_F","Box_East_WpsSpecial_F","Box_NATO_WpsSpecial_F"];    
	_currBox1 = _Boxes call BIS_fnc_selectRandom;
	_box1 = createVehicle [_currBox1, _lastPos, [], 5, "None"];
	_box1 setDir random 360;
	[_box2, "mission_Main_A3snipers"] call fn_refillbox;

	_currBox2 = _Boxes call BIS_fnc_selectRandom;
	while {_currBox1 == _currBox2} do {
		_currBox2 = _Boxes call BIS_fnc_selectRandom;
	};
	_box2 = createVehicle [_currBox2, _lastPos, [], 5, "None"];
	_box2 setDir random 360;
	[_box2, "mission_USLaunchers"] call fn_refillbox;

	_successHintMessage = "The sky is clear again, the enemy patrol was taken out! Ammo crates and some money have fallen near the pilot.";
};

_this call militaryMissionProcessor;
