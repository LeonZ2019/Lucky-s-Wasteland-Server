// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: fn_refilltruck.sqf
//	@file Author: AgentRev
//	@file Created: 30/06/2013 15:28
// recode this to less stuff and couple more of set
if (!isServer) exitWith {};

#define RANDOM_BETWEEN(START,END) (START + floor random ((END - START) + 1))

private ["_truck", "_truckItems", "_item", "_qty", "_mag"];
_truck = _this;

// Clear prexisting cargo first
clearMagazineCargoGlobal _truck;
clearWeaponCargoGlobal _truck;
clearItemCargoGlobal _truck;

// Item type, Item, # of items, # of magazines per weapon
_truckItems =
[
	[
		["wep", ["Binocular", "Rangefinder"], RANDOM_BETWEEN(0,2)],
		["itm", "FirstAidKit", RANDOM_BETWEEN(2,5)],
		["itm", "Medikit", RANDOM_BETWEEN(1,3)],
		["itm", "Toolkit", RANDOM_BETWEEN(0,1)],

		["itm", ["muzzle_snds_M", "muzzle_snds_m_khk_F", "muzzle_snds_m_snd_F", "muzzle_snds_H", "muzzle_snds_H_khk_F", "muzzle_snds_H_snd_F", "muzzle_snds_65_TI_blk_F", "muzzle_snds_65_TI_hex_F", "muzzle_snds_65_TI_ghex_F", "muzzle_snds_B", "muzzle_snds_B_khk_F", "muzzle_snds_B_snd_F", "muzzle_snds_B_arid_F", "muzzle_snds_B_lush_F"], RANDOM_BETWEEN(1,4)],
		["itm", ["optic_Aco", "optic_ACO_grn", "optic_MRCO", "optic_Hamr", "optic_Arco"], RANDOM_BETWEEN(2,4)],

		["wep", [
			["arifle_Mk20_GL_plain_F", "arifle_Mk20_GL_F", "arifle_TRG21_GL_F", "arifle_Katiba_GL_F"],
			["arifle_MX_GL_F", "arifle_MX_GL_Black_F", "arifle_MX_GL_khk_F"],
			["arifle_CTAR_GL_blk_F", "arifle_CTAR_GL_hex_F", "arifle_CTAR_GL_ghex_F"],
			["arifle_AK12_GL_F", "arifle_AK12_GL_arid_F", "arifle_AK12_GL_lush_F"]
		], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(3,5)],
		["wep", [
			["srifle_LRR_LRPS_F", "srifle_LRR_camo_LRPS_F", "srifle_LRR_tna_LRPS_F"],
			["srifle_GM6_LRPS_F", "srifle_GM6_camo_LRPS_F", "srifle_GM6_ghex_LRPS_F"],
			["srifle_DMR_06_camo_F", "srifle_DMR_06_olive_F", "srifle_DMR_06_hunter_F"]
		], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(4,8)],
		["wep",[
			"launch_NLAW_F",
			["launch_RPG32_F", "launch_RPG32_ghex_F", "launch_RPG32_green_F"],
			["launch_O_Vorona_brown_F", "launch_O_Vorona_green_F"]
		], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(1,3)],
		["wep", ["launch_Titan_F", "launch_O_Titan_F", "launch_I_Titan_F", "launch_B_Titan_tna_F", "launch_O_Titan_ghex_F"], RANDOM_BETWEEN(1,2), 1],

		["mag", "HandGrenade", RANDOM_BETWEEN(4,8)],
		["mag", "1Rnd_HE_Grenade_shell", RANDOM_BETWEEN(4,8)],

		["mag", ["APERSTripMine_Wire_Mag", "APERSBoundingMine_Range_Mag", "SLAMDirectionalMine_Wire_Mag", "ATMine_Range_Mag"], RANDOM_BETWEEN(2,5)],
		["mag", ["SLAMDirectionalMine_Wire_Mag", "ATMine_Range_Mag", "DemoCharge_Remote_Mag", "SatchelCharge_Remote_Mag"], RANDOM_BETWEEN(2,5)],

		["itm", [
			["H_HelmetB", "H_HelmetB_camo", "H_HelmetB_grass", "H_HelmetB_snakeskin", "H_HelmetB_desert", "H_HelmetB_black", "H_HelmetB_sand", "H_HelmetB_tna_F", "H_HelmetB_plain_wdl"],
			["H_HelmetO_ocamo", "H_HelmetO_ghex_F", "H_HelmetO_oucamo"]
		], RANDOM_BETWEEN(3,5)],
		["itm", [
			["V_PlateCarrier1_rgr", "V_PlateCarrier1_blk", "V_PlateCarrierIA1_dgtl"], // Lite
			["V_PlateCarrier2_rgr", "V_PlateCarrier2_blk", "V_PlateCarrierIA2_dgtl"], // Rig
			["V_PlateCarrierSpec_rgr", "V_PlateCarrierSpec_blk", "V_PlateCarrierSpec_mtp"], // Special
			["V_PlateCarrierGL_rgr", "V_PlateCarrierGL_blk", "V_PlateCarrierGL_mtp", "V_PlateCarrierIAGL_dgtl", "V_PlateCarrierIAGL_oli"] // GL
		], RANDOM_BETWEEN(1,4)]
	],
	[
		["wep", ["Laserdesignator", "Laserdesignator_03", "Laserdesignator_01_khk_F", "Laserdesignator_02", "Laserdesignator_02_ghex_F"], RANDOM_BETWEEN(0,2)],
		["itm", "FirstAidKit", RANDOM_BETWEEN(2,5)],
		["itm", "Medikit", RANDOM_BETWEEN(1,3)],
		["itm", "Toolkit", RANDOM_BETWEEN(0,1)],

		["itm", ["muzzle_snds_M", "muzzle_snds_m_khk_F", "muzzle_snds_m_snd_F", "muzzle_snds_H", "muzzle_snds_H_khk_F", "muzzle_snds_H_snd_F", "muzzle_snds_65_TI_blk_F", "muzzle_snds_65_TI_hex_F", "muzzle_snds_65_TI_ghex_F", "muzzle_snds_B", "muzzle_snds_B_khk_F", "muzzle_snds_B_snd_F", "muzzle_snds_B_arid_F", "muzzle_snds_B_lush_F"], RANDOM_BETWEEN(1,4)],
		["itm", ["optic_Aco", "optic_ACO_grn", "optic_MRCO", "optic_Hamr", "optic_Arco"], RANDOM_BETWEEN(2,4)],

		["wep", [
			["arifle_SPAR_01_GL_blk_F", "arifle_SPAR_01_GL_khk_F", "arifle_SPAR_01_GL_snd_F"],
			["arifle_ARX_blk_F", "arifle_ARX_hex_F", "arifle_ARX_ghex_F"],
			["arifle_MSBS65_GL_F", "arifle_MSBS65_GL_black_F", "arifle_MSBS65_GL_camo_F", "arifle_MSBS65_GL_sand_F"]
		], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(3,5)],
		["wep", [
			["srifle_DMR_02_F", "srifle_DMR_02_camo_F", "srifle_DMR_02_sniper_F"],
			["srifle_DMR_05_blk_F", "srifle_DMR_05_hex_F", "srifle_DMR_05_tan_f"],
			["srifle_DMR_03_F", "srifle_DMR_03_multicam_F", "srifle_DMR_03_khaki_F", "srifle_DMR_03_tan_F", "srifle_DMR_03_woodland_F"]
		], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(4,8)],
		["wep",[
			["launch_MRAWS_green_rail_F", "launch_MRAWS_olive_rail_F", "launch_MRAWS_sand_rail_F", "launch_MRAWS_green_F", "launch_MRAWS_olive_F", "launch_MRAWS_sand_F"],
			["launch_Titan_short_F", "launch_O_Titan_short_F", "launch_I_Titan_short_F", "launch_B_Titan_short_tna_F", "launch_O_Titan_short_ghex_F"]
		], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(1,3)],
		["wep", ["launch_Titan_F", "launch_O_Titan_F", "launch_I_Titan_F", "launch_B_Titan_tna_F", "launch_O_Titan_ghex_F"], RANDOM_BETWEEN(1,2), 1],
	
		["mag", "HandGrenade", RANDOM_BETWEEN(4,8)],
		["mag", "1Rnd_HE_Grenade_shell", RANDOM_BETWEEN(4,8)],

		["mag", ["APERSTripMine_Wire_Mag", "APERSBoundingMine_Range_Mag", "SLAMDirectionalMine_Wire_Mag", "ATMine_Range_Mag"], RANDOM_BETWEEN(2,5)],
		["mag", ["SLAMDirectionalMine_Wire_Mag", "ATMine_Range_Mag", "DemoCharge_Remote_Mag", "SatchelCharge_Remote_Mag"], RANDOM_BETWEEN(2,5)],

		["itm", [
			["H_HelmetSpecB", "H_HelmetSpecB_blk", "H_HelmetSpecB_snakeskin", "H_HelmetSpecB_paint1", "H_HelmetSpecB_paint2", "H_HelmetSpecB_sand", "H_HelmetSpecB_wdl", "H_HelmetB_Enh_tna_F"],
			["H_HelmetLeaderO_ocamo", "H_HelmetLeaderO_oucamo", "H_HelmetLeaderO_ghex_F", "H_HelmetSpecO_ocamo", "H_HelmetSpecO_ghex_F", "H_HelmetSpecO_blk"]
		], RANDOM_BETWEEN(3,5)],
		["itm", [
			["V_PlateCarrier1_rgr", "V_PlateCarrier1_blk", "V_PlateCarrierIA1_dgtl"], // Lite
			["V_PlateCarrier2_rgr", "V_PlateCarrier2_blk", "V_PlateCarrierIA2_dgtl"], // Rig
			["V_PlateCarrierSpec_rgr", "V_PlateCarrierSpec_blk", "V_PlateCarrierSpec_mtp"], // Special
			["V_PlateCarrierGL_rgr", "V_PlateCarrierGL_blk", "V_PlateCarrierGL_mtp", "V_PlateCarrierIAGL_dgtl", "V_PlateCarrierIAGL_oli"] // GL
		], RANDOM_BETWEEN(1,4)]
		
	]
];

[_truck, _truckItems call BIS_fnc_selectRandom] call processItems;
