// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: createStoryMen.sqf
/*
 * Creates story men.
 *
 * Arguments: [ position, group, name]: Array
 *    position: Position - Location unit is created at.
 *    group: Group - Existing group new unit will join.
 *    name: String - Name.
 */

if (!isServer) exitWith {};

private ["_group", "_position", "_name", "_men"];

_menTypes = ["C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_3_F", "C_man_polo_4_F", "C_man_polo_5_F", "C_man_polo_6_F"];

_group = _this select 0;
_position = _this select 1;
_name = _this select 2;

_men = _group createUnit [_menTypes call BIS_fnc_selectRandom, _position, [], 0, "NONE"];

removeAllWeapons _men;
removeAllAssignedItems _men;
removeUniform _men;
removeVest _men;
removeBackpack _men;
removeHeadgear _men;
removeGoggles _men;

switch (_name) do
{
	case "miller":
	{
		_men addWeapon "arifle_SPAR_01_blk_F";
		_men addPrimaryWeaponItem "acc_pointer_IR";
		_men addPrimaryWeaponItem "optic_ERCO_blk_F";
		_men addPrimaryWeaponItem "30Rnd_556x45_Stanag";
		_men addGoggles "G_Tactical_Black";
		_men forceAddUniform "U_B_CTRG_Soldier_3_F";
		_men addVest "V_PlateCarrier2_rgr_noflag_F";
		for "_i" from 1 to 3 do {_men addItemToUniform "30Rnd_556x45_Stanag";};
		for "_i" from 1 to 2 do {_men addItemToVest "HandGrenade";};
		[_men,"Miller","male03engb"] call BIS_fnc_setIdentity;
	};
	case "president":
	{
		_men forceAddUniform "U_C_FormalSuit_01_black_F";
		[_men,"WhiteHead_14","male11eng"] call BIS_fnc_setIdentity;
		_men setName "Benjamin Asher";
	};
};

_men disableAI "MOVE";
_men disableAI "AUTOTARGET";
_men disableAI "AUTOCOMBAT";
_men disableAI "WEAPONAIM";
_men setBehaviour "SAFE";
_men setCombatMode "BLUE";
_men setspeedmode "FULL";
_men setSkill 0;
_men setskill ["courage",1];

_men
