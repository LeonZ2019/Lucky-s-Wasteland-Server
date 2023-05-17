// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: customGroup4.sqf

if (!isServer) exitWith {};

params ["_group", "_pos", "_nbUnits"];
private ["_camo", "_unit", "_loadout", "_weapons", "_magazines", "_scope", "_backpack", "_uPos", "_waypoint"];
_loadout = [];
_weapons = ["arifle_TRG21_F", "arifle_TRG21_GL_F", "launch_RPG32_green_F", "launch_I_Titan_F"];
_scope = ["optic_Aco", "optic_ACO_grn"];
_magazines = ["30Rnd_556x45_Stanag", "1Rnd_HE_Grenade_shell", "RPG32_F"];
_backpack = "B_Carryall_khk";
_loadout pushBack ["H_PASGT_basic_black_F", "H_PASGT_basic_blue_F", "H_PASGT_basic_olive_F", "H_PASGT_basic_white_F"];
_loadout pushBack ["U_BG_Guerilla1_1", "U_BG_Guerilla1_2_F", "U_BG_Guerilla2_1", "U_BG_Guerilla2_2", "U_BG_Guerilla2_3", "U_BG_Guerilla3_1", "U_BG_Guerrilla_6_1", "U_BG_leader", "U_OG_Guerilla1_1", "U_OG_Guerilla2_1", "U_OG_Guerilla2_2", "U_OG_Guerilla2_3", "U_OG_Guerilla3_1", "U_OG_Guerrilla_6_1", "U_BG_Guerrilla_6_1", "U_OG_leader", "U_IG_Guerilla1_1", "U_IG_Guerilla2_1", "U_IG_Guerilla2_2", "U_IG_Guerilla2_3", "U_IG_Guerilla3_1", "U_IG_Guerrilla_6_1", "U_IG_leader", "U_BG_leader"];


_loadout pushBack ["V_TacVest_blk", "V_TacVest_brn", "V_TacVest_camo", "V_TacVest_khk", "V_TacVest_oli"];

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
	_uPos = _pos vectorAdd ([[random 5, 0, 0], random 360] call BIS_fnc_rotateVector2D);
	_unit = _group createUnit [_unitTypes call BIS_fnc_selectRandom, _uPos, [], 0, "Form"];
	_unit setPosATL _uPos;

	removeAllWeapons _unit;
	removeAllAssignedItems _unit;
	removeUniform _unit;
	removeVest _unit;
	removeBackpack _unit;
	removeHeadgear _unit;
	removeGoggles _unit;
	_unit addGoggles (["G_RegulatorMask_F", "G_AirPurifyingRespirator_01_F", "G_AirPurifyingRespirator_02_black_F", "G_AirPurifyingRespirator_02_olive_F", "G_AirPurifyingRespirator_02_sand_F"] call BIS_fnc_selectRandom);
	_unit addHeadgear ((_loadout select 0) call BIS_fnc_selectRandom);
	_unit forceAddUniform ((_loadout select 1) call BIS_fnc_selectRandom);
	_unit addVest ((_loadout select 2) call BIS_fnc_selectRandom);

	switch (true) do
	{
		// Grenadier every 6 units, starting from #2
		case ((_i + 6) % 3 == 0):
		{
			_unit addWeapon (_weapons select 1);
			_unit addMagazines [(_magazines select 1), 3];
		};
		// PCML every 16 units, starting from #6
		case (_i % 16 == 0):
		{
			_unit addBackpack _backpack;
			_unit addWeapon (_weapons select 0);
			_unit addWeapon (_weapons select 2);
			_unit addMagazines [(_magazines select 2), 3];
		};
		// RPG-42 every 10 units, starting from #3
		case ((_i + 3) % 10 == 0):
		{
			_unit addBackpack _backpack;
			_unit addWeapon (_weapons select 0);
			_unit addWeapon "launch_RPG32_green_F";
			_unit addMagazines ["RPG32_F", 3];
		};
		// Rifleman
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
	_unit addPrimaryWeaponItem (_scope call BIS_fnc_selectRandom);
	_unit addMagazines [(_magazines select 0), 6];
	_unit addPrimaryWeaponItem (_magazines select 0);
	if (random 1 > 0.5) then
	{
		_unit addPrimaryWeaponItem "acc_flashlight";
		_unit enablegunlights "forceOn";
	} else
	{
		_unit addPrimaryWeaponItem "acc_pointer_IR";
		_unit enableIRLasers true;
	};

	_unit addRating 1e11;
	_unit call setMissionSkill;
	_unit spawn refillPrimaryAmmo;
};

