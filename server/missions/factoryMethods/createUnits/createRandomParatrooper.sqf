// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: createRandomParatrooper.sqf
/*
 * Creates paratrooper.
 *
 * Arguments: [ position, group, _nbUnits, _camo]: Array
 *    position: Position - Location unit is created at.
 *    group: Group - Existing group new unit will join.
 *    name: String - Name.
 */

if (!isServer) exitWith {};

params ["_group", "_missionPos", "_nbUnits", "_camo", "_vehicleClass"];
private ["_unit", "_menTypes", "_loadout", "_weapon", "_magazines", "_scope", "_backpack"];

_menTypes = ["C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_3_F", "C_man_polo_4_F", "C_man_polo_5_F", "C_man_polo_6_F"];
_loadout = [];
_weapons = "";
_magazines = [];
_scope = [];
_backpack = "";

switch (_camo) do
{
	case "GreenHex":
	{
		_weapons = ["arifle_Katiba_F", "arifle_Katiba_GL_F", "launch_RPG32_ghex_F"];
		_scope = ["optic_Arco_blk_F", "optic_Aco", "optic_ACO_grn"];
		_magazines = ["30Rnd_65x39_caseless_green", "1Rnd_HE_Grenade_shell", "RPG32_F"];
		_backpack = "B_Carryall_ghex_F";
		_loadout pushBack ["H_HelmetLeaderO_ghex_F", "H_MilCap_ghex_F", "H_HelmetO_ghex_F"];
		_loadout pushBack ["U_O_T_Soldier_F", "U_O_V_Soldier_Viper_F"]; // wrong uniform tropic
		_loadout pushBack ["V_HarnessO_ghex_F", "V_HarnessOGL_ghex_F", "V_TacVest_oli"];
	};
	case "Hex":
	{
		_weapons = ["arifle_Katiba_F", "arifle_Katiba_GL_F", "launch_RPG32_F"];
		_scope = ["optic_Arco_blk_F", "optic_Aco", "optic_ACO_grn"];
		_magazines = ["30Rnd_65x39_caseless_green", "1Rnd_HE_Grenade_shell", "RPG32_F"];
		_backpack = "B_Carryall_ocamo";
		_loadout pushBack ["H_HelmetO_ocamo", "H_HelmetSpecO_ocamo", "H_Cap_brn_SPECOPS", "H_HelmetLeaderO_ocamo", "H_MilCap_ocamo"];
		_loadout pushBack ["U_O_CombatUniform_ocamo", "U_O_SpecopsUniform_ocamo", "U_O_V_Soldier_Viper_hex_F"];
		_loadout pushBack ["V_TacVest_khk", "V_Chestrig_khk", "V_HarnessO_brn"];
	};
	case "Green":
	{
		_weapons = ["arifle_AK12_arid_F", "arifle_AK12_GL_arid_F", "launch_RPG32_green_F"];
		_scope = ["optic_Arco_AK_arid_F", "optic_Holosight_arid_F", "optic_ACO_grn", "optic_Aco"];
		_magazines = ["30rnd_762x39_AK12_Arid_Mag_F", "1Rnd_HE_Grenade_shell", "RPG32_F"];
		_backpack = "B_Carryall_green_F";
		_loadout pushBack ["H_HelmetAggressor_cover_F", "H_MilCap_grn", "H_Booniehat_mgrn"];
		_loadout pushBack ["U_O_R_Gorka_01_F", "U_O_R_Gorka_01_brown_F"];
		_loadout pushBack ["V_SmershVest_01_F", "V_SmershVest_01_radio_F"];
	};
	case "Taiga":
	{
		_weapons = ["arifle_AK12_lush_F", "arifle_AK12_GL_lush_F", "launch_RPG32_green_F"];
		_scope = ["optic_Arco_AK_lush_F", "optic_Holosight_lush_F", "optic_ACO_grn", "optic_Aco"];
		_magazines = ["30rnd_762x39_AK12_Arid_Mag_F", "1Rnd_HE_Grenade_shell", "RPG32_F"];
		_backpack = "B_Carryall_taiga_F";
		_loadout pushBack ["H_HelmetAggressor_cover_taiga_F", "H_MilCap_taiga", "H_Booniehat_taiga"];
		_loadout pushBack ["U_O_R_Gorka_01_camo_F"];
		_loadout pushBack ["V_SmershVest_01_F", "V_SmershVest_01_radio_F"];
	};
};

_spawnPos = _missionPos vectorAdd ([[random 150 + random 150, 0, 0], random 360] call BIS_fnc_rotateVector2D);
_spawnPos = [_spawnPos, 0, 50, 0, 0, 0, 0, [], [_spawnPos, _spawnPos]] call BIS_fnc_findSafePos;
// back up vector then use in parachute velocity?
for "_i" from 1 to _nbUnits do
{
	_unitPos = _spawnPos;
	_unitPos vectorAdd ([[random 25, 0, 0], random 360] call BIS_fnc_rotateVector2D);
	_unitPos set [2, 50 + random 25];
	_unit = _group createUnit [_menTypes call BIS_fnc_selectRandom, _unitPos, [], 0, "NONE"];
	_unit setPosATL _unitPos;

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
		case ((_i + 4) % 3 == 0):
		{
			_unit addWeapon (_weapons select 1);
			_unit addMagazines [(_magazines select 1), 3];
		};
		case ((_i + 3) % 6 == 0):
		{
			_unit addBackpack _backpack;
			_unit addWeapon (_weapons select 0);
			_unit addWeapon "launch_RPG32_green_F";
			_unit addMagazines ["RPG32_F", 3];
			_unit addSecondaryWeaponItem "RPG32_F";
		};
		default
		{
			_unit addWeapon (_weapons select 0);
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

	_para = createVehicle ["Steerable_Parachute_F", (getPos _unit), [], 0, "FLY"];
	_para setPosATL _unitPos;
	_para disableCollisionWith _unit;
	_unit moveInDriver _para;
	_heading = _unitPos getDirVisual _missionPos;
	_para setDir _heading;
};

_spawnPos set [2, 100];

_vehicle = createVehicle [_vehicleClasses call BIS_fnc_selectRandom, _spawnPos, [], 0, "FLY"];
_vehicle setPosATL _spawnPos;
_vehicle setVariable ["Running", true, true];
[_vehicle] call vehicleSetup;
_vehicle call parachuteLiftedVehicle;
_vehicle setVariable ["A3W_lockpickDisabled", true, true];
_vehicle setVariable ["R3F_LOG_disabled", true, true];
[_group, _vehicle, _spawnPos, _camo] spawn
{
	_group = _this select 0;
	_vehicle = _this select 1;
	_spawnPos = _this select 2;
	_spawnPos set [2, 0];
	_camo = _this select 3;
	waitUntil
	{
		sleep 1;
		_pos = getPos _vehicle;
		(isTouchingGround _vehicle || _pos select 2 < 5) && {vectorMagnitude velocity _vehicle < [1,5] select surfaceIsWater _pos}
	};
	if (_vehicle getVariable ["Running", false]) then
	{
		_soldier = [_group, _spawnPos, _camo] call createRandomSoldier;
		_soldier = [_group, _spawnPos, _camo] call createRandomSoldier;
		_soldier = [_group, _spawnPos, _camo] call createRandomSoldier;
		_soldier moveInDriver _vehicle;
		_soldier moveInGunner _vehicle;
		_soldier moveInAny _vehicle;
		[_vehicle, _group] spawn checkMissionVehicleLock;
		_vehicle lock 2;
		_group addVehicle _vehicle;
	};
};
_vehicle