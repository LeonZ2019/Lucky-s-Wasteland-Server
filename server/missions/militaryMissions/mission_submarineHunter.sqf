// spawn submarine, then will need helicopter to indentify without getting kill by
// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_redDawn.sqf

if (!isServer) exitwith {};
#include "militaryMissionDefines.sqf";

private ["_deep", "_posASL", "_ATLAlt", "_submarineClass", "_submarine", "_submarine", "_vls", "_grid"];

_setupVars =
{
	_missionType = "Hunter Killer";
	_locationsArray = DeepWaterMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_deep = 0.8;
	_posASL = _missionPos vectorAdd ([[random 1000, 0, 0], random 360] call BIS_fnc_rotateVector2D);
	_posATL = ASLToATL _posASL;
	_ATLAlt = ((_posATL select 2) * _deep);
	_posASL set [2, -_ATLAlt + 16.80456];
	_submarineClass = "Submarine_01_F";
	_submarine = createSimpleObject [_submarineClass, _posASL];
	/*
		_workSub = createVehicle ["B_SDV_01_F", getPosASL _submarine, [], 0, "CAN_COLLIDE"];
		_workSub hideObject true;
		_workSub allowDamage false;
	*/

	_missionPicture = "client\icons\hms.paa";
	_missionHintText = format ["An unknown submarine in somewhere of Malden, take their out before they have acquire player location <br/><t size='1.25' color='%1'>CH-49 Mohawk is required</t> for deploy sonar. You have 25 minutes until they lock and launch missile!", militaryMissionColor];
};

_ignoreAiDeaths = true;
_waitUntilMarkerPos = nil;
_waitUntilExec = nil;

_waitUntilCondition = nil;
_waitUntilSuccessCondition = {
	_submarine getVariable ["detected", false]
};

_failedExec =
{
	if (count allPlayers >= 1) then
	{
		_vls = createVehicle ["B_Ship_MRLS_01_F", getPos _submarine, [], 0, "CAN_COLLIDE"];

		createVehicleCrew _vls;
		_grp = createGroup CIVILIAN; 
		(crew _vls) joinSilent _grp;

		_vls hideObjectGlobal true;
		_vls allowDamage false;
		_pos = getPosASLW _vls;
		_pos set [2, 0];
		_vls setPosASLW _pos;

		_player = allPlayers call BIS_fnc_selectRandom;
		CIVILIAN reportRemoteTarget [_player, 3000];
		_vls confirmSensorTarget [side _player, true];
		_vls fireAtTarget [_player, "weapon_vls_01"];
		[_vls] spawn
		{
			params ["_vls"];
			uiSleep 60;
			deleteVehicle _vls;
		};
		_grid = mapGridPosition _player;
		_failedHintMessage = format ["Miller launch a cruise missile to Player %1 at GRID %2", name _player, _grid];
	};
	deleteVehicle _submarine;
	// deleteVehicle _workSub;
};


_successExec =
{
	deleteVehicle _submarine;
	// deleteVehicle _workSub;

	_successHintMessage = format ["HMS PROTEUS dissapear from radar. %1, %2", ["Malden is safe now that Miller has left", "Away from Miller, the island is safe", "Malden was safe from HMS Proteus and Miller"] call BIS_fnc_selectRandom, "they left behind the recon submarine which may have contained any fortune"];

};

_this call militaryMissionProcessor;
