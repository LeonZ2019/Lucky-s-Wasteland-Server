// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_redDawn.sqf

if (!isServer) exitwith {};
#include "militaryMissionDefines.sqf";

private ["_markerDir", "_nbUnits", "_camo", "_leftWaves", "_countDown", "_paraUnits", "_vehicles", "_boxes", "_boxTypes", "_boxClass", "_box", "_boxType", "_vehicleClasses", "_enemy", "_vehicle", "_waypoint", "_leader", "_spawnPos", "_boxLocked"];

_setupVars =
{
	_missionType = "Red Dawn";
	_locationsArray = MorayMissionMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_markerDir = markerDir _missionLocation;

	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE + round (random 6)} else { AI_GROUP_MEDIUM + round (random 4)};

	_camo = ["GreenHex", "Hex", "Green", "Taiga"] call BIS_fnc_selectRandom;
	_leftWaves = ceil ((count allPlayers) * 2.2);
	_countDown = 4 * 60;
	_paraUnits = [];
	_vehicles = [];
	_boxes = [];
	_boxTypes = ["mission_RULaunchers", "mission_RUMachineguns","mission_Explosive"];
	_boxClass = ["Box_IND_Wps_F","Box_East_Wps_F","Box_NATO_Wps_F","Box_East_WpsSpecial_F","Box_NATO_WpsSpecial_F"];
	for "_i" from 0 to 2 do
	{
		if (_i == 2) then
		{
			_boxType = "mission_CBRN";
		} else
		{
			_boxType = _boxTypes call BIS_fnc_selectRandom;
		};
		_box = createVehicle [_boxClass call BIS_fnc_selectRandom, _missionPos, [], 7.5, "None"];
		[_box, _boxType] call fn_refillbox;
		_box setDir random 360;
		_box setVariable ["R3F_LOG_disabled", true, true];
		// _box setVariable ["R3F_LOG_disabled", true, true];
		_boxes pushBack _box;
	};
	_boxLocked = true;
	_vehicleClasses = ["O_MRAP_02_hmg_F", "O_APC_Wheeled_02_rcws_v2_F", "O_APC_Tracked_02_cannon_F", "O_APC_Wheeled_02_rcws_v2_F", "O_APC_Tracked_02_cannon_F", "O_MBT_02_cannon_F"];

	// _missionPicture = getText (configFile >> "CfgVehicles" >> (_veh1 select 0) >> "picture");
	//paratrooper drop picture

	_missionHintText = format ["North Korea paratroopers will arrive at <br/><t size='1.25' color='%1'>Pegasus Airfield</t> in 4 mins<br/><br/>Fight them until retreats!", militaryMissionColor];
};

_ignoreAiDeaths = true;
_waitUntilMarkerPos = nil;
_waitUntilExec = {
	if (_countDown > 0) then
	{
		_countDown = _countDown - 1;
	} else
	{
		_countDown = 60;
		if (_leftWaves > 0) then
		{
			_group = createGroup CIVILIAN;
			_vehicle = [_group, _missionPos, _nbUnits - 3, _camo, _vehicleClasses call BIS_fnc_selectRandom] call createRandomParatrooper;
			_leader = leader _group;
			_leader setRank "LIEUTENANT";
			_group setCombatMode "YELLOW"; 
			_group setBehaviour "COMBAT"; 
			_group setFormation "STAG COLUMN";
			_speedMode = "LIMITED";
			_group setSpeedMode _speedMode;

			_waypoint = _group addWaypoint [_missionPos, 3, 0];
			_waypoint setWaypointType "MOVE";
			_waypoint setWaypointCompletionRadius 5;
			_waypoint setWaypointCombatMode "YELLOW";
			_waypoint setWaypointBehaviour "COMBAT";
			_waypoint setWaypointFormation "STAG COLUMN";
			_waypoint setWaypointSpeed _speedMode;
			_paraUnits append (units _group);

			_vehicles pushBack _vehicle;
			_leftWaves = _leftWaves - 1;
		} else
		{
			if (_boxLocked) then
			{
				{ _x setVariable ["R3F_LOG_disabled", false, true]; } forEach _boxes;
				_boxLocked = false;
			};
		};
	};
	{
		_x doMove _missionPos;
	} forEach _paraUnits;
};

_waitUntilCondition = { _totalAlive = count (_paraUnits select { vehicle _x == _x && alive _x && _x distance _missionPos <= 20}); (_totalAlive >= (_nbUnits * 0.8) || (_vehicles findIf {_x distance _missionPos <= 20} != -1)) };

_waitUntilSuccessCondition = {
	_leftWaves == 0 &&
	(_paraUnits findIf { alive _x } == -1) && _vehicles findIf { (crew _x) findIf { alive _x } != -1 } == -1
};

_failedExec =
{
	
	_enemy = _paraUnits select { alive _x };
	_inRange = count (_enemy select {_x distance2D _missionPos <= 20});
	if ((_inRange > _nbUnits) || (count _enemy == _inRange)) then
	{
		_failedHintMessage = "Enemy have occupied the island";
	};
	{
		deleteVehicle _x;
	} forEach _enemy + _boxes;
	{
		if (alive _x) then { deleteVehicle _x };
	} forEach _vehicles;
};


_successExec =
{
	// Mission completed
	// reward CBRN gear
	// reward left over vehicle such as few apc and 1 or 2 tank if not fully damage
	{
		_x setVariable ["R3F_LOG_disabled", false, true];
	} forEach _boxes;
	{
		_x setVariable ["Running", nil, true];
		[_x, 1] call A3W_fnc_setLockState;
	} forEach _vehicles;
	_successHintMessage = "Pegasus airfield is clear, enemy has retreated ! Take those left over crates and vehicles.";
};

_this call militaryMissionProcessor;
