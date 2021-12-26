// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_airdrop.sqf
//	@file Author: Leon
//	@file Created: 08/19/2021 18:45

if (!isServer) exitwith {};
#include "logisticsMissionDefines.sqf"

private ["_town", "_dropCenter", "_dropRadius", "_dropName", "_cratePos", "_crate", "_smoke", "_para", "_missionAirdrop", "_crate", "_veh", "_lastDriver", "_cash"];

_setupVars =
{
	_missionType = "Airdrop Supply";
	_locationsArray = MissionSpawnMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_town = ((call cityList) call BIS_fnc_selectRandom);
	_dropCenter = markerPos (_town select 0);
	while {_dropCenter distance _missionPos < 5500 || _dropCenter distance _missionPos > 7500} do {
		_town = ((call cityList) call BIS_fnc_selectRandom);
		_dropCenter = markerPos (_town select 0);
	};
	_dropRadius = _town select 1;
	_dropName = _town select 2;
	_crate = createVehicle ["Land_CargoBox_V1_F", _missionPos vectorAdd [0, 0, 75], [], 1, "None"];
	_crate setVariable ["Mission_Crate", true];
	_crate setVariable ["Mission_AirdropOnly", true];
	_crate allowDamage false; 
	_smoke = createVehicle ["SmokeShell", position _crate, [], 0, "NONE"]; 
	_smoke attachTo [_crate, [0, 0, 0.65]];

	_para = createVehicle ["I_parachute_02_F", position _crate, [], 0, ""];

	_para setDir getDir _crate;
	_para setPosATL getPosATL _crate;
	_crate attachTo [_para, [0, 0, 0]];

	[_crate, _para] spawn {
		params ["_crate", "_para"];
		while {(getPos _crate) select 2 > 3 && attachedTo _crate == _para} do
		{
			_para setVectorUp [0,0,1];
			_para setVelocity [0, 0, (velocity _para) select 2];
			uiSleep 0.1;
		};
	};

	_missionAirdrop = createMarker ["missionAirdrop", _dropCenter];
	_missionAirdrop setMarkerType "loc_container";
	_missionAirdrop setMarkerText "Airdrop Zone";
	_missionAirdrop setMarkerColor "ColorWhite";
	_missionAirdrop setMarkerSize [0.5, 0.5];

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, 2, 7] call createCustomGroup;

	_missionHintText = format ["An medical supply has been airdrop at wrong location, please lift it up and airdrop to Town <t color='%2'>%1</t>!", _dropName, logisticsMissionColor];
};

_ignoreAiDeaths = true;
_waitUntilMarkerPos = nil;
_waitUntilExec = {
	_veh = _crate getVariable ["R3F_LOG_est_transporte_par", objNull];
	if (!isNull _veh) then
	{
		_lastDriver = driver _veh;
	};
};
_waitUntilCondition = nil;
_waitUntilSuccessCondition = {
	_crate distance _dropCenter <= _dropRadius && (isTouchingGround _crate || (getPos _crate) select 2 < 5) && {vectorMagnitude velocity _crate < 1} && isNull (_crate getVariable ["R3F_LOG_est_deplace_par", objNull])
};

_failedExec =
{
	_veh = _crate getVariable ["R3F_LOG_est_transporte_par", objNull];
	if (!isNull _veh) then
	{
		detach _crate;
		_crate setVariable ["R3F_LOG_est_transporte_par", objNull, true];
		[_crate, true] call fn_enableSimulationGlobal;
		_objets_charges = _veh getVariable "R3F_LOG_objets_charges";
		_objets_charges = _objets_charges - [_crate];
		_veh setVariable ["R3F_LOG_objets_charges", _objets_charges, true];
	};
	deleteMarker _missionAirdrop;
	deleteVehicle _crate;
};

_successExec =
{
	if (!isNil "_lastDriver") then
	{
		[_lastDriver, 7500] call A3W_fnc_setCMoney;
		_lastDriver globalChat "Your received cash 7,500 for sent airdrop.";
	} else
	{
		_cash = createVehicle ["Land_Money_F", position _crate, [], 0, "None"];
		_cash setPos (getPos _crate);
		_cash setVariable ["cmoney", 7500, true];
		_cash setVariable ["owner", "world", true];
	};
	deleteMarker _missionAirdrop;
	deleteVehicle _crate;
	_successHintMessage = "Civilian received resupply.";
};
_this call logisticsMissionProcessor;
