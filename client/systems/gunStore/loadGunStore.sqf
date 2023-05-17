// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: loadGunStore.sqf
//	@file Author: [404] Deadbeat
//	@file Created: 20/11/2012 05:13
//	@file Args:

#include "dialog\gunstoreDefines.sqf";
disableSerialization;

private ["_gunshopDialog", "_Dialog", "_playerMoney", "_owner", "_welcome"];
_gunshopDialog = createDialog "gunshopd";

_Dialog = findDisplay gunshop_DIALOG;
_playerMoney = _Dialog displayCtrl gunshop_money;
_playerMoney ctrlSetText format["Cash: $%1", [player getVariable ["cmoney", 0]] call fn_numbersText];

_welcome = playSound (format ["gunStore_welcome_0%1", [1,2] select (random 2 < 1)]);
/*
"Civilian_MarketInvite_Merchant_A_01_Vincent" // something you need?
"Civilian_MarketInvite_Merchant_A_02_Vincent" // what you're looking for? aha
"Civilian_MarketInvite_Merchant_A_04_Vincent" // come on, see what's here
"Civilian_MarketInvite_Merchant_A_Ahmeed_01" // something  you need?
"Civilian_MarketInvite_Merchant_A_Ahmeed_02" // what you're looking for? oi
"Civilian_MarketInvite_Merchant_B_01_Vincent" // come on take a look
"Civilian_MarketInvite_Merchant_B_Ahmeed_01" // come on, see what's here
"Civilian_MarketInvite_Merchant_B_Ahmeed_02" // come on, take a look

"Civilain_MarketInventory_Merchant_A_01_Vincent" // so whatever you want, we got it
"Civilain_MarketInventory_Merchant_A_02_Vincent" // if you need gun, no problem
"Civilain_MarketInventory_Merchant_A_Ahmeed_01" // so whatever you want, we got it
"Civilain_MarketInventory_Merchant_A_Ahmeed_02" // if you need gun, no problem
"Civilain_MarketInventory_Merchant_B_01_Vincent" // see anything you want?
"Civilain_MarketInventory_Merchant_B_02_A_Vincent" // as you can see pattron
"Civilain_MarketInventory_Merchant_B_02_B_Vincent" // there is no much we can get hah
"Civilain_MarketInventory_Merchant_B_Ahmeed_01" // see anything you want?
"Civilain_MarketInventory_Merchant_B_Ahmeed_02_A" // as you can see butthole?
"Civilain_MarketInventory_Merchant_B_Ahmeed_02_B" // there is no much we can get heh

"Civilain_MarketExit_Merchant_A_01_Vincent" // you come back again
"Civilain_MarketExit_Merchant_A_Ahmeed_01" // you come back again
"Civilian_MarketExit_Merchant_A_02_Vincent" // that is, ok see you later
"Civilian_MarketExit_Merchant_A_Ahmeed_02" // that is, ok see you later
"Civilian_MarketExit_Merchant_B_01_Vincent" // salute mate
"Civilian_MarketExit_Merchant_B_02_Vincent" // see you real soon, hahh
"Civilian_MarketExit_Merchant_B_Ahmeed_01" // salute mate
"Civilian_MarketExit_Merchant_B_Ahmeed_02" // see you real soon, hahh
*/

if (!isNil "_this") then { _owner = _this select 0 };
if (!isNil "_owner") then
{
	currentOwnerID = _owner;
	currentOwnerName = vehicleVarName _owner;
};

[_welcome] spawn
{
	disableSerialization;
	_dialog = findDisplay gunshop_DIALOG;
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
	playSound (format ["gunStore_exit_0%1", [1,2,3,4] call BIS_fnc_selectRandom]);
};
