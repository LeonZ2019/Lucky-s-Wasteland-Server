// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: loadGenStore.sqf
//	@file Author: [404] Deadbeat
//	@file Created: 20/11/2012 05:13
//	@file Args:

#include "dialog\genstoreDefines.sqf";
disableSerialization;

private ["_genshopDialog", "_Dialog", "_playerMoney", "_owner", "_welcome"];
_genshopDialog = createDialog "genstored";

_Dialog = findDisplay genstore_DIALOG;
_playerMoney = _Dialog displayCtrl genstore_money;
_playerMoney ctrlSetText format["Cash: $%1", [player getVariable ["cmoney", 0]] call fn_numbersText];

_welcome = playSound (format ["genStore_welcome_0%1", [1,2] select (random 2 < 1)]);

if (!isNil "_this") then { _owner = _this select 0 };
if (!isNil "_owner") then
{
	currentOwnerID = _owner;
	currentOwnerName = vehicleVarName _owner;
};

[_welcome] spawn
{
	disableSerialization;
	_dialog = findDisplay genstore_DIALOG;
	while {!isNull _dialog} do
	{
		_escMenu = findDisplay 49;
		if (!isNull _escMenu) exitWith { _escMenu closeDisplay 0 }; // Force close Esc menu if open
		sleep 0.1;
	};
	if !(isNull (_this select 0)) then
	{
		deleteVehicle (_this select 0);
	};
	playSound (format ["genStore_exit_0%1", [1,2,3,4] call BIS_fnc_selectRandom]);
};
