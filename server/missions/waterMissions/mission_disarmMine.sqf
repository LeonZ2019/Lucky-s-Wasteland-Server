// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 2
//	@file Name: mission_disarmMine.sqf
//	@file Author: Leon
//	@file Created: 04/10/2023 16:16
//	@file Args: none

if (!isServer) exitwith {};
#include "waterMissionDefines.sqf"

private ["_boxTypes", "_boxType", "_box", "_activeMine", "_mines", "_mine", "_speedMode"];

_setupVars =
{
	_missionType = "Minesweeper";
	_locationsArray = SunkenMissionMarkers;
};

_setupObjects =
{ // once trigger, check condition player nearby then send some enemy intercept it, it is infinity
	private ["_pos"];
	_missionPos = markerPos _missionLocation;
	_mines = [];
	// _mine setPosASL _missionPos;
	for "_i" from 1 to 10 do {
		_mine = createMine ["UnderwaterMine", _missionPos, [], 75];
		_pos = getPosATL _mine;
		_pos set [2, (_pos select 2) - 3 - (random 10)];
		_mine setPosATL _pos;
		_mines pushBack _mine;
	};
	_activeMine = count _mines;
	_boxTypes = ["mission_USSpecial","mission_USRifles","mission_RURifles","mission_Explosive","mission_Gear","mission_Diving","mission_Militia"];
	_boxType = _boxTypes call BIS_fnc_selectRandom;
	_box = createVehicle ["Box_NATO_Wps_F", _missionPos, [], 5, "None"];
	[_box, _boxType] call fn_refillbox;
	_boxPos = getPosASL _box;
	_boxPos set [2, getTerrainHeightASL _boxPos + 1];
	_box setPos _boxPos;
	_box setDir random 360;
	_box setVariable ["R3F_LOG_disabled", true, true];

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };
	_aiGroup = createGroup [CIVILIAN, false];
	_aiGroup setSpeedMode _speedMode;
	// 
	// [_aiGroup, _missionPos] call createSmallDivers;

	_missionHintText = "Several enemy's naval bombs have been spotted in the ocean near the marker. Watch out for reinforcement and explosion. Mine detector and an toolkit are needed.";
};

_ignoreAiDeaths = true;
_waitUntilMarkerPos = nil;
_waitUntilExec = {
	if (({ mineActive _x } count _mines) != _activeMine) then
	{
		_activeMine = { mineActive _x } count _mines;
		if (random 100 >= 80) then
		{
			private _randomPos = [_missionPos, 100, 125, 0, 2, 0, 0] call BIS_fnc_findSafePos;
			[_aiGroup, _randomPos, false] call createSmallDivers;
			_aiGroup move _missionPos;
		};
	};
};
_waitUntilCondition = nil;
_waitUntilSuccessCondition = { _mines findIf { mineActive _x } == -1 && units _aiGroup findIf {alive _x} == -1 };

_failedExec =
{
	// Mission failed
	deleteVehicle _box;
	{
		if (!isNull _x) then
		{
			if (mineActive _x) then
			{
				_x setDamage 1;
			} else
			{
				deleteVehicle _x;
			};
		};
	} forEach _mines;
};

_successExec =
{
	// Mission completed
	_box setVariable ["R3F_LOG_disabled", false, true];

	_successHintMessage = "All naval bomb have been neutralize, well done.";
	{ if (!isNull _x) then { deleteVehicle _x; }; } forEach _mines;
};

_this call waterMissionProcessor;
