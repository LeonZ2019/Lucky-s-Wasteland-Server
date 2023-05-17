// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_policePatrol.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "militaryMissionDefines.sqf";

private ["_convoyVeh", "_veh1", "_veh2", "_veh3", "_veh4", "_veh5", "_createVehicle", "_rad", "_vehicles", "_leader", "_speedMode","_waypoint", "_vehicleName", "_vehicleName2", "_vehicleName3", "_numWaypoints", "_cash", "_boxTypes", "_box1Type", "_box1", "_box2Type", "_box2"];

_setupVars =
{
	_missionType = "Police Patrol";
	_locationsArray = nil;
};

_setupObjects =
{
	_town = (call cityList) call BIS_fnc_selectRandom;
	_missionPos = markerPos (_town select 0);

	_convoyVeh = ["B_MRAP_01_F","B_GEN_Offroad_01_covered_F","B_GEN_Offroad_01_covered_F","B_MRAP_01_F", "I_Heli_light_03_unarmed_F"];
	_veh1 = _convoyVeh select 0;
	_veh2 = _convoyVeh select 1;
	_veh3 = _convoyVeh select 2;
	_veh4 = _convoyVeh select 3;
	_veh5 = _convoyVeh select 4;

	_createVehicle = {
		private ["_type","_position","_direction","_maxRadius","_special","_vehicle","_safePos","_soldier", "_textures", "_indexT", "_colors", "_indexC", "_texture"];
		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;
		_maxRadius = _this select 3;
		_special = param [4, "NONE", [""]];
	
		_safePos = [_position, 0, _maxRadius + 25, 5, 0, 0, 0, _type] call findSafePos;
		if (_special == "FLY") then
		{
			_safePos = _position vectorAdd [random 15, random 15, 50 + random 25];
		};
		_vehicle = createVehicle [_type, _safePos, [], 0, _special];
		if (_type != "B_GEN_Offroad_01_covered_F") then
		{
			_textures = call colorsArray;
			_indexT = _textures findIf {_x select 0 == _type};
			_colors = _textures select _indexT select 1;
			_indexC = _colors findIf {_x select 0 == "Gendarmerie"};
			_texture = _colors select _indexC select 1;
			[_vehicle, _texture] call applyVehicleTexture;
		};
		[_vehicle] call vehicleSetup;
	
		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;

		_soldier = [_aiGroup, _safePos] call createRandomPolice;
		_soldier moveInDriver _vehicle;
		_soldier = [_aiGroup, _safePos] call createRandomPolice;
		_soldier moveInAny _vehicle;
		_soldier = [_aiGroup, _safePos] call createRandomPolice;
		_soldier moveInAny _vehicle;
		_soldier = [_aiGroup, _safePos] call createRandomPolice;
		_soldier moveInAny _vehicle;

		_vehicle setVariable ["R3F_LOG_disabled", true, true]; // force vehicles to be locked
		[_vehicle, _aiGroup] spawn checkMissionVehicleLock; // force vehicles to be locked

		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;

	_rad = _town select 1;
	_vehicles =
	[
		[_veh1, _missionPos, 0, _rad] call _createVehicle,
		[_veh2, _missionPos, 0, _rad] call _createVehicle,
		[_veh3, _missionPos, 0, _rad] call _createVehicle,
		[_veh4, _missionPos, 0, _rad] call _createVehicle,
		[_veh5, _missionPos, 0, _rad, "FLY"] call _createVehicle
	];

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";
	
	_aiGroup setCombatMode "GREEN"; // units will defend themselves
	_aiGroup setBehaviour "SAFE"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "FILE";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };
	_aiGroup setSpeedMode _speedMode;

	_cityList = call cityList;
	{ _x set [3, false] } forEach _cityList;
	_waypointPos = [_missionPos];
	_getNextTown = 
	{
		private ["_towns", "_tempTowns", "_nearestDistance", "_nearestTown", "_distance", "_town", "_pos"];
		_towns = _this select 0;
		_nearestDistance = 9999;
		_nearestTown = -1;
		{
			if !(_x select 3) then
			{
				_distance = (markerPos (_x select 0)) distance (_waypointPos select (count _waypointPos - 1));
				if (_nearestDistance > _distance) then {
					_nearestDistance = _distance;
					_nearestTown = _forEachIndex;
				};
			};
		} forEach _towns;
		_pos = [0,0,0];
		if (_nearestTown != -1) then
		{
			_town = _cityList select _nearestTown;
			_town set [3, true];
			_cityList set [_nearestTown, _town];
			_pos = markerPos (_town select 0)
		};
		_pos
	};
	_nearestPos = [_cityList] call _getNextTown;
	while { {_x == 0} count _nearestPos != 3 } do
	{
		_waypointPos pushBack _nearestPos;
		_nearestPos = [_cityList] call _getNextTown;
		_waypoint = _aiGroup addWaypoint [_nearestPos, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "GREEN";
		_waypoint setWaypointBehaviour "SAFE";
		_waypoint setWaypointFormation "FILE";
		_waypoint setWaypointSpeed _speedMode;
	};

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh2 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh2 >> "displayName");
	_vehicleName2 = getText (configFile >> "CfgVehicles" >> _veh3 >> "displayName");
	_vehicleName3 = getText (configFile >> "CfgVehicles" >> _veh4 >> "displayName");
	
	_missionHintText = format ["A convoy containing at least a <t color='%4'>%1</t>, a <t color='%4'>%2</t> and a <t color='%4'>%3</t> is patrolling Malden! Stop the patrol and capture the goods and money!", _vehicleName, _vehicleName2, _vehicleName3, militaryMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};
_failedExec = nil;

_successExec =
{
	// Mission completed
	for "_x" from 1 to 5 do
	{
		_cash = createVehicle ["Land_Money_F", _lastPos, [], 5, "None"];
		_cash setPos ([_lastPos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash setDir random 360;
		_cash setVariable ["cmoney", 2000, true];
		_cash setVariable ["owner", "world", true];
	};

	_boxTypes = ["mission_USRifles","mission_RURifles","mission_USMachineguns","mission_RUMachineguns","mission_PDW","mission_Gear","mission_Militia"];
	_box1Type = _boxTypes call BIS_fnc_selectRandom;
	_box1 = "Box_East_Wps_F" createVehicle _lastPos;
	[_box1, _box1Type] call fn_refillbox;

	_box2Type = _boxTypes call BIS_fnc_selectRandom;
	_box2 = "Box_NATO_Wps_F" createVehicle _lastPos;
	[_box2, _box2Type] call fn_refillbox;

	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];

	_successHintMessage = "The patrol has been stopped, the money, crates and vehicles are yours to take.";
};

_this call militaryMissionProcessor;