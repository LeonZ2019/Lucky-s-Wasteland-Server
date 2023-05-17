// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_DefendTerritory.sqf
//	@file Author: Leon
//	@file Created: 12/24/2021 14:11

if (!isServer) exitwith {};
#include "mainMissionDefines.sqf"

private ["_territories", "_territory", "_spawnRadius", "_territoryName", "_reward", "_createVehicle", "_spawnWave", "_trigger", "_cash", "_pos", "_currBox1", "_box1", "_box2", "_box3", "_randomBox", "_camo", "_totalAttacker", "_totalDead"];

_setupVars =
{
	_missionType = "Defend Territory";
	_locationsArray = MissionSpawnMarkers;
	_territories = call compile preprocessFileLineNumbers "mapConfig\territories.sqf";
	_territory = _territories call BIS_fnc_selectRandom;
	while {["TERRITORY_USS", _territory select 0] call fn_startsWith} do
	{
		_territory = _territories call BIS_fnc_selectRandom;
	};
	_spawnRadius = selectMax (markerSize (_territory select 0)) * 2.5;
	_missionPos = markerPos (_territory select 0);
	_territoryName = _territory select 1;
	_reward = (_territory select 2) * 40 max 40000;
};

_setupObjects =
{
	_createVehicle =
	{
		private ["_group", "_type", "_position", "_minDist", "_maxDist", "_trigger", "_vehicle", "_soldier", "_camo"];

		_group = _this select 0;
		_type = _this select 1;
		_position = _this select 2;
		_minDist =  _this select 3;
		_maxDist =  _this select 4;
		_trigger =  _this select 5;
		_camo =  _this select 6;

		for "_i" from 0 to 100 do
		{
			_position = [position _trigger, _minDist, _maxDist, 8, 0, 1, 0] call BIS_fnc_findSafePos;
			if (allplayers findif {_x distance _position < 400} == -1 && !(_position inArea _trigger)) exitwith {};
		};
		_position set [2, 0];
		_vehicle = createVehicle [_type, _position, [], 0, "NONE"];
		_vehicle setVariable ["R3F_LOG_disabled", true, true];

		[_vehicle] call vehicleSetup;
		_group addVehicle _vehicle;

		_soldier = [_group, _position, _camo] call createRandomSoldier;
		_soldier moveInDriver _vehicle;
		_soldier = [_group, _position, _camo] call createRandomSoldier;
		_soldier moveInGunner _vehicle;
		_commander = fullCrew [_vehicle, "commander", true];
		if (count _commander > 0 && { isNull(_commander select 0 select 0) }) then
		{
			_soldier = [_group, _position, _camo] call createRandomSoldier;
			_soldier moveInCommander  _vehicle;
		};
		[_vehicle, _group] spawn checkMissionVehicleLock;
		_vehicle
	};

	_spawnWave =
	{
		params ["_trigger"];
		private ["_aiGroup1", "_aiGroup2", "_aiGroup3", "_aiGroup4", "_createVehicle", "_missionPos", "_attackers", "_attackersPool", "_spawnPositions", "_playerCount", "_triggerArea", "_minDist", "_maxDist", "_ranOff", "_tankClass", "_tank", "_aaClass", "_aa", "_speedMode", "_tankPos", "_randomBox", "_rewardBox", "_para", "_apc", "_apcClass"];
		_trigger setVariable ["Attacking", true, true];
		_createVehicle = _trigger getVariable "createVehicle";
		_missionPos = _trigger getVariable "missionPos";
		_attackers = _trigger getVariable "Attackers";
		_attackersPool = _trigger getVariable "AttackersPool";
		_camo = _trigger getVariable "camo";
		_spawnPositions = [];
		_triggerArea = triggerArea _trigger;
		_playerCount = count (allPlayers select { _x inArea [position _trigger, _triggerArea select 0 * 1.5, _triggerArea select 1 * 1.5, _triggerArea select 2, _triggerArea select 3, -1] }) max 2 min 4;
		_triggerArea resize 2;
		_minDist = (selectMax _triggerArea) * 1.75 + 150 min 300;
		_maxDist = _minDist + 50;
		_perGroup = parseNumber ((_minDist * 0.06) toFixed 0) max 10 min 15;
		for "_i" from 0 to (_playerCount - 1) do
		{
			_pos = [position _trigger, _minDist, _maxDist, 5, 0, 1, 0] call BIS_fnc_findSafePos;
			for "_j" from 0 to 100 do
			{
				_pos = [position _trigger, _minDist, _maxDist, 5, 0, 1, 0] call BIS_fnc_findSafePos;
				if (allplayers findif {_x distance _pos < 175} == -1 && !(_pos inArea _trigger)) exitwith {};
			};
			_pos set [2, 0];
			_spawnPositions pushBack _pos;
		};
		_ranOff = selectrandom [0,0,1,1,1,2,2]; // apc, tank, anti air
		_tankPos = _missionPos;
		_tankPos set [2, 0];

		if (_ranOff == 0) then
		{
			_aiGroup4 = createGroup civilian;
			_apcClass = ["B_APC_Tracked_01_rcws_F", "I_APC_tracked_03_cannon_F", "O_APC_Tracked_02_cannon_F"] call BIS_fnc_selectRandom;
			_apc = [_aiGroup4, _apcClass, position _trigger, _minDist + 500, _maxDist + 750, _trigger, _camo] call _createVehicle;
			_vehs = _trigger getVariable "Vehicles";
			_vehs pushBack _apc;
			_trigger setVariable ["Vehicles", _vehs, true];
			_attackers append (units _aiGroup4);
			_attackersPool = _attackersPool - (count units _aiGroup4);
			{
				_waypoint = _aiGroup4 addWaypoint [_tankPos, 0];
				_waypoint setWaypointType _x;
				_waypoint setWaypointSpeed "NORMAL";
				_waypoint setWaypointBehaviour "CARELESS";
				_waypoint setWaypointCompletionRadius 10;
				_waypoint setWaypointCombatMode "YELLOW";
			} forEach ["MOVE", "SAD"];
			sleep 2;
		};

		if (_ranOff == 1) then
		{
			_aiGroup1 = createGroup civilian;
			_tankClass = ["B_MBT_01_cannon_F", "O_MBT_02_cannon_F", "I_MBT_03_cannon_F"] call BIS_fnc_selectRandom;
			_tank = [_aiGroup1, _tankClass, position _trigger, _minDist + 500, _maxDist + 750, _trigger, _camo] call _createVehicle;
			_vehs = _trigger getVariable "Vehicles";
			_vehs pushBack _tank;
			_trigger setVariable ["Vehicles", _vehs, true];
			_attackers append (units _aiGroup1);
			_attackersPool = _attackersPool - (count units _aiGroup1);
			{
				_waypoint = _aiGroup1 addWaypoint [_tankPos, 0];
				_waypoint setWaypointType _x;
				_waypoint setWaypointSpeed "NORMAL";
				_waypoint setWaypointBehaviour "CARELESS";
				_waypoint setWaypointCompletionRadius 10;
				_waypoint setWaypointCombatMode "YELLOW";
			} forEach ["MOVE", "SAD"];
		};

		if (_ranOff == 2) then
		{
			_aiGroup2 = createGroup civilian;
			_aaClass = ["B_APC_Tracked_01_AA_F", "O_APC_Tracked_02_AA_F", "I_LT_01_AA_F"] call BIS_fnc_selectRandom;
			_aa = [_aiGroup2, _aaClass, position _trigger, _minDist + 750, _maxDist + 1000, _trigger, _camo] call _createVehicle;
			_vehs = _trigger getVariable "Vehicles";
			_vehs pushBack _aa;
			_trigger setVariable ["Vehicles", _vehs, true];
			_attackers append (units _aiGroup2);
			_attackersPool = _attackersPool - (count units _aiGroup2);
			{
				_waypoint = _aiGroup2 addWaypoint [_tankPos, 0];
				_waypoint setWaypointType _x;
				_waypoint setWaypointSpeed "NORMAL";
				_waypoint setWaypointBehaviour "CARELESS";
				_waypoint setWaypointCompletionRadius 10;
				_waypoint setWaypointCombatMode "YELLOW";
			} forEach ["MOVE", "SAD"];
			sleep 2;
		};
		{
			if (_attackersPool - _perGroup >= 0) then
			{
				_attackersPool = _attackersPool - _perGroup;
				_aiGroup3 = createGroup civilian;
				[_aiGroup3, _x, _perGroup, 15, _camo] call createCustomGroup3;
				_aiGroup3 setCombatMode "RED";
				_aiGroup3 setBehaviour "AWARE";
				_aiGroup3 setFormation "WEDGE";
				_attackers append (units _aiGroup3);
				_speedMode = if (missionDifficultyHard) then { "FULL" } else { "NORMAL" };
				_aiGroup3 setSpeedMode _speedMode;
				while {count (waypoints _aiGroup3) > 0} do
				{
					deleteWaypoint ((waypoints _aiGroup3) select 0);
				};
				{
					_waypoint = _aiGroup3 addWaypoint [_missionPos, 0];
					_waypoint setWaypointType _x;
					_waypoint setWaypointSpeed "FULL";
					_waypoint setWaypointBehaviour "AWARE";
					_waypoint setWaypointCompletionRadius 10;
					_waypoint setWaypointCombatMode "RED";
				} forEach ["SAD", "CYCLE"];
			};
		} forEach _spawnPositions;
		_randomBox = ["mission_USRifles", "mission_RURifles", "mission_Explosive"] call BIS_fnc_selectRandom;
		_rewardBox = createVehicle ["Box_FIA_Support_F", (position _trigger) vectorAdd [random 60 -30, random 150 - 75, random 30 + 80], [], 0, "NONE"];
		_rewardBox setDir random 360;
		[_rewardBox, _randomBox] call fn_refillbox;
		_rewardBox setVariable ["artillery", 0, true];
		_rewardBox setVariable ["R3F_LOG_disabled", false, true];
		_para = createVehicle ["I_parachute_02_F", [0,0,999999], [], 0, "NONE"];
		_para setDir (getDir _rewardBox);
		_para setPosATL (getPosATL _rewardBox);
		_rewardBox attachTo [_para, [0, 0, 0]];
		if (dayTime <= 20.5 && dayTime > 3.5) then
		{
			private _attachItem = createVehicle ["SmokeShellGreen", getPosATL _para, [], 0, "NONE"];
			_attachItem attachto [_para, [0,0,-0.5]];
		} else
		{
			private _attachItem = createVehicle ["B_IRStrobe", getPosATL _para, [], 0, "NONE"];
			_attachItem attachto [_para, [0,0,-0.5]];
		};
		waituntil {count (_attackers select {alive _x}) <= 10};
		_trigger setVariable ["Attackers", _attackers, true];
		if (_attackersPool >= 10) then
		{
			_trigger setVariable ["AttackersPool", _attackersPool, true];
			[_trigger] spawn (_trigger getVariable "spawnWave");
		} else
		{
			_trigger setvariable ["AttackersPool", 0, true];
		};
	};
	_camo = ["MTP", "Tropic", "CTRGUrban", "CTRGArid", "CTRGTropic", "Woodland", "GreenHex", "Hex", "Green", "Taiga", "Digital", "Geometric", "Guerilla"] call BIS_fnc_selectRandom;

	_trigger = createTrigger ["EmptyDetector", _missionPos, true];
	_trigger setVariable ["camo", _camo, true];
	_trigger setVariable ["spawnWave", _spawnWave, true];
	_trigger setVariable ["createVehicle", _createVehicle, true];
	_trigger setVariable ["Attacking", false, true];
	_trigger setVariable ["Attackers", [], true];
	_trigger setVariable ["Vehicles", [], true];
	_trigger setVariable ["missionPos", _missionPos, true];
	_totalAttacker = (count allPlayers) * 30;
	_trigger setVariable ["AttackersPool", _totalAttacker, true];
	_trigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
	_triggerArea = markerSize (_territory select 0) + [markerDir (_territory select 0), markerShape (_territory select 0) == "RECTANGLE", 50];
	_trigger setTriggerArea _triggerArea;
	_trigger setTriggerStatements ["this", '
	[thisTrigger] spawn (thisTrigger getVariable "spawnWave");
	', ""];

	_missionHintText = format ["<t color='%1'>%2</t> will be infiltrate by enemy, defend and capture it!", mainMissionColor, _territoryName];
};

_ignoreAiDeaths = true;
_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = { _trigger getVariable ["Attacking", false] && count (_trigger getVariable ["Attackers", []] select { alive _x && vehicle _x == _x && _x distance _missionPos <= 10 }) >= 5};
_waitUntilSuccessCondition = {
	_trigger getVariable ["Attacking", false] && _trigger getVariable ["AttackersPool", 1] <= 0 && _trigger getVariable "Attackers" findIf {alive _x} == -1
}; // countdown finish, any player still alive in area, reward will give to everyone who in area. territory will auto transfer to most same side in area

_failedExec =
{
	if (count (_trigger getVariable ["Attackers", []] select {alive _x && vehicle _x == _x && _x distance2D _missionPos <= 10}) >= 5) then
	{
		_failedHintMessage = "Enemy have made through in final area";
	};
	
	_totalDead = count ((_trigger getVariable ["Attackers", []]) select {!alive _x});
	_failReward = [_reward * (_totalDead / _totalAttacker) * 0.75, 0] call BIS_fnc_cutDecimals;
	_triggerArea = triggerArea _trigger;
	{
		playSound "FD_Finish_F";
		[_x, _failReward] call A3W_fnc_setCMoney;
	} forEach (allPlayers select { _x inArea [position _trigger, _triggerArea select 0 * 1.5, _triggerArea select 1 * 1.5, _triggerArea select 2, _triggerArea select 3, -1] });
	{
		deleteVehicle _x;
	} forEach ((_trigger getVariable "Attackers" select {alive _x}) + (_trigger getVariable ["Vehicles", []] select {alive _x}));

	deleteVehicle _trigger;
};

_successExec =
{
	_triggerArea = triggerArea _trigger;
	{
		playSound "FD_Finish_F";
		[_x, _reward] call A3W_fnc_setCMoney;
	} forEach (allPlayers select { _x inArea [position _trigger, _triggerArea select 0 * 1.5, _triggerArea select 1 * 1.5, _triggerArea select 2, _triggerArea select 3, -1] });
	
	_randomBox = ["mission_USLaunchers","mission_RULaunchers","mission_USSpecial","mission_Main_A3snipers","mission_RUSniper"];
	_box1 = createVehicle ["Box_FIA_Support_F", (position _trigger) vectorAdd [random 30 + 15, random 30 + 35, random 30 + 80], [], 0, "NONE"];
	_box2 = createVehicle ["Box_FIA_Support_F", (position _trigger) vectorAdd [random 30 - 25, random 30 + 25, random 30 + 120], [], 0, "NONE"];
	_box3 = createVehicle ["Box_FIA_Support_F", (position _trigger) vectorAdd [random 30 + 35, random 30 - 15, random 30 + 100], [], 0, "NONE"];
	{
		_x setDir random 360;
		[_x, _randomBox call BIS_fnc_selectRandom] call fn_refillbox;
		_x setVariable ["R3F_LOG_disabled", false, true];
		_x setVariable ["cmoney", _totalAttacker * 1000, true];
		private _para = createVehicle ["I_parachute_02_F", [0,0,999999], [], 0, "NONE"];
		_para setDir (getDir _x);
		_para setPosATL (getPosATL _x);
		_x attachTo [_para, [0, 0, 0]];
		if (dayTime <= 20.5 && dayTime > 3.5) then
		{
			private _attachItem = createVehicle ["SmokeShellGreen", getPosATL _x, [], 0, "NONE"];
			_attachItem attachto [_x, [0,0,-0.5]];
		} else
		{
			private _attachItem = createVehicle ["B_IRStrobe", getPosATL _x, [], 0, "NONE"];
			_attachItem attachto [_x, [0,0,-0.5]];
		};
	} forEach [_box1, _box2, _box3];

	deleteVehicle _trigger;

	_successHintMessage = format ["Territory %1 has secured! Grab the reward", _territoryName];
};
_this call mainMissionProcessor;
