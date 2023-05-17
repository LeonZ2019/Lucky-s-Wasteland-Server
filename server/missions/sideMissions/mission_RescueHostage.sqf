// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_RescueHostage.sqf
//	@file Author: Leon
//	@file Created: 7/27/2021 16:07

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf";

private ["_missionPos", "_hostageGroup", "_safePos", "_hostage", "_obj", "_cash"];

_setupVars =
{
	_missionType = "Hostage Rescue";
	_locArray = ((call cityList) call BIS_fnc_selectRandom);
	_missionPos = markerPos (_locArray select 0);
};

_setupObjects =
{
	_hostageGroup = createGroup CIVILIAN;
	_safePos = [_missionPos, 0, 30, 5, 0, 0, 0] call findSafePos;
	_hostage = [_hostageGroup, _safePos] call createHostage;
	[_hostageGroup, _missionPos, 25, true, false] call moveIntoBuildings;
	[_hostage, "Acts_ExecutionVictim_Loop"] call switchMoveGlobal;

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, 10] call createCustomGroup2;
	[_aiGroup, _missionPos, 50, true, false] call moveIntoBuildings;

	HostageEHAdd = [_hostage, _aiGroup];
	publicVariable "HostageEHAdd";

	_missionHintText = "A hostage has been found, rescue it!";
};

_waitUntilMarkerPos = {getPos _hostage};
_waitUntilExec =
{
	// HostageEHAdd = [_hostage, _aiGroup];
	// publicVariable "HostageEHAdd";
};
_waitUntilCondition = {!alive _hostage};
_waitUntilSuccessCondition = { animationState _hostage == "amovpercmstpsnonwnondnon" };
_ignoreAiDeaths = true;
_failedExec = {
	HostageEHRemove = _hostage;
	publicVariable "HostageEHRemove";
	deleteVehicle _hostage;
};

_successExec =
{
	// Mission completed
	_hostage playActionNow "PutDown";
	sleep 0.5;
	_obj = createVehicle ["Land_Defibrillator_F", [_hostage, [0,1,0]] call relativePos, [], 0, "CAN_COLLIDE"];
	_obj setDir getDir _hostage;
	_obj setVariable ["mf_item_id", "defibrillator", true];
	_cash = createVehicle ["Land_Money_F", [_hostage, [0,1,0]] call relativePos, [], 5, "None"];
	_cash setPos ([_hostage, [0,1,0], [[0,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
	_cash setVariable ["owner", "world", true];
	_cash setVariable ["cmoney", 10000, true];

	sleep 2;
	HostageEHRemove = _hostage;
	publicVariable "HostageEHRemove";
	deleteVehicle _hostage;
	_successHintMessage = "Hostage has been rescued.";
};

_this call sideMissionProcessor;
