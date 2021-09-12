// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_RescueWarCrime.sqf
//	@file Author: Leon
//	@file Created: 7/27/2021 16:07

if (!isServer) exitwith {};
#include "militaryMissionDefines.sqf";

private ["_convoyVeh", "_veh1", "_veh2", "_veh3", "_veh4", "_veh5", "_createVehicle", "_vehicles", "_randomVehicle", "_missionPos", "_hostageGroup", "_hostage", "_leader", "_safePos", "_speedMode", "_waypoint", "_missionDifficulty", "_numWaypoints", "_pos", "_cash", "_boxTypes", "_Boxes", "_box"];

_setupVars =
{
	_missionType = "Rescue War Crime";
	_locationsArray = LandConvoyPaths;
};

_setupObjects =
{
    private ["_starts", "_startDirs", "_waypoints"];
	call compile preprocessFileLineNumbers format ["mapConfig\convoys\%1.sqf", _missionLocation];
	
	_convoyVeh = if (missionDifficultyHard) then
	{
        [
            ["B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_rcws_F", "B_MBT_01_TUSK_F"],
            ["O_APC_Wheeled_02_rcws_v2_F", "O_APC_Tracked_02_cannon_F", "O_MBT_04_command_F"],
            ["I_APC_Wheeled_03_cannon_F", "I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F"]
        ] call BIS_fnc_selectRandom;
	}
	else
	{
        [
            ["B_MRAP_01_hmg_F", "B_MRAP_01_F", "B_MRAP_01_gmg_F"],
            ["O_MRAP_02_hmg_F", "O_MRAP_02_F", "O_MRAP_02_gmg_F"],
            ["I_MRAP_03_hmg_F", "I_MRAP_03_F", "I_MRAP_03_gmg_F"]
        ] call BIS_fnc_selectRandom;
	};

    _veh1 = _convoyVeh select 0;
	_veh2 = _convoyVeh select 1;
	_veh3 = _convoyVeh select 1;
	_veh4 = _convoyVeh select 1;
	_veh5 = _convoyVeh select 2;

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
		_soldier = [_aiGroup, _position] call createRandomPolice;
		_soldier moveInDriver _vehicle;
		_soldier = [_aiGroup, _position] call createRandomPolice;
		_soldier moveInCargo [_vehicle, 0];
		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;
	_vehicles =
	[
		[_veh1, _starts select 0, _startDirs select 0] call _createVehicle,
		[_veh2, _starts select 1, _startDirs select 1] call _createVehicle,
		[_veh3, _starts select 2, _startDirs select 2] call _createVehicle,
		[_veh4, _starts select 3, _startDirs select 3] call _createVehicle,
		[_veh5, _starts select 4, _startDirs select 4] call _createVehicle
	];

	_hostageGroup = createGroup CIVILIAN;
	_safePos = [_starts select 2, 0, 30, 5, 0, 0, 0] call findSafePos;
	_hostage = [_hostageGroup, _safePos] call createHostage;
	_randomVehicle = _vehicles select (selectRandom [1,2,3]); //move in between 1-3, 0 and 4 keep it out
    _hostage moveInCargo _randomVehicle;
	_randomVehicle allowCrewInImmobile true;
    _hostage disableAI "ANIM";

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;

	_aiGroup setCombatMode "YELLOW";
	_aiGroup setBehaviour "SAFE";
	_aiGroup setFormation "FILE";
	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };
	_aiGroup setSpeedMode _speedMode;

	{
		_waypoint = _aiGroup addWaypoint [_x, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 25;
		_waypoint setWaypointCombatMode "YELLOW";
		_waypoint setWaypointBehaviour "SAFE";
		_waypoint setWaypointFormation "FILE";
		_waypoint setWaypointSpeed _speedMode;
	} forEach _waypoints;

	_missionPos = getPosATL leader _aiGroup;
    _missionDifficulty = if (missionDifficultyHard) then { "heavy" } else { "standard" };
	_missionHintText = format ["War crime is being escorted by 5 %1 vehicles. Stop the convoy and rescue him!", _missionDifficulty];
    _numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPos _leader};
_waitUntilExec = nil;
_waitUntilCondition = {!alive _hostage || currentWaypoint _aiGroup >= _numWaypoints};
_waitUntilSuccessCondition = { ({alive _x} count units _aiGroup) == 0 && alive _hostage};
_failedExec = {
	if (alive _hostage) then
	{
		_failedHintMessage = "War crime has been safety escorted to destination.";
		deleteVehicle _hostage;
	} else
	{
		_failedHintMessage = "War crime killed! Next time try not to destroy the vehicle.";
	};
};

_successExec =
{
	// Mission completed
	if (vehicle _hostage != _hostage) then {
    	_hostage enableAI "ANIM";
		_hostageMove = _hostageGroup addWaypoint [_hostage modelToWorld [-3,0,0], 0];
		_hostageMove setWaypointType "GETOUT";
		_hostageMove setWaypointCombatMode "BLUE";
		_hostageMove setWaypointBehaviour "CARELESS";
	};
	_pos = getPosATL _hostage;
	for "_i" from 1 to 10 do
	{
		_cash = createVehicle ["Land_Money_F", _pos, [], 5, "None"];
		_cash setPos ([_pos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash setDir random 360;
	    _value = if (missionDifficultyHard) then { 4000 } else { 2000 };
		_cash setVariable ["cmoney", _value, true];
		_cash setVariable ["owner", "world", true];
	};
	_boxTypes = ["mission_USLaunchers","mission_RULaunchers","mission_USSpecial"];
	_Boxes = ["Box_IND_Wps_F","Box_East_Wps_F","Box_NATO_Wps_F"];
	_box = createVehicle [_Boxes call BIS_fnc_selectRandom, _pos, [], 5, "None"];
	_box setDir random 360;
	[_box, _boxTypes call BIS_fnc_selectRandom] call fn_refillbox;
	deleteVehicle _hostage;
	_successHintMessage = "War crime has been released.";
};

_this call militaryMissionProcessor;
