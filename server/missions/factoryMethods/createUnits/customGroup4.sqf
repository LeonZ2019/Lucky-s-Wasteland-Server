// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: customGroup4.sqf

if (!isServer) exitWith {};

params ["_group", "_nbUnits", "_from", "_to"];
private ["_camo", "_unit", "_loadout", "_weapons", "_magazines", "_scope", "_backpack", "_uPos", "_waypoint"];

_loadout = [];
_weapons = ""; // normal rifle + grenade launcher + launcher
_magazines = []; // ammo, grenade, missile
_scope = []; // random pick 1
_backpack = []; // normal, radio
_camo = ["Digital", "Geometric"] call BIS_fnc_selectRandom;
switch (_camo) do
{
	case "Digital":
	{
		_weapons = ["arifle_Mk20_F", "arifle_Mk20_GL_F", "launch_NLAW_F"];
		_scope = ["optic_Aco", "optic_ACO_grn", "optic_MRCO"];
		_magazines = ["30Rnd_556x45_Stanag", "1Rnd_HE_Grenade_shell", "NLAW_F"];
		_backpack = ["B_Carryall_oli", "B_RadioBag_01_digi_F"];
		_loadout pushBack ["H_Booniehat_dgtl", "H_Cap_blk_Raven", "H_MilCap_dgtl", "H_HelmetIA"];
		_loadout pushBack ["U_I_CombatUniform", "U_I_CombatUniform_shortsleeve"];
		_loadout pushBack ["V_PlateCarrierIA1_dgtl", "V_PlateCarrierIA2_dgtl"];
	};
	case "Geometric":
	{
		_weapons = ["arifle_MSBS65_F", "arifle_MSBS65_GL_F", "launch_NLAW_F"];
		_scope = ["optic_ico_01_f"];
		_magazines = ["30Rnd_65x39_caseless_msbs_mag", "1Rnd_HE_Grenade_shell", "NLAW_F"];
		_backpack = ["B_Carryall_eaf_F", "B_RadioBag_01_eaf_F"];
		_loadout pushBack ["H_HelmetHBK_headset_F", "H_HelmetHBK_F", "H_Booniehat_eaf", "H_MilCap_eaf"];
		_loadout pushBack ["U_I_E_Uniform_01_shortsleeve_F", "U_I_E_Uniform_01_sweater_F", "U_I_E_Uniform_01_tanktop_F", "U_I_E_Uniform_01_F"];
		_loadout pushBack ["V_CarrierRigKBT_01_light_EAF_F", "V_CarrierRigKBT_01_EAF_F"];
	};
};
_unitTypes =
[
	"C_man_polo_1_F", "C_man_polo_1_F_euro", "C_man_polo_1_F_afro", "C_man_polo_1_F_asia",
	"C_man_polo_2_F", "C_man_polo_2_F_euro", "C_man_polo_2_F_afro", "C_man_polo_2_F_asia",
	"C_man_polo_3_F", "C_man_polo_3_F_euro", "C_man_polo_3_F_afro", "C_man_polo_3_F_asia",
	"C_man_polo_4_F", "C_man_polo_4_F_euro", "C_man_polo_4_F_afro", "C_man_polo_4_F_asia",
	"C_man_polo_5_F", "C_man_polo_5_F_euro", "C_man_polo_5_F_afro", "C_man_polo_5_F_asia",
	"C_man_polo_6_F", "C_man_polo_6_F_euro", "C_man_polo_6_F_afro", "C_man_polo_6_F_asia"
];

for "_i" from 1 to _nbUnits do
{
	_uPos = _from vectorAdd ([[random 5, 0, 0], random 360] call BIS_fnc_rotateVector2D);
	_unit = _group createUnit [_unitTypes call BIS_fnc_selectRandom, _uPos, [], 0, "Form"];
	_unit setPosATL _uPos;

	removeAllWeapons _unit;
	removeAllAssignedItems _unit;
	removeUniform _unit;
	removeVest _unit;
	removeBackpack _unit;
	removeHeadgear _unit;
	removeGoggles _unit;

	_unit addHeadgear ((_loadout select 0) call BIS_fnc_selectRandom);
	_unit forceAddUniform ((_loadout select 1) call BIS_fnc_selectRandom);
	_unit addVest ((_loadout select 2) call BIS_fnc_selectRandom);

	switch (true) do
	{
		case (_i == 1):
		{
			_unit addBackpack (_backpack select 1);
			_unit addWeapon (_weapons select 0);
			_unit addMagazines [(_magazines select 0), 3];
			_unit setVariable ["IsRadioOperator", true, true];
		};
		case ((_i + 4) % 3 == 0):
		{
			_unit addWeapon (_weapons select 1);
			_unit addMagazines [(_magazines select 1), 3];
		};
		case (_i % 6 == 0):
		{
			_unit addBackpack (_backpack select 0);
			_unit addWeapon (_weapons select 0);
			_unit addWeapon (_weapons select 2);
			_unit addMagazines [(_magazines select 2), 3];
		};
		case ((_i + 3) % 6 == 0):
		{
			_unit addBackpack (_backpack select 0);
			_unit addWeapon (_weapons select 0);
			_unit addWeapon "launch_RPG32_green_F";
			_unit addMagazines ["RPG32_F", 3];
		};
		default
		{
			_unit addWeapon (_weapons select 0);
			_unit addMagazines [(_magazines select 0), 3];
			if (_unit == leader _group) then
			{
				_unit setRank "SERGEANT";
			};
		};
	};

	_unit addItem "FirstAidKit";
	_unit addPrimaryWeaponItem "acc_flashlight";
	_unit addPrimaryWeaponItem (_scope call BIS_fnc_selectRandom);
	_unit addMagazines [(_magazines select 0), 6];
	_unit addPrimaryWeaponItem (_magazines select 0);
	_unit enablegunlights "forceOn";

	_unit addRating 1e11;
	_unit call setMissionSkill;
	_unit spawn refillPrimaryAmmo;
};

_waypoint = _group addWaypoint [_to, 5];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointCompletionRadius 5;
_waypoint setWaypointCombatMode "RED";
_waypoint setWaypointBehaviour "COMBAT";
_waypoint setWaypointFormation "DIAMOND";
_waypoint setWaypointSpeed "LIMITED";
units _group
