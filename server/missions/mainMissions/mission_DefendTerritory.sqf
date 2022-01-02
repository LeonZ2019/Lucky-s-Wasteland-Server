// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_DefendTerritory.sqf
//	@file Author: Leon
//	@file Created: 12/24/2021 14:11

if (!isServer) exitwith {};
#include "mainMissionDefines.sqf"

private ["_territories", "_territory", "_spawnRadius", "_territoryName", "_reward", "_createVehicle", "_spawnWave", "_trigger", "_cash", "_pos", "_currBox1", "_box1", "_box2", "_box3", "_randomBox", "_randomCase", "_camo"];

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
	_reward = (_territory select 2) * 25 max 40000;
};

_setupObjects =
{
	_createVehicle =
	{
		private ["_group", "_type", "_position", "_minDist", "_maxDist", "_special", "_variant", "_vehicle", "_soldier", "_camo"];

		_group = _this select 0;
		_type = _this select 1;
		_position = _this select 2;
		_minDist =  _this select 3;
		_maxDist =  _this select 4;
		_special = param [5, "NONE", [""]];
		_variant = param [6,"",[""]];

		for "_i" from 0 to 100 do
		{
			_position = [position _trigger, _minDist, _maxDist, 10, 0, 1, 0] call BIS_fnc_findSafePos;
			if (allplayers findif {_x distance _position < 400} == -1) exitwith {};
		};
		if (_type isKindOf "Helicopter") then
		{
			_position set [2, 200];
		} else
		{
			_position set [2, 0];
		};
		_vehicle = createVehicle [_type, _position, [], 0, _special];
		_vehicle setVariable ["R3F_LOG_disabled", true, true];

		if (_variant != "") then { _vehicle setVariable ["A3W_vehicleVariant", _variant, true] };

		[_vehicle] call vehicleSetup;
		_group addVehicle _vehicle;

		if (_vehicle isKindOf "Helicopter") then
		{
			_soldier = [_group, _position] call createRandomPilot;
			_soldier moveInDriver _vehicle;
			_soldier = [_group, _position] call createRandomPilot;
			_soldier moveInGunner _vehicle;
		} else {
			_camo = ["MTP", "Tropic", "CTRGUrban", "CTRGArid", "CTRGTropic", "Woodland", "GreenHex", "Hex", "Green", "Taiga", "Digital", "Geometric", "Guerilla"] call BIS_fnc_selectRandom;
			_soldier = [_group, _position, _camo] call createRandomSoldier;
			_soldier moveInDriver _vehicle;
			_soldier = [_group, _position, _camo] call createRandomSoldier;
			_soldier moveInGunner _vehicle;
		};
		[_vehicle, _group] spawn checkMissionVehicleLock;
		_vehicle
	};

	_spawnWave =
	{
		params ["_trigger"];
		private ["_aiGroup1", "_aiGroup2", "_aiGroup3", "_createVehicle", "_missionPos", "_attackers", "_attackersPool", "_spawnPositions", "_playerCount", "_triggerArea", "_minDist", "_maxDist", "_ranOff", "_tankClass", "_tank", "_heliClass", "_heli", "_speedMode", "_tankPos", "_heliPos"];
		_trigger setVariable ["Attacking", true, true];
		_createVehicle = _trigger getVariable "createVehicle";
		_missionPos = _trigger getVariable "missionPos";
		_attackers = _trigger getVariable "Attackers";
		_attackersPool = _trigger getVariable "AttackersPool";
		_camo = _trigger getVariable "camo";
		_spawnPositions = [];
		_triggerArea = triggerArea _trigger;
		_playerCount = count (allPlayers select { _x inArea [position _trigger, _triggerArea select 0 * 1.5, _triggerArea select 1 * 1.5, _triggerArea select 2, _triggerArea select 3, -1] }) max 1 min 4;
		_triggerArea resize 2;
		_minDist = (selectMax _triggerArea) * 2 + 50;
		_maxDist = _minDist * 1.5;
		_perGroup = parseNumber ((_minDist * 0.9) toFixed 0) max 10 min 20;
		for "_i" from 0 to (_playerCount - 1) do
		{
			_pos = [position _trigger, _minDist, _maxDist, 5, 0, 1, 0] call BIS_fnc_findSafePos;
			for "_i" from 0 to 100 do
			{
				_pos = [position _trigger, _minDist, _maxDist, 5, 0, 1, 0] call BIS_fnc_findSafePos;
				if (allplayers findif {_x distance _pos < 200} == -1) exitwith {};
			};
			_pos set [2, 0];
			_spawnPositions pushBack _pos;
			sleep 0.3;
		};
		_ranOff = selectrandom [0,0,0,0,1,1,1,2,2]; // nothing, tank, light heli

		if (_ranOff == 1) then
		{
			_aiGroup1 = createGroup civilian;
			_tankClass = ["B_MBT_01_cannon_F", "O_MBT_02_cannon_F", "I_MBT_03_cannon_F"] call BIS_fnc_selectRandom;
			_tank = [_aiGroup1, _tankClass, position _trigger, _minDist + 500, _maxDist + 750, "NONE", ""] call _createVehicle;
			_vehs = _trigger getVariable "Vehicles";
			_vehs pushBack _tank;
			_trigger setVariable ["Vehicles", _vehs, true];
			_attackers append (units _aiGroup1);
			_attackersPool = _attackersPool - (count units _aiGroup1);
			{
				_tankPos = _missionPos;
				_tankPos set [2, 0];
				_waypoint = _aiGroup1 addWaypoint [_tankPos, 0];
				_waypoint setWaypointType _x;
			} forEach ["SAD", "CYCLE"];
			[_aiGroup1, 0] setWaypointCompletionRadius 25;
		};

		if (_ranOff == 2) then
		{
			_aiGroup2 = createGroup civilian;
			_heliClass = [["B_Heli_Light_01_dynamicLoadout_F", "pawneeNormal"], ["O_Heli_Light_02_dynamicLoadout_F", "orcaDAGR"], "I_Heli_light_03_dynamicLoadout_F"] call BIS_fnc_selectRandom;
			_variant = "";
			if (_heliClass isEqualType []) then
			{
				_variant = _heliClass select 1;
				_heliClass = _heliClass select 0;
			};
			_heli = [_aiGroup2, _heliClass, position _trigger, _minDist + 750, _maxDist + 1000,  "FLY", _variant] call _createVehicle;
			_vehs = _trigger getVariable "Vehicles";
			_vehs pushBack _heli;
			_trigger setVariable ["Vehicles", _vehs, true];
			_attackers append (units _aiGroup2);
			_attackersPool = _attackersPool - (count units _aiGroup2);
			{
				if (["CMFlare", _x] call fn_findString != -1) then
				{
					_heli removeMagazinesTurret [_x, [-1]];
				};
			} forEach getArray (configFile >> "CfgVehicles" >> _heliClass >> "magazines");
			{
				_heliPos = _missionPos;
				_heliPos set [2, 50];
				_waypoint = _aiGroup2 addWaypoint [_heliPos, 0];
				_waypoint setWaypointType "_x";
			} forEach ["MOVE", "LOITER"];
			[_aiGroup2, 0] setWaypointCompletionRadius 25;
			[_aiGroup2, 1] setWaypointLoiterRadius (selectMin _triggerArea);
		};
		{
			_aiGroup3 = createGroup civilian;
			[_aiGroup3, _x, _perGroup, 15, _camo] call createCustomGroup3;
			_aiGroup3 setCombatMode "RED";
			_aiGroup3 setBehaviour "COMBAT";
			_aiGroup3 setFormation "WEDGE";
			_attackers append (units _aiGroup3);
			_attackersPool = _attackersPool - _perGroup;
			_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };
			_aiGroup3 setSpeedMode _speedMode;
			while {(count (waypoints _aiGroup3)) > 0} do
			{
				deleteWaypoint ((waypoints _aiGroup3) select 0);
			};
			{
				_waypoint = _aiGroup3 addWaypoint [_missionPos, 0];
				_waypoint setWaypointType _x;
			} forEach ["SAD", "CYCLE"];
		} forEach _spawnPositions;
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
	_trigger setVariable ["AttackersPool", (count allPlayers) * 40 max 250, true];
	_trigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
	_triggerArea = markerSize (_territory select 0) + [markerDir (_territory select 0), markerShape (_territory select 0) == "RECTANGLE", 50];
	_trigger setTriggerArea _triggerArea;
	_trigger setTriggerStatements ["this", '
	[thisTrigger] spawn (thisTrigger getVariable "spawnWave");
	', ""];

	_missionHintText = format ["<t color='%1'>%2</t> will be infiltrate by enemy, defend and capture it!", mainMissionColor, _territoryName];
};

_ignoreAiDeaths = true;
_waitUntilMarkerPos = { _missionPos };
_waitUntilExec = nil;
_waitUntilCondition = { _trigger getVariable ["Attacking", false] && count (_trigger getVariable ["Attackers", []] select { alive _x && vehicle _x == _x && _x distance _missionPos <= 10 }) >= 5};
_waitUntilSuccessCondition = {
	_trigger getVariable ["Attacking", false] && _trigger getVariable ["AttackersPool", 1] <= 0 && _trigger getVariable "Attackers" findIf {alive _x} == -1
}; // countdown finish, any player still alive in area, reward will give to everyone who in area. territory will auto transfer to most same side in area

_failedExec =
{
	// systemChat "territory retrieve back to sideUnknown!";
	if (count (_trigger getVariable ["Attackers", []] select {alive _x && vehicle _x == _x &&  _x distance2D _missionPos <= 10}) >= 5) then
	{
		_failedHintMessage = "Enemy have made through in final area";
	};
	deleteVehicle _trigger;
	{
		deletevehicle _x;
	} forEach (((_trigger getVariable "Attackers") select {alive _x}) + (_trigger getVariable ["Vehicles", []] select {alive _x}));
};

_successExec =
{
	{
		[_x, _reward] call A3W_fnc_setCMoney;
	} forEach (allPlayers select { _x inArea _trigger });

	_randomBox = ["mission_USLaunchers","mission_RULaunchers","mission_USSpecial","mission_Main_A3snipers","mission_RUSniper"];
	_randomCase = ["Box_FIA_Support_F","Box_FIA_Wps_F","Box_FIA_Ammo_F"] call BIS_fnc_selectRandom;

	_box1 = createVehicle [_randomCase, (position _trigger) vectorAdd [random 30 + 15, random 30 + 35, random 30 + 80], [], 0, "NONE"];
	_box2 = createVehicle [_randomCase, (position _trigger) vectorAdd [random 30 + 25, random 30 + 25, random 30 + 120], [], 0, "NONE"];
	_box3 = createVehicle [_randomCase, (position _trigger) vectorAdd [random 30 + 35, random 30 + 15, random 30 + 100], [], 0, "NONE"];

	{
		_x setDir random 360;
		[_x, _randomBox call BIS_fnc_selectRandom] call fn_refillbox;
		_x setVariable ["R3F_LOG_disabled", false, true];

		_para = createVehicle [format ["I_parachute_02_F"], [0,0,999999], [], 0, ""];
		_para setDir getDir _x;
		_para setPosATL getPosATL _x;
		_x attachTo [_para, [0, 0, 0]];

		while {(getPos _x) select 2 > 3 && attachedTo _x == _para} do
		{
			_para setVectorUp [0,0,1];
			_para setVelocity [0, 0, (velocity _para) select 2];
			uiSleep 0.1;
		};
	} forEach [_box1, _box2, _box3];

	_successHintMessage = format ["Territory %1 has secured! Grab the reward", _territoryName];
};
_this call mainMissionProcessor;
