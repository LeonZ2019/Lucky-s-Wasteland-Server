// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: playerSetupGear.sqf
//	@file Author: [GoT] JoSchaap, AgentRev

private ["_player", "_uniform", "_vest", "_headgear", "_backpack", "_goggles"];
_player = _this;

// Clothing is now defined in "client\functions\getDefaultClothing.sqf"

_uniform = [_player, "uniform"] call getDefaultClothing;
_vest = [_player, "vest"] call getDefaultClothing;
_headgear = [_player, "headgear"] call getDefaultClothing;
_goggles = [_player, "goggles"] call getDefaultClothing;
_backpack = [_player, "backpack"] call getDefaultClothing;
_weapon = [_player, "weapon"] call getDefaultClothing;
_weaponItem = [_player, "weaponItem"] call getDefaultClothing;
if (_uniform != "") then { _player addUniform _uniform };
if (_vest != "") then { _player addVest _vest };
if (_headgear != "") then { _player addHeadgear _headgear };
if (_goggles != "") then { _player addGoggles _goggles };

sleep 0.1;

// Remove GPS
_player unlinkItem "ItemGPS";

// Remove radio
//_player unlinkItem "ItemRadio";

// Remove NVG
if (hmd _player != "") then { _player unlinkItem hmd _player };

// Add NVG
_player linkItem "NVGoggles";

_player addWeapon _weapon;
if (_weaponItem select 0 != "") then { _player addPrimaryWeaponItem (_weaponItem select 0); };
_player addPrimaryWeaponItem (_weaponItem select 1);

_player addBackpack _backpack;
for "_i" from 1 to 3 do {_player addMagazine (_weaponItem select 1);};
for "_i" from 1 to 2 do {_player addItem "MiniGrenade";};
if (count _weaponItem == 3) then { for "_i" from 1 to 3 do {_player addItem (_weaponItem select 2);}; };

for "_i" from 1 to 2 do {_player addItem "9Rnd_45ACP_Mag";};
_player addWeapon "hgun_ACPC2_F";
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
