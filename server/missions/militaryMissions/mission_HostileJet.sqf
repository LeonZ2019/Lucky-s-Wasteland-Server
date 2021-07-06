// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HostileJet.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "militaryMissionDefines.sqf";

private ["_planeChoices", "_convoyVeh", "_veh1", "_createVehicle", "_vehicle", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_cash", "_boxes1", "_currBox1", "_box1"];

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
		"O_Plane_CAS_02_F",
		"I_Plane_Fighter_03_CAS_F"
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
		_vehicle addEventHandler ["GetOut", {
			params ["_vehicle", "_role", "_unit", "_turret"];
			_this select 2 setDamage 1;
		}];
		_vehicle setMagazineTurretAmmo ["120Rnd_CMFlare_Chaff_Magazine", 10, [-1]];
		_vehicle
	};
	
	_aiGroup = createGroup CIVILIAN;
	
	_vehicle = [_veh1, _missionPos vectorAdd ([[random 50, 0, 0], random 360] call BIS_fnc_rotateVector2D), 0] call _createVehicle;
	_leader = effectiveCommander _vehicle;
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";

	_aiGroup setCombatMode "YELLOW";
	_aiGroup setBehaviour "COMBAT";
	_aiGroup setFormation "DIAMOND";
	
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
	_vehicle spawn
	{
		_veh = _this;
		waitUntil
		{
			sleep 0.1;
			_pos = getPos _veh;
			(isTouchingGround _veh || _pos select 2 < 5) && {vectorMagnitude velocity _veh < [1,5] select surfaceIsWater _pos}
		};
		_pos = getPosATL _veh;
		for "_i" from 1 to 10 do
		{
			_cash = createVehicle ["Land_Money_F", _pos, [], 5, "None"];
			_cash setPos ([_pos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
			_cash setDir random 360;
			_cash setVariable ["cmoney", 1500, true];
			_cash setVariable ["owner", "world", true];
		};

		_Boxes = ["Box_IND_Wps_F","Box_East_Wps_F","Box_NATO_Wps_F","Box_NATO_AmmoOrd_F","Box_NATO_Grenades_F","Box_East_WpsLaunch_F","Box_NATO_WpsLaunch_F","Box_East_WpsSpecial_F","Box_NATO_WpsSpecial_F"];    
		_currBox1 = _Boxes call BIS_fnc_selectRandom;
		_box1 = createVehicle [_currBox1, _pos, [], 5, "None"];
		_box1 setDir random 360;
		[_box1, "mission_USLaunchers"] call fn_refillbox;
	};

	_successHintMessage = "The sky is clear again, the enemy patrol was taken out! Ammo crates and some money have fallen near the pilot.";
};

_this call militaryMissionProcessor;
