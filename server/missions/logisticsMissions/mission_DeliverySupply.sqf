// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_deliverySupply.sqf
//	@file Author: Leon
//	@file Created: 08/18/2021 01:34

if (!isServer) exitwith {};
#include "logisticsMissionDefines.sqf"

private ["_town", "_safePos", "_nearestRoad", "_startOfRoad", "_endOfRoad", "_edgeOfRoad", "_roadCenter", "_roadDir", "_camo", "_enemyGroup", "_enemy", "_type", "_wreck", "_crate", "_missionCrate", "_veh", "_offroadPos", "_vehicle", "_cash", "_loots", "_loot"];

_setupVars =
{
	_missionType = "Enemy Resupply";
	_locationsArray = ForestMissionMarkers;
};

_setupObjects =
{
	_town = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);
	_missionPos = markerPos _missionLocation;
	while {_town distance _missionPos < 5500 || _town distance _missionPos > 7500} do {
		_town = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);
	};
	_safePos = [_town, 50, 100, 5, 0, 0, 0] call findSafePos;
	_nearestRoad = getRoadInfo ((_safePos nearRoads 100) select 0);
	_startOfRoad = _nearestRoad select 6;
	_endOfRoad = _nearestRoad select 7;
	_edgeOfRoad = (round (- ((_nearestRoad select 1) / 2 * 1000))) / 1000;
	_roadCenter = [((_startOfRoad select 0) + (_endOfRoad select 0)) / 2, ((_startOfRoad select 1) + (_endOfRoad select 1)) / 2, 0];
	_roadDir = round (([_startOfRoad, _endOfRoad] call BIS_fnc_dirTo) - 90);
	if (_roadDir > 360) then {_roadDir = _roadDir - 360 };
	if (_roadDir < 0) then {_roadDir = _roadDir + 360 };
	_camo = ["MTP", "Tropic", "CTRGUrban", "CTRGArid", "CTRGTropic", "Woodland", "GreenHex", "Hex", "Green", "Taiga", "Digital", "Geometric", "Guerilla"] call BIS_fnc_selectRandom;
	_enemyGroup = createGroup CIVILIAN;
	_enemy = [_enemyGroup, _roadCenter, _camo] call createRandomSoldier;
	_enemy setDir _roadDir;
	_enemy setPos (_enemy modelToWorld [0, _edgeOfRoad, 0]);
	_enemy disableAI "ANIM";
	_enemy setBehaviour "SAFE";
	_enemy setCombatMode "BLUE";

	_type = ["B_Truck_01_ammo_F", "O_Truck_03_ammo_F", "I_Truck_02_ammo_F"] call BIS_fnc_selectRandom;
	_wreck = [_type, _missionPos, 0, 0, 1] call createMissionVehicle;
	_wreck setDir random 360;

	_crate = createVehicle ["Land_CargoBox_V1_F", _missionPos, [], 1, "None"];
	_crate setVariable ["Mission_Crate", true];
	_crate allowDamage false;

	_missionCrate = createMarker ["missionCrate", position _enemy];
	_missionCrate setMarkerType "loc_Box";
	_missionCrate setMarkerText "Resupply";
	_missionCrate setMarkerColor "ColorWhite";
	_missionCrate setMarkerSize [0.5, 0.5];

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, 8, 16] call createCustomGroup;

	_missionHintText = format ["An enemy's resupply crate has been intercept by local militant, pick up the crate and delivery to enemy!", logisticsMissionColor];
};

_ignoreAiDeaths = true;
_waitUntilMarkerPos = nil;
_waitUntilExec = {
	_veh = _crate getVariable ["R3F_LOG_est_transporte_par", objNull];
	if (!isNull _veh && !isNil _missionCrate) then
	{
		deleteMarker _missionCrate;
	};
};
_waitUntilCondition = {!alive _enemy};
_waitUntilSuccessCondition = {
	_crate distance _enemy <= 5 && (isTouchingGround _crate || (getPos _crate) select 2 < 5) && {vectorMagnitude velocity _crate < 1} && isNull (_crate getVariable ["R3F_LOG_est_deplace_par", objNull])
};

_failedExec =
{
	deleteMarker _missionCrate;
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
	{ deleteVehicle _x } forEach [_crate, _enemy];
};

_successExec =
{
	deleteMarker _missionCrate;
	{ deleteVehicle _x } forEach [_crate, _enemy];

	_offroadPos = [_roadCenter, 0, 7, 2, 0, 0, 0, "C_Offroad_01_F"] call findSafePos;
	_vehicle = ["C_Offroad_01_F", _offroadPos] call createMissionVehicle;
	[_vehicle, 1] call A3W_fnc_setLockState;
	_vehicle setDIr (_roadDir + 90);

	for "_i" from 1 to 5 do
	{
		_cash = createVehicle ["Land_Money_F", _offroadPos, [], 5, "None"];
		_cash setPos ([_offroadPos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash setDir random 360;
		_cash setVariable ["cmoney", 1000, true];
		_cash setVariable ["owner", "world", true];
	};

	_loots = ["Land_Sacks_goods_F", "Land_BarrelWater_F"] call BIS_fnc_selectRandom;
	_loot = createVehicle [_loots, _offroadPos, [], 5, "None"];
	_loot setDir random 360;
	if (typeOf _loot == "Land_Sacks_goods_F") then
	{
		_loot setVariable ["food", 20, true];
	};
	if (typeOf _loot == "Land_BarrelWater_F") then
	{
		_loot setVariable ["water", 25, true];
	};
	_successHintMessage = "Enemy has been received resupply.";
};
_this call logisticsMissionProcessor;
