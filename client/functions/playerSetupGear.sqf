// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: playerSetupGear.sqf
//	@file Author: [GoT] JoSchaap, AgentRev

private ["_player", "_uniform", "_goggles", "_nvg", "_weapon", "_weaponItem", "_pistol", "_primaryGunConfig", "_primaryGunMags", "_hgunConfig", "_hgunMags", "_terminal", "_weaponItems"];
_player = _this;

// Clothing is now defined in "client\functions\getDefaultClothing.sqf"

_uniform = [_player, "uniform"] call getDefaultClothing;
_goggles = [_player, "goggles"] call getDefaultClothing;
_weapon = [_player, "weapon"] call getDefaultClothing;
_weaponItem = [_player, "weaponItem"] call getDefaultClothing;
_nvg = [_player, "nvg"] call getDefaultClothing;

if (count _uniform >= 4) then
{
	_player addHeadgear (_uniform select 0);
	_player forceAddUniform (_uniform select 1);
	_player addVest (_uniform select 2);
	_player addBackpack (_uniform select 3);
	if (count _uniform == 5) then
	{
		_player addGoggles (_uniform select 4);
	};
};
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
for "_i" from 1 to 2 do {_player addItem _hgunMags;};
_player addHandgunItem _hgunMags;

_player addItem "FirstAidKit";
_player addItem "FirstAidKit";
_player selectWeapon _weapon;
if (_player getVariable ["donator", 0] != 0) then
{
	_player linkItem "ItemGPS";
	_player addItem "FirstAidKit";
	_player addWeapon "Rangefinder";
	for "_i" from 1 to 3 do {_player addMagazine _primaryGunMags;};
	for "_i" from 1 to 3 do {_player addItem _hgunMags;};
	for "_i" from 1 to 2 do {_player addItem "HandGrenade";};
	_weaponItems = _weapon call BIS_fnc_compatibleItems;
	_muzzle = _weaponItems findIf { ["muzzle_", _x] call fn_startsWith };
	if ("acc_pointer_IR" in _weaponItems) then { _player addPrimaryWeaponItem "acc_pointer_IR" };
	if (_muzzle != -1) then { _player addPrimaryWeaponItem (_weaponItems select _muzzle) };
} else
{
	_player addWeapon "Binocular";
};

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
	case (["_soldier_UAV_", typeOf _player] call fn_findString != -1):
	{
		_terminal = switch (side _player) do
		{
			case BLUFOR: { "B_UavTerminal" };
			case OPFOR:  { "O_UavTerminal" };
			default      { "I_UavTerminal" };
		};
		_player linkItem _terminal;
	};
	case (["_Pilot_", typeOf _player] call fn_findString != -1):
	{
		_player addHeadgear (_uniform select 0);
		_player addItem "SmokeShellGreen";
		_player addItem "SmokeShellGreen";
		_player addItem "SmokeShellRed";
		_player addItem "SmokeShellRed";
		_player addItem "Chemlight_green";
		_player addItem "Chemlight_red";
	};
};

if (_player == player) then
{
	thirstLevel = 100;
	hungerLevel = 100;
};
