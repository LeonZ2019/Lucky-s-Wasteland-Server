// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: createRandomSoldier.sqf
/*
 * Creates a random civilian soldier.
 *
 * Arguments: [ position, group, camo, rank]: Array
 *    position: Position - Location unit is created at.
 *    group: Group - Existing group new unit will join.
 *    camo: String - Camo Name.
 *    rank: String - (optional, default "PRIVATE")
 */

if (!isServer) exitWith {};

private ["_soldierTypes", "_group", "_position", "_camo", "_rank", "_weapons", "_weaponIndex", "_scope", "_loadout", "_soldier"];

_soldierTypes = ["C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_3_F", "C_man_polo_4_F", "C_man_polo_5_F", "C_man_polo_6_F"];
_group = _this select 0;
_position = _this select 1;
_camo = _this select 2;
_rank = param [3, "", [""]];
_weapons = [];
_scope = [];
_loadout = [];
_magazine = "";
switch (_camo) do
{
	case "MTP":
	{
		_weapons = ["arifle_MX_F", "arifle_MX_GL_F"];
		_scope = ["optic_Arco", "optic_ACO_grn", "optic_Aco", "optic_Holosight", "optic_Hamr"];
		_loadout pushBack ["H_Booniehat_mcamo", "H_Cap_tan_specops_US", "H_HelmetB_desert", "H_HelmetB_light_desert", "H_HelmetSpecB_paint2", "H_MilCap_mcamo"];
		_magazine = "30Rnd_65x39_caseless_mag_Tracer";
		_loadout pushBack ["U_B_CombatUniform_mcam", "U_B_CombatUniform_mcam_vest", "U_B_CombatUniform_mcam_tshirt"];
		_loadout pushBack ["V_PlateCarrier1_rgr", "V_PlateCarrier2_rgr", "V_Chestrig_rgr", "V_BandollierB_rgr"];
	};
	case "Tropic":
	{
		_weapons = ["arifle_MX_khk_F", "arifle_MX_GL_khk_F"];
		_scope = ["optic_Aco", "optic_ACO_grn", "optic_ERCO_khk_F", "optic_Holosight_khk_F", "optic_Hamr_khk_F"];
		_magazine = "30Rnd_65x39_caseless_khaki_mag";
		_loadout pushBack ["H_Booniehat_tna_F", "H_HelmetB_tna_F", "H_HelmetB_Enh_tna_F", "H_HelmetB_Light_tna_F", "H_MilCap_tna_F"];
		_loadout pushBack ["U_B_T_Soldier_F", "U_B_T_Soldier_SL_F", "U_B_T_Soldier_AR_F", "U_B_T_Sniper_F"];
		_loadout pushBack ["V_PlateCarrier1_tna_F", "V_PlateCarrier2_tna_F"];
	};
	case "CTRGArid":
	{
		_weapons = ["arifle_SPAR_01_snd_F", "arifle_SPAR_01_GL_snd_F"];
		_scope = ["optic_Aco", "optic_ACO_grn", "optic_Arco", "optic_ERCO_snd_F", "optic_Holosight", "optic_Hamr"];
		_magazine = "30Rnd_556x45_Stanag_Sand_red";
		_loadout pushBack ["H_HelmetB_TI_arid_F"];
		_loadout pushBack ["U_B_CTRG_1", "U_B_CTRG_2", "U_B_CTRG_3", "U_B_CTRG_Soldier_Arid_F", "U_B_CTRG_Soldier_2_Arid_F", "U_B_CTRG_Soldier_3_Arid_F"];
		_loadout pushBack ["V_PlateCarrierL_CTRG", "V_PlateCarrierH_CTRG"];
	};
	case "CTRGUrban":
	{
		_weapons = ["arifle_SPAR_01_khk_F", "arifle_SPAR_01_GL_khk_F"];
		_scope = ["optic_Aco", "optic_ACO_grn", "optic_ERCO_khk_F", "optic_Holosight_khk_F", "optic_Hamr_khk_F"];
		_magazine = "30Rnd_556x45_Stanag_red";
		_loadout pushBack ["H_HelmetB_TI_tna_F"];
		_loadout pushBack ["U_B_CTRG_Soldier_urb_1_F", "U_B_CTRG_Soldier_urb_2_F", "U_B_CTRG_Soldier_urb_3_F"];
		_loadout pushBack ["V_PlateCarrierL_CTRG", "V_PlateCarrierH_CTRG"];
	};
	case "CTRGTropic":
	{
		_weapons = ["arifle_SPAR_01_blk_F", "arifle_SPAR_01_GL_blk_F"];
		_scope = ["optic_Aco", "optic_ACO_grn", "optic_Arco_blk_F", "optic_ERCO_blk_F", "optic_Holosight_blk_F", "optic_Hamr"];
		_magazine = "30Rnd_556x45_Stanag_red";
		_loadout pushBack ["H_HelmetB_TI_tna_F"];
		_loadout pushBack ["U_B_CTRG_Soldier_F", "U_B_CTRG_Soldier_2_F", "U_B_CTRG_Soldier_3_F"];
		_loadout pushBack ["V_PlateCarrierL_CTRG", "V_PlateCarrierH_CTRG"];
	};
	case "Woodland":
	{
		_weapons = ["arifle_MX_Black_F", "arifle_MX_GL_Black_F"];
		_scope = ["optic_Aco", "optic_ACO_grn", "optic_Arco_blk_F", "optic_ERCO_blk_F", "optic_Holosight_blk_F", "optic_Hamr"];
		_magazine = "30Rnd_65x39_caseless_black_mag_Tracer";
		_loadout pushBack ["H_Booniehat_wdl", "H_HelmetB_plain_wdl", "H_HelmetSpecB_wdl", "H_HelmetB_light_wdl", "H_MilCap_wdl"];
		_loadout pushBack ["U_B_CombatUniform_mcam_wdl_f", "U_B_CombatUniform_tshirt_mcam_wdL_f", "U_B_CombatUniform_vest_mcam_wdl_f"];
		_loadout pushBack ["V_PlateCarrier1_wdl", "V_PlateCarrier2_wdl"];
	};
	case "GreenHex":
	{
		_weapons = ["arifle_Katiba_F", "arifle_Katiba_GL_F"];
		_scope = ["optic_Arco_blk_F", "optic_Aco", "optic_ACO_grn"];
		_magazine = "30Rnd_65x39_caseless_green";
		_loadout pushBack ["H_HelmetLeaderO_ghex_F", "H_MilCap_ghex_F", "H_HelmetO_ghex_F"];
		_loadout pushBack ["U_O_T_Soldier_F", "U_O_V_Soldier_Viper_F"];
		_loadout pushBack ["V_HarnessO_ghex_F", "V_HarnessOGL_ghex_F", "V_TacVest_oli"];
	};
	case "Hex":
	{
		_weapons = ["arifle_Katiba_F", "arifle_Katiba_GL_F"];
		_scope = ["optic_Arco_blk_F", "optic_Aco", "optic_ACO_grn"];
		_magazine = "30Rnd_65x39_caseless_green";
		_loadout pushBack ["H_HelmetO_ocamo", "H_HelmetSpecO_ocamo", "H_Cap_brn_SPECOPS", "H_HelmetLeaderO_ocamo", "H_MilCap_ocamo"];
		_loadout pushBack ["U_O_CombatUniform_ocamo", "U_O_SpecopsUniform_ocamo", "U_O_V_Soldier_Viper_hex_F"];
		_loadout pushBack ["V_TacVest_khk", "V_Chestrig_khk", "V_HarnessO_brn"];
	};
	case "Green":
	{
		_weapons = ["arifle_AK12_arid_F", "arifle_AK12_GL_arid_F"];
		_scope = ["optic_Arco_AK_arid_F", "optic_Holosight_arid_F", "optic_ACO_grn", "optic_Aco"];
		_magazine = "30rnd_762x39_AK12_Arid_Mag_F";
		_loadout pushBack ["H_HelmetAggressor_cover_F", "H_MilCap_grn", "H_Booniehat_mgrn"];
		_loadout pushBack ["U_O_R_Gorka_01_F", "U_O_R_Gorka_01_brown_F"];
		_loadout pushBack ["V_SmershVest_01_F", "V_SmershVest_01_radio_F"];
	};
	case "Taiga":
	{
		_weapons = ["arifle_AK12_lush_F", "arifle_AK12_GL_lush_F"];
		_scope = ["optic_Arco_AK_lush_F", "optic_Holosight_lush_F", "optic_ACO_grn", "optic_Aco"];
		_magazine = "30rnd_762x39_AK12_Arid_Mag_F";
		_loadout pushBack ["H_HelmetAggressor_cover_taiga_F", "H_MilCap_taiga", "H_Booniehat_taiga"];
		_loadout pushBack ["U_O_R_Gorka_01_camo_F"];
		_loadout pushBack ["V_SmershVest_01_F", "V_SmershVest_01_radio_F"];
	};
	case "Digital":
	{
		_weapons = ["arifle_Mk20_F", "arifle_Mk20_GL_F"];
		_scope = ["optic_Aco", "optic_ACO_grn", "optic_MRCO"];
		_magazine = "30Rnd_556x45_Stanag";
		_loadout pushBack ["H_Booniehat_dgtl", "H_Cap_blk_Raven", "H_MilCap_dgtl", "H_HelmetIA"];
		_loadout pushBack ["U_I_CombatUniform", "U_I_CombatUniform_shortsleeve"];
		_loadout pushBack ["V_PlateCarrierIA1_dgtl", "V_PlateCarrierIA2_dgtl"];
	};
	case "Geometric":
	{
		_weapons = ["arifle_MSBS65_F", "arifle_MSBS65_GL_F"];
		_scope = ["optic_ico_01_f"];
		_magazine = "30Rnd_65x39_caseless_msbs_mag";
		_loadout pushBack ["H_HelmetHBK_headset_F", "H_HelmetHBK_F", "H_Booniehat_eaf", "H_MilCap_eaf"];
		_loadout pushBack ["U_I_E_Uniform_01_shortsleeve_F", "U_I_E_Uniform_01_sweater_F", "U_I_E_Uniform_01_tanktop_F", "U_I_E_Uniform_01_F"];
		_loadout pushBack ["V_CarrierRigKBT_01_light_EAF_F", "V_CarrierRigKBT_01_EAF_F"];
	};
	case "Guerilla":
	{
		_weapons = ["arifle_TRG21_F", "arifle_TRG21_GL_F"];
		_scope = ["optic_Aco", "optic_ACO_grn"];
		_magazine = "30Rnd_556x45_Stanag";
		_loadout pushBack ["H_Watchcap_blk", "H_Booniehat_khk", "H_Shemag_olive", "H_Bandanna_khk", "H_Watchcap_blk", "H_Booniehat_khk"];
		_loadout pushBack ["U_IG_leader", "U_BG_Guerilla2_1", "U_IG_Guerilla1_1", "U_BG_Guerilla2_2", "U_BG_Guerilla2_3", "U_BG_Guerrilla_6_1", "U_BG_Guerilla1_1", "U_BG_Guerilla3_1"];
		_loadout pushBack ["V_Chestrig_blk", "V_TacVest_blk", "V_Chestrig_oli"];
	};
};

_soldier = _group createUnit [_soldierTypes call BIS_fnc_selectRandom, _position, [], 0, "NONE"];
removeHeadgear _soldier;
removeAllAssignedItems _soldier;

_soldier addHeadgear ((_loadout select 0) call BIS_fnc_selectRandom);
_soldier forceAddUniform ((_loadout select 1) call BIS_fnc_selectRandom);
_soldier addVest ((_loadout select 2) call BIS_fnc_selectRandom);
_weaponIndex = floor random 2;
[_soldier, _weapons select _weaponIndex, 4, _magazine] call BIS_fnc_addWeapon;
if (_weaponIndex == 1) then
{
	_soldier addMagazines ["1Rnd_HE_Grenade_shell", 3];
};
_soldier addItem "FirstAidKit";
_soldier addPrimaryWeaponItem (_scope call BIS_fnc_selectRandom);

if (_rank != "") then
{
	_soldier setRank _rank;
};

_soldier call setMissionSkill;
_soldier spawn refillPrimaryAmmo;

_soldier
