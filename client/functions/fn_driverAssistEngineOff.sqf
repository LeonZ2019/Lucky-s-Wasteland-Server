// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2017 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: fn_driverAssistEngineOff.sqf
//	@file Author: Lee

private _veh = if (isNil "_veh") then { objectParent player } else { _veh };
private _driver = driver _veh;

if (!isAgent teamMember _driver || !((_driver getVariable ["A3W_driverAssistOwner", objNull]) in [player,objNull]) || !isEngineOn _veh) exitWith {};
_veh engineOn false;