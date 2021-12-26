// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: fn_refillbox.sqf  "fn_refillbox"
//	@file Author: [404] Pulse , [404] Costlyy , [404] Deadbeat, AgentRev
//	@file Created: 22/1/2012 00:00
//	@file Args: [OBJECT (Weapons box that needs filling), STRING (Name of the fill to give to object)]

if (!isServer) exitWith {};

#define RANDOM_BETWEEN(START,END) ((START) + floor random ((END) - (START) + 1))
#define RANDOM_ODDS(ODDS) ([0,1] select (random 1 < (ODDS))) // between 0.0 and 1.0

private ["_box", "_boxType", "_boxItems", "_item", "_qty", "_mag"];
_box = _this select 0;
_boxType = _this select 1;

_box setVariable [call vChecksum, true];

_box allowDamage false; // No more fucking busted crates
_box setVariable ["allowDamage", false, true];
_box setVariable ["A3W_inventoryLockR3F", true, true];

// Clear pre-existing cargo first
//clearBackpackCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearItemCargoGlobal _box;

if (_boxType == "mission_USSpecial2") then { _boxType = "mission_USSpecial" };

switch (_boxType) do
{
	case "mission_USLaunchers":
	{
		_boxItems =
		[
			["wep",[
				"launch_NLAW_F",
				["launch_Titan_short_F", "launch_O_Titan_short_F", "launch_I_Titan_short_F", "launch_B_Titan_short_tna_F"],
				["launch_MRAWS_green_F", "launch_MRAWS_olive_F", "launch_MRAWS_sand_F"]
			], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(2,4)],

			["wep", ["launch_Titan_F", "launch_B_Titan_tna_F", "launch_I_Titan_eaf_F"], RANDOM_BETWEEN(2,3), RANDOM_BETWEEN(1,2)],

			["wep", ["Laserdesignator", "Laserdesignator_01_khk_F", "Laserdesignator_03"], RANDOM_BETWEEN(1,2), 1],

			["itm", "FirstAidKit", RANDOM_BETWEEN(2,5)],

			["itm", ["B_Kitbag_cbr", "B_Kitbag_rgr", "B_Kitbag_mcamo", "B_Kitbag_sgg", "B_Kitbag_tan"], 3],

			["mag", ["ClaymoreDirectionalMine_Remote_Mag", "SLAMDirectionalMine_Wire_Mag", "IEDUrbanSmall_Remote_Mag"], RANDOM_BETWEEN(2,4)],

			["mag", "HandGrenade", RANDOM_BETWEEN(5,10)]
		];
	};
	case "mission_RULaunchers":
	{
		_boxItems =
		[
			["wep", ["launch_RPG7_F",
				["launch_RPG32_F", "launch_RPG32_ghex_F"],
				["launch_O_Vorona_brown_F", "launch_O_Vorona_green_F"],
				["launch_MRAWS_green_rail_F", "launch_MRAWS_olive_rail_F", "launch_MRAWS_sand_rail_F"]
			], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(2,4)],

			["wep", ["launch_Titan_F", "launch_O_Titan_F", "launch_I_Titan_F", "launch_O_Titan_ghex_F"], RANDOM_BETWEEN(2,3), RANDOM_BETWEEN(1,2)],

			["wep", ["Laserdesignator", "Laserdesignator_02_ghex_F", "Laserdesignator_02"], RANDOM_BETWEEN(1,2), 1],

			["itm", "FirstAidKit", RANDOM_BETWEEN(2,5)],

			["itm", ["B_Kitbag_cbr", "B_Kitbag_rgr", "B_Kitbag_mcamo", "B_Kitbag_sgg", "B_Kitbag_tan"], 3],

			["mag", ["ClaymoreDirectionalMine_Remote_Mag", "SLAMDirectionalMine_Wire_Mag", "IEDUrbanSmall_Remote_Mag"], RANDOM_BETWEEN(2,4)],

			["mag", "HandGrenade", RANDOM_BETWEEN(5,10)]
		];
	};
	case "mission_CTRGGears": // failure
	{
		_boxItems =
		[
			["itm", ["H_HelmetB_TI_arid_F", "H_HelmetB_TI_tna_F", "H_HelmetB_TI_arid_F", "H_HelmetLeaderO_ocamo", "H_HelmetLeaderO_oucamo", "H_HelmetLeaderO_ghex_F"], RANDOM_BETWEEN(5,9)],

			["itm", ["U_B_CTRG_1", "U_B_CTRG_2", "U_B_CTRG_3", "U_B_CTRG_Soldier_Arid_F", "U_B_CTRG_Soldier_2_Arid_F", "U_B_CTRG_Soldier_3_Arid_F", "U_B_CTRG_Soldier_urb_1_F", "U_B_CTRG_Soldier_urb_2_F", "U_B_CTRG_Soldier_urb_3_F", "U_B_CTRG_Soldier_F", "U_B_CTRG_Soldier_2_F", "U_B_CTRG_Soldier_3_F", "U_O_V_Soldier_Viper_hex_F", "U_O_V_Soldier_Viper_F"], RANDOM_BETWEEN(10,14)],

			["itm", ["NVGoggles", "NVGoggles_OPFOR", "NVGoggles_INDEP", "NVGoggles_tna_F", "O_NVGoggles_ghex_F", "O_NVGoggles_hex_F", "O_NVGoggles_urb_F"], RANDOM_BETWEEN(3,7)],

			["itm", ["V_PlateCarrierL_CTRG", "V_PlateCarrierH_CTRG"], RANDOM_BETWEEN(2,4)],

			["itm", ["B_Carryall_green_F", "B_Carryall_taiga_F", "B_Carryall_wdl_F", "B_Carryall_eaf_F"], RANDOM_BETWEEN(4,6)],

			["itm", ["Medikit", "ToolKit", "MineDetector", "Laserdesignator", "Laserdesignator_01_khk_F", "Laserdesignator_03", "Laserdesignator_02", "Laserdesignator_02_ghex_F"], RANDOM_BETWEEN(6,8)],

			["itm", "FirstAidKit", RANDOM_BETWEEN(2,5)],

			["itm", ["optic_ERCO_blk_F", "optic_ERCO_khk_F", "optic_ERCO_snd_F", "optic_Arco", "optic_Arco_arid_F", "optic_Arco_blk_F", "optic_Arco_ghex_F", "optic_Arco_lush_F", "optic_Hamr", "optic_Hamr_khk_F", "optic_Arco_AK_arid_F", "optic_Arco_AK_black_F", "optic_Arco_AK_lush_F"], RANDOM_BETWEEN(5,10)],
			
			["itm", ["optic_tws", "optic_tws_mg", "optic_Nightstalker"], RANDOM_ODDS(0.7)],

			["itm", ["muzzle_snds_H", "muzzle_snds_H_khk_F", "muzzle_snds_H_snd_F", "muzzle_snds_M", "muzzle_snds_m_khk_F", "muzzle_snds_m_snd_F"], RANDOM_BETWEEN(4,6)],

			["mag", "HandGrenade", RANDOM_BETWEEN(5,10)]
		];
	};
	case "mission_USSpecial":
	{
		_boxItems =
		[
			["wep", "arifle_SDAR_F", RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(2,4)],

			["wep", ["arifle_MXM_F", "arifle_MXM_Black_F", "arifle_MXM_khk_F", "arifle_SPAR_03_blk_F", "arifle_SPAR_03_khk_F", "arifle_SPAR_03_snd_F"], RANDOM_BETWEEN(3,6), RANDOM_BETWEEN(6,12)],

			["wep", ["srifle_DMR_02_F", "srifle_DMR_02_camo_F", "srifle_DMR_02_sniper_F", "srifle_DMR_04_F", "srifle_DMR_04_tan_F"], RANDOM_BETWEEN(0,2), RANDOM_BETWEEN(6,9)],

			["wep", ["LMG_Mk200_F", "LMG_Zafir_F"], RANDOM_BETWEEN(0,2), RANDOM_BETWEEN(1,3)],

			["wep", ["Binocular", "Rangefinder"], RANDOM_BETWEEN(0,2)],

			["itm", ["NVGoggles", "NVGoggles_OPFOR", "NVGoggles_INDEP"], RANDOM_BETWEEN(2,4)],

			["itm", ["H_HelmetB_camo", "H_HelmetB_grass", "H_HelmetB_snakeskin", "H_HelmetB_desert", "H_HelmetB_black", "H_HelmetB_sand", "H_HelmetB_tna_F", "H_HelmetB_plain_wdl", "H_HelmetB"], RANDOM_BETWEEN(1,4)],

			["itm", [
				["V_PlateCarrier1_rgr", "V_PlateCarrier1_blk", "V_PlateCarrierL_CTRG", "V_PlateCarrier1_tna_F", "V_PlateCarrier1_wdl"],
				["V_TacVest_blk", "V_TacVest_brn", "V_TacVest_camo", "V_TacVest_khk", "V_TacVest_oli"]
			], RANDOM_BETWEEN(1,4)],

			["itm", ["optic_ERCO_blk_F", "optic_ERCO_khk_F", "optic_ERCO_snd_F", "optic_Arco", "optic_Arco_arid_F", "optic_Arco_blk_F", "optic_Arco_ghex_F", "optic_Arco_lush_F", "optic_Hamr", "optic_Hamr_khk_F", "optic_Arco_AK_arid_F", "optic_Arco_AK_black_F", "optic_Arco_AK_lush_F"], RANDOM_BETWEEN(5,10)],

			["itm", ["muzzle_snds_H", "muzzle_snds_H_khk_F", "muzzle_snds_H_snd_F", "muzzle_snds_338_black", "muzzle_snds_338_green", "muzzle_snds_338_sand", "muzzle_snds_M", "muzzle_snds_m_khk_F", "muzzle_snds_m_snd_F"], RANDOM_BETWEEN(4,8)],

			["itm", "FirstAidKit", RANDOM_BETWEEN(2,5)],

			["mag", "HandGrenade", RANDOM_BETWEEN(5,10)]
		];
	};
	case "mission_USRifles":
	{
		_boxItems =
		[
			["wep", ["arifle_MX_F", "arifle_MX_Black_F", "arifle_MX_khk_F", "arifle_SPAR_01_blk_F", "arifle_SPAR_01_khk_F", "arifle_SPAR_01_snd_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(2,4)],

			["wep", ["arifle_MX_GL_F", "arifle_MX_GL_Black_F", "arifle_MX_GL_khk_F", "arifle_SPAR_01_GL_blk_F", "arifle_SPAR_01_GL_khk_F", "arifle_SPAR_01_GL_snd_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(2,4)],
			
			["wep", ["hgun_Pistol_heavy_01_F", "hgun_Pistol_heavy_01_green_F", "hgun_P07_F", "hgun_P07_khk_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(3,5)],

			["itm", ["optic_ERCO_blk_F", "optic_ERCO_khk_F", "optic_ERCO_snd_F", "optic_Arco", "optic_Arco_arid_F", "optic_Arco_blk_F", "optic_Arco_ghex_F", "optic_Arco_lush_F", "optic_Hamr", "optic_Hamr_khk_F", "optic_Arco_AK_arid_F", "optic_Arco_AK_black_F", "optic_Arco_AK_lush_F"], RANDOM_BETWEEN(5,10)],
			
			["itm", ["optic_tws", "optic_tws_mg", "optic_Nightstalker"], RANDOM_ODDS(0.5)],

			["itm", "FirstAidKit", RANDOM_BETWEEN(2,5)],

			["itm", ["muzzle_snds_H", "muzzle_snds_H_khk_F", "muzzle_snds_H_snd_F", "muzzle_snds_M", "muzzle_snds_m_khk_F", "muzzle_snds_m_snd_F"], RANDOM_BETWEEN(4,6)],

			["mag", ["1Rnd_HE_Grenade_shell", "3Rnd_HE_Grenade_shell"], RANDOM_BETWEEN(5,10)],

			["mag", ["1Rnd_Smoke_Grenade_shell","1Rnd_SmokeYellow_Grenade_shell","1Rnd_SmokeOrange_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","UGL_FlareRed_F","UGL_FlareGreen_F","UGL_FlareWhite_F"], RANDOM_BETWEEN(2,5)],

			["mag", "HandGrenade", RANDOM_BETWEEN(5,10)]
		];
	};
	case "mission_RURifles":
	{
		_boxItems =
		[
			["wep", ["arifle_TRG21_F", "arifle_Katiba_F", "arifle_CTAR_blk_F", "arifle_CTAR_hex_F", "arifle_CTAR_ghex_F", "arifle_AK12_F", "arifle_AK12_arid_F", "arifle_AK12_lush_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(2,4)],

			["wep", ["arifle_TRG21_GL_F", "arifle_Katiba_GL_F", "arifle_CTAR_GL_blk_F", "arifle_CTAR_GL_hex_F", "arifle_CTAR_GL_ghex_F", "arifle_AK12_GL_F", "arifle_AK12_GL_arid_F", "arifle_AK12_GL_lush_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(2,4)],
			
			["wep", ["hgun_Pistol_heavy_01_F", "hgun_Pistol_heavy_01_green_F", "hgun_P07_F", "hgun_P07_khk_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(3,5)],

			["itm", ["optic_ERCO_blk_F", "optic_ERCO_khk_F", "optic_ERCO_snd_F", "optic_Arco", "optic_Arco_arid_F", "optic_Arco_blk_F", "optic_Arco_ghex_F", "optic_Arco_lush_F", "optic_Hamr", "optic_Hamr_khk_F", "optic_Arco_AK_arid_F", "optic_Arco_AK_black_F", "optic_Arco_AK_lush_F", "optic_Holosight", "optic_Holosight_arid_F", "optic_Holosight_blk_F", "optic_Holosight_khk_F", "optic_Holosight_lush_F"], RANDOM_BETWEEN(4,6)],
			
			["itm", ["optic_tws", "optic_tws_mg", "optic_Nightstalker"], RANDOM_ODDS(0.5)],

			["itm", "FirstAidKit", RANDOM_BETWEEN(2,5)],

			["itm", ["muzzle_snds_H", "muzzle_snds_H_khk_F", "muzzle_snds_H_snd_F", "muzzle_snds_M", "muzzle_snds_m_khk_F", "muzzle_snds_m_snd_F", "muzzle_snds_58_blk_F", "muzzle_snds_58_hex_F", "muzzle_snds_58_ghex_F"], RANDOM_BETWEEN(4,6)],

			["mag", ["1Rnd_HE_Grenade_shell", "3Rnd_HE_Grenade_shell"], RANDOM_BETWEEN(5,10)],

			["mag", ["1Rnd_SmokePurple_Grenade_shell","1Rnd_SmokeBlue_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell","UGL_FlareRed_F","UGL_FlareYellow_F"], RANDOM_BETWEEN(2,5)],

			["mag", "HandGrenade", RANDOM_BETWEEN(5,10)]
		];
	};
	case "mission_USMachineguns":
	{
		_boxItems =
		[
			["wep", ["arifle_MX_SW_F", "arifle_MX_SW_Black_F", "arifle_MX_SW_khk_F", "arifle_SPAR_02_blk_F", "arifle_SPAR_02_khk_F", "arifle_SPAR_02_snd_F", "arifle_MX_SW_F", "LMG_Mk200_F"], RANDOM_BETWEEN(4,6), RANDOM_BETWEEN(1,3)],

			["wep", ["MMG_02_sand_F", "MMG_02_camo_F", "MMG_02_black_F", "LMG_03_F"], RANDOM_ODDS(0.5), RANDOM_BETWEEN(2,4)],

			["itm", ["optic_ERCO_blk_F", "optic_ERCO_khk_F", "optic_ERCO_snd_F", "optic_Arco", "optic_Arco_arid_F", "optic_Arco_blk_F", "optic_Arco_ghex_F", "optic_Arco_lush_F", "optic_Hamr", "optic_Hamr_khk_F", "optic_Arco_AK_arid_F", "optic_Arco_AK_black_F", "optic_Arco_AK_lush_F", "optic_Holosight", "optic_Holosight_arid_F", "optic_Holosight_blk_F", "optic_Holosight_khk_F", "optic_Holosight_lush_F", "optic_MRCO"], RANDOM_BETWEEN(4,6)],

			["itm", ["Rangefinder", "Binocular"], RANDOM_BETWEEN(1,3)],

			["itm", ["muzzle_snds_H", "muzzle_snds_H_khk_F", "muzzle_snds_H_snd_F", "muzzle_snds_M", "muzzle_snds_m_khk_F", "muzzle_snds_m_snd_F", "muzzle_snds_338_black", "muzzle_snds_338_green", "muzzle_snds_338_sand"], RANDOM_BETWEEN(4,6)],

			["itm", ["bipod_01_F_blk", "bipod_02_F_blk", "bipod_03_F_blk", "bipod_01_F_mtp", "bipod_02_F_hex", "bipod_03_F_oli", "bipod_01_F_snd", "bipod_02_F_tan"],  RANDOM_BETWEEN(2,4)],

			["itm", "FirstAidKit", RANDOM_BETWEEN(2,5)],

			["mag", "HandGrenade", RANDOM_BETWEEN(5,10)]
		];
	};
	case "mission_RUMachineguns":
	{
		_boxItems =
		[
			["wep", ["arifle_CTARS_blk_F", "arifle_CTARS_hex_F", "arifle_CTARS_ghex_F", "arifle_RPK12_F", "arifle_RPK12_arid_F", "arifle_RPK12_lush_F"], RANDOM_BETWEEN(4,6), RANDOM_BETWEEN(1,3)],

			["wep", ["MMG_01_tan_F", "MMG_01_hex_F", "LMG_Zafir_F"], RANDOM_ODDS(0.5), RANDOM_BETWEEN(2,4)],

			["itm", ["optic_ERCO_blk_F", "optic_ERCO_khk_F", "optic_ERCO_snd_F", "optic_Arco", "optic_Arco_arid_F", "optic_Arco_blk_F", "optic_Arco_ghex_F", "optic_Arco_lush_F", "optic_Hamr", "optic_Hamr_khk_F", "optic_Arco_AK_arid_F", "optic_Arco_AK_black_F", "optic_Arco_AK_lush_F", "optic_Holosight", "optic_Holosight_arid_F", "optic_Holosight_blk_F", "optic_Holosight_khk_F", "optic_Holosight_lush_F", "optic_MRCO"], RANDOM_BETWEEN(4,6)],

			["itm", ["Rangefinder", "Binocular"], RANDOM_BETWEEN(1,3)],

			["itm", ["muzzle_snds_H", "muzzle_snds_H_khk_F", "muzzle_snds_H_snd_F", "muzzle_snds_M", "muzzle_snds_m_khk_F", "muzzle_snds_m_snd_F", "muzzle_snds_B", "muzzle_snds_B_khk_F", "muzzle_snds_B_snd_F", "muzzle_snds_B_arid_F", "muzzle_snds_B_lush_F", "muzzle_snds_93mmg", "muzzle_snds_93mmg_tan"], RANDOM_BETWEEN(4,6)],

			["itm", ["bipod_01_F_blk", "bipod_02_F_blk", "bipod_03_F_blk", "bipod_01_F_mtp", "bipod_02_F_hex", "bipod_03_F_oli", "bipod_01_F_snd", "bipod_02_F_tan"],  RANDOM_BETWEEN(2,4)],

			["itm", "FirstAidKit", RANDOM_BETWEEN(2,5)],

			["mag", "HandGrenade", RANDOM_BETWEEN(5,10)]

		];
	};
	case "mission_Main_A3snipers":
	{
		_boxItems =
		[
			["wep", ["arifle_MXM_F", "arifle_MXM_Black_F", "arifle_MXM_khk_F", "arifle_SPAR_03_blk_F", "arifle_SPAR_03_khk_F", "arifle_SPAR_03_snd_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(3,6)],

			["wep", ["srifle_LRR_LRPS_F", "srifle_LRR_camo_LRPS_F", "srifle_LRR_tna_LRPS_F"], RANDOM_BETWEEN(3,5), RANDOM_BETWEEN(4,8)],

			["wep", ["srifle_DMR_02_F", "srifle_DMR_02_camo_F", "srifle_DMR_02_sniper_F", "srifle_DMR_06_camo_F", "srifle_DMR_06_olive_F", "srifle_DMR_06_hunter_F", "srifle_DMR_03_F", "srifle_DMR_03_multicam_F", "srifle_DMR_03_khaki_F", "srifle_DMR_03_tan_F", "srifle_DMR_03_woodland_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(4,6)],

			["wep", "Rangefinder", RANDOM_BETWEEN(3,6)],

			["itm", ["optic_SOS", "optic_SOS_khk_F", "optic_DMS", "optic_DMS_ghex_F", "optic_DMS_weathered_F", "optic_DMS_weathered_Kir_F"], RANDOM_BETWEEN(2,4)],

			["itm", ["optic_KHS_old", "optic_KHS_blk", "optic_KHS_hex", "optic_KHS_tan", "optic_AMS", "optic_AMS_khk", "optic_AMS_snd", "optic_LRPS", "optic_LRPS_ghex_F", "optic_LRPS_tna_F", "optic_Holosight_khk_F", "optic_Holosight_lush_F"], RANDOM_BETWEEN(4,6)],

			["itm", ["U_B_FullGhillie_ard", "U_B_FullGhillie_lsh", "U_B_FullGhillie_sard", "U_B_T_FullGhillie_tna_F"], RANDOM_BETWEEN(2,4)],

			["itm", "FirstAidKit", RANDOM_BETWEEN(2,5)],

			["mag", "HandGrenade", RANDOM_BETWEEN(5,10)]
		];
	};
	case "mission_RUSniper":
	{
		_boxItems =
		[
			["wep", ["arifle_MSBS65_Mark_F", "arifle_MSBS65_Mark_black_F", "arifle_MSBS65_Mark_camo_F", "arifle_MSBS65_Mark_sand_F", "srifle_DMR_07_blk_F", "srifle_DMR_07_hex_F", "srifle_DMR_07_ghex_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(3,6)],

			["wep", ["srifle_GM6_LRPS_F", "srifle_GM6_camo_LRPS_F", "srifle_GM6_ghex_LRPS_F"], RANDOM_BETWEEN(3,5), RANDOM_BETWEEN(4,8)],

			["wep", ["srifle_DMR_05_blk_F", "srifle_DMR_05_hex_F", "srifle_DMR_05_tan_f", "srifle_DMR_06_camo_F", "srifle_DMR_06_olive_F", "srifle_DMR_06_hunter_F", "srifle_DMR_04_tan_F", "srifle_DMR_01_F", "srifle_EBR_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(4,6)],

			["wep", "Rangefinder", RANDOM_BETWEEN(3,6)],

			["itm", ["optic_SOS", "optic_SOS_khk_F", "optic_DMS", "optic_DMS_ghex_F", "optic_DMS_weathered_F", "optic_DMS_weathered_Kir_F"], RANDOM_BETWEEN(2,4)],

			["itm", ["optic_KHS_old", "optic_KHS_blk", "optic_KHS_hex", "optic_KHS_tan", "optic_AMS", "optic_AMS_khk", "optic_AMS_snd", "optic_LRPS", "optic_LRPS_ghex_F", "optic_LRPS_tna_F", "optic_Holosight_khk_F", "optic_Holosight_lush_F"], RANDOM_BETWEEN(4,6)],

			["itm", ["U_O_FullGhillie_ard", "U_O_FullGhillie_lsh", "U_O_FullGhillie_sard", "U_O_T_FullGhillie_tna_F"], RANDOM_BETWEEN(2,4)],

			["itm", "FirstAidKit", RANDOM_BETWEEN(2,5)],

			["mag", "HandGrenade", RANDOM_BETWEEN(5,10)]
		];
	};
	case "mission_PDW":
	{
		_boxItems =
		[
			["wep", ["hgun_PDW2000_F", "SMG_05_F", "hgun_P07_khk_F", "SMG_02_F", "SMG_01_F"], RANDOM_BETWEEN(3,5), RANDOM_BETWEEN(5,8)],

			["wep", ["SMG_03C_TR_black", "SMG_03C_TR_camo", "SMG_03C_TR_hex", "SMG_03C_TR_khaki", "SMG_03_TR_black", "SMG_03_TR_camo", "SMG_03_TR_hex", "SMG_03_TR_khaki"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(3,5)],

			["wep", ["arifle_MXC_F", "arifle_MXC_Black_F", "arifle_MXC_khk_F", "arifle_Katiba_C_F", "arifle_TRG20_F", "arifle_Mk20C_plain_F", "arifle_Mk20C_F", "arifle_AKS_F", "arifle_AK12U_F", "arifle_AK12U_arid_F", "arifle_AK12U_lush_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(4,5)],

			["wep", ["hgun_Pistol_01_F", "hgun_P07_F", "hgun_P07_khk_F", "hgun_Rook40_F", "hgun_ACPC2_F", "hgun_Pistol_heavy_02_F", "hgun_Pistol_heavy_01_F", "hgun_Pistol_heavy_01_green_F"], RANDOM_BETWEEN(4,6), RANDOM_BETWEEN(3,6)],

			["itm", ["acc_flashlight_pistol", "optic_Yorris", "optic_MRD", "optic_MRD_black"], RANDOM_BETWEEN(1,4)],

			["itm", ["optic_Holosight_smg", "optic_Holosight_smg_blk_F", "optic_Holosight_smg_khk_F", "optic_Holosight", "optic_Holosight_arid_F", "optic_Holosight_blk_F", "optic_Holosight_khk_F", "optic_Holosight_lush_F", "optic_aco_smg", "optic_ACO_grn_smg", "optic_Aco", "optic_Aco_grn", "acc_pointer_IR", "acc_flashlight"], RANDOM_BETWEEN(10,16)],

			["itm", "FirstAidKit", RANDOM_BETWEEN(2,5)],

			["itm", ["U_B_GEN_Commander_F", "U_B_GEN_Soldier_F", "U_O_GEN_Commander_F", "U_O_GEN_Soldier_F"], RANDOM_BETWEEN(4,7)],

			["mag", "HandGrenade", RANDOM_BETWEEN(5,10)]

		];
	};
	case "mission_Explosive":
	{
		_boxItems =
		[
			["mag", ["1Rnd_HE_Grenade_shell", "1Rnd_HE_Grenade_shell", "1Rnd_HE_Grenade_shell"], RANDOM_BETWEEN(8,16)],
		
			["mag", ["3Rnd_HE_Grenade_shell", "3Rnd_HE_Grenade_shell", "3Rnd_HE_Grenade_shell"], RANDOM_BETWEEN(4,8)],
			
			["mag", ["APERSTripMine_Wire_Mag", "APERSBoundingMine_Range_Mag", "APERSMine_Range_Mag", "APERSMineDispenser_Mag", "DemoCharge_Remote_Mag", "SatchelCharge_Remote_Mag"], RANDOM_BETWEEN(5,10)],

			["mag", ["ClaymoreDirectionalMine_Remote_Mag", "SLAMDirectionalMine_Wire_Mag", "ATMine_Range_Mag", "IEDUrbanSmall_Remote_Mag", "IEDUrbanBig_Remote_Mag"], RANDOM_BETWEEN(4,8)],
			
			["mag", ["MiniGrenade", "HandGrenade", "B_IR_Grenade", "O_IR_Grenade", "I_IR_Grenade"], RANDOM_BETWEEN(10,15)],

			["mag", ["Chemlight_blue", "Chemlight_green", "SmokeShell", "SmokeShellYellow", "SmokeShellOrange", "SmokeShellRed"], RANDOM_BETWEEN(2,5)],
			
			["itm", ["Toolkit", "MineDetector"], RANDOM_BETWEEN(2,4)],

			["itm", ["V_EOD_blue_F", "V_EOD_coyote_F", "V_EOD_olive_F", "V_EOD_IDAP_blue_F", "V_PlateCarrierGL_rgr", "V_PlateCarrierGL_blk", "V_PlateCarrierGL_mtp", "V_PlateCarrierGL_tna_F", "V_PlateCarrierGL_wdl"], RANDOM_BETWEEN(3,6)],

			["itm", "FirstAidKit", RANDOM_BETWEEN(2,5)],

			["itm", ["B_Kitbag_cbr", "B_Kitbag_rgr", "B_Kitbag_mcamo", "B_Kitbag_sgg", "B_Kitbag_tan"], 3]

		];
	};
	case "mission_Gear":
	{
		_boxItems =
		[
			["itm", ["H_HelmetB", "H_HelmetB_camo", "H_HelmetB_sand", "H_HelmetB_black", "H_HelmetB_desert", "H_HelmetB_grass", "H_HelmetB_snakeskin", "H_HelmetB_tna_F", "H_HelmetB_TI_tna_F", "H_HelmetB_light", "H_HelmetB_light_sand", "H_HelmetB_light_black", "H_HelmetB_light_desert", "H_HelmetB_light_snakeskin", "H_HelmetB_light_grass", "H_HelmetB_Light_tna_F", "H_HelmetSpecB", "H_HelmetSpecB_sand", "H_HelmetSpecB_blk", "H_HelmetSpecB_paint2", "H_HelmetSpecB_paint1", "H_HelmetSpecB_snakeskin", "H_HelmetB_Enh_tna_F", "H_HelmetSpecO_blk", "H_HelmetSpecO_ghex_F", "H_HelmetSpecO_ocamo", "H_HelmetLeaderO_ghex_F", "H_HelmetLeaderO_ocamo", "H_HelmetLeaderO_oucamo", "H_HelmetO_ghex_F", "H_HelmetO_ocamo", "H_HelmetO_oucamo", "H_HelmetIA", "H_PASGT_basic_blue_F", "H_PASGT_basic_blue_press_F", "H_PASGT_neckprot_blue_press_F", "H_PASGT_basic_olive_F", "H_PASGT_basic_white_F", "H_HelmetCrew_B", "H_HelmetCrew_O", "H_HelmetCrew_O_ghex_F", "H_HelmetCrew_I", "H_CrewHelmetHeli_B", "H_CrewHelmetHeli_O", "H_CrewHelmetHeli_I", "H_PilotHelmetHeli_B", "H_PilotHelmetHeli_O", "H_PilotHelmetHeli_I", "H_PilotHelmetFighter_B", "H_PilotHelmetFighter_O", "H_PilotHelmetFighter_I", "H_Construction_basic_black_F", "H_Construction_basic_orange_F", "H_Construction_basic_red_F", "H_Construction_basic_white_F", "H_Construction_basic_yellow_F", "H_Helmet_Skate", "H_Watchcap_blk", "H_Watchcap_cbr", "H_Watchcap_khk", "H_Watchcap_camo", "H_HeadSet_black_F", "H_MilCap_blue", "H_MilCap_gen_F", "H_MilCap_gry", "H_MilCap_ghex_F", "H_MilCap_ocamo", "H_MilCap_mcamo", "H_MilCap_tna_F", "H_MilCap_dgtl", "H_Hat_blue", "H_Hat_brown", "H_Hat_camo", "H_Hat_checker", "H_Hat_grey", "H_Hat_tan", "H_StrawHat", "H_StrawHat_dark", "H_Booniehat_khk_hs", "H_Booniehat_khk", "H_Booniehat_oli", "H_Booniehat_tan", "H_Booniehat_mcamo", "H_Booniehat_tna_F", "H_Booniehat_dgtl", "H_Hat_Safari_olive_F", "H_Hat_Safari_sand_F", "H_HeadBandage_clean_F", "H_HeadBandage_stained_F", "H_HeadBandage_bloody_F", "H_Cap_grn_BI", "H_Cap_blk", "H_Cap_blu", "H_Cap_blk_CMMG", "H_Cap_grn", "H_Cap_blk_ION", "H_Cap_oli", "H_Cap_oli_hs", "H_Cap_police", "H_Cap_press", "H_Cap_red", "H_Cap_surfer", "H_Cap_tan", "H_Cap_khaki_specops_UK", "H_Cap_usblack", "H_Cap_tan_specops_US", "H_Cap_blk_Raven", "H_Cap_brn_SPECOPS", "H_Cap_White_IDAP_F", "H_Cap_Orange_IDAP_F", "H_Cap_Black_IDAP_F", "H_Cap_headphones", "H_Beret_blk", "H_Beret_gen_F", "H_Beret_Colonel", "H_Beret_02", "H_Bandanna_gry", "H_Bandanna_blu", "H_Bandanna_cbr", "H_Bandanna_khk_hs", "H_Bandanna_khk", "H_Bandanna_mcamo", "H_Bandanna_sgg", "H_Bandanna_sand", "H_Bandanna_surfer", "H_Bandanna_surfer_blk", "H_Bandanna_surfer_grn", "H_Bandanna_camo", "H_Shemag_olive", "H_Shemag_olive_hs", "H_ShemagOpen_tan", "H_ShemagOpen_khk", "H_RacingHelmet_1_black_F", "H_RacingHelmet_1_blue_F", "H_RacingHelmet_1_green_F", "H_RacingHelmet_1_yellow_F", "H_RacingHelmet_1_orange_F", "H_RacingHelmet_1_red_F", "H_RacingHelmet_1_white_F", "H_RacingHelmet_1_F", "H_RacingHelmet_2_F", "H_RacingHelmet_3_F", "H_RacingHelmet_4_F"], RANDOM_BETWEEN(10,20)],
			
			["itm", ["V_RebreatherB", "V_RebreatherIR", "V_RebreatherIA", "V_Safety_yellow_F", "V_Safety_orange_F", "V_Safety_blue_F", "V_Plain_crystal_F", "V_Plain_medical_F", "V_Rangemaster_belt", "V_Pocketed_black_F", "V_Pocketed_coyote_F", "V_Pocketed_olive_F", "V_BandollierB_blk", "V_BandollierB_cbr", "V_BandollierB_rgr", "V_BandollierB_khk", "V_BandollierB_oli", "V_BandollierB_ghex_F", "V_LegStrapBag_black_F", "V_LegStrapBag_coyote_F", "V_LegStrapBag_olive_F", "V_HarnessOGL_brn", "V_HarnessOGL_gry", "V_HarnessOGL_ghex_F", "V_Chestrig_khk", "V_Chestrig_rgr", "V_Chestrig_blk", "V_Chestrig_oli", "V_TacChestrig_cbr_F", "V_TacChestrig_grn_F", "V_TacChestrig_oli_F", "V_HarnessO_brn", "V_HarnessO_gry", "V_HarnessO_ghex_F", "V_TacVestIR_blk", "V_TacVest_blk", "V_TacVest_brn", "V_TacVest_camo", "V_TacVest_khk", "V_TacVest_oli", "V_I_G_resistanceLeader_F", "V_Press_F", "V_DeckCrew_blue_F", "V_DeckCrew_green_F", "V_DeckCrew_yellow_F", "V_DeckCrew_red_F", "V_DeckCrew_brown_F", "V_DeckCrew_violet_F", "V_DeckCrew_white_F", "V_TacVest_blk_POLICE", "V_TacVest_gen_F", "V_PlateCarrier1_rgr", "V_PlateCarrier1_rgr_noflag_F", "V_PlateCarrier1_blk", "V_PlateCarrierL_CTRG", "V_PlateCarrier1_tna_F", "V_PlateCarrierIA1_dgtl", "V_PlateCarrierIA2_dgtl", "V_PlateCarrier2_rgr", "V_PlateCarrier2_rgr_noflag_F", "V_PlateCarrier2_blk", "V_PlateCarrierH_CTRG", "V_PlateCarrier2_tna_F"], RANDOM_BETWEEN(6,12)],

			["itm", ["V_PlateCarrierGL_rgr", "V_PlateCarrierGL_blk", "V_PlateCarrierGL_mtp", "V_PlateCarrierGL_tna_F", "V_PlateCarrierSpec_rgr", "V_PlateCarrierSpec_blk", "V_PlateCarrierSpec_mtp", "V_PlateCarrierSpec_tna_F", "V_PlateCarrierIAGL_dgtl", "V_PlateCarrierIAGL_oli", "V_EOD_blue_F", "V_EOD_IDAP_blue_F", "V_EOD_coyote_F", "V_EOD_olive_F"], RANDOM_ODDS(0.5)],

			["itm", ["B_OutdoorPack_blk", "B_OutdoorPack_tan", "B_LegStrapBag_black_F", "B_LegStrapBag_coyote_F", "B_LegStrapBag_olive_F", "B_Messenger_Black_F", "B_Messenger_Coyote_F", "B_Messenger_Gray_F", "B_Messenger_Olive_F", "B_Messenger_IDAP_F", "B_AssaultPack_blk", "B_AssaultPack_rgr", "B_AssaultPack_mcamo", "B_AssaultPack_ocamo", "B_AssaultPack_dgtl", "B_AssaultPack_khk", "B_AssaultPack_cbr", "B_AssaultPack_sgg", "B_AssaultPack_tna_F", "B_AssaultPack_Kerry", "B_Kitbag_cbr", "B_Kitbag_rgr", "B_Kitbag_mcamo", "B_Kitbag_sgg", "B_ViperLightHarness_blk_F", "B_ViperLightHarness_ghex_F", "B_ViperLightHarness_hex_F", "B_ViperLightHarness_khk_F", "B_ViperLightHarness_oli_F", "B_TacticalPack_rgr", "B_TacticalPack_mcamo", "B_TacticalPack_ocamo", "B_TacticalPack_oli", "B_FieldPack_blk", "B_FieldPack_cbr", "B_FieldPack_khk", "B_FieldPack_oucamo", "B_FieldPack_ocamo", "B_FieldPack_ghex_F", "B_Bergen_blk", "B_Bergen_rgr", "B_Bergen_mcamo", "B_Bergen_sgg", "B_ViperHarness_blk_F", "B_ViperHarness_ghex_F", "B_ViperHarness_hex_F", "B_ViperHarness_khk_F", "B_ViperHarness_oli_F", "B_Carryall_khk", "B_Carryall_mcamo", "B_Carryall_oli", "B_Carryall_ocamo", "B_Carryall_oucamo", "B_Carryall_ghex_F", "B_Bergen_dgtl_F", "B_Bergen_hex_F", "B_Bergen_mcamo_F", "B_Bergen_tna_F"], RANDOM_BETWEEN(10,20)],

			["itm", ["G_Aviator", "G_Lady_Blue", "G_Lowprofile", "G_Tactical_Clear", "G_Tactical_Black", "G_Spectacles_Tinted", "G_Diving", "G_Combat", "G_Combat_Goggles_tna_F", "G_Balaclava_blk", "G_Balaclava_oli", "G_Balaclava_lowprofile", "G_Balaclava_combat", "G_Balaclava_TI_blk_F", "G_Balaclava_TI_G_blk_F", "G_Balaclava_TI_tna_F", "G_Balaclava_TI_G_tna_F", "G_Bandanna_aviator", "G_Bandanna_shades", "G_Bandanna_beast", "G_Bandanna_blk", "G_Bandanna_khk", "G_Bandanna_oli", "G_Bandanna_tan", "G_Respirator_blue_F", "G_Respirator_white_F", "G_Respirator_yellow_F", "G_EyeProtectors_F", "G_EyeProtectors_Earpiece_F", "G_WirelessEarpiece_F"], 15],

			["itm", ["NVGoggles", "NVGoggles_OPFOR", "NVGoggles_INDEP", "NVGoggles_tna_F", "O_NVGoggles_ghex_F", "O_NVGoggles_hex_F", "O_NVGoggles_urb_F"], RANDOM_BETWEEN(6,12)],

			["itm", ["Chemlight_blue", "Chemlight_green", "Chemlight_yellow", "Chemlight_red"], RANDOM_BETWEEN(5,15)],

			["itm", "FirstAidKit", RANDOM_BETWEEN(6,12)],

			["itm", ["FirstAidKit", "Medikit", "ToolKit", "MineDetector", "Binocular", "Rangefinder", "Laserdesignator", "Laserdesignator_01_khk_F", "Laserdesignator_03", "Laserdesignator_02", "Laserdesignator_02_ghex_F"], RANDOM_BETWEEN(10,15)]
		];
	};
	case "mission_Diving":
	{
		_boxItems =
		[
			["wep", "arifle_SDAR_F", RANDOM_BETWEEN(4,6), RANDOM_BETWEEN(4,6)],

			["wep", ["hgun_PDW2000_F", "SMG_05_F", "hgun_P07_khk_F", "SMG_02_F", "SMG_01_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(3,6)],

			["itm", ["U_B_Wetsuit", "V_RebreatherB"], RANDOM_BETWEEN(4,6)],
			
			["itm", ["U_O_Wetsuit", "V_RebreatherIR"], RANDOM_BETWEEN(4,6)],
			
			["itm", ["U_I_Wetsuit", "V_RebreatherIA"], RANDOM_BETWEEN(4,6)],

			["itm", "G_Diving", RANDOM_BETWEEN(8,12)],

			["itm", "FirstAidKit", RANDOM_BETWEEN(2,5)],

			["mag", "20Rnd_556x45_UW_mag", RANDOM_BETWEEN(6,10)],

			["mag", "HandGrenade", RANDOM_BETWEEN(5,10)]
		];
	};
	case "mission_Militia":
	{
		_boxItems =
		[
			["wep", ["arifle_AKM_F", "launch_RPG7_F", "arifle_AKS_F", "srifle_DMR_06_camo_F", "srifle_DMR_06_olive_F", "hgun_Rook40_F", "hgun_Pistol_01_F", "SMG_05_F", "LMG_03_F"], RANDOM_BETWEEN(5,10), RANDOM_BETWEEN(3,5)],

			["wep", ["hgun_Pistol_01_F", "hgun_P07_F", "hgun_P07_khk_F", "hgun_Rook40_F", "hgun_ACPC2_F", "hgun_Pistol_heavy_02_F"], RANDOM_BETWEEN(4,6), RANDOM_BETWEEN(3,6)],

			["itm", ["MineDetector", "Binocular", "V_Chestrig_rgr", "V_Chestrig_khk", "V_Chestrig_blk", "V_TacChestrig_oli_F", "V_TacChestrig_cbr_F", "V_TacVest_camo", "H_Bandanna_camo"], RANDOM_BETWEEN(4,8)],

			["itm", ["H_ShemagOpen_khk", "H_ShemagOpen_tan", "H_Shemag_olive"], RANDOM_BETWEEN(2,5)],
			
			["itm", ["V_HarnessO_brn", "V_HarnessO_gry", "V_HarnessO_ghex_F", "V_HarnessOGL_brn", "V_HarnessOGL_gry", "V_HarnessOGL_ghex_F"], RANDOM_BETWEEN(6,10)],
			
			["itm", ["B_Messenger_Black_F", "B_Messenger_Coyote_F", "B_Messenger_Gray_F", "B_Messenger_Olive_F", "B_Messenger_IDAP_F"], RANDOM_BETWEEN(4,6)],

			["itm", ["FirstAidKit", "Medikit"], RANDOM_BETWEEN(8,16)],

			["mag", "HandGrenade", RANDOM_BETWEEN(5,10)]
		];
	};
	case "General_supplies":
	{
		_boxItems =
		[
			["itm", "FirstAidKit", RANDOM_BETWEEN(5,6)],
			["wep", ["Binocular", "Rangefinder", "Laserdesignator"], RANDOM_BETWEEN(3,5)],
			["wep", ["hgun_Pistol_heavy_01_F", "hgun_Pistol_heavy_01_MRD_F", "hgun_Pistol_heavy_02_F", "hgun_Pistol_heavy_02_Yorris_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(3,5)],
			["itm", "Medikit", RANDOM_BETWEEN(2,3)],
			["itm", "Toolkit", RANDOM_BETWEEN(2,3)],
			["itm", "Laserbatteries", RANDOM_BETWEEN(2,4)],
			["itm", "MineDetector", 3],
			["itm", ["H_CrewHelmetHeli_B","H_CrewHelmetHeli_O", "H_CrewHelmetHeli_I"], RANDOM_BETWEEN(2,4)],
			["bac", ["B_Kitbag_mcamo", "B_Bergen_sgg", "B_FieldPack_khk", "B_Carryall_mcamo"], RANDOM_BETWEEN(3,5)],
			["itm", ["V_PlateCarrierIAGL_dgtl", "V_TacVest_camo", "V_PlateCarrierGL_rgr"], RANDOM_BETWEEN(2,4)],
			["itm", ["Chemlight_red", "Chemlight_green", "Chemlight_yellow", "Chemlight_blue"], RANDOM_BETWEEN(6,9)],
			["mag", ["SmokeShell", "SmokeShellRed", "SmokeShellgreen"], RANDOM_BETWEEN(5,9)]
		]
	};
};

[_box, _boxItems] call processItems;

if (["A3W_artilleryStrike"] call isConfigOn) then
{
	if (random 1.0 < ["A3W_artilleryCrateOdds", 1/10] call getPublicVar) then
	{
		_box setVariable ["artillery", 1, true];
	};
};
