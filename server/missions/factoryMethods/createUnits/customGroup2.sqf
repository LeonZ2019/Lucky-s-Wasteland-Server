// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: customGroup2.sqf
//	@file Author: AgentRev, JoSchaap

if (!isServer) exitWith {};

private ["_group", "_pos", "_nbUnits", "_unitTypes", "_uPos", "_unit"];

_group = _this select 0;
_pos = _this select 1;
_nbUnits = param [2, 7, [0]];
_radius = param [3, 10, [0]];

_unitTypes =
[
	"C_man_hunter_1_F","C_man_p_beggar_F","C_man_p_beggar_F_afro",
	"C_man_p_fugitive_F","C_man_p_shorts_1_F","C_man_polo_1_F",
	"C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F",
	"C_man_p_beggar_F","C_man_p_beggar_F_afro",
	"C_man_p_fugitive_F","C_journalist_F","C_Orestes",
	"C_man_polo_5_F","C_man_polo_6_F","C_man_shorts_1_F",
	"C_man_shorts_2_F","C_man_shorts_3_F","C_man_shorts_4_F",
	"C_man_w_worker_F","C_man_p_beggar_F","C_man_p_beggar_F_afro",
	"C_man_p_fugitive_F"
];

_generateGear = {
	private ["_gears"];
	_gears = [];
	_gears pushBack ([["arifle_AKM_F","30Rnd_762x39_Mag_F"],["arifle_AK12_F","30Rnd_762x39_AK12_Mag_F"],["arifle_AKS_F","30Rnd_545x39_Mag_F"]] call BIS_fnc_selectRandom);
	_gears pushBack (["","","","","H_Cap_headphones","H_MilCap_gry"] call BIS_fnc_selectRandom);
	_gears pushBack (["","","V_TacVest_oli","V_Chestrig_khk","V_Chestrig_blk","V_Chestrig_oli"] call BIS_fnc_selectRandom);
	_gears pushBack (["U_I_C_Soldier_Para_1_F","U_I_C_Soldier_Para_2_F","U_I_C_Soldier_Para_3_F","U_I_C_Soldier_Para_4_F","U_I_C_Soldier_Para_5_F"] call BIS_fnc_selectRandom);
	_gears
};

for "_i" from 1 to _nbUnits do
{
	_uPos = _pos vectorAdd ([[random _radius, 0, 0], random 360] call BIS_fnc_rotateVector2D);
	_unit = _group createUnit [_unitTypes call BIS_fnc_selectRandom, _uPos, [], 0, "Form"];
	_unit setPosATL _uPos;
	_gears = call _generateGear;
	removeAllWeapons _unit;
	removeAllAssignedItems _unit;
	removeVest _unit;
	removeBackpack _unit;
	_unit forceAddUniform (_gears select 3);
	if ((_gears select 2) != "") then { _unit addVest (_gears select 2);};
	if ((_gears select 1) != "") then { _unit addHeadgear (_gears select 2);};
	switch (true) do
	{
		// Grenadier every 3 units
		case (_i % 3 == 0):
		{
			_unit addWeapon "arifle_AK12_GL_F";
			_unit addPrimaryWeaponItem "30Rnd_762x39_AK12_Mag_F";
			for "_i" from 1 to 5 do {_unit addItem "30Rnd_762x39_AK12_Mag_F";};
			for "_i" from 1 to 3 do {_unit addItem "1Rnd_HE_Grenade_shell";};
		};
		// RPG every 7 units, starting from second one
		case ((_i + 5) % 7 == 0):
		{
			_unit addWeapon (_gears select 0 select 0);
			_unit addPrimaryWeaponItem (_gears select 0 select 1);
			for "_i" from 1 to 5 do {_unit addItem (_gears select 0 select 1);};
			_unit addWeapon "launch_RPG7_F";
			_unit addSecondaryWeaponItem "RPG7_F";
			_unit addBackpack "B_Kitbag_cbr_Para_5_F";
			for "_i" from 1 to 3 do {_unit addItemToBackpack "RPG7_F";};
		};
		// Medic/Engineer every 4 units
		case ((_i + 5) % 4 == 0):
		{
			_unit addWeapon (_gears select 0 select 0);
			_unit addPrimaryWeaponItem (_gears select 0 select 1);
			for "_i" from 1 to 5 do {_unit addItem (_gears select 0 select 1);};
			_unit addBackpack (["B_Kitbag_rgr_Para_3_F","B_Kitbag_rgr_Para_8_F"] call BIS_fnc_selectRandom);
			_unit addItemToBackpack (["Medikit", "ToolKit"] call BIS_fnc_selectRandom);
		};
		// Machine Gunner every 6 units
		case ((_i + 5) % 6 == 0):
		{
			_unit addWeapon "LMG_03_F";
			_unit addPrimaryWeaponItem "200Rnd_556x45_Box_F";
			for "_i" from 1 to 2 do {_unit addItem "200Rnd_556x45_Box_F";};
		};
		// Rifleman
		default
		{
			_unit addWeapon (_gears select 0 select 0);
			_unit addPrimaryWeaponItem (_gears select 0 select 1);
			for "_i" from 1 to 5 do {_unit addItem (_gears select 0 select 1);};
			if (_unit == leader _group) then
			{
				_unit setRank "SERGEANT";
			};
		};
	};

	_unit addPrimaryWeaponItem "acc_flashlight";
	_unit enablegunlights "forceOn";

	_unit addRating 1e11;
	_unit spawn refillPrimaryAmmo;
	_unit call setMissionSkill;
};
