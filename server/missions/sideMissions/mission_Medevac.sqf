// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Created: 08/25/2021 01:40

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf";

private ["_patientGroup", "_patient", "_camo", "_soldiers", "_direction", "_safePos", "_smoke", "_leader", "_baseToDelete", "_headquarters", "_missionHQ", "_box", "_boxType", "_defib", "_beacon"];

_setupVars =
{
	_missionType = "Medical Evacuation";
	_locationsArray = ForestMissionMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_camo = ["MTP", "Tropic", "CTRGUrban", "CTRGArid", "CTRGTropic", "Woodland", "GreenHex", "Hex", "Green", "Taiga", "Digital", "Geometric", "Guerilla"] call BIS_fnc_selectRandom;
	_patientGroup = createGroup CIVILIAN;
	_patient = [_patientGroup, _missionPos, _camo] call createRandomSoldier;
	_patient setVariable ["FAR_isUnconscious", 1, true];
	_patient setVariable ["FAR_isStabilized", 1, true];
	_patient setVariable ["FAR_handleStabilize", true, true];
	_patient setVariable ["Mission_Man", true, true];
	removeAllWeapons _patient;
	{ _patient removeMagazine _x } forEach (magazines _patient);
	_patient setName "Rhyane";
	[_patient] spawn FAR_Player_Unconscious;

	_aiGroup = createGroup CIVILIAN;
	_soldiers = [];
	_soldiers pushBack ([_aiGroup, _patient modelToWorld [3,0,0], _camo] call createRandomSoldier);
	_soldiers pushBack ([_aiGroup, _patient modelToWorld [0,-3,0], _camo] call createRandomSoldier);
	_soldiers pushBack ([_aiGroup, _patient modelToWorld [-3,0,0], _camo] call createRandomSoldier);
	_soldiers pushBack ([_aiGroup, _patient modelToWorld [0,3,0], _camo] call createRandomSoldier);
	_direction = 90;
	{
		[_x, "AidlPknlMstpSrasWrflDnon_G0S"] call switchMoveGlobal;
		_x disableAI "MOVE";
		_X disableAI "ANIM";
		_X disableAI "TARGET";
		_x setDir _direction;
		_direction = _direction + 90;
	} forEach _soldiers;
	_leader = leader _aiGroup;
	_smoke = createVehicle ["SmokeShellGreen", position _leader, [], 0, "NONE"];
	_smoke attachTo [_leader, [-0.1,-0.15,0.2], "head"];
	// HQ
	_safePos = ((HQSafePosMarkers call BIS_fnc_selectRandom) select 0);
	_baseToDelete = nearestObjects [MarkerPos _safePos, ["All"], 8];
	{ deleteVehicle _x } forEach _baseToDelete;
	_headquarters = ["Medevac_Headquarters", MarkerPos _safePos, markerDir _safePos] call createOutpost;
	_safePos = MarkerPos _safePos;
	{
		if (typeOf _x == "Land_MedicalTent_01_white_IDAP_med_closed_F") then
		{
			_x animateSource ["Door_Hide", 1];
			_x animateSource ["SolarPanel1_Hide", 1];
			_x animateSource ["SolarPanel2_Hide", 1];
		};
		_x allowDamage false;
		_x setDammage 0;
	} forEach _headquarters;
	_boxType = ["mission_USLaunchers","mission_RULaunchers","mission_USSpecial","mission_USRifles","mission_RURifles","mission_Explosive","mission_Gear","mission_Militia"] call BIS_fnc_selectRandom;
	_box = createVehicle ["Box_NATO_WpsSpecial_F", _safePos, [], 2, "None"];
	_box setDir random 360;
	[_box, _boxType] call fn_refillbox;
	_box setVariable ["R3F_LOG_disabled", true, true];

	_missionHQ = createMarker ["missionHQ", _safePos];
	_missionHQ setMarkerType "loc_Hospital";
	_missionHQ setMarkerText "Medical Tent";
	_missionHQ setMarkerColor "ColorWhite";
	_missionHQ setMarkerSize [0.5, 0.5];

	_missionHintText = format ["A medevac been called at <t color='%1'></t> location, use helicopter bring him return to Medical Tent!", sideMissionColor]
};

_ignoreAiDeaths = true;
_waitUntilMarkerPos = nil;
_waitUntilExec = {
	if (!alive _smoke && _leader distance _patient <= 10) then
	{
		_smoke = createVehicle ["SmokeShellGreen", position _leader, [], 0, "NONE"];
		_smoke attachTo [_leader, [-0.1,-0.15,0.2], "head"];
	}
};
_waitUntilCondition = {
	!alive _patient
};
_waitUntilSuccessCondition = {
	_patient distance _safePos < 5 && vehicle _patient == _patient && isNull (_patient getVariable ["FAR_draggedBy", objNull])
};

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach _headquarters;
	{ deleteVehicle _x } forEach [_patient, _smoke, _box];
	deleteMarker _missionHQ;
};

_successExec =
{
	// Mission complete
	deleteMarker _missionHQ;
	_defib = createVehicle ["Land_Defibrillator_F", position _patient, [], 0, "CAN_COLLIDE"];
	_defib setVariable ["mf_item_id", "defibrillator", true];
	_beacon = createVehicle ["Land_Sleeping_bag_folded_F", position _patient, [], 0, "CAN_COLLIDE"];
	_beacon setVariable ["mf_item_id", "spawnbeacon", true];
	_box setVariable ["R3F_LOG_disabled", false, true];
	{ deleteVehicle _x } forEach _headquarters;
	{ deleteVehicle _x } forEach [_patient, _smoke];
	_successHintMessage = "Rhyane has been rescued!";
};

_this call sideMissionProcessor;
