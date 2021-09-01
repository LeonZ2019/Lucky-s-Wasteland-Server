//	@file Name: createRandomPilot.sqf
/*
 * Creates a random civilian soldier.
 *
 * Arguments: [ position, group, init, skill, rank]: Array
 *    position: Position - Location unit is created at.
 *    group: Group - Existing group new unit will join.
 *    init: String - (optional, default "") Command to be executed upon creation of unit. Parameter this is set to the created unit and passed to the code.
 *    skill: Number - (optional, default 0.5)
 *    rank: String - (optional, default "PRIVATE")
 */

if (!isServer) exitWith {};

private ["_soldierTypes","_uniformTypes","_vestTypes","_weaponTypes","_group","_position","_soldier"];

_headGearTypes = ["H_PilotHelmetFighter_O", "H_PilotHelmetFighter_B"];
_soldierTypes = ["C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F"];
_uniformTypes = ["U_I_pilotCoveralls", "U_B_PilotCoveralls"];
_vestTypes = ["V_PlateCarrier1_rgr","V_PlateCarrier2_rgr"];
_weaponTypes = ["SMG_01_F","SMG_02_F","SMG_05_F","SMG_03C_TR_black"];

_group = _this select 0;
_position = _this select 1;

_soldier = _group createUnit [_soldierTypes call BIS_fnc_selectRandom, _position, [], 0, "NONE"];
removeAllAssignedItems _soldier;

_soldier addUniform (_uniformTypes call BIS_fnc_selectRandom);
_soldier addVest (_vestTypes call BIS_fnc_selectRandom);

_soldier addItemToVest "Chemlight_green";
_soldier addItemToVest "SmokeShellGreen";

_weapon = (_weaponTypes call BIS_fnc_selectRandom);
_soldier addWeapon _weapon;
_soldier addWeapon "hgun_ACPC2_F";

_ammo = "";
switch (_weapon) do {
    case "SMG_01_F": {_ammo = "30Rnd_45ACP_Mag_SMG_01"};
    case "SMG_02_F"; case "SMG_05_F": {_ammo = "30Rnd_9x21_Mag_SMG_02"};
    case "SMG_03C_TR_black": {_ammo = "50Rnd_570x28_SMG_03"};
};

for "_i" from 1 to 3 do {_soldier addItemToVest _ammo;};
for "_i" from 1 to 2 do {_soldier addItemToUniform "9Rnd_45ACP_Mag";};

sleep 0.1; // Without this delay, headgear doesn't get removed properly
_soldier addHeadgear (_headGearTypes call BIS_fnc_selectRandom);
_soldier addWeaponItem [_weapon, _ammo];

_soldier spawn refillPrimaryAmmo;
_soldier call setMissionSkill;

_soldier
