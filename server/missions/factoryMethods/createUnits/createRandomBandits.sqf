if (!isServer) exitWith {};

private ["_banditTypes", "_group", "_position", "_weapons", "_weaponIndex", "_loadout", "_bandit"];

_banditTypes = ["C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_3_F", "C_man_polo_4_F", "C_man_polo_5_F", "C_man_polo_6_F"];
_group = _this select 0;
_position = _this select 1;
_weapons = ["arifle_AKM_F", "arifle_AKS_F", "SMG_02_F", "sgun_HunterShotgun_01_f", "sgun_HunterShotgun_01_sawedoff_f"];
_loadout = [["H_Bandanna_gry", "H_Bandanna_blu", "H_Bandanna_cbr", "H_Bandanna_khk", "H_Bandanna_sand", "H_Bandanna_sgg"], ["U_BG_Guerilla3_1", "U_BG_Guerilla2_3", "U_BG_Guerilla2_1", "U_BG_Guerilla2_2", "U_I_C_Soldier_Bandit_1_F", "U_I_C_Soldier_Bandit_2_F", "U_I_C_Soldier_Bandit_3_F", "U_I_C_Soldier_Bandit_4_F", "U_I_C_Soldier_Bandit_5_F"], ["V_Chestrig_blk", "V_TacVest_blk", "V_Chestrig_oli"]];

_bandit = _group createUnit [_banditTypes call BIS_fnc_selectRandom, _position, [], 0, "NONE"];
removeHeadgear _bandit;
removeAllAssignedItems _bandit;

_bandit addHeadgear ((_loadout select 0) call BIS_fnc_selectRandom);
_bandit forceAddUniform ((_loadout select 1) call BIS_fnc_selectRandom);
_bandit addVest ((_loadout select 2) call BIS_fnc_selectRandom);
_weaponIndex = floor random 5;
[_bandit, _weapons select _weaponIndex, 6] call BIS_fnc_addWeapon;

_bandit addItem "FirstAidKit";
_bandit spawn refillPrimaryAmmo;
_bandit call setMissionSkill;

[_group, _position] call defendArea;
_bandit
