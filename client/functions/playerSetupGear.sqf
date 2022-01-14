// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: playerSetupGear.sqf
//	@file Author: [GoT] JoSchaap, AgentRev

private ["_player", "_uniform", "_vest", "_backpack", "_goggles", "_nvg", "_weapon", "_weaponItem", "_pistol"];
_player = _this;

// Clothing is now defined in "client\functions\getDefaultClothing.sqf"

_uniform = [_player, "uniform"] call getDefaultClothing;
_vest = [_player, "vest"] call getDefaultClothing;
_goggles = [_player, "goggles"] call getDefaultClothing;
_backpack = [_player, "backpack"] call getDefaultClothing;
_weapon = [_player, "weapon"] call getDefaultClothing;
_weaponItem = [_player, "weaponItem"] call getDefaultClothing;
_nvg = [_player, "nvg"] call getDefaultClothing;

if (count _uniform == 2) then
{
	_player addHeadgear (_uniform select 0);
	_player forceAddUniform (_uniform select 1);
};
if (_vest != "") then { _player addVest _vest };
if (_goggles != "") then { _player addGoggles _goggles };

sleep 0.1;

// Remove GPS
_player unlinkItem "ItemGPS";

// Remove radio
//_player unlinkItem "ItemRadio";

// Remove NVG
if (hmd _player != "") then { _player unlinkItem hmd _player };

// Add NVG
_player linkItem _nvg;

_player addBackpack _backpack;

for "_i" from 1 to 2 do {_player addItem "HandGrenade";};
if (count _weaponItem == 2) then { for "_i" from 1 to 3 do {_player addItem (_weaponItem select 1);}; };

_primaryGunConfig = configfile >> "CfgWeapons" >> _weapon;
_primaryGunMags = [];
_primaryGunMags append getArray (_primaryGunConfig >> "magazines");
{
	{
		_primaryGunMags append getArray _x;
	} forEach configProperties [configFile >> "CfgMagazineWells" >> _x, "isArray _x"];
} forEach getArray (_primaryGunConfig >> "magazineWell");
_primaryGunMags = _primaryGunMags call BIS_fnc_selectRandom;

_player addWeapon _weapon;
_player addPrimaryWeaponItem _primaryGunMags;
if (_weaponItem select 0 != "") then { _player addPrimaryWeaponItem (_weaponItem select 0); };
for "_i" from 1 to 3 do {_player addMagazine _primaryGunMags;};

_pistol = [ "hgun_P07_F", "hgun_P07_khk_F", "hgun_P07_blk_F", "hgun_Pistol_heavy_01_F", "hgun_Pistol_heavy_01_green_F", "hgun_ACPC2_F", "hgun_Rook40_F" ] call BIS_fnc_selectRandom;
_hgunConfig = configfile >> "CfgWeapons" >> _pistol;
_hgunMags = [];
_hgunMags append getArray (_hgunConfig >> "magazines");
{
	{
		_hgunMags append getArray _x;
	} forEach configProperties [configFile >> "CfgMagazineWells" >> _x, "isArray _x"];
} forEach getArray (_hgunConfig >> "magazineWell");
_hgunMags = _hgunMags call BIS_fnc_selectRandom;
_player addWeapon _pistol;
for "_i" from 1 to 2 do {_player addItem _hgunMags ;};
_player addHandgunItem _hgunMags;

_player addItem "FirstAidKit";
_player addItem "FirstAidKit";
_player selectWeapon "_weapon";

switch (true) do
{
	case (["_medic_", typeOf _player] call fn_findString != -1):
	{
		_player removeItem "FirstAidKit";
		_player removeItem "FirstAidKit";
		_player addItem "Medikit";
	};
	case (["_engineer_", typeOf _player] call fn_findString != -1):
	{
		_player addItem "MineDetector";
		_player addItem "Toolkit";
	};
	case (["_sniper_", typeOf _player] call fn_findString != -1):
	{
		_player addWeapon "Rangefinder";
	};
	case (["_AT_", typeOf _player] call fn_findString != -1):
	{
		_player removeItem "FirstAidKit";
		_player addMagazine "Laserbatteries";
		_player addWeapon "Laserdesignator";
		_player addWeapon "launch_NLAW_F";
		_player addSecondaryWeaponItem "NLAW_F";
		_player addItemToBackpack "NLAW_F";
		_player addItem "SmokeShellGreen";
		_player addItem "SmokeShellRed";
	};
};

if (_player == player) then
{
	thirstLevel = 100;
	hungerLevel = 100;
};
