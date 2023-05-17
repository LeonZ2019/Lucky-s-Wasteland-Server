// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: addWeaponInventory.sqf
//	@file Author: AgentRev
//	@file Created: 16/11/2013 19:20
//	@file Args:

private ["_player", "_weapon", "_return"];

_player = _this select 0;
_weapon = _this select 1;
_value = [[_weapon, "", "", "", [], [], ""], 1];
if (_weapon == "hgun_esd_01_F") then
{
	_value = [[_weapon, "muzzle_antenna_01_f", "", "", [], [], ""], 1];
};
_return = true;

switch (true) do
{
	case ([_player, _weapon, "backpack"] call fn_fitsInventory): { (backpackContainer _player) addWeaponWithAttachmentsCargoGlobal _value };
	case ([_player, _weapon, "vest"] call fn_fitsInventory):     { (vestContainer _player) addWeaponWithAttachmentsCargoGlobal _value };
	case ([_player, _weapon, "uniform"] call fn_fitsInventory):  { (uniformContainer _player) addWeaponWithAttachmentsCargoGlobal _value };
	default                                                      { _return = false };
};

if (_return && _weapon select [0,15] == "Laserdesignator" && {{_x == "Laserbatteries"} count magazines _player == 0}) then
{
	[_player, "Laserbatteries"] call fn_forceAddItem;
};

_return
