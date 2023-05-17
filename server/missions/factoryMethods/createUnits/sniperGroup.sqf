//	@file Version: 1.0
//	@file Name: smallGroup.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file Created: 08/12/2012 21:58
//	@file Args:

if (!isServer) exitWith {};

private ["_group","_pos","_leader","_man1","_man2","_man3","_man4","_man5","_man6","_man7","_man8","_man9"];

_group = _this select 0;
_pos = _this select 1;

// Sniper
_leader = _group createUnit ["C_man_polo_1_F", [(_pos select 0) + 10, _pos select 1, 0], [], 1, "Form"];
removeAllAssignedItems _leader;
_leader forceAddUniform "U_B_FullGhillie_ard";
_leader addVest "V_Chestrig_rgr";
_leader addWeapon "srifle_LRR_camo_F";
_leader addPrimaryWeaponItem "optic_LRPS";
for "_i" from 1 to 5 do {_leader addMagazine "7Rnd_408_Mag";};
_leader addMagazine "HandGrenade";

// Sniper
_man1 = _group createUnit ["C_man_polo_2_F", [(_pos select 0) - 30, _pos select 1, 0], [], 1, "Form"];
removeAllAssignedItems _man1;
_man1 forceAddUniform "U_B_FullGhillie_ard";
_man1 addVest "V_Chestrig_rgr";
_man1 addWeapon "srifle_LRR_camo_F";
_man1 addPrimaryWeaponItem "optic_LRPS";
for "_i" from 1 to 5 do {_man1 addMagazine "7Rnd_408_Mag";};
_man1 addMagazine "HandGrenade";

// Sniper
_man2 = _group createUnit ["C_man_polo_2_F", [(_pos select 0) - 30, _pos select 1, 0], [], 1, "Form"];
removeAllAssignedItems _man2;
_man2 forceAddUniform "U_B_FullGhillie_ard";
_man2 addVest "V_Chestrig_rgr";
_man2 addWeapon "srifle_GM6_LRPS_F";
_man2 addPrimaryWeaponItem "optic_LRPS";
for "_i" from 1 to 5 do {_man2 addMagazine "5Rnd_127x108_APDS_Mag";};
_man2 addMagazine "HandGrenade";

// Sniper
_man3 = _group createUnit ["C_man_polo_2_F", [(_pos select 0) - 30, _pos select 1, 0], [], 1, "Form"];
removeAllAssignedItems _man3;
_man3 forceAddUniform "U_B_FullGhillie_ard";
_man3 addVest "V_Chestrig_rgr";
_man3 addWeapon "srifle_GM6_LRPS_F";
_man3 addPrimaryWeaponItem "optic_LRPS";
for "_i" from 1 to 5 do {_man3 addMagazine "5Rnd_127x108_APDS_Mag";};
_man3 addMagazine "HandGrenade";

// Spotter
_man4 = _group createUnit ["C_man_polo_3_F", [_pos select 0, (_pos select 1) + 30, 0], [], 1, "Form"];
removeAllAssignedItems _man4;
_man4 forceAddUniform "U_B_FullGhillie_ard";
_man4 addVest "V_Chestrig_rgr";
_man4 addWeapon "srifle_EBR_SOS_F";
for "_i" from 1 to 5 do {_man4 addMagazine "20Rnd_762x51_Mag";};
_man4 addMagazine "HandGrenade";
_man4 addItem "Rangefinder";

// Spotter
_man5 = _group createUnit ["C_man_polo_3_F", [_pos select 0, (_pos select 1) + 30, 0], [], 1, "Form"];
removeAllAssignedItems _man5;
_man5 forceAddUniform "U_B_FullGhillie_ard";
_man5 addVest "V_Chestrig_rgr";
_man5 addWeapon "srifle_EBR_SOS_F";
for "_i" from 1 to 5 do {_man5 addMagazine "20Rnd_762x51_Mag";};
_man5 addMagazine "HandGrenade";
_man5 addItem "Rangefinder";

// Spotter
_man6 = _group createUnit ["C_man_polo_3_F", [_pos select 0, (_pos select 1) + 30, 0], [], 1, "Form"];
removeAllAssignedItems _man6;
_man6 forceAddUniform "U_B_FullGhillie_ard";
_man6 addVest "V_Chestrig_rgr";
_man6 addWeapon "srifle_EBR_SOS_F";
_man6 addMagazine "HandGrenade";
for "_i" from 1 to 5 do {_man6 addMagazine "20Rnd_762x51_Mag";};
_man6 addItem "Rangefinder";

// Spotter
_man7 = _group createUnit ["C_man_polo_3_F", [_pos select 0, (_pos select 1) + 30, 0], [], 1, "Form"];
removeAllAssignedItems _man7;
_man7 forceAddUniform "U_B_FullGhillie_ard";
_man7 addVest "V_Chestrig_rgr";
_man7 addWeapon "srifle_EBR_SOS_F";
_man7 addMagazine "HandGrenade";
for "_i" from 1 to 5 do {_man7 addMagazine "20Rnd_762x51_Mag";};
_man7 addItem "Rangefinder";

//AA Defender
_man8 = _group createUnit ["C_man_polo_3_F", [_pos select 0, (_pos select 1) + 30, 0], [], 1, "Form"];
removeAllAssignedItems _man8;
_man8 forceAddUniform "U_B_FullGhillie_ard";
_man8 addVest "V_Chestrig_rgr";
_man8 addBackpack "B_Carryall_oli";
_man8 addWeapon "srifle_DMR_01_F";
_man8 addPrimaryWeaponItem "optic_Holosight";
_man8 addWeapon "launch_I_Titan_F";
_man8 addMagazine "HandGrenade";
_man8 selectWeapon "launch_I_Titan_F";
for "_i" from 1 to 5 do {_man8 addMagazine "10Rnd_762x51_Mag";};
for "_i" from 1 to 3 do {_man8 addMagazine "Titan_AA";};

//AT Defender
_man9 = _group createUnit ["C_man_polo_3_F", [_pos select 0, (_pos select 1) + 30, 0], [], 1, "Form"];
removeAllAssignedItems _man9;
_man9 forceAddUniform "U_B_FullGhillie_ard";
_man9 addVest "V_Chestrig_rgr";
_man9 addBackpack "B_Carryall_oli";
_man9 addWeapon "srifle_DMR_01_F";
_man9 addPrimaryWeaponItem "optic_Holosight";
_man9 addWeapon "launch_RPG32_F";
_man9 addMagazine "HandGrenade";
_man9 selectWeapon "launch_RPG32_F";
for "_i" from 1 to 3 do {_man9 addMagazine "10Rnd_762x51_Mag";};
for "_i" from 1 to 4 do {_man9 addMagazine "RPG32_F";};

_leader = leader _group;

{
	
	_x addItem "FirstAidKit";
	_x call setMissionSkill;
	_x spawn refillPrimaryAmmo;
	_x allowFleeing 0;
	_x addRating 9999999;
	_x setSkill ["spotDistance", 0.46];
} forEach units _group;

[_group, _pos] call defendArea;
