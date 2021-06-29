// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_policePatrol.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "militaryMissionDefines.sqf";

private ["_convoyVeh","_veh1","_veh2","_veh3","_veh4","_veh5","_createVehicle","_pos","_rad","_vehiclePosArray","_vPos1","_vPos2","_vPos3","_vehiclePos1","_vehiclePos2","_vehiclePos3","_vehiclePos4","_vehicles","_leader","_speedMode","_waypoint","_vehicleName","_numWaypoints","_cash","_box1","_box2","_box3"];

_setupVars =
{
	_missionType = "Police Patrol";
	_locationsArray = nil;
};

_setupObjects =
{
	_town = (call cityList) call BIS_fnc_selectRandom;
	_missionPos = markerPos (_town select 0);

	_convoyVeh = ["I_MRAP_03_hmg_F","I_MBT_03_cannon_F","O_APC_Tracked_02_AA_F","I_MBT_03_cannon_F","I_MRAP_03_gmg_F"];
	
	_veh1 = _convoyVeh select 0;
	_veh2 = _convoyVeh select 1;
	_veh3 = _convoyVeh select 2;
	_veh4 = _convoyVeh select 3;
	_veh5 = _convoyVeh select 4;

	_createVehicle = {
		private ["_type","_position","_direction","_vehicle","_soldier"];
		
		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "None"];
		[_vehicle] call vehicleSetup;

		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;

		_soldier = [_aiGroup, _position] call createRandomPolice; 
		_soldier moveInDriver _vehicle;
		_soldier = [_aiGroup, _position] call createRandomPolice; 
		_soldier moveInCommander _vehicle;
		_soldier = [_aiGroup, _position] call createRandomPolice; 
		_soldier moveInGunner _vehicle;

		//_vehicle setVariable ["R3F_LOG_disabled", false, true]; // force vehicles to be unlocked
		_vehicle setVariable ["R3F_LOG_disabled", true, true]; // force vehicles to be locked
		[_vehicle, _aiGroup] spawn checkMissionVehicleLock; // force vehicles to be locked

		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;
	
	//_pos = getMarkerPos (_town select 0);
	_rad = _town select 1;
	_vehiclePosArray = [_missionPos,_rad,_rad + 50,5,0,0,0] call findSafePos;
	/*_vPos1 = _vehiclePosArray select 0;
	_vPos2 = _vehiclePosArray select 1;
	_vPos3 = _vehiclePosArray select 2;
	_vehiclePos1 = [_vPos1 + 5, _vPos2 + 5, _vPos3];
	_vehiclePos2 = [_vPos1 + 10, _vPos2 + 10, _vPos3];
	_vehiclePos3 = [_vPos1 + 15, _vPos2 + 15, _vPos3];
	_vehiclePos4 = [_vPos1 + 20, _vPos2 + 20, _vPos3];*/

	_vehicles =
	[
		[_veh1, _vehiclePosArray, 0] call _createVehicle,
		[_veh2, _vehiclePosArray, 0] call _createVehicle,
		[_veh3, _vehiclePosArray, 0] call _createVehicle,
		[_veh4, _vehiclePosArray, 0] call _createVehicle,
		[_veh5, _vehiclePosArray, 0] call _createVehicle
	];

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";
	
	_aiGroup setCombatMode "GREEN"; // units will defend themselves
	_aiGroup setBehaviour "SAFE"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "FILE";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };
	_aiGroup setSpeedMode _speedMode;

	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "GREEN";
		_waypoint setWaypointBehaviour "SAFE"; // safe is the best behaviour to make AI follow roads, as soon as they spot an enemy or go into combat they WILL leave the road for cover though!
		_waypoint setWaypointFormation "FILE";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh2 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh2 >> "displayName");
	_vehicleName2 = getText (configFile >> "CfgVehicles" >> _veh3 >> "displayName");
	_vehicleName3 = getText (configFile >> "CfgVehicles" >> _veh4 >> "displayName");
	
	_missionHintText = format ["A convoy containing at least a <t color='%4'>%1</t>, a <t color='%4'>%2</t> and a <t color='%4'>%3</t> is patrolling Altis! Stop the patrol and capture the goods and money!", _vehicleName, _vehicleName2, _vehicleName3, militaryMissionColor];

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
		_cash = "Land_Money_F" createVehicle markerPos _marker;
		_cash setPos ((markerPos _marker) vectorAdd ([[2 + random 2,0,0], random 360] call BIS_fnc_rotateVector2D));
		_cash setDir random 360;
		_cash setVariable["cmoney",5000,true];
		_cash setVariable["owner","world",true];
	};

	_box1 = "Box_East_Wps_F" createVehicle getMarkerPos _marker;
    [_box1,"mission_USLaunchers"] call fn_refillbox;
	_box1 allowDamage false;
	
	_box2 = "Box_NATO_Wps_F" createVehicle getMarkerPos _marker;
    [_box2,"mission_USSpecial2"] call fn_refillbox;
	_box2 allowDamage false;
	
	_box3 = "Box_NATO_Support_F" createVehicle getMarkerPos _marker;
    [_box3,"mission_Main_A3snipers"] call fn_refillbox;
	_box3 allowDamage false;
	
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2, _box3];

	_successHintMessage = "The patrol has been stopped, the money, crates and vehicles are yours to take.";
};

_this call militaryMissionProcessor;