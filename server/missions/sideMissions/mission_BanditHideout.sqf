// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_BanditHideout.sqf
//	@file Author: Leon
//	@file Created: 3/31/2023 05:44

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf";

private ["_missionPos", "_nbUnits", "_bandits", "_supplyPos", "_supply", "_tentPos", "_tent", "_aiGroup"];

_setupVars =
{
	_missionType = "Bandit Hideout";
	_locationsArray = MountainMissionMarkers;

	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
	_nbUnits = _nbUnits / 4;
	_bandits = [];
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_supplyPos = _missionPos vectorAdd ([[75 + (random 400), 0], random 360] call BIS_fnc_rotateVector2D);
	_supplyPos = [_supplyPos, 0, 25, 4.1, 0, 0, 0, [], _supplyPos] call BIS_fnc_findSafePos;
	_supply = createVehicle ["Box_Syndicate_Wps_F", _supplyPos,[], 0, "NONE"];
	[_supply, "mission_empty"] call fn_refillbox;
	_supply setVariable ["R3F_LOG_disabled", false, true];

	_tentPos = _supply getRelPos [2, 0];
	_tent = createVehicle ["Land_TentSolar_01_sand_F", _tentPos, [], 0, "CAN_COLLIDE"];
	_tent enableSimulationGlobal false;
	_tent allowDamage false;

	_dir = _missionPos getDirVisual _supplyPos;
	_direction = [[{_dir >= 45 && _dir <= 135}, "East"], [{_dir > 135 && _dir < 225}, "South"], [{_dir >= 225 && _dir <= 315}, "West"], [{_dir > 315 || _dir < 45}, "North"]];
	_name = _direction select { call (_x select 0) } select 0 select 1;
	_missionHintText = format ["A <t color='%1'>Stolen Supplies</t> has been reported it is hidden in the mountain with radius 500m from center, worth to search <t color='%1'>%2 Side</t>, locate it then and extract!", sideMissionColor, _name];
};

_ignoreAiDeaths = true;
_waitUntilMarkerPos = nil;
_waitUntilExec = {
	private _timeout = _supply getVariable ["timeout", 0];
	_distance = _supply getVariable ["R3F_LOG_est_transporte_par", _supply] distance2D _supplyPos;
	_supply setVariable ["timeout", _timeout + 1];
	if (_timeout % 60 == 0 && random 100 > ([66, 33] select (_distance <= 20))) then
	{
		_group = createGroup CIVILIAN;
		for "_i" from 2 to (2 + (ceil (random (_nbUnits - 2)))) do
		{
			_position = _supplyPos vectorAdd ([[random 500, 0, 0], random 360] call BIS_fnc_rotateVector2D);
			[_group, _position] call createRandomBandits;
		};
		_bandits pushBack _group;
	};
	if (_distance > 20) then
	{
		_target = _supply getVariable ["R3F_LOG_est_transporte_par", _supply];
		_targetPos = position _target;
		{
			(units _x) doMove _targetPos;
		} forEach _bandits;
	};
};
_waitUntilCondition = nil;

_waitUntilSuccessCondition = {
	_actualObj = _supply getVariable ["R3F_LOG_est_transporte_par", _supply];
	if (isNull _actualObj) then
	{
		_actualObj = _supply;
	};
	(_actualObj distance2D _supplyPos) > 800
};

_failedExec =
{
	// Mission failed
	if !(isNull (_supply getVariable ["R3F_LOG_est_transporte_par", objNull])) then
	{
		[_supply, "mission_junk"] call fn_refillbox;
		// refill box with yuke
	} else
	{
		deleteVehicle _supply;
	};
	deleteVehicle _tent;
	{
		_group = _x;
		{
			if (alive _x) then { deleteVehicle _x } 
		} forEach units _group;
		deleteGroup _group;
	} forEach _bandits;
};

_successExec =
{
	// Mission completed
	deleteVehicle _tent;
	{
		_group = _x;
		{
			if (alive _x) then { deleteVehicle _x } 
		} forEach units _group;
		deleteGroup _group;
	} forEach _bandits;
	
	_randomBox = ["mission_Militia","General_supplies","mission_Gear","mission_Main_A3snipers","mission_Explosive","mission_RULaunchers", "mission_USLaunchers"] call BIS_fnc_selectRandom;

	[_supply, _randomBox] call fn_refillbox;
	// _supply setVariable ["perkPoints", 1, true]; // to be edit later

	_successHintMessage = "The supplies has been successful retrieved!";
};

_this call sideMissionProcessor;