// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_chemical.sqf
//	@file Author: Leon
//	@file Created: 4/21/2023 05:10

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf";

private ["_nbUnits", "_town", "_townName", "_missionPos", "_buildingRadius", "_putOnRoof", "_fillEvenly", "_aiGroup1", "_aiGroup2", "_units", "_sizes", "_supplyPos", "_supplyPos", "_supply", "_supplyPos", "_boxTypes", "_boxType", "_box", "_boxPos"];

_setupVars =
{
	_missionType = "Ghost Town"; // town invasion but chemical
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };

	_locArray = ((call cityList) call BIS_fnc_selectRandom);
	_town = _locArray select 0;
	_missionPos = markerPos _town;
	_buildingRadius = _locArray select 1;
	_townName = _locArray select 2;

	_nbUnits = _nbUnits + round(random (_nbUnits*0.5));
	_buildingRadius = if (_buildingRadius > 201) then {(_buildingRadius*0.5)} else {_buildingRadius};
	if (random 1 < 0.75) then { _putOnRoof = true } else { _putOnRoof = false };
	if (random 1 < 0.75) then { _fillEvenly = true } else { _fillEvenly = false };
};

_setupObjects =
{
	_units = [];
	_aiGroup1 = createGroup CIVILIAN; // skill low
	[_aiGroup1, _missionPos, _nbUnits] call createCustomGroup5; // cbrn gear
	_units append (units _aiGroup1);
	[_aiGroup1, _missionPos, _buildingRadius, _fillEvenly, _putOnRoof] call moveIntoBuildings;

	_aiGroup2 = createGroup CIVILIAN;
	[_aiGroup2, _missionPos, _nbUnits] call createCustomGroup5; // cbrn gear
	[_aiGroup2, _missionPos, _buildingRadius, _fillEvenly, _putOnRoof] call moveIntoBuildings;
	_units append (units _aiGroup2);
	_sizes = markerSize _town;

	_supplyPos = [_missionPos, 10, selectMin _sizes, 2, 0, 0, 0, [], _missionPos] call BIS_fnc_findSafePos; // how about move into house? less visible from air
	_supply = createVehicle ["Land_CratesWooden_F", _supplyPos, [], 0, "NONE"];
	_supply setDir (random 360);
	_boxTypes = ["mission_USLaunchers","mission_RULaunchers","mission_USSpecial","mission_USRifles","mission_RURifles","mission_Main_A3snipers","mission_RUSniper","mission_Explosive","mission_Militia"];
	_boxType = _boxTypes call BIS_fnc_selectRandom;
	_boxPos = [_supplyPos, 0, 20, 2, 0, 0, 0, [], _supplyPos] call BIS_fnc_findSafePos;
	_box = createVehicle ["Box_NATO_Wps_F", _boxPos, [], 5, "None"];
	_box setDir random 360;
	[_box, _boxType] call fn_refillbox;
	_box allowDamage true;

	["Ghost_Town", _supplyPos, direction _supply, (_sizes select 0) / 1.5, (_sizes select 1) / 1.5, markerShape _town == "RECTANGLE"] execVM "addons\contactScripts\CBRN\createArea.sqf";

	_missionHintText = format ["Chemical leak in <t size='1.25' color='%1'>%2</t><br/>There seem to be <t color='%1'>%3 looters</t> running ghost town. Destroy the leaking source!<br/> Remember no scavenger!", sideMissionColor, _townName, _nbUnits * 2];
};

_ignoreAiDeaths = true;
_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;
_waitUntilSuccessCondition = { _units findIf { alive _x } == -1 && !alive _supply };

_failedExec =
{
	["Ghost_Town"] execVM "addons\contactScripts\CBRN\deleteArea.sqf";
	
	if ({ alive _x } count _units > 1) then
	{
		_creatures = _units select {alive _x};
		{
			_x addRating -1e13;
		} forEach _creatures;
		[_creatures, _supplyPos] spawn
		{
			params ["_creatures", "_supplyPos", "_maxTime"];
			_maxTime = 150; // 2.5 minutes
			while {{ alive _x } count _creatures > 1 || _maxTime >= 0} do
			{
				{
					if (alive _x) then {
						_dmg = (damage _x) + 0.03;
						_x setDamage _dmg;
						_x doMove _supplyPos;
					};
				} forEach _creatures;
				uiSleep 10;
				_maxTime = _maxTime - 10;
			};
			{ _x setDamage 1; } forEach _creatures;
		};
	};
	deleteVehicle _supply;
	deleteVehicle _box;
	_failedHintMessage = "All human in town mutated into infected";
};

_successExec =
{
	// Mission completed
	["Ghost_Town"] execVM "addons\contactScripts\CBRN\deleteArea.sqf";
	if (alive _box) then
	{
		_box allowDamage false;
		_box setVariable ["R3F_LOG_disabled", false, true];
	};
	deleteVehicle _supply;

	_successHintMessage = "You just extinct all civilian who left behind!";
};

_this call sideMissionProcessor;