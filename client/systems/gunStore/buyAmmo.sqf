// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: buyAmmo.sqf
//	@file Author: [KoS] His_Shadow, AgentRev
//	@file Created: 20/11/2012 05:13
//	@file Args: [int (0 = buy to player 1 = buy to crate)]

if (!isNil "storePurchaseHandle" && {typeName storePurchaseHandle == "SCRIPT"} && {!scriptDone storePurchaseHandle}) exitWith {hint "Please wait, your previous purchase is being processed"};

#include "dialog\gunstoreDefines.sqf";
//#include "addons\proving_ground\defs.hpp"
#define GET_DISPLAY (findDisplay balca_debug_VC_IDD)
#define GET_CTRL(a) (GET_DISPLAY displayCtrl ##a)
#define GET_SELECTED_DATA(a) ([##a] call {_idc = _this select 0;_selection = (lbSelection GET_CTRL(_idc) select 0);if (isNil {_selection}) then {_selection = 0};(GET_CTRL(_idc) lbData _selection)})
#define KINDOF_ARRAY(a,b) [##a,##b] call {_veh = _this select 0;_types = _this select 1;_res = false; {if (_veh isKindOf _x) exitwith { _res = true };} forEach _types;_res}

storePurchaseHandle = _this spawn
{
	disableSerialization;

	private ["_name", "_switch", "_price", "_dialog", "_ammoList", "_playerMoneyText", "_playerMoney", "_itemIndex", "_itemText", "_itemData", "_handleMoney", "_class", "_name", "_mag", "_type", "_backpack"];

	//Initialize Values
	_switch = _this select 0;

	// Grab access to the controls
	_dialog = findDisplay gunshop_DIALOG;
	_ammoList = _dialog displayCtrl gunshop_ammo_list;
	_playerMoneyText = _Dialog displayCtrl gunshop_money;
	_playerMoney = player getVariable ["cmoney", 0];

	_itemIndex = lbCurSel gunshop_ammo_list;
	_itemText = _ammoList lbText _itemIndex;
	_itemData = _ammoList lbData _itemIndex;

	_showInsufficientFundsError =
	{
		_itemText = _this select 0;
		hint format ["You don't have enough money for ""%1""", _itemText];
		playSound "FD_CP_Not_Clear_F";
		_price = -1;
	};

	_showInsufficientSpaceError =
	{
		_itemText = _this select 0;
		hint format ["You don't have enough space for ""%1""", _itemText];
		playSound "FD_CP_Not_Clear_F";
		_price = -1;
	};

	switch(_switch) do
	{
		//Buy To Player
		case 0:
		{
			{
				if (_itemData == _x select 1) exitWith
				{
					_class = _x select 1;
					_price = _x select 2;
					_mag = configFile >> "CfgMagazines" >> _class;

					//ensure the player has enough money
					if (_price > _playerMoney) exitWith
					{
						[_itemText] call _showInsufficientFundsError;
					};
					if (count (weaponsItems player) == 0) then
					{
						if ([player, _class] call fn_fitsInventory) then
						{
							[player, _class] call fn_forceAddItem;
						} else
						{
							[_itemText] call _showInsufficientSpaceError;
						};
					} else
					{
						_hasAdded = false;
						{
							_canAdd = [false, false];
							{
								switch (count (_x)) do
								{
									case 2: { if (_x select 1 == 0) then { _canAdd set [_forEachIndex, true] }};
									case 0: { _canAdd set [_forEachIndex, true] };
								};
							} forEach [_x select 4, _x select 5];
							_weapon = configFile >> "CfgWeapons" >> _x select 0;
							_mainMags = [];
							_secondMags = [];
							{
								if (_x == "this") then
								{
									_mainMags append getArray (_weapon >> "magazines");
									{
									{ _mainMags append getArray _x } forEach configProperties [configFile >> "CfgMagazineWells" >> _x, "isArray _x"];
									} forEach getArray (_weapon >> "magazineWell");
								} else
								{
									_secondMags append getArray (_weapon >> _x >> "magazines");
									{
									{ _secondMags append getArray _x } forEach configProperties [configFile >> "CfgMagazineWells" >> _x, "isArray _x"];
									} forEach getArray (_weapon >> _x >> "magazineWell");
								};
							} forEach getArray (_weapon >> "muzzles");
							if (_class in _mainMags) exitWith
							{
								if (_canAdd select 0) then
								{
									player addWeaponItem [_x select 0, _class, true];
									_hasAdded = true;
								};
							};
							if (_class in _secondMags) exitWith
							{
								if (_canAdd select 1) then
								{
									player addWeaponItem [_x select 0, _class, true];
									_hasAdded = true;
								};
							};
						} forEach (weaponsItems player);
						if (!_hasAdded) then
						{
							if ([player, _class] call fn_fitsInventory) then
							{
								[player, _class] call fn_forceAddItem;
							}
							else
							{
								[_itemText] call _showInsufficientSpaceError;
							};
						};
					};
				}
			} forEach (call ammoArray);
		};
	};

	if (!isNil "_price" && {_price > -1}) then
	{
		//player setVariable ["cmoney", _playerMoney - _price, true];
		[player, -_price] call A3W_fnc_setCMoney;
		_playerMoneyText ctrlSetText format ["Cash: $%1", [player getVariable ["cmoney", 0]] call fn_numbersText];
		hint "Purchase successful!";
		playSound "FD_Finish_F";
	};
};

private "_storePurchaseHandle";
_storePurchaseHandle = storePurchaseHandle;
waitUntil {scriptDone _storePurchaseHandle};

storePurchaseHandle = nil;
