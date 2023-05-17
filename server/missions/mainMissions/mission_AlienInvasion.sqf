// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: main_AlienInvasion.sqf
//	@file Author: Leon
//	@file Created: 4/21/2023 02:02

if (!isServer) exitwith {};
#include "mainMissionDefines.sqf"

private ["_nbUnits", "_alien", "_pos", "_terminal", "_enemy", "_air", "_ground", "_camo", "_trigger", "_startMission", "_canSpawn", "_aiGroup", "_operator"];

_setupVars =
{
	_missionType = "The Visitor";
	_locationsArray = MountainMissionMarkers;
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
	_nbUnits = ceil (_nbUnits * 2 / 3);
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_missionPos set [2, 50 + random 300];
	// alien fall from sky
	_alien = createSimpleObject [getMissionPath "mothership\Mothership_01_F.p3d", _missionPos];
	_alien setPosATL _missionPos;
	_alien setDir (random 360);
 
	_pos = [_missionPos, 200, 500, 2] call BIS_fnc_findSafePos;
	_missionPos = _pos;

	_terminal = createVehicle ["Land_DataTerminal_01_F", _missionPos, [], 0, "NONE"];
	[_terminal, "orange", "red", "green"] call BIS_fnc_dataTerminalColor;
	_terminal allowDamage false;
	TerminalEHAdd = _terminal;
	publicVariable "TerminalEHAdd";

	_enemy = [];
	_startMission = false;
	_canSpawn = { count (_enemy select { alive _x }) <= ((_nbUnits / 4) max 2) };
	/* _air = ["I_Heli_light_03_dynamicLoadout_F", "I_Plane_Fighter_03_dynamicLoadout_F", "I_Plane_Fighter_04_F"]; // heli and jet
	_ground = ["I_APC_tracked_03_cannon_F", "I_APC_Wheeled_03_cannon_F"]; */

	// set trigger when a air object such as plane or heli with exploded if in range 200
	_trigger = createTrigger ["EmptyDetector", getPos _alien, true];
	// _trigger setPosASL (getPosASL _alien);
	_trigger setTriggerArea [400, 400, 0, false, 400];
	_trigger setTriggerInterval 0.5;
	_trigger setTriggerActivation ["ANY", "PRESENT", true];
	_trigger setTriggerStatements ["
	thisList findIf {!(_x isKindOf 'CAManBase') && !(_x getVariable ['EMP_STUNNED', false])} != -1
	", "
	{
		if (!(_x isKindOf 'CAManBase') && !( _x getVariable ['EMP_STUNNED', false])) then
		{
			_x setVariable ['EMP_STUNNED', true, true];
			_x setVariable ['EMP_Source', thisTrigger, true];
			if (isEngineOn _x) then
			{
				(driver _x) groupChat 'Engine failure';
				_x setVariable ['EMP_LastMessage', ceil time, true];
				_x engineOn false;
			};
			_index = _x addEventHandler ['Engine', {
				params ['_vehicle', '_engineState'];
				_source = _vehicle getVariable 'EMP_Source';
				if (_vehicle inArea _source) then
				{
					if (_engineState) then
					{
						_time = _vehicle getVariable ['EMP_LastMessage', ceil time - 1];
						if (ceil time - _time >= 1) then
						{
							(driver _vehicle) groupChat 'Engine start failure.';
							_vehicle setVariable ['EMP_LastMessage', ceil time, true];
						};
						_vehicle engineOn false;
					};
				} else
				{
					_vehicle setVariable ['EMP_STUNNED', false, true];
					_index = _vehicle getVariable 'Engine_index';
					_vehicle removeEventHandler ['Engine', _index];
				};
			}];
			_x setVariable ['Engine_index', _index, true];
		};
	} forEach thisList;
	", ""];
	_missionHintText = "An unusual phenomena happen in mountains, locate terminal and secure it!";
};

_ignoreAiDeaths = true;
_waitUntilMarkerPos = nil;
_waitUntilExec = {
	TerminalEHAdd = _terminal;
	publicVariable "TerminalEHAdd";
	if (!_startMission) then
	{
		_startMission = _terminal getVariable ["startMission", false];
	};
	if (_startMission && call _canSpawn && !(_terminal getVariable ["secured", false])) then
	{
		_aiGroup = createGroup civilian;
		_from = [_pos, 200, 400, 2] call BIS_fnc_findSafePos;
		_enemy append ([_aiGroup, _nbUnits, _from, _pos] call createCustomGroup4);
			
		_operator = _terminal getVariable ["Radio_interceptor", []];
		_operator append (_enemy select { _x getVariable ["IsRadioOperator", false] });
		_terminal setVariable ["Radio_interceptor", _operator, true];
		_terminal setVariable ["enemy", _enemy];
	};
};
_waitUntilCondition = {
	// radio operator in distance 10m
	(_enemy select { _x getVariable ["IsRadioOperator", false] } findIf { _x distance _terminal <= 10 } != -1)
};
_waitUntilSuccessCondition = {
	_terminal getVariable ["secured", false] && _enemy findIf { alive _x } == -1
	// all livonian defence force die?
};
_failedExec =
{
	TerminalEHRemove = _terminal;
	publicVariable "TerminalEHRemove";
	if (_enemy findIf { _x distance _terminal <= 10 } != -1) then
	{
		_failedHintMessage = "Enemy sabotaged the terminal, run before too late";
	};
	{ deleteVehicle _x } forEach (_enemy select { alive _x }) + [_terminal, _alien, _trigger];
	// alien attack, create massive attack? tf im talking?
};

_successExec =
{
	TerminalEHRemove = _terminal;
	publicVariable "TerminalEHRemove";
	// alien get back to sky
	/*
	
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
	} forEach [_box1, _box2, _box3];*/
	{ deleteVehicle _x } forEach (_enemy select { alive _x }) + [_terminal, _alien, _trigger];
	_successHintMessage = "Extraterrestrials has been changed to peace mode";
};
_this call mainMissionProcessor;
