//	@file Name: createHostage.sqf
/*
 * Creates a random hostage.
 *
 * Arguments: [ position, group, init, skill, rank]: Array
 *    position: Position - Location unit is created at.
 *    group: Group - Existing group new unit will join.
 *    init: String - (optional, default "") Command to be executed upon creation of unit. Parameter this is set to the created unit and passed to the code.
 *    skill: Number - (optional, default 0.5)
 *    rank: String - (optional, default "PRIVATE")
 */

if (!isServer) exitWith {};

private ["_hostageTypes","_group","_position","_hostage"];

_headGearTypes = ["H_PilotHelmetFighter_O", "H_PilotHelmetFighter_B"];
_hostageTypes = ["C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F"];

_group = _this select 0;
_position = _this select 1;

_hostage = _group createUnit [_hostageTypes call BIS_fnc_selectRandom, _position, [], 0, "NONE"];
removeAllAssignedItems _hostage;
removeAllWeapons _hostage;
removeAllItems _hostage;
removeAllAssignedItems _hostage;
removeVest _hostage;
removeBackpack _hostage;
removeHeadgear _hostage;

_hostage forceAddUniform "U_C_Uniform_Farmer_01_F";
_hostage addGoggles "G_Blindfold_01_white_F";
_hostage
