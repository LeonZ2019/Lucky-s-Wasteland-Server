// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: customGroup.sqf
//	@file Author: AgentRev

if (!isServer) exitWith {};

private ["_group", "_pos", "_nbUnits", "_unitTypes", "_uPos", "_unit"];

_group = _this select 0;
_pos = _this select 1;
_nbUnits = param [2, 7, [0]];
_radius = param [3, 10, [0]];

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
	_uPos = _pos vectorAdd ([[random _radius, random _radius, 0], random 360] call BIS_fnc_rotateVector2D);
	_unit = _group createUnit [_unitTypes call BIS_fnc_selectRandom, _uPos, [], 0, "Form"];
	_unit setPosATL _uPos;
	
	removeAllWeapons _unit;
	removeAllAssignedItems _unit;
	removeUniform _unit;
	removeVest _unit;
	removeBackpack _unit;
	removeHeadgear _unit;
	removeGoggles _unit;

	_unit addGoggles "G_Spectacles_Tinted";
	_unit addVest "V_TacVest_blk_POLICE";
	_unit addUniform "U_B_GEN_Soldier_F";

	switch (true) do
	{
		// AT every 5 units
		case (_i % 7 == 0):
		{
			_unit addHeadgear "H_ParadeDressCap_01_LDF_F";
			_unit addBackpack "B_CivilianBackpack_01_Everyday_Black_F";

			_unit addWeapon "arifle_Katiba_C_F";
			_unit addPrimaryWeaponItem "acc_flashlight";
			_unit addPrimaryWeaponItem "optic_ACO_grn";
			_weaponsArray = [["launch_NLAW_F","NLAW_F"],["launch_Titan_short_F", "Titan_AT"]];
			_weapon = _weaponsArray call BIS_fnc_selectRandom;
			_unit addWeapon (_weapon select 0);
			_unit addSecondaryWeaponItem (_weapon select 1);

			for "_i" from 1 to 5 do {_unit addItemToUniform "16Rnd_9x21_Mag";};
			for "_i" from 1 to 5 do {_unit addItemToVest "30Rnd_65x39_caseless_green";};
			for "_i" from 1 to 2 do {_unit addItemToBackpack (_weapon select 1);};
		};
		// Sniper every 6 units
		case (_i % 5 == 0):
		{
			_unit addHeadgear "H_Cap_police";

			_unit addWeapon "srifle_DMR_06_olive_F";
			_unit addPrimaryWeaponItem "optic_KHS_old";
			_unit addPrimaryWeaponItem "bipod_03_F_oli";

			for "_i" from 1 to 5 do {_unit addItemToVest "20Rnd_762x51_Mag";};
		};
		// Rifleman
		default
		{
			if (_unit == leader _group) then
			{
				_unit addHeadgear "H_Beret_gen_F";
				removeGoggles _unit;
				_unit addGoggles "G_AirPurifyingRespirator_01_F";
				_unit addWeapon "arifle_Katiba_F";
				_unit addPrimaryWeaponItem "optic_ACO_grn";
				_unit addPrimaryWeaponItem "acc_flashlight";
				
				for "_i" from 1 to 7 do {_unit addItemToVest "30Rnd_65x39_caseless_green";};
				for "_i" from 1 to 2 do {_unit addItemToVest "MiniGrenade";};

				_unit setRank "SERGEANT";
			}
			else
			{
				_unit addHeadgear "H_Cap_police";

				_unit addWeapon "SMG_05_F";
				_unit addPrimaryWeaponItem "optic_ACO_grn";
				_unit addPrimaryWeaponItem "acc_flashlight";

				for "_i" from 1 to 7 do {_unit addItemToVest "30Rnd_9x21_Mag_SMG_02";};
			};
		};
	};

	_unit addWeapon "hgun_Rook40_F";
	_unit addHandgunItem "16Rnd_9x21_Mag";
	for "_i" from 1 to 3 do {_unit addItemToUniform "16Rnd_9x21_Mag";};

	_unit addRating 1e11;
	_unit spawn refillPrimaryAmmo;
	_unit call setMissionSkill;
};

[_group, _pos, "LandVehicle"] call defendArea;
