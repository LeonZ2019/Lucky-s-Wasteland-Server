//	@file Name: createAASoldier.sqf
/*
 * Creates a random AA soldier.
 *
 * Arguments: [group, position]: Array
 *    position: Position - Location unit is created at.
 *    group: Group - Existing group new unit will join.
 */

if (!isServer) exitWith {};

private ["_group", "_position", "_soldierTypes", "_weapon", "_uniformTypes", "_vestTypes","_soldier"];

_group = _this select 0;
_position = _this select 1;

_soldierTypes = ["C_man_1_3_F","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F"];
_weapon = ["launch_Titan_F", "launch_O_Titan_F", "launch_I_Titan_F", "launch_B_Titan_tna_F", "launch_O_Titan_ghex_F", "launch_I_Titan_eaf_F"] call BIS_fnc_selectRandom;
_uniformTypes = ["U_B_CombatUniform_mcam_vest", "U_B_CombatUniform_mcam_tshirt" ,"U_B_CombatUniform_mcam"];
_vestTypes = ["V_PlateCarrier1_rgr","V_PlateCarrier2_rgr"];

_soldier = _group createUnit [_soldierTypes call BIS_fnc_selectRandom, _position, [], 0, "NONE"];

removeAllAssignedItems _soldier;

_soldier addUniform (_uniformTypes call BIS_fnc_selectRandom);
_soldier addVest (_vestTypes call BIS_fnc_selectRandom);
_soldier addWeapon _weapon;
_soldier addWeaponItem [_weapon, "Titan_AA", true];

_soldier call setMissionSkill;

_soldier
