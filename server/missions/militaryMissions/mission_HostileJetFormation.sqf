// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HostileJetFormation.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "militaryMissionDefines.sqf"

private ["_planeChoices", "_convoyVeh", "_veh1", "_veh2", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_vehicleName2", "_numWaypoints", "_cash", "_Boxes", "_currBox1", "_currBox2", "_currBox3", "_box1", "_box2", "_box3", "_box4"];

_setupVars =
{
	_missionType = "Hostile Jets";
	_locationsArray = nil; // locations are generated on the fly from towns
};

_setupObjects =
{
	_missionPos = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);
	_planeChoices =["B_Plane_Fighter_01_F", "O_Plane_Fighter_02_F","I_Plane_Fighter_04_F"];

	_convoyVeh = _planeChoices call BIS_fnc_selectRandom;

	_veh1 = _convoyVeh;
	_veh2 = _convoyVeh;
	_veh3 = _convoyVeh;

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
		_vehicle setMagazineTurretAmmo ["240Rnd_CMFlare_Chaff_Magazine", 20, [-1]];
		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;
	_vehicles =
	[
		[_veh1, _missionPos vectorAdd ([[random 50, 0, 0], random 360] call BIS_fnc_rotateVector2D), 0] call _createVehicle,
		[_veh2, _missionPos vectorAdd ([[random 50, 0, 0], random 360] call BIS_fnc_rotateVector2D), 0] call _createVehicle,
		[_veh3, _missionPos vectorAdd ([[random 50, 0, 0], random 360] call BIS_fnc_rotateVector2D), 0] call _createVehicle
	];

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";
	
	_aiGroup setCombatMode "YELLOW";
	_aiGroup setBehaviour "COMBAT";
	_aiGroup setFormation "DIAMOND";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	_aiGroup setSpeedMode _speedMode;

	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "GREEN";
		_waypoint setWaypointBehaviour "SAFE";
		_waypoint setWaypointFormation "VEE";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh1 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh1 >> "displayName");
	_vehicleName2 = _vehicleName;
	_vehicleName3 = _vehicleName;

	_missionHintText = format ["A formation of Jets containing three <t color='%3'>%1</t> are patrolling the island. Destroy them and recover their cargo!", _vehicleName, _vehicleName2, _vehicleName3, militaryMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_waitUntilSuccessCondition = { {!alive _x} count _vehicles == 3 };
_ignoreAiDeaths = true;

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome
_successExec =
{
	//Money
	for "_i" from 1 to 10 do
	{
		_cash = createVehicle ["Land_Money_F", _lastPos, [], 5, "None"];
		_cash setPos ([_lastPos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash setDir random 360;
		_cash setVariable ["cmoney", 5000, true]; //50k
		_cash setVariable ["owner", "world", true];
	};

	_boxTypes = ["mission_USLaunchers","mission_RULaunchers","mission_USSpecial","mission_USMachineguns","mission_RUMachineguns","mission_Explosive","mission_Gear"];
	_box1Type = _boxTypes call BIS_fnc_selectRandom;
	_Boxes = ["Box_IND_Wps_F","Box_East_Wps_F","Box_NATO_Wps_F","Box_East_WpsSpecial_F","Box_NATO_WpsSpecial_F"];
	_currBox1 = _Boxes call BIS_fnc_selectRandom;
	_box1 = createVehicle [_currBox1, _lastPos, [], 2, "None"];
	_box1 setDir random 360;
	[_box1, _box1Type] call fn_refillbox;

	_box2Type = _boxTypes call BIS_fnc_selectRandom;
	_currBox2 = _Boxes call BIS_fnc_selectRandom;
	_box2 = createVehicle [_currBox2, _lastPos, [], 2, "None"];
	_box2 setDir random 360;
	[_box2, _box2Type] call fn_refillbox;

	_box3Type = _boxTypes call BIS_fnc_selectRandom;
	_currBox3 = _Boxes call BIS_fnc_selectRandom;
	_box3 = createVehicle [_currBox3, _lastPos, [], 2, "None"];
	_box3 setDir random 360;
	[_box3, _box3Type] call fn_refillbox;
	
	_box4Type = _boxTypes call BIS_fnc_selectRandom;
	_currBox4 = _Boxes call BIS_fnc_selectRandom;
	_box4 = createVehicle [_currBox4, _lastPos, [], 2, "None"];
	_box4 setDir random 360;
	[_box4, _box4Type] call fn_refillbox;
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2, _box3, _box4];

	_successHintMessage = "The sky is clear again, the enemy patrol was taken out! Ammo crates and some money have fallen near the pilot.";
};

_this call militaryMissionProcessor;
