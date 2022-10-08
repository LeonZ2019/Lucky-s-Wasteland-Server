// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
/*********************************************************#
# @@ScriptName: storeConfig.sqf
# @@Author: His_Shadow, AgentRev
# @@Create Date: 2013-09-16 20:40:58
#*********************************************************/

// This tracks which store owner the client is interacting with
currentOwnerName = "";

// Gunstore Weapon List - Gun Store Base List
// Text name, classname, buy cost

// empty name = name is extracted from class config

pistolArray = compileFinal str
[
	// Handguns
	["PM Pistol", "hgun_Pistol_01_F", 125],
	["P07 Pistol", "hgun_P07_F", 150],
	["P07 Pistol (Khaki)", "hgun_P07_khk_F", 150, "noDLC"],
	["P07 Pistol (Black)", "hgun_P07_blk_F", 150, "noDLC"],
	["Rook-40 Pistol", "hgun_Rook40_F", 150],
	["ACP-C2 Pistol", "hgun_ACPC2_F", 175],
	["Zubr Revolver", "hgun_Pistol_heavy_02_F", 175],
	["4-five Pistol", "hgun_Pistol_heavy_01_F", 200],
	["4-five Pistol (Green)", "hgun_Pistol_heavy_01_green_F", 200, "noDLC"],
	["Starter Pistol", "hgun_Pistol_Signal_F", 200],
	["Spectrum Device", "hgun_esd_01_F", 400]
];

smgArray = compileFinal str
[
	["PDW2000 SMG", "hgun_PDW2000_F", 300],
	["Protector SMG", "SMG_05_F", 300],
	["Sting SMG", "SMG_02_F", 325],
	["Vermin SMG", "SMG_01_F", 325],

	["ADR-97C (Black)", "SMG_03C_black", 300],
	["ADR-97C (Camo)", "SMG_03C_camo", 300],
	["ADR-97C (Hex)", "SMG_03C_hex", 300],
	["ADR-97C (Khaki)","SMG_03C_khaki", 300],
	["ADR-97C TR (Black)", "SMG_03C_TR_black", 325],
	["ADR-97C TR (Camo)", "SMG_03C_TR_camo", 325],
	["ADR-97C TR (Hex)", "SMG_03C_TR_hex", 325],
	["ADR-97C TR (Khaki)", "SMG_03C_TR_khaki", 325],
	["ADR-97 (Black)", "SMG_03_black", 325],
	["ADR-97 (Camo)", "SMG_03_camo", 325],
	["ADR-97 (Hex)", "SMG_03_hex", 325],
	["ADR-97 (Khaki)", "SMG_03_khaki", 325],
	["ADR-97 TR (Black)", "SMG_03_TR_black", 350],
	["ADR-97 TR (Camo)", "SMG_03_TR_camo", 350],
	["ADR-97 TR (Hex)", "SMG_03_TR_hex", 350],
	["ADR-97 TR (Khaki)", "SMG_03_TR_khaki", 350],
	// Shotguns
	["Kozlice Shotgun", "sgun_HunterShotgun_01_f", 350],
	["Kozlice Shotgun (Sawed-Off)", "sgun_HunterShotgun_01_sawedoff_f", 175]
];

rifleArray = compileFinal str
[
	// Underwater Gun
	["SDAR Underwater Rifle", "arifle_SDAR_F", 500],

	// Assault Rifles
	["Mk20 Carbine", "arifle_Mk20C_plain_F", 550],
	["Mk20 Carbine (Camo)", "arifle_Mk20C_F", 550],
	["Mk20 Rifle", "arifle_Mk20_plain_F", 600],
	["Mk20 Rifle (Camo)", "arifle_Mk20_F", 600],
	["Mk20 EGLM Rifle", "arifle_Mk20_GL_plain_F", 650],
	["Mk20 EGLM Rifle (Camo)", "arifle_Mk20_GL_F", 650],

	["TRG-20 Carbine", "arifle_TRG20_F", 550],
	["TRG-21 Rifle ", "arifle_TRG21_F", 600],
	["TRG-21 EGLM Rifle", "arifle_TRG21_GL_F", 650],

	["Katiba Carbine", "arifle_Katiba_C_F", 550],
	["Katiba Rifle", "arifle_Katiba_F", 600],
	["Katiba GL Rifle", "arifle_Katiba_GL_F", 650],

	["MX Carbine", "arifle_MXC_F", 550],
	["MX Carbine (Black)", "arifle_MXC_Black_F", 550],
	["MX Carbine (Khaki)", "arifle_MXC_khk_F", 550, "noDLC"],
	["MX Rifle", "arifle_MX_F", 600],
	["MX Rifle (Black)", "arifle_MX_Black_F", 600],
	["MX Rifle (Khaki)", "arifle_MX_khk_F", 600, "noDLC"],
	["MX 3GL Rifle", "arifle_MX_GL_F", 650],
	["MX 3GL Rifle (Black)", "arifle_MX_GL_Black_F", 650],
	["MX 3GL Rifle (Khaki)", "arifle_MX_GL_khk_F", 650, "noDLC"],

	["SPAR-16 Rifle", "arifle_SPAR_01_blk_F", 600],
	["SPAR-16 Rifle (Khaki)", "arifle_SPAR_01_khk_F", 600],
	["SPAR-16 Rifle (Sand)", "arifle_SPAR_01_snd_F", 600],
	["SPAR-16 GL Rifle", "arifle_SPAR_01_GL_blk_F", 650],
	["SPAR-16 GL Rifle (Khaki)", "arifle_SPAR_01_GL_khk_F", 650],
	["SPAR-16 GL Rifle (Sand)", "arifle_SPAR_01_GL_snd_F", 250],

	["CAR-95 Rifle", "arifle_CTAR_blk_F", 600],
	["CAR-95 Rifle (Hex)", "arifle_CTAR_hex_F", 600],
	["CAR-95 Rifle (G Hex)", "arifle_CTAR_ghex_F", 600],
	["CAR-95 GL Rifle", "arifle_CTAR_GL_blk_F", 650],
	["CAR-95 GL Rifle (Hex)", "arifle_CTAR_GL_hex_F", 650],
	["CAR-95 GL Rifle (G Hex)", "arifle_CTAR_GL_ghex_F", 650],
	["Type 115 Stealth Rifle", "arifle_ARX_blk_F", 700],
	["Type 115 Stealth Rifle (Hex)", "arifle_ARX_hex_F", 700],
	["Type 115 Stealth Rifle (G Hex)", "arifle_ARX_ghex_F", 700],

	["AKS-74U Carbine", "arifle_AKS_F", 550],
	["AKM Rifle", "arifle_AKM_F", 600],
	["AKU-12 Carbine", "arifle_AK12U_F", 600],
	["AKU-12 Carbine (Arid)", "arifle_AK12U_arid_F", 600],
	["AKU-12 Carbine (Lush)", "arifle_AK12U_lush_F", 600],
	["AK-12 Rifle", "arifle_AK12_F", 650],
	["AK-12 Rifle (Arid)", "arifle_AK12_arid_F", 650],
	["AK-12 Rifle (Lush)", "arifle_AK12_lush_F", 650],
	["AK-12 GL Rifle", "arifle_AK12_GL_F", 700],
	["AK-12 GL Rifle (Arid)", "arifle_AK12_GL_arid_F", 700],
	["AK-12 GL Rifle (Lush)", "arifle_AK12_GL_lush_F", 700],

	["Promet Rifle", "arifle_MSBS65_F", 600, "noDLC"],
	["Promet Rifle (Black)", "arifle_MSBS65_black_F", 600, "noDLC"],
	["Promet Rifle (Camo)", "arifle_MSBS65_camo_F", 600, "noDLC"],
	["Promet Rifle (Sand)", "arifle_MSBS65_sand_F", 600, "noDLC"],
	["Promet GL Rifle", "arifle_MSBS65_GL_F", 650, "noDLC"],
	["Promet GL Rifle (Black)", "arifle_MSBS65_GL_black_F", 650, "noDLC"],
	["Promet GL Rifle (Camo)", "arifle_MSBS65_GL_camo_F", 650, "noDLC"],
	["Promet GL Rifle (Sand)", "arifle_MSBS65_GL_sand_F", 650, "noDLC"],
	["Promet SG Rifle", "arifle_MSBS65_UBS_F", 650, "noDLC"],
	["Promet SG Rifle (Black)", "arifle_MSBS65_UBS_black_F", 650, "noDLC"],
	["Promet SG Rifle (Camo)", "arifle_MSBS65_UBS_camo_F", 650, "noDLC"],
	["Promet SG Rifle (Sand)", "arifle_MSBS65_UBS_sand_F", 650, "noDLC"]
];

sniperArray = compileFinal str
[
	["Mk14 Rifle (Camo)", "srifle_DMR_06_camo_F", 900, "noDLC"],
	["Mk14 Rifle (Olive)", "srifle_DMR_06_olive_F", 900, "noDLC"],
	["Mk14 Rifle (Classic)", "srifle_DMR_06_hunter_F", 900, "noDLC"],
	["Mk18 ABR Rifle", "srifle_EBR_F", 950],
	["Rahim DMR Rifle", "srifle_DMR_01_F", 1000],
	["Cyrus Rifle", "srifle_DMR_05_blk_F", 1250],
	["Cyrus Rifle (Hex)", "srifle_DMR_05_hex_F", 1250],
	["Cyrus Rifle (Tan)", "srifle_DMR_05_tan_f", 1250],

	["Promet MR Rifle", "arifle_MSBS65_Mark_F", 700, "noDLC"],
	["Promet MR Rifle (Black)", "arifle_MSBS65_Mark_black_F", 700, "noDLC"],
	["Promet MR Rifle (Camo)", "arifle_MSBS65_Mark_camo_F", 700, "noDLC"],
	["Promet MR Rifle (Sand)", "arifle_MSBS65_Mark_sand_F", 700, "noDLC"],
	["MXM Rifle", "arifle_MXM_F", 700],
	["MXM Rifle (Black)", "arifle_MXM_Black_F", 700],
	["MXM Rifle (Khaki)", "arifle_MXM_khk_F", 700, "noDLC"],
	["CMR-76 Stealth Rifle", "srifle_DMR_07_blk_F", 1000],
	["CMR-76 Stealth Rifle (Hex)", "srifle_DMR_07_hex_F", 1000],
	["CMR-76 Stealth Rifle (G Hex)", "srifle_DMR_07_ghex_F", 1000],
	["SPAR-17 Rifle", "arifle_SPAR_03_blk_F", 1050],
	["SPAR-17 Rifle (Khaki)", "arifle_SPAR_03_khk_F", 1050],
	["SPAR-17 Rifle (Sand)", "arifle_SPAR_03_snd_F", 1050],

	["Mk-I EMR Rifle", "srifle_DMR_03_F", 1500],
	["Mk-I EMR Rifle (Camo)", "srifle_DMR_03_multicam_F", 1500],
	["Mk-I EMR Rifle (Khaki)", "srifle_DMR_03_khaki_F", 1500],
	["Mk-I EMR Rifle (Sand)", "srifle_DMR_03_tan_F", 1500],
	["Mk-I EMR Rifle (Woodland)", "srifle_DMR_03_woodland_F", 1500],
	["MAR-10 Rifle", "srifle_DMR_02_F", 1250],
	["MAR-10 Rifle (Camo)", "srifle_DMR_02_camo_F", 1250],
	["MAR-10 Rifle (Sand)", "srifle_DMR_02_sniper_F", 1250],
	["ASP-1 Kir Rifle", "srifle_DMR_04_F", 1250],
	["ASP-1 Kir Rifle (Tan)", "srifle_DMR_04_tan_F", 1250],
	["M320 LRR Sniper", "srifle_LRR_LRPS_F", 3000],
	["M320 LRR Sniper (Camo)", "srifle_LRR_camo_LRPS_F", 3200],
	["M320 LRR Sniper (Tropic)", "srifle_LRR_tna_LRPS_F", 3200, "noDLC"],
	["GM6 Lynx Sniper", "srifle_GM6_LRPS_F", 3250],
	["GM6 Lynx Sniper (Camo)", "srifle_GM6_camo_LRPS_F", 3500],
	["GM6 Lynx Sniper (G Hex)", "srifle_GM6_ghex_LRPS_F", 3500, "noDLC"]
];

lmgArray = compileFinal str
[
	["MX SW LMG", "arifle_MX_SW_F", 1300],
	["MX SW LMG (Black)", "arifle_MX_SW_Black_F", 1325],
	["MX SW LMG (Khaki)", "arifle_MX_SW_khk_F", 1325, "noDLC"],
	["Mk200 LMG", "LMG_Mk200_F", 1400],
	["Mk200 LMG (Black)", "LMG_Mk200_black_F", 1400, "noDLC"],
	["Zafir LMG", "LMG_Zafir_F", 1500],

	["SPAR-16S LMG", "arifle_SPAR_02_blk_F", 1300],
	["SPAR-16S LMG (Khaki)", "arifle_SPAR_02_khk_F", 1300],
	["SPAR-16S LMG (Sand)", "arifle_SPAR_02_snd_F", 1300],
	["CAR-95-1 LMG", "arifle_CTARS_blk_F", 1300],
	["CAR-95-1 LMG (Hex)", "arifle_CTARS_hex_F", 1300],
	["CAR-95-1 LMG (G Hex)", "arifle_CTARS_ghex_F", 1300],
	["LIM-85 LMG", "LMG_03_F", 1350],

	["RPK-12 LMG", "arifle_RPK12_F", 1500],
	["RPK-12 LMG (Arid)", "arifle_RPK12_arid_F", 1500],
	["RPK-12 LMG (Lush)", "arifle_RPK12_lush_F", 1500],

	["SPMG MMG (Sand)", "MMG_02_sand_F", 2750],
	["SPMG MMG (MTP)", "MMG_02_camo_F", 2750],
	["SPMG MMG (Black)", "MMG_02_black_F", 2750],
	["Navid MMG (Tan)", "MMG_01_tan_F", 3000],
	["Navid MMG (Hex)", "MMG_01_hex_F", 3000]
];

launcherArray = compileFinal str
[
	["RPG-7", "launch_RPG7_F", 2000],
	["RPG-42 Alamut", "launch_RPG32_F", 2250],
	["RPG-42 Alamut (G Hex)", "launch_RPG32_ghex_F", 2250, "noDLC"],
	["RPG-42 Alamut (Green)", "launch_RPG32_green_F", 2250, "noDLC"],
	["PCML", "launch_NLAW_F", 2750],
	["MAAWS Mk4 Mod 0 (Green)", "launch_MRAWS_green_rail_F", 2500, "noDLC"], // RPG-42 and MAAWS are similar, but MAAWS has longer range
	["MAAWS Mk4 Mod 0 (Olive)", "launch_MRAWS_olive_rail_F", 2500, "noDLC"],
	["MAAWS Mk4 Mod 0 (Sand)", "launch_MRAWS_sand_rail_F", 2500, "noDLC"],
	["MAAWS Mk4 Mod 1 (Green)", "launch_MRAWS_green_F", 3000, "noDLC"], // MAAWS Mod 1 has nightvision and laser rangefinder, while Mod 0 doesn't
	["MAAWS Mk4 Mod 1 (Olive)", "launch_MRAWS_olive_F", 3000, "noDLC"],
	["MAAWS Mk4 Mod 1 (Sand)", "launch_MRAWS_sand_F", 3000, "noDLC"],
	["9M135 Vorona (Brown)", "launch_O_Vorona_brown_F", 4500, "noDLC"],
	["9M135 Vorona (Green)", "launch_O_Vorona_green_F", 4500, "noDLC"],
	["Titan MPRL Compact (Sand)", "launch_Titan_short_F", 4250],
	["Titan MPRL Compact (Coyote)", "launch_O_Titan_short_F", 4250],
	["Titan MPRL Compact (Olive)", "launch_I_Titan_short_F", 4250],
	["Titan MPRL Compact (Tropic)", "launch_B_Titan_short_tna_F", 4250, "noDLC"],
	["Titan MPRL Compact (G Hex)", "launch_O_Titan_short_ghex_F", 4250, "noDLC"],
	["Titan MPRL AA (Sand)", "launch_Titan_F", 3500],
	["Titan MPRL AA (Hex)", "launch_O_Titan_F", 3500],
	["Titan MPRL AA (Digi)", "launch_I_Titan_F", 3500],
	["Titan MPRL AA (Tropic)", "launch_B_Titan_tna_F", 3500, "noDLC"],
	["Titan MPRL AA (G Hex)", "launch_O_Titan_ghex_F", 3500, "noDLC"],
	["Titan MPRL AA (Geometric)", "launch_I_Titan_eaf_F", 3500, "noDLC"]
];

allGunStoreFirearms = compileFinal str (call pistolArray + call smgArray + call rifleArray + call lmgArray + call sniperArray +call launcherArray);

staticGunsArray = compileFinal str
[
	// ["Vehicle Ammo Crate", "Box_NATO_AmmoVeh_F", 2500],
	["Static Titan AT 4Rnd", "B_static_AT_F", 9000], // Static launchers only have 4 ammo, hence the low price
	["Static Titan AT 4Rnd", "O_static_AT_F", 9000],
	["Static Titan AT 4Rnd", "I_static_AT_F", 9000],
	["Static Titan AA 4Rnd", "B_static_AA_F", 7500],
	["Static Titan AA 4Rnd", "O_static_AA_F", 7500],
	["Static Titan AA 4Rnd", "I_static_AA_F", 7500],
	["M2 HMG .50", "B_G_HMG_02_F", 4000],
	["M2 HMG .50", "O_G_HMG_02_F", 4000],
	["M2 HMG .50", "I_G_HMG_02_F", 4000],
	["M2 HMG .50 (Raised)", "B_G_HMG_02_high_F", 4200],
	["M2 HMG .50 (Raised)", "O_G_HMG_02_high_F", 4200],
	["M2 HMG .50 (Raised)", "I_G_HMG_02_high_F", 4200],
	["Mk30 HMG .50 Low tripod", "B_HMG_01_F", 5000],
	["Mk30 HMG .50 Low tripod", "O_HMG_01_F", 5000],
	["Mk30 HMG .50 Low tripod", "I_HMG_01_F", 5000],
	["Mk30A HMG .50 Sentry", "B_HMG_01_A_F", 15000],
	["Mk30A HMG .50 Sentry", "O_HMG_01_A_F", 15000],
	["Mk30A HMG .50 Sentry", "I_HMG_01_A_F", 15000],
	["Mk30 HMG .50 High tripod", "B_HMG_01_high_F", 5500],
	["Mk30 HMG .50 High tripod", "O_HMG_01_high_F", 5500],
	["Mk30 HMG .50 High tripod", "I_HMG_01_high_F", 5500],
	["Mk32 GMG 20mm Low tripod", "B_GMG_01_F", 7500],
	["Mk32 GMG 20mm Low tripod", "O_GMG_01_F", 7500],
	["Mk32 GMG 20mm Low tripod", "I_GMG_01_F", 7500],
	["Mk32A GMG 20mm Sentry", "B_GMG_01_A_F", 20000],
	["Mk32A GMG 20mm Sentry", "O_GMG_01_A_F", 20000],
	["Mk32A GMG 20mm Sentry", "I_GMG_01_A_F", 20000],
	["Mk32 GMG 20mm High tripod", "B_GMG_01_high_F", 10000],
	["Mk32 GMG 20mm High tripod", "O_GMG_01_high_F", 10000],
	["Mk32 GMG 20mm High tripod", "I_GMG_01_high_F", 10000],
	["Mk6 Mortar", "B_Mortar_01_F", 25000],
	["Mk6 Mortar", "O_Mortar_01_F", 25000],
	["Mk6 Mortar", "I_Mortar_01_F", 25000]
];

throwputArray = compileFinal str
[
	["RGN Mini Grenade", "MiniGrenade", 150],
	["RGO Frag Grenade", "HandGrenade", 200],
	["APERS Tripwire Mine", "APERSTripMine_Wire_Mag", 400],
	["APERS Bounding Mine", "APERSBoundingMine_Range_Mag", 420],
	["APERS Mine", "APERSMine_Range_Mag", 450],
	["APERS Mine Dispenser", "APERSMineDispenser_Mag", 2000],
	["Claymore Charge", "ClaymoreDirectionalMine_Remote_Mag", 475],
	["M6 SLAM Mine", "SLAMDirectionalMine_Wire_Mag", 650],
	["AT Mine", "ATMine_Range_Mag", 700],
	["Explosive Charge", "DemoCharge_Remote_Mag", 750],
	["Explosive Satchel", "SatchelCharge_Remote_Mag", 1000],
	["Smoke Grenade (White)", "SmokeShell", 150],
	["Smoke Grenade (Purple)", "SmokeShellPurple", 150],
	["Smoke Grenade (Blue)", "SmokeShellBlue", 150],
	["Smoke Grenade (Green)", "SmokeShellGreen", 150],
	["Smoke Grenade (Yellow)", "SmokeShellYellow", 150],
	["Smoke Grenade (Orange)", "SmokeShellOrange", 150],
	["Smoke Grenade (Red)", "SmokeShellRed", 150],
	["Small IED (Urban)", "IEDUrbanSmall_Remote_Mag", 2000],
	["Large IED (Urban)", "IEDUrbanBig_Remote_Mag", 2500],
	["Chemlight (Blue)", "Chemlight_blue", 75],
	["Chemlight (Green)", "Chemlight_green", 75],
	["Chemlight (Yellow)", "Chemlight_yellow", 75],
	["Chemlight (Red)", "Chemlight_red", 75],
	["IR Designator Grenade", "B_IR_Grenade", 100, "WEST"],
	["IR Designator Grenade", "O_IR_Grenade", 100, "EAST"],
	["IR Designator Grenade", "I_IR_Grenade", 100, "GUER"]
];

//Gun Store Ammo List
//Text name, classname, buy cost
ammoArray = compileFinal str
[
	["9mm 10Rnd Mag", "10Rnd_9x21_Mag", 25],
	["9mm 16Rnd Mag", "16Rnd_9x21_Mag", 30],
	["9mm 16Rnd Mag T-R (Reload)", "16Rnd_9x21_red_Mag", 32],
	["9mm 16Rnd Mag T-Y (Reload)", "16Rnd_9x21_yellow_Mag", 32],
	["9mm 16Rnd Mag T-G (Reload)", "16Rnd_9x21_green_Mag", 32],
	["9mm 30Rnd Mag", "30Rnd_9x21_Mag", 35],
	["9mm 30Rnd Mag T-R (Reload)", "30Rnd_9x21_Red_Mag", 37],
	["9mm 30Rnd Mag T-Y (Reload)", "30Rnd_9x21_Yellow_Mag", 37],
	["9mm 30Rnd Mag T-G (Reload)", "30Rnd_9x21_Green_Mag", 37],
	["9mm 30Rnd SMG Mag", "30Rnd_9x21_Mag_SMG_02", 35],
	["9mm 30Rnd SMG Mag T-R (Reload)", "30Rnd_9x21_Mag_SMG_02_Tracer_Red", 37],
	["9mm 30Rnd SMG Mag T-Y (Reload)", "30Rnd_9x21_Mag_SMG_02_Tracer_Yellow", 37],
	["9mm 30Rnd SMG Mag T-G (Reload)", "30Rnd_9x21_Mag_SMG_02_Tracer_Green", 37],
	[".45 ACP 6Rnd Cylinder", "6Rnd_45ACP_Cylinder", 25],
	[".45 ACP 9Rnd Mag", "9Rnd_45ACP_Mag", 30],
	[".45 ACP 11Rnd Mag", "11Rnd_45ACP_Mag", 35],
	[".45 ACP 30Rnd Vermin Mag", "30Rnd_45ACP_MAG_SMG_01", 40],
	[".45 ACP 30Rnd Vermin Mag T-G", "30Rnd_45ACP_Mag_SMG_01_tracer_green", 35],
	["5.45mm 30Rnd Mag", "30Rnd_545x39_Mag_F", 70],
	["5.45mm 30Rnd Mag T-Y", "30Rnd_545x39_Mag_Tracer_F", 75],
	["5.45mm 30Rnd Mag T-R", "30Rnd_545x39_Mag_Tracer_Green_F", 75],
	["5.56mm 20Rnd Underwater Mag", "20Rnd_556x45_UW_mag", 90],
	["5.56mm 30Rnd Mag", "30Rnd_556x45_Stanag", 70],
	["5.56mm 30Rnd Mag T-G", "30Rnd_556x45_Stanag_Tracer_Green", 75],
	["5.56mm 30Rnd Mag T-Y", "30Rnd_556x45_Stanag_Tracer_Yellow", 75],
	["5.56mm 30Rnd Mag T-R", "30Rnd_556x45_Stanag_Tracer_Red", 75],
	["5.56mm 30Rnd Mag (Sand)", "30Rnd_556x45_Stanag_Sand", 75],
	["5.56mm 30Rnd Mag (Sand) T-G", "30Rnd_556x45_Stanag_Sand_Tracer_Green", 70],
	["5.56mm 30Rnd Mag (Sand) T-Y", "30Rnd_556x45_Stanag_Sand_Tracer_Yellow", 70],
	["5.56mm 30Rnd Mag (Sand) T-R", "30Rnd_556x45_Stanag_Sand_Tracer_Red", 70],
	["5.56mm 150Rnd Mag", "150Rnd_556x45_Drum_Mag_F", 100],
	["5.56mm 150Rnd Mag T-R", "150Rnd_556x45_Drum_Mag_Tracer_F", 185],
	["5.56mm 150Rnd Mag (Khaki)", "150Rnd_556x45_Drum_Green_Mag_F", 110],
	["5.56mm 150Rnd Mag (Khaki) T-R", "150Rnd_556x45_Drum_Green_Mag_Tracer_F", 185],
	["5.56mm 150Rnd Mag (Sand)", "150Rnd_556x45_Drum_Sand_Mag_F", 110],
	["5.56mm 150Rnd Mag (Sand) T-R", "150Rnd_556x45_Drum_Sand_Mag_Tracer_F", 185],
	["5.56mm 200Rnd Box", "200Rnd_556x45_Box_F", 225],
	["5.56mm 200Rnd Box T-Y", "200Rnd_556x45_Box_Tracer_F", 200],
	["5.56mm 200Rnd Box T-R", "200Rnd_556x45_Box_Tracer_Red_F", 200],
	["5.7mm 50Rnd Mag", "50Rnd_570x28_SMG_03", 80],
	["5.8mm 30Rnd Mag", "30Rnd_580x42_Mag_F", 80],
	["5.8mm 30Rnd Mag T-G", "30Rnd_580x42_Mag_Tracer_F", 85],
	["5.8mm 100Rnd Mag", "100Rnd_580x42_Mag_F", 200],
	["5.8mm 100Rnd Mag T-G", "100Rnd_580x42_Mag_Tracer_F", 275],
	["5.8mm 100Rnd Mag (Hex)", "100Rnd_580x42_hex_Mag_F", 210],
	["5.8mm 100Rnd Mag (Hex) T-G", "100Rnd_580x42_hex_Mag_Tracer_F", 285],
	["5.8mm 100Rnd Mag (G Hex)", "100Rnd_580x42_ghex_Mag_F", 210],
	["5.8mm 100Rnd Mag (G Hex) T-G", "100Rnd_580x42_ghex_Mag_Tracer_F", 285],
	["6.5mm 20Rnd CMR Mag", "20Rnd_650x39_Cased_Mag_F", 215],
	["6.5mm 30Rnd Promet Mag", "30Rnd_65x39_caseless_msbs_mag", 220],
	["6.5mm 30Rnd Promet Mag T-R", "30Rnd_65x39_caseless_msbs_mag_Tracer", 215],
	["6.5mm 30Rnd Katiba Mag", "30Rnd_65x39_caseless_green", 220],
	["6.5mm 30Rnd Katiba Mag T-G", "30Rnd_65x39_caseless_green_mag_Tracer", 215],
	["6.5mm 30Rnd MX Mag (Sand)", "30Rnd_65x39_caseless_mag", 220],
	["6.5mm 30Rnd MX Mag (Sand) T-R", "30Rnd_65x39_caseless_mag_Tracer", 215],
	["6.5mm 30Rnd MX Mag (Black)", "30Rnd_65x39_caseless_black_mag", 225],
	["6.5mm 30Rnd MX Mag (Black) T-R", "30Rnd_65x39_caseless_black_mag_Tracer", 225],
	["6.5mm 30Rnd MX Mag (Khaki)", "30Rnd_65x39_caseless_khaki_mag", 225],
	["6.5mm 30Rnd MX Mag (Khaki) T-R", "30Rnd_65x39_caseless_khaki_mag_Tracer", 225],
	["6.5mm 100Rnd MX Mag (Sand)", "100Rnd_65x39_caseless_mag", 275],
	["6.5mm 100Rnd MX Mag (Sand) T-R", "100Rnd_65x39_caseless_mag_Tracer", 250],
	["6.5mm 100Rnd MX Mag (Black)", "100Rnd_65x39_caseless_black_mag", 285],
	["6.5mm 100Rnd MX Mag (Black) T-R", "100Rnd_65x39_caseless_black_mag_tracer", 260],
	["6.5mm 100Rnd MX Mag (Khaki)", "100Rnd_65x39_caseless_khaki_mag", 285],
	["6.5mm 100Rnd MX Mag (Khaki) T-R", "100Rnd_65x39_caseless_khaki_mag_tracer", 260],
	["6.5mm 200Rnd Belt Case", "200Rnd_65x39_cased_Box", 250],
	["6.5mm 200Rnd Belt Case T-Y", "200Rnd_65x39_cased_Box_Tracer", 225],
	["6.5mm 200Rnd Belt Case T-R", "200Rnd_65x39_cased_Box_Tracer_Red", 225],
	["7.62mm 10Rnd Rahim Mag", "10Rnd_762x54_Mag", 315],
	["7.62mm 20Rnd Mag", "20Rnd_762x51_Mag", 325],
	["7.62mm 30Rnd AKM Mag", "30Rnd_762x39_Mag_F", 320],
	["7.62mm 30Rnd AKM Mag T-Y", "30Rnd_762x39_Mag_Tracer_F", 315],
	["7.62mm 30Rnd AKM Mag T-G", "30Rnd_762x39_Mag_Tracer_Green_F", 315],
	["7.62mm 30Rnd AK12 Mag", "30Rnd_762x39_AK12_Mag_F", 320],
	["7.62mm 30Rnd AK12 Mag T-Y", "30Rnd_762x39_AK12_Mag_Tracer_F", 315],
	["7.62mm 30Rnd AK12 Mag (Arid)", "30rnd_762x39_AK12_Arid_Mag_F", 325],
	["7.62mm 30Rnd AK12 Mag (Arid) T-Y", "30rnd_762x39_AK12_Arid_Mag_Tracer_F", 320],
	["7.62mm 30Rnd AK12 Mag (Lush)", "30rnd_762x39_AK12_Lush_Mag_F", 325],
	["7.62mm 30Rnd AK12 Mag (Lush) T-Y", "30rnd_762x39_AK12_Lush_Mag_Tracer_F", 320],
	["7.62mm 75Rnd AKM Mag", "75Rnd_762x39_Mag_F", 175],
	["7.62mm 75Rnd AKM Mag T-Y", "75Rnd_762x39_Mag_Tracer_F", 165],
	["7.62mm 75Rnd AK12 Mag", "75rnd_762x39_AK12_Mag_F", 175],
	["7.62mm 75Rnd AK12 Mag T-Y", "75rnd_762x39_AK12_Mag_Tracer_F", 165],
	["7.62mm 75Rnd AK12 Mag (Arid)", "75rnd_762x39_AK12_Arid_Mag_F", 180],
	["7.62mm 75Rnd AK12 Mag (Arid) T-Y", "75rnd_762x39_AK12_Arid_Mag_Tracer_F", 170],
	["7.62mm 75Rnd AK12 Mag (Lush)", "75rnd_762x39_AK12_Lush_Mag_F", 180],
	["7.62mm 75Rnd AK12 Mag (Lush) T-Y", "75rnd_762x39_AK12_Lush_Mag_Tracer_F", 170],
	["7.62mm 150Rnd Box", "150Rnd_762x54_Box", 350],
	["7.62mm 150Rnd Box T-G", "150Rnd_762x54_Box_Tracer", 325],
	[".338 LM 10Rnd Mag", "10Rnd_338_Mag", 250],
	[".338 NM 130Rnd Belt", "130Rnd_338_Mag", 950],
	["9.3mm 10Rnd Mag", "10Rnd_93x64_DMR_05_Mag", 150],
	["9.3mm 150Rnd Belt", "150Rnd_93x64_Mag", 1050],
	[".408 7Rnd Cheetah Mag", "7Rnd_408_Mag", 150],
	["12.7mm 5Rnd Mag", "5Rnd_127x108_Mag", 250],
	["12.7mm 5Rnd Armor-Piercing Mag", "5Rnd_127x108_APDS_Mag", 260],
	["12.7mm 10Rnd Subsonic Mag", "10Rnd_127x54_Mag", 275],
	["12 Gauge 2Rnd Pellets", "2Rnd_12Gauge_Pellets", 65],
	["12 Gauge 2Rnd Slug", "2Rnd_12Gauge_Slug", 65],
	["12 Gauge 6Rnd Pellets", "6Rnd_12Gauge_Pellets", 90],
	["12 Gauge 6Rnd Slug", "6Rnd_12Gauge_Slug", 100],
	["Signal Flares (Green)", "6Rnd_GreenSignal_F", 45],
	["Signal Flares (Red)", "6Rnd_RedSignal_F", 45],
	[".50 BW 10Rnd Mag", "10Rnd_50BW_Mag_F", 350],             //                 hit                      hit,  radius
	["PG-7VM HEAT Grenade", "RPG7_F", 900],                   // Direct damage:  343     | Splash damage:  13,  3.0m     | Guidance: none
	["RPG-42 AT Rocket", "RPG32_F", 1000],                     //                 422     |                 28,  2.5m     |           none
	["RPG-42 HE Rocket", "RPG32_HE_F", 1000],                  //                 200     |                 50,  6.0m     |           none
	["MAAWS HEAT 75 Rocket", "MRAWS_HEAT_F", 1500],            //                 495     |                 14,  2.0m     |           none
	["MAAWS HEAT 55 Rocket", "MRAWS_HEAT55_F", 1450],          //                 450     |                 14,  2.0m     |           none
	["MAAWS HE 44 Rocket", "MRAWS_HE_F", 1000],                //                 200     |                 50,  6.0m     |           none
	["9M135 HEAT Missile", "Vorona_HEAT", 2000],              //                 634     |                 28,  2.5m     |           mouse
	["9M135 HE Missile", "Vorona_HE", 1750],                   //                 220     |                 45,  8.0m     |           mouse
	["PCML AT Missile", "NLAW_F", 1750],                       //                 462     |                 25,  2.4m     |           laser/IR, cold/hot ground vehicles
	["Titan Anti-Tank Missile", "Titan_AT", 3000],            //                 515     |                 20,  2.0m     |           mouse, laser/IR, hot ground vehicles
	["Titan Anti-Personnel Missile", "Titan_AP", 1750],        //                 100     |                 25, 10.0m     |           mouse, laser/IR
	["Titan AA Missile", "Titan_AA", 1750],                    //                  80     |                 60,  6.0m     |           aircraft
	["40mm HE Grenade Round", "1Rnd_HE_Grenade_shell", 225],
	["40mm 3Rnd HE Grenades", "3Rnd_HE_Grenade_shell", 750],
	["40mm Smoke Round (White)", "1Rnd_Smoke_Grenade_shell", 100],
	["40mm Smoke Round (Purple)", "1Rnd_SmokePurple_Grenade_shell", 100],
	["40mm Smoke Round (Blue)", "1Rnd_SmokeBlue_Grenade_shell", 100],
	["40mm Smoke Round (Green)", "1Rnd_SmokeGreen_Grenade_shell", 100],
	["40mm Smoke Round (Yellow)", "1Rnd_SmokeYellow_Grenade_shell", 100],
	["40mm Smoke Round (Orange)", "1Rnd_SmokeOrange_Grenade_shell", 100],
	["40mm Smoke Round (Red)", "1Rnd_SmokeRed_Grenade_shell", 100],
	["40mm 3Rnd Smokes (White)", "3Rnd_Smoke_Grenade_shell", 300],
	["40mm 3Rnd Smokes (Purple)", "3Rnd_SmokePurple_Grenade_shell", 300],
	["40mm 3Rnd Smokes (Blue)", "3Rnd_SmokeBlue_Grenade_shell", 300],
	["40mm 3Rnd Smokes (Green)", "3Rnd_SmokeGreen_Grenade_shell", 300],
	["40mm 3Rnd Smokes (Yellow)", "3Rnd_SmokeYellow_Grenade_shell", 300],
	["40mm 3Rnd Smokes (Orange)", "3Rnd_SmokeOrange_Grenade_shell", 300],
	["40mm 3Rnd Smokes (Red)", "3Rnd_SmokeRed_Grenade_shell", 300],
	["40mm Flare Round (White)", "UGL_FlareWhite_F", 125],
	["40mm Flare Round (Green)", "UGL_FlareGreen_F", 125],
	["40mm Flare Round (Yellow)", "UGL_FlareYellow_F", 125],
	["40mm Flare Round (Red)", "UGL_FlareRed_F", 125],
	["40mm Flare Round (IR)", "UGL_FlareCIR_F", 125],
	["40mm 3Rnd Flares (White)", "3Rnd_UGL_FlareWhite_F", 350],
	["40mm 3Rnd Flares (Green)", "3Rnd_UGL_FlareGreen_F", 350],
	["40mm 3Rnd Flares (Yellow)", "3Rnd_UGL_FlareYellow_F", 350],
	["40mm 3Rnd Flares (Red)", "3Rnd_UGL_FlareRed_F", 350],
	["40mm 3Rnd Flares (IR)", "3Rnd_UGL_FlareCIR_F", 350]
];

//Gun Store item List
//Text name, classname, buy cost, item class
accessoriesArray = compileFinal str
[
	["Suppressor 9mm", "muzzle_snds_L", 250, "item"],
	["Suppressor .45 ACP", "muzzle_snds_acp", 175, "item"],
	["Suppressor 5.56mm", "muzzle_snds_M", 200, "item"],
	["Suppressor 5.56mm (Khaki)", "muzzle_snds_m_khk_F", 200, "item", "noDLC"],
	["Suppressor 5.56mm (Sand)", "muzzle_snds_m_snd_F", 200, "item", "noDLC"],
	["Suppressor 5.7mm", "muzzle_snds_570", 175, "item"],
	["Suppressor 5.8mm Stealth", "muzzle_snds_58_blk_F", 200, "item"],
	["Suppressor 5.8mm Stealth (Hex)", "muzzle_snds_58_hex_F", 200, "item"],
	["Suppressor 5.8mm Stealth (G Hex)", "muzzle_snds_58_ghex_F", 200, "item"],
	["Suppressor 6.5mm", "muzzle_snds_H", 200, "item"],
	["Suppressor 6.5mm (Khaki)", "muzzle_snds_H_khk_F", 200, "item", "noDLC"],
	["Suppressor 6.5mm (Sand)", "muzzle_snds_H_snd_F", 200, "item", "noDLC"],
	["Suppressor 6.5mm LMG", "muzzle_snds_H_MG", 225, "item"],
	["Suppressor 6.5mm LMG (Black)", "muzzle_snds_H_MG_blk_F", 225, "item", "noDLC"],
	["Suppressor 6.5mm LMG (Khaki)", "muzzle_snds_H_MG_khk_F", 225, "item", "noDLC"],
	["Suppressor 6.5mm Stealth", "muzzle_snds_65_TI_blk_F", 225, "item"],
	["Suppressor 6.5mm Stealth (Hex)", "muzzle_snds_65_TI_hex_F", 225, "item"],
	["Suppressor 6.5mm Stealth (G Hex)", "muzzle_snds_65_TI_ghex_F", 225, "item"],
	["Suppressor 7.62mm", "muzzle_snds_B", 300, "item"],
	["Suppressor 7.62mm (Khaki)", "muzzle_snds_B_khk_F", 300, "item", "noDLC"],
	["Suppressor 7.62mm (Sand)", "muzzle_snds_B_snd_F", 300, "item", "noDLC"],
	["Suppressor 7.62mm AK (Arid)", "muzzle_snds_B_arid_F", 300, "item"],
	["Suppressor 7.62mm AK (Lush)", "muzzle_snds_B_lush_F", 300, "item"],
	["Suppressor .338", "muzzle_snds_338_black", 350, "item"],
	["Suppressor .338 (Green)", "muzzle_snds_338_green", 350, "item"],
	["Suppressor .338 (Sand)", "muzzle_snds_338_sand", 1375, "item"],
	["Suppressor 9.3mm", "muzzle_snds_93mmg", 475, "item"],
	["Suppressor 9.3mm (Tan)", "muzzle_snds_93mmg_tan", 475, "item"],
	["SD Military Antenna (78-89 MHz)", "muzzle_antenna_01_f", 0, "item", "HIDDEN"],
	["SD Experimental Antenna (390-500 MHz)", "muzzle_antenna_02_f", 0, "item", "HIDDEN"],
	// ["SD Jammer Antenna (433 MHz)", "muzzle_antenna_03_f", 200, "item"],
	["Bipod (NATO)", "bipod_01_F_blk", 200, "item", "noDLC"],
	["Bipod (CSAT)", "bipod_02_F_blk", 200, "item", "noDLC"],
	["Bipod (AAF)", "bipod_03_F_blk", 200, "item", "noDLC"],
	["Bipod (MTP)", "bipod_01_F_mtp", 200, "item", "noDLC"],
	["Bipod (Hex)", "bipod_02_F_hex", 200, "item", "noDLC"],
	["Bipod (Olive)", "bipod_03_F_oli", 200, "item", "noDLC"],
	["Bipod (Sand)", "bipod_01_F_snd", 200, "item", "noDLC"],
	["Bipod (Tan)", "bipod_02_F_tan", 200, "item", "noDLC"],
	["Bipod (Khaki)", "bipod_01_F_khk", 200, "item", "noDLC"],
	["Bipod (Lush)", "bipod_02_F_lush", 200, "item", "noDLC"],
	["Bipod (Arid)", "bipod_02_F_arid", 200, "item", "noDLC"],
	["Flashlight", "acc_flashlight", 125, "item"],
	["Pistol Flashlight" ,"acc_flashlight_pistol", 125, "item"],
	["SD Flashlight", "acc_esd_01_flashlight", 125, "item"],
	["IR Laser Pointer", "acc_pointer_IR", 125, "item"],
	["Yorris J2 (Zubr)", "optic_Yorris", 125, "item"],
	["MRD (4-five/Sand)", "optic_MRD", 125, "item"],
	["MRD (4-five/Black)", "optic_MRD_black", 125, "item", "noDLC"],
	["ACO SMG (Red)", "optic_aco_smg", 150, "item"],
	["ACO SMG (Green)", "optic_ACO_grn_smg", 150, "item"],
	["ACO (Red)", "optic_Aco", 175, "item"],
	["ACO (Green)", "optic_Aco_grn", 175, "item"],
	["Holosight SMG", "optic_Holosight_smg", 150, "item"],
	["Holosight SMG (Black)", "optic_Holosight_smg_blk_F", 150, "item", "noDLC"],
	["Holosight SMG (Khaki)", "optic_Holosight_smg_khk_F", 150, "item", "noDLC"],
	["Holosight", "optic_Holosight", 175, "item"],
	["Holosight (Arid)", "optic_Holosight_arid_F", 175, "item", "noDLC"],
	["Holosight (Black)", "optic_Holosight_blk_F", 175, "item", "noDLC"],
	["Holosight (Khaki)", "optic_Holosight_khk_F", 175, "item", "noDLC"],
	["Holosight (Lush)", "optic_Holosight_lush_F", 175, "item", "noDLC"],
	["Promet Modular Sight", "optic_ico_01_f", 200, "item"],
	["Promet Modular Sight (Black)", "optic_ico_01_black_f", 200, "item"],
	["Promet Modular Sight (Camo)", "optic_ico_01_camo_f", 200, "item"],
	["Promet Modular Sight (Sand)", "optic_ico_01_sand_f", 200, "item"],
	["MRCO", "optic_MRCO", 200, "item"],
	["ERCO", "optic_ERCO_blk_F", 200, "item"],
	["ERCO (Khaki)", "optic_ERCO_khk_F", 200, "item"],
	["ERCO (Sand)", "optic_ERCO_snd_F", 200, "item"],
	["ARCO", "optic_Arco", 225, "item"],
	["ARCO (Arid)", "optic_Arco_arid_F", 225, "item", "noDLC"],
	["ARCO (Black)", "optic_Arco_blk_F", 225, "item", "noDLC"],
	["ARCO (G Hex)", "optic_Arco_ghex_F", 225, "item", "noDLC"],
	["ARCO (Lush)", "optic_Arco_lush_F", 225, "item", "noDLC"],
	["ARCO AK (Arid)", "optic_Arco_AK_arid_F", 225, "item", "noDLC"],
	["ARCO AK (Black)", "optic_Arco_AK_black_F", 225, "item", "noDLC"],
	["ARCO AK (Lush)", "optic_Arco_AK_lush_F", 225, "item", "noDLC"],
	["RCO", "optic_Hamr", 250, "item"],
	["RCO (Khaki)", "optic_Hamr_khk_F", 250, "item", "noDLC"],
	["MOS", "optic_SOS", 250, "item"],
	["MOS (Khaki)", "optic_SOS_khk_F", 250, "item", "noDLC"],
	["DMS", "optic_DMS", 275, "item"],
	["DMS (G Hex)", "optic_DMS_ghex_F", 275, "item", "noDLC"],
	["DMS (Weathered)", "optic_DMS_weathered_F", 225, "item", "noDLC"],
	["DMS (Weathered Kir)", "optic_DMS_weathered_Kir_F", 225, "item", "noDLC"],
	["Kahlia (Sightless)", "optic_KHS_old", 300, "item"],
	["Kahlia", "optic_KHS_blk", 325, "item"],
	["Kahlia (Hex)", "optic_KHS_hex", 325, "item"],
	["Kahlia (Tan)", "optic_KHS_tan", 325, "item"],
	["AMS", "optic_AMS", 350, "item"],
	["AMS (Khaki)", "optic_AMS_khk", 350, "item"],
	["AMS (Sand)", "optic_AMS_snd", 350, "item"],
	["LRPS", "optic_LRPS", 500, "item"],
	["LRPS (G Hex)", "optic_LRPS_ghex_F", 500, "item", "noDLC"],
	["LRPS (Tropic)", "optic_LRPS_tna_F", 500, "item", "noDLC"],
	["NVS", "optic_NVS", 1500, "item"],
	["TWS", "optic_tws", 4000, "item", "HIDDEN"],
	["TWS MG", "optic_tws_mg", 5000, "item", "HIDDEN"],
	["Nightstalker", "optic_Nightstalker", 6500, "item", "HIDDEN"]
];

// If commented, means the color/camo isn't implemented or is a duplicate of another hat
headArray = compileFinal str
[
	["Modular Helmet (Digi)", "H_HelmetIA", 150, "hat"],
	["Advanced Modular Helmet", "H_HelmetHBK_headset_F", 150, "hat", "noDLC"],
	["Advanced Modular Helmet (Olive)", "H_HelmetHBK_F", 150, "hat", "noDLC"],
	["Advanced Modular Helmet (Chops)", "H_HelmetHBK_chops_F", 175, "hat", "noDLC"],
	["Advanced Modular Helmet (Ear Protectors)", "H_HelmetHBK_ear_F", 175, "hat", "noDLC"],
	["Light Combat Helmet", "H_HelmetB_light", 140, "hat"],
	["Light Combat Helmet (Grass)", "H_HelmetB_light_grass", 140, "hat"],
	["Light Combat Helmet (Snakeskin)", "H_HelmetB_light_snakeskin", 140, "hat"],
	["Light Combat Helmet (Desert)", "H_HelmetB_light_desert", 140, "hat"],
	["Light Combat Helmet (Black)", "H_HelmetB_light_black", 140, "hat"],
	["Light Combat Helmet (Sand)", "H_HelmetB_light_sand", 140, "hat"],
	["Light Combat Helmet (Tropic)", "H_HelmetB_Light_tna_F", 140, "hat", "noDLC"],
	["Light Combat Helmet (Woodland)", "H_HelmetB_light_wdl", 140, "hat", "noDLC"],
	["Combat Helmet", "H_HelmetB", 150, "hat"],
	["Combat Helmet (Camonet)", "H_HelmetB_camo", 150, "hat"],
	["Combat Helmet (Grass)", "H_HelmetB_grass", 150, "hat"],
	["Combat Helmet (Snakeskin)", "H_HelmetB_snakeskin", 150, "hat"],
	["Combat Helmet (Desert)", "H_HelmetB_desert", 150, "hat"],
	["Combat Helmet (Black)", "H_HelmetB_black", 150, "hat"],
	["Combat Helmet (Sand)", "H_HelmetB_sand", 150, "hat"],
	["Combat Helmet (Tropic)", "H_HelmetB_tna_F", 150, "hat", "noDLC"],
	["Combat Helmet (Woodland)", "H_HelmetB_plain_wdl", 150, "hat", "noDLC"],
	["Stealth Combat Helmet", "H_HelmetB_TI_tna_F", 175, "hat", "noDLC"],
	["Stealth Combat Helmet (Arid)", "H_HelmetB_TI_arid_F", 175, "hat", "noDLC"],
	["Special Purpose Helmet (Hex)", "H_HelmetO_ViperSP_hex_F", 7500, "hat", "HIDDEN"],
	["Special Purpose Helmet (Green Hex)", "H_HelmetO_ViperSP_ghex_F", 7500, "hat", "HIDDEN"],
	["Enhanced Combat Helmet", "H_HelmetSpecB", 175, "hat"],
	["Enhanced Combat Helmet (Black)", "H_HelmetSpecB_blk", 175, "hat"],
	["Enhanced Combat Helmet (Snakeskin)", "H_HelmetSpecB_snakeskin", 175, "hat"],
	["Enhanced Combat Helmet (Grass)", "H_HelmetSpecB_paint1", 175, "hat"],
	["Enhanced Combat Helmet (Desert)", "H_HelmetSpecB_paint2", 175, "hat"],
	["Enhanced Combat Helmet (Sand)", "H_HelmetSpecB_sand", 175, "hat"],
	["Enhanced Combat Helmet (Woodland)", "H_HelmetSpecB_wdl", 175, "hat", "noDLC"],
	["Enhanced Combat Helmet (Tropic)", "H_HelmetB_Enh_tna_F", 175, "hat", "noDLC"],
	["Protector Helmet (Hex)", "H_HelmetO_ocamo", 160, "hat"],
	["Protector Helmet (Green Hex)", "H_HelmetO_ghex_F", 160, "hat", "noDLC"],
	["Protector Helmet (Urban)", "H_HelmetO_oucamo", 160, "hat"],
	["Assassin Helmet (Hex)", "H_HelmetSpecO_ocamo", 175, "hat"],
	["Assassin Helmet (Green Hex)", "H_HelmetSpecO_ghex_F", 175, "hat", "noDLC"],
	["Assassin Helmet (Black)", "H_HelmetSpecO_blk", 175, "hat", "noDLC"],
	["Avenger Helmet", "H_HelmetAggressor_F", 175, "hat", "noDLC"],
	["Avenger Helmet (Cover B)", "H_HelmetAggressor_cover_F", 175, "hat", "noDLC"],
	["Avenger Helmet (Cover T)", "H_HelmetAggressor_cover_taiga_F", 175, "hat", "noDLC"],
	["Defender Helmet (Hex)", "H_HelmetLeaderO_ocamo", 200, "hat"],
	["Defender Helmet (Urban)", "H_HelmetLeaderO_oucamo", 200, "hat"],
	["Defender Helmet (G Hex)", "H_HelmetLeaderO_ghex_F", 200, "hat", "noDLC"],
	["Pilot Helmet (NATO)", "H_PilotHelmetFighter_B", 160, "hat"],
	["Pilot Helmet (CSAT)", "H_PilotHelmetFighter_O", 160, "hat"],
	["Pilot Helmet (AAF)", "H_PilotHelmetFighter_I", 160, "hat"],
	["Pilot Helmet (LDF)", "H_PilotHelmetFighter_I_E", 160, "hat", "noDLC"],
	["Crew Helmet (NATO)", "H_HelmetCrew_B", 160, "hat"],
	["Crew Helmet (CSAT)", "H_HelmetCrew_O", 160, "hat"],
	["Crew Helmet (Green Hex)(CSAT)", "H_HelmetCrew_O_ghex_F", 160, "hat", "noDLC"],
	["Crew Helmet (AAF)", "H_HelmetCrew_I", 160, "hat"],
	["Crew Helmet (LDF)", "H_HelmetCrew_I_E", 160, "hat", "noDLC"],
	["Crew Helmet (SOFT)[LDF]", "H_Tank_eaf_F", 160, "hat", "noDLC"],
	["Heli Pilot Helmet (NATO)", "H_PilotHelmetHeli_B", 150, "hat"],
	["Heli Pilot Helmet (CSAT)", "H_PilotHelmetHeli_O", 150, "hat"],
	["Heli Pilot Helmet (AAF)", "H_PilotHelmetHeli_I", 150, "hat"],
	["Heli Pilot Helmet (LDF)", "H_PilotHelmetHeli_I_E", 150, "hat", "noDLC"],
	["Heli Crew Helmet (NATO)", "H_CrewHelmetHeli_B", 150, "hat"],
	["Heli Crew Helmet (CSAT)", "H_CrewHelmetHeli_O", 150, "hat"],
	["Heli Crew Helmet (AAF)", "H_CrewHelmetHeli_I", 150, "hat"],
	["Heli Crew Helmet (LDF)", "H_CrewHelmetHeli_I_E", 150, "hat", "noDLC"],
	["Basic Helmet (Black)", "H_PASGT_basic_black_F", 150, "hat", "noDLC"],
	["Basic Helmet (Blue)", "H_PASGT_basic_blue_F", 150, "hat", "noDLC"],
	["Basic Helmet (Olive)", "H_PASGT_basic_olive_F", 150, "hat", "noDLC"],
	["Basic Helmet (White)", "H_PASGT_basic_white_F", 150, "hat", "noDLC"],
	["Press Helmet", "H_PASGT_basic_blue_press_F", 150, "hat", "noDLC"],
	["Press Helmet (Neck Protection)", "H_PASGT_neckprot_blue_press_F", 150, "hat", "noDLC"],
	["Safari Hat (Sand)", "H_Hat_Safari_sand_F", 30, "hat", "noDLC"],
	["Safari Hat (Olive)", "H_Hat_Safari_olive_F", 30, "hat", "noDLC"],
	["Straw Hat", "H_StrawHat", 30, "hat"],
	["Straw Hat (Dark)", "H_StrawHat_dark", 30, "hat"],
	["Bandana (Black)", "H_Bandanna_gry", 30, "hat"],
	["Bandana (Blue)", "H_Bandanna_blu", 30, "hat"],
	["Bandana (Coyote)", "H_Bandanna_cbr", 30, "hat"],
	["Bandana (Headset)", "H_Bandanna_khk_hs", 30, "hat"],
	["Bandana (Khaki)", "H_Bandanna_khk", 30, "hat"],
	["Bandana (MTP)", "H_Bandanna_mcamo", 30, "hat"],
	["Bandana (Sage)", "H_Bandanna_sgg", 30, "hat"],
	["Bandana (Sand)", "H_Bandanna_sand", 30, "hat"],
	["Bandana (Surfer)", "H_Bandanna_surfer", 30, "hat"],
	["Bandana (Surfer, Black)", "H_Bandanna_surfer_blk", 30, "hat"],
	["Bandana (Surfer, Green)", "H_Bandanna_surfer_grn", 30, "hat"],
	["Bandana (Woodland)", "H_Bandanna_camo", 30, "hat"],
	["Beanie (Black)", "H_Watchcap_blk", 30, "hat"],
	["Beanie (Brown)", "H_Watchcap_cbr", 30, "hat"],
	["Beanie (Khaki)", "H_Watchcap_khk", 30, "hat"],
	["Beanie (Navy)", "H_Watchcap_sgg", 30, "hat"],
	["Beanie (Olive)", "H_Watchcap_camo", 30, "hat"],
	["Beret (Black)", "H_Beret_blk", 30, "hat"],
	["Beret (Colonel)", "H_Beret_Colonel", 30, "hat"],
	["Beret (NATO)", "H_Beret_02", 30, "hat"],
	["Beret [LDF]", "H_Beret_EAF_01_F", 30, "hat", "noDLC"],
	["Beret (Red) [CSAT]", "H_Beret_CSAT_01_F", 30, "hat", "noDLC"],
	["Beret (Gendarmerie)", "H_Beret_gen_F", 30, "hat", "noDLC"],
	["Booniehat (AAF)", "H_Booniehat_dgtl", 30, "hat"],
	["Booniehat (Headset)", "H_Booniehat_khk_hs", 30, "hat"],
	["Booniehat (Khaki)", "H_Booniehat_khk", 30, "hat"],
	["Booniehat (MTP)", "H_Booniehat_mcamo", 30, "hat"],
	["Booniehat (Olive)", "H_Booniehat_oli", 30, "hat"],
	["Booniehat (Sand)", "H_Booniehat_tan", 30, "hat"],
	["Booniehat (Tropic)", "H_Booniehat_tna_F", 30, "hat", "noDLC"],
	["Booniehat (Green)", "H_Booniehat_mgrn", 30, "hat", "noDLC"],
	["Booniehat (Taiga)", "H_Booniehat_taiga", 30, "hat", "noDLC"],
	["Booniehat [LDF]", "H_Booniehat_eaf", 30, "hat", "noDLC"],
	["Booniehat (Woodland)", "H_Booniehat_wdl", 30, "hat", "noDLC"],
	["Fedora (Blue)", "H_Hat_blue", 30, "hat"],
	["Fedora (Brown)", "H_Hat_brown", 30, "hat"],
	["Fedora (Camo)", "H_Hat_camo", 30, "hat"],
	["Fedora (Checker)", "H_Hat_checker", 30, "hat"],
	["Fedora (Gray)", "H_Hat_grey", 30, "hat"],
	["Fedora (Tan)", "H_Hat_tan", 30, "hat"],
	["Parade Cap (AAF)", "H_ParadeDressCap_01_AAF_F", 175, "hat", "noDLC"],
	["Parade Cap (CSAT)", "H_ParadeDressCap_01_CSAT_F", 175, "hat", "noDLC"],
	["Parade Cap (LDF)", "H_ParadeDressCap_01_LDF_F", 175, "hat", "noDLC"],
	["Parade Cap (US)", "H_ParadeDressCap_01_US_F", 175, "hat", "noDLC"],
	["Cap (BI)", "H_Cap_grn_BI", 30, "hat"],
	["Cap (Black)", "H_Cap_blk", 30, "hat"],
	["Cap (Blue)", "H_Cap_blu", 30, "hat"],
	["Cap (CMMG)", "H_Cap_blk_CMMG", 30, "hat"],
	["Cap (Green)", "H_Cap_grn", 30, "hat"],
	["Cap (ION)", "H_Cap_blk_ION", 30, "hat"],
	["Cap (Olive)", "H_Cap_oli", 30, "hat"],
	["Cap (Olive, Headset)", "H_Cap_oli_hs", 30, "hat"],
	["Cap (Police)", "H_Cap_police", 30, "hat"],
	["Cap (Press)", "H_Cap_press", 30, "hat"],
	["Cap (Red)", "H_Cap_red", 30, "hat"],
	["Cap (Surfer)", "H_Cap_surfer", 30, "hat"],
	["Cap (Tan)", "H_Cap_tan", 30, "hat"],
	["Cap (UK)", "H_Cap_khaki_specops_UK", 30, "hat"],
	["Cap (US Black)", "H_Cap_usblack", 30, "hat"],
	["Cap (US MTP)", "H_Cap_tan_specops_US", 30, "hat"],
	["Cap (AAF)", "H_Cap_blk_Raven", 30, "hat"],
	["Cap (OPFOR)", "H_Cap_brn_SPECOPS", 30, "hat"],
	["Cap (White) [IDAP]", "H_Cap_White_IDAP_F", 30, "hat", "noDLC"],
	["Cap (Orange) [IDAP]", "H_Cap_Orange_IDAP_F", 30, "hat", "noDLC"],
	["Cap (Black) [IDAP]", "H_Cap_Black_IDAP_F", 30, "hat", "noDLC"],
	["Military Cap (Blue)", "H_MilCap_blue", 45, "hat"],
	["Military Cap (Gray)", "H_MilCap_gry", 45, "hat"],
	["Military Cap (Urban)", "H_MilCap_oucamo", 45, "hat"],
	["Military Cap (Russia)", "H_MilCap_rucamo", 45, "hat"],
	["Military Cap (MTP)", "H_MilCap_mcamo", 45, "hat"],
	["Military Cap (Hex)", "H_MilCap_ocamo", 45, "hat"],
	["Military Cap (AAF)", "H_MilCap_dgtl", 45, "hat"],
	["Military Cap (Tropic)", "H_MilCap_tna_F", 45, "hat", "noDLC"],
	["Military Cap (Green Hex)", "H_MilCap_ghex_F", 45, "hat", "noDLC"],
	["Military Cap (Gendarmerie)", "H_MilCap_gen_F", 45, "hat", "noDLC"],
	["Rangemaster Cap", "H_Cap_headphones", 45, "hat"],
	["Marshal Cap", "H_Cap_marshal", 45, "hat"],
	["Shemag (Olive)", "H_Shemag_olive", 45, "hat"],
	["Shemag (Olive, Headset)", "H_Shemag_olive_hs", 45, "hat"],
	["Shemag (Tan)", "H_ShemagOpen_tan", 45, "hat"],
	["Shemag (White)", "H_ShemagOpen_khk", 45, "hat"],
	["Racing Helmet (Black)", "H_RacingHelmet_1_black_F", 45, "hat"],
	["Racing Helmet (Blue)", "H_RacingHelmet_1_blue_F", 45, "hat"],
	["Racing Helmet (Green)", "H_RacingHelmet_1_green_F", 45, "hat"],
	["Racing Helmet (Yellow)", "H_RacingHelmet_1_yellow_F", 45, "hat"],
	["Racing Helmet (Orange)", "H_RacingHelmet_1_orange_F", 45, "hat"],
	["Racing Helmet (Red)", "H_RacingHelmet_1_red_F", 45, "hat"],
	["Racing Helmet (White)", "H_RacingHelmet_1_white_F", 45, "hat"],
	["Racing Helmet (Fuel)", "H_RacingHelmet_1_F", 45, "hat"],
	["Racing Helmet (Bluking)", "H_RacingHelmet_2_F", 45, "hat"],
	["Racing Helmet (Redstone)", "H_RacingHelmet_3_F", 45, "hat"],
	["Racing Helmet (Vrana)", "H_RacingHelmet_4_F", 45, "hat"],
	["Hard Hat (Yellow)", "H_Construction_basic_yellow_F", 25, "hat", "noDLC"],
	["Hard Hat (White)", "H_Construction_basic_white_F", 25, "hat", "noDLC"],
	["Hard Hat (Orange)", "H_Construction_basic_orange_F", 25, "hat", "noDLC"],
	["Hard Hat (Red)", "H_Construction_basic_red_F", 25, "hat", "noDLC"],
	["Hard Hat (Vrana)", "H_Construction_basic_vrana_F", 25, "hat", "noDLC"],
	["Hard Hat (Black)", "H_Construction_basic_black_F", 25, "hat", "noDLC"],
	["Hard Hat (Yellow, Ear Protectors)", "H_Construction_earprot_yellow_F", 25, "hat", "noDLC"],
	["Hard Hat (White, Ear Protectors)", "H_Construction_earprot_white_F", 25, "hat", "noDLC"],
	["Hard Hat (Orange, Ear Protectors)", "H_Construction_earprot_orange_F", 25, "hat", "noDLC"],
	["Hard Hat (Red, Ear Protectors)", "H_Construction_earprot_red_F", 25, "hat", "noDLC"],
	["Hard Hat (Vrana, Ear Protectors)", "H_Construction_earprot_vrana_F", 25, "hat", "noDLC"],
	["Hard Hat (Black, Ear Protectors)", "H_Construction_earprot_black_F", 25, "hat", "noDLC"],
	["Hard Hat (Yellow, Headset)", "H_Construction_headset_yellow_F", 25, "hat", "noDLC"],
	["Hard Hat (White, Headset)", "H_Construction_headset_white_F", 25, "hat", "noDLC"],
	["Hard Hat (Orange, Headset)", "H_Construction_headset_orange_F", 25, "hat", "noDLC"],
	["Hard Hat (Red, Headset)", "H_Construction_headset_red_F", 25, "hat", "noDLC"],
	["Hard Hat (Vrana, Headset)", "H_Construction_headset_vrana_F", 25, "hat", "noDLC"],
	["Hard Hat (Black, Headset)", "H_Construction_headset_black_F", 25, "hat", "noDLC"],
	["Tin Foil Hat", "H_Hat_Tinfoil_F", 666, "hat", "noDLC"],
	["Skate Helmet", "H_Helmet_Skate", 30, "hat", "noDLC"]
];

uniformArray = compileFinal str
[
	["Wetsuit", "U_B_Wetsuit", 1750, "uni"],
	["Wetsuit", "U_O_Wetsuit", 1750, "uni"],
	["Wetsuit", "U_I_Wetsuit", 1750, "uni"],
	["Gendarmerie Commander Uniform", "U_B_GEN_Commander_F", 200, "uni", "noDLC"],
	["Gendarmerie Uniform", "U_B_GEN_Soldier_F", 200, "uni", "noDLC"],
	["Gendarmerie Commander Uniform", "U_O_GEN_Commander_F", 200, "uni", "noDLC"],
	["Gendarmerie Uniform", "U_O_GEN_Soldier_F", 200, "uni", "noDLC"],
	["Light Ghillie", "U_B_GhillieSuit", 1750, "uni"],
	["Light Ghillie", "U_O_GhillieSuit", 1750, "uni"],
	["Light Ghillie", "U_I_GhillieSuit", 1750, "uni"],
	["Light Ghillie (Jungle)", "U_B_T_Sniper_F", 1750, "uni", "noDLC"],
	["Light Ghillie (Jungle)", "U_O_T_Sniper_F", 1750, "uni", "noDLC"],
	["Full Ghillie (Arid)", "U_B_FullGhillie_ard", 3000, "uni", "noDLC"],
	["Full Ghillie (Arid)", "U_O_FullGhillie_ard", 3000, "uni", "noDLC"],
	["Full Ghillie (Arid)", "U_I_FullGhillie_ard", 3000, "uni", "noDLC"],
	["Full Ghillie (Lush)", "U_B_FullGhillie_lsh", 3000, "uni", "noDLC"],
	["Full Ghillie (Lush)", "U_O_FullGhillie_lsh", 3000, "uni", "noDLC"],
	["Full Ghillie (Lush)", "U_I_FullGhillie_lsh", 3000, "uni", "noDLC"],
	["Full Ghillie (Semi-Arid)", "U_B_FullGhillie_sard", 3000, "uni", "noDLC"],
	["Full Ghillie (Semi-Arid)", "U_O_FullGhillie_sard", 3000, "uni", "noDLC"],
	["Full Ghillie (Semi-Arid)", "U_I_FullGhillie_sard", 3000, "uni", "noDLC"],
	["Full Ghillie (Jungle)", "U_B_T_FullGhillie_tna_F", 3000, "uni", "noDLC"],
	["Full Ghillie (Jungle)", "U_O_T_FullGhillie_tna_F", 3000, "uni", "noDLC"],
	["Special Purpose Suit (Hex)", "U_O_V_Soldier_Viper_hex_F", 1500, "uni", "noDLC"],
	["Special Purpose Suit (G Hex)", "U_O_V_Soldier_Viper_F", 1500, "uni", "noDLC"],
	["Survival Fatigues (NATO)", "U_B_survival_uniform", 400, "uni"],
	["CBRN Suit (AAF)", "U_I_CBRN_Suit_01_AAF_F", 500, "uni", "noDLC"],
	["CBRN Suit (Blue)", "U_C_CBRN_Suit_01_Blue_F", 500, "uni", "noDLC"],
	["CBRN Suit (LDF)", "U_I_E_CBRN_Suit_01_EAF_F", 500, "uni", "noDLC"],
	["CBRN Suit (MTP)", "U_B_CBRN_Suit_01_MTP_F", 500, "uni", "noDLC"],
	["CBRN Suit (Tropic)", "U_B_CBRN_Suit_01_Tropic_F", 500, "uni", "noDLC"],
	["CBRN Suit (White)", "U_C_CBRN_Suit_01_White_F", 500, "uni", "noDLC"],
	["CBRN Suit (Woodland)", "U_B_CBRN_Suit_01_Wdl_F", 500, "uni", "noDLC"],
	["Granit-B Suit", "U_O_R_Gorka_01_F", 500, "uni", "noDLC"],
	["Granit-B Suit (Weathered)", "U_O_R_Gorka_01_brown_F", 500, "uni", "noDLC"],
	["Granit-T Suit", "U_O_R_Gorka_01_camo_F", 500, "uni", "noDLC"],
	["Granit-N Suit", "U_O_R_Gorka_01_black_F", 500, "uni", "noDLC"],
	["Default Uniform (NATO)", "U_B_CombatUniform_mcam", 300, "uni"],
	["Default Uniform (CSAT)", "U_O_officer_noInsignia_hex_F", 300, "uni", "noDLC"],
	["Default Uniform (AAF)", "U_I_CombatUniform", 300, "uni"],
	["Combat Fatigues (MTP, Tee)", "U_B_CombatUniform_mcam_tshirt", 450, "uni"],
	["Combat Fatigues (Tropic)", "U_B_T_Soldier_F", 450, "uni", "noDLC"],
	["Combat Fatigues (Tropic, Tee)", "U_B_T_Soldier_AR_F", 450, "uni", "noDLC"],
	["Combat Fatigues (Woodland)", "U_B_CombatUniform_mcam_wdl_f", 450, "uni", "noDLC"],
	["Combat Fatigues (Woodland, Tee)", "U_B_CombatUniform_tshirt_mcam_wdL_f", 450, "uni", "noDLC"],
	["Combat Fatigues [LDF]", "U_I_E_Uniform_01_F", 450, "uni", "noDLC"],
	["Combat Fatigues (Rolled-up)[LDF]", "U_I_E_Uniform_01_shortsleeve_F", 450, "uni", "noDLC"],
	["Combat Fatigues (Sweater)[LDF]", "U_I_E_Uniform_01_sweater_F", 450, "uni", "noDLC"],
	["Combat Fatigues (Tank Top)[LDF]", "U_I_E_Uniform_01_tanktop_F", 450, "uni", "noDLC"],
	["Combat Fatigues (Gangsta)", "U_I_G_resistanceLeader_F", 450, "uni"],
	["Combat Fatigues (Rolled-up)", "U_I_CombatUniform_shortsleeve", 450, "uni"],
	["Recon Fatigues (MTP)", "U_B_CombatUniform_mcam_vest", 450, "uni"],
	["Recon Fatigues (Tropic)", "U_B_T_Soldier_SL_F", 450, "uni", "noDLC"],
	["Recon Fatigues (Woodland)", "U_B_CombatUniform_vest_mcam_wdl_f", 450, "uni", "noDLC"],
	["Recon Fatigues (Hex)", "U_O_SpecopsUniform_ocamo", 450, "uni"],
	["CTRG Combat Uniform", "U_B_CTRG_1", 550, "uni", "noDLC"],
	["CTRG Combat Uniform (Tee)", "U_B_CTRG_2", 550, "uni", "noDLC"],
	["CTRG Combat Uniform (Rolled-up)", "U_B_CTRG_3", 550, "uni", "noDLC"],
	["CTRG Stealth Uniform", "U_B_CTRG_Soldier_F", 2000, "uni", "noDLC"],
	["CTRG Stealth Uniform (Rolled-up)", "U_B_CTRG_Soldier_3_F", 1250, "uni", "noDLC"],
	["CTRG Stealth Uniform (Tee)", "U_B_CTRG_Soldier_2_F", 1250, "uni", "noDLC"],
	["CTRG Stealth Uniform (Arid)", "U_B_CTRG_Soldier_Arid_F", 1250, "uni", "noDLC"],
	["CTRG Stealth Uniform (Tee, Arid)", "U_B_CTRG_Soldier_2_Arid_F", 1250, "uni", "noDLC"],
	["CTRG Stealth Uniform (Rolled-up, Arid)", "U_B_CTRG_Soldier_3_Arid_F", 1250, "uni", "noDLC"],
	["CTRG Urban Uniform", "U_B_CTRG_Soldier_urb_1_F", 1250, "uni", "noDLC"],
	["CTRG Urban Uniform (Tee)", "U_B_CTRG_Soldier_urb_2_F", 1250, "uni", "noDLC"],
	["CTRG Urban Uniform (Rolled-up)", "U_B_CTRG_Soldier_urb_3_F", 1250, "uni", "noDLC"],
	["Fatigues (Hex)", "U_O_CombatUniform_ocamo", 700, "uni"],
	["Fatigues (Urban)", "U_O_CombatUniform_oucamo", 700, "uni"],
	["Fatigues (G Hex)", "U_O_T_Soldier_F", 700, "uni", "noDLC"],
	["Officer Fatigues", "U_I_OfficerUniform", 550, "uni"],
	["Officer Fatigues (Green Hex) [CSAT]", "U_O_T_Officer_F", 550, "uni", "noDLC"],
	["Officer Fatigues (Hex)", "U_O_OfficerUniform_ocamo", 550, "uni"],
	["Officer Fatigues [LDF]", "U_I_E_Uniform_01_officer_F", 550, "uni", "noDLC"],
	["Pilot Coveralls", "U_B_PilotCoveralls", 750, "uni"],
	["Pilot Coveralls", "U_O_PilotCoveralls", 750, "uni"],
	["Pilot Coveralls", "U_I_pilotCoveralls", 750, "uni"],
	["Heli Pilot Coveralls [NATO]", "U_B_HeliPilotCoveralls", 500, "uni"],
	["Heli Pilot Coveralls [AAF]", "U_I_HeliPilotCoveralls", 500, "uni"],
	["Heli Pilot Coveralls {LDF}", "U_I_E_Uniform_01_coveralls_F", 500, "uni"],
	["Tank Coveralls [AAF]", "U_Tank_green_F", 250, "uni", "noDLC"],
	["Syndikat Uniform", "U_I_C_Soldier_Camo_F", 200, "uni", "noDLC"],
	["Paramilitary Garb (Tee)", "U_I_C_Soldier_Para_1_F", 200, "uni", "noDLC"],
	["Paramilitary Garb (Jacket)", "U_I_C_Soldier_Para_2_F", 200, "uni", "noDLC"],
	["Paramilitary Garb (Shirt)", "U_I_C_Soldier_Para_3_F", 200, "uni", "noDLC"],
	["Paramilitary Garb (Tank Top)", "U_I_C_Soldier_Para_4_F", 200, "uni", "noDLC"],
	["Paramilitary Garb (Shorts)", "U_I_C_Soldier_Para_5_F", 200, "uni", "noDLC"],
	["Bandit Clothes (Polo Shirt)", "U_I_C_Soldier_Bandit_1_F", 200, "uni", "noDLC"],
	["Bandit Clothes (Skull)", "U_I_C_Soldier_Bandit_2_F", 200, "uni", "noDLC"],
	["Bandit Clothes (Tee)", "U_I_C_Soldier_Bandit_3_F", 200, "uni", "noDLC"],
	["Bandit Clothes (Checkered)", "U_I_C_Soldier_Bandit_4_F", 200, "uni", "noDLC"],
	["Bandit Clothes (Tank Top)", "U_I_C_Soldier_Bandit_5_F", 200, "uni", "noDLC"],
	["Looter Clothes (Leather Jacket)", "U_C_E_LooterJacket_01_F", 200, "uni", "noDLC"],
	["Deserter Clothes (Jacket)", "U_I_L_Uniform_01_camo_F", 200, "uni", "noDLC"],
	["Deserter Clothes (T-Shirt)", "U_I_L_Uniform_01_deserter_F", 200, "uni", "noDLC"],
	["Looter Clothes (T-Shirt, Black)", "U_I_L_Uniform_01_tshirt_black_F", 200, "uni", "noDLC"],
	["Looter Clothes (T-Shirt, Olive)", "U_I_L_Uniform_01_tshirt_olive_F", 200, "uni", "noDLC"],
	["Looter Clothes (T-Shirt, Skull)", "U_I_L_Uniform_01_tshirt_skull_F", 200, "uni", "noDLC"],
	["Looter Clothes (T-Shirt, Sport)", "U_I_L_Uniform_01_tshirt_sport_F", 200, "uni", "noDLC"],
	["Guerilla Garment", "U_BG_Guerilla1_1", 150, "uni"],  // BLUFOR
	["Guerilla Outfit (Plain, Dark)", "U_BG_Guerilla2_1", 150, "uni"],
	["Guerilla Outfit (Pattern)", "U_BG_Guerilla2_2", 150, "uni"],
	["Guerilla Outfit (Plain, Light)", "U_BG_Guerilla2_3", 150, "uni"],
	["Guerilla Smocks", "U_BG_Guerilla3_1", 150, "uni"],
	["Guerilla Apparel", "U_BG_Guerrilla_6_1", 150, "uni"],
	["Guerilla Uniform", "U_BG_leader", 150, "uni"],
	["Guerilla Garment", "U_OG_Guerilla1_1", 150, "uni"], // OPFOR
	["Guerilla Outfit (Plain, Dark)", "U_OG_Guerilla2_1", 150, "uni"],
	["Guerilla Outfit (Pattern)", "U_OG_Guerilla2_2", 150, "uni"],
	["Guerilla Outfit (Plain, Light)", "U_OG_Guerilla2_3", 150, "uni"],
	["Guerilla Smocks", "U_OG_Guerilla3_1", 150, "uni"],
	["Guerilla Apparel", "U_OG_Guerrilla_6_1", 150, "uni"],
	["Guerilla Uniform", "U_OG_leader", 150, "uni"],
	["Guerilla Garment", "U_IG_Guerilla1_1", 150, "uni"], // Independent
	["Guerilla Garment (Olive)", "U_BG_Guerilla1_2_F", 150, "uni", "noDLC"], // Independent
	["Guerilla Outfit (Plain, Dark)", "U_IG_Guerilla2_1", 150, "uni"],
	["Guerilla Outfit (Pattern)", "U_IG_Guerilla2_2", 150, "uni"],
	["Guerilla Outfit (Plain, Light)", "U_IG_Guerilla2_3", 150, "uni"],
	["Guerilla Smocks", "U_IG_Guerilla3_1", 150, "uni"],
	["Guerilla Apparel", "U_IG_Guerrilla_6_1", 150, "uni"],
	["Guerilla Uniform", "U_IG_leader", 150, "uni"],
	["Polo (Competitor)", "U_Competitor", 150, "uni"],
	["Polo (Rangemaster)", "U_Rangemaster", 150, "uni"],
	["Jacket and Shorts", "U_OrestesBody", 150, "uni"],
	["Marshal Clothes", "U_Marshal", 150, "uni"],
	["Parade Uniform [US]", "U_B_ParadeUniform_01_US_F", 1000, "uni", "noDLC"],
	["Parade Uniform [LDF]", "U_I_E_ParadeUniform_01_LDF_F", 1000, "uni", "noDLC"],
	["Parade Uniform [CSAT]", "U_O_ParadeUniform_01_CSAT_F", 1000, "uni", "noDLC"],
	["Parade Uniform [AAF]", "U_I_ParadeUniform_01_AAF_decorated_F", 1000, "uni", "noDLC"],
	["Parade Uniform (Decorated)[US]", "U_B_ParadeUniform_01_US_decorated_F", 1100, "uni", "noDLC"],
	["Parade Uniform (Decorated)[LDF]", "U_I_E_ParadeUniform_01_LDF_decorated_F", 1100, "uni", "noDLC"],
	["Parade Uniform (Decorated)[CSAT]", "U_O_ParadeUniform_01_CSAT_decorated_F", 1100, "uni", "noDLC"],
	["Parade Uniform (Decorated)[AAF]", "U_I_ParadeUniform_01_AAF_F", 1100, "uni", "noDLC"],
	["Tron Light Suit (Blue)", "U_B_Protagonist_VR", 15000, "uni"],
	["Tron Light Suit (Red)", "U_O_Protagonist_VR", 15000, "uni"],
	["Tron Light Suit (Green)", "U_I_Protagonist_VR", 15000, "uni"],
	["Tron Light Suit [Civilians]", "U_C_Protagonist_VR", 15000, "uni"],
	["Nikos Clothes", "U_NikosBody", 100, "uni"],
	["Commoner Clothes (Blue)", "U_C_Poloshirt_blue", 100, "uni"],
	["Commoner Clothes (Burgundy)", "U_C_Poloshirt_burgundy", 100, "uni"],
	["Commoner Clothes (Striped)", "U_C_Poloshirt_stripped", 100, "uni"],
	["Commoner Clothes (Tricolor)", "U_C_Poloshirt_tricolour", 100, "uni"],
	["Commoner Clothes (Salmon)", "U_C_Poloshirt_salmon", 100, "uni"],
	["Commoner Clothes (Red-White)", "U_C_Poloshirt_redwhite", 100, "uni"],
	["Sport Clothes (Beach)", "U_C_man_sport_1_F", 100, "uni", "noDLC"],
	["Sport Clothes (Orange)", "U_C_man_sport_2_F", 100, "uni", "noDLC"],
	["Sport Clothes (Blue)", "U_C_man_sport_3_F", 100, "uni", "noDLC"],
	["Casual Clothes (Navy)", "U_C_Man_casual_1_F", 100, "uni", "noDLC"],
	["Casual Clothes (Blue)", "U_C_Man_casual_2_F", 100, "uni", "noDLC"],
	["Casual Clothes (Green)", "U_C_Man_casual_3_F", 100, "uni", "noDLC"],
	["Casual Clothes (Art of War)", "U_C_ArtTShirt_01_v1_F", 100, "uni", "noDLC"],
	["Casual Clothes (Drones)", "U_C_ArtTShirt_01_v2_F", 100, "uni", "noDLC"],
	["Casual Clothes (Waltham Robotics)", "U_C_ArtTShirt_01_v3_F", 100, "uni", "noDLC"],
	["Casual Clothes (Exhibition)", "U_C_ArtTShirt_01_v4_F", 100, "uni", "noDLC"],
	["Casual Clothes (Robogeddon)", "U_C_ArtTShirt_01_v5_F", 100, "uni", "noDLC"],
	["Casual Clothes (Abstract)", "U_C_ArtTShirt_01_v6_F", 100, "uni", "noDLC"],
	["Worn Clothes", "U_C_Poor_1", 100, "uni"],
	["Summer Clothes (Sky)", "U_C_Man_casual_4_F", 100, "uni", "noDLC"],
	["Summer Clothes (Yellow)", "U_C_Man_casual_5_F", 100, "uni", "noDLC"],
	["Summer Clothes (Red)", "U_C_Man_casual_6_F", 100, "uni", "noDLC"],
	["Driver Coverall (Fuel)", "U_C_Driver_1", 150, "uni", "noDLC"],
	["Driver Coverall (Bluking)", "U_C_Driver_2", 150, "uni", "noDLC"],
	["Driver Coverall (Redstone)", "U_C_Driver_3", 150, "uni", "noDLC"],
	["Driver Coverall (Vrana)", "U_C_Driver_4", 150, "uni", "noDLC"],
	["Driver Coverall (Black)", "U_C_Driver_1_black", 150, "uni", "noDLC"],
	["Driver Coverall (Blue)", "U_C_Driver_1_blue", 150, "uni", "noDLC"],
	["Driver Coverall (Green)", "U_C_Driver_1_green", 150, "uni", "noDLC"],
	["Driver Coverall (Red)", "U_C_Driver_1_red", 150, "uni", "noDLC"],
	["Driver Coverall (White)", "U_C_Driver_1_white", 150, "uni", "noDLC"],
	["Driver Coverall (Yellow)", "U_C_Driver_1_yellow", 150, "uni", "noDLC"],
	["Driver Coverall (Orange)", "U_C_Driver_1_orange", 150, "uni", "noDLC"],
	["Mechanic Clothes", "U_C_Mechanic_01_F", 250, "uni", "noDLC"],
	["Worker Coveralls", "U_C_WorkerCoveralls", 250, "uni", "noDLC"],
	["Hunting Clothes", "U_C_HunterBody_grn", 250, "uni"],
	["Farmer Outfit", "U_C_Uniform_Farmer_01_F", 250, "uni", "noDLC"],
	["Journalist Clothes", "U_C_Journalist", 250, "uni"],
	["Paramedic Outfit", "U_C_Paramedic_01_F", 250, "uni", "noDLC"],
	["Aid Worker Clothes (Polo, Shorts) [IDAP]", "U_C_IDAP_Man_shorts_F", 150, "uni", "noDLC"],
	["Aid Worker Clothes (Polo) [IDAP]", "U_C_IDAP_Man_casual_F", 150, "uni", "noDLC"],
	["Aid Worker Clothes (Cargo) [IDAP]", "U_C_IDAP_Man_cargo_F", 150, "uni", "noDLC"],
	["Aid Worker Clothes (Tee) [IDAP]", "U_C_IDAP_Man_Tee_F", 150, "uni", "noDLC"],
	["Aid Worker Clothes (Jeans) [IDAP]", "U_C_IDAP_Man_Jeans_F", 150, "uni", "noDLC"],
	["Aid Worker Clothes (Tee, Shorts) [IDAP]", "U_C_IDAP_Man_TeeShorts_F", 150, "uni", "noDLC"],
	["Scientist Clothes", "U_C_Scientist", 200, "uni"],
	["Scientist Outfit (Formal, White)", "U_C_Uniform_Scientist_01_F", 200, "uni", "noDLC"],
	["Scientist Outfit (Formal, Blue)", "U_C_Uniform_Scientist_01_formal_F", 200, "uni", "noDLC"],
	["Scientist Outfit (Informal, Black)", "U_C_Uniform_Scientist_02_F", 200, "uni", "noDLC"],
	["Scientist Outfit (Informal, Red)", "U_C_Uniform_Scientist_02_formal_F", 200, "uni", "noDLC"],
	["Construction Coverall (Red)", "U_C_ConstructionCoverall_Red_F", 200, "uni", "noDLC"],
	["Construction Coverall (Vrana)", "U_C_ConstructionCoverall_Vrana_F", 200, "uni", "noDLC"],
	["Construction Coverall (Black)", "U_C_ConstructionCoverall_Black_F", 200, "uni", "noDLC"],
	["Construction Coverall (Blue)", "U_C_ConstructionCoverall_Blue_F", 200, "uni", "noDLC"],
	["Formal Suit (Black)", "U_C_FormalSuit_01_black_F", 1000, "uni", "noDLC"],
	["Formal Suit (Blue)", "U_C_FormalSuit_01_blue_F", 1200, "uni", "noDLC"],
	["Formal Suit (Gray)", "U_C_FormalSuit_01_gray_F", 1200, "uni", "noDLC"],
	["Formal Suit (Khaki)", "U_C_FormalSuit_01_khaki_F", 1000, "uni", "noDLC"],
	["Formal Suit (T-Shirt, Black)", "U_C_FormalSuit_01_tshirt_black_F",950, "uni", "noDLC"],
	["Formal Suit (T-Shirt, Gray)", "U_C_FormalSuit_01_tshirt_gray_F", 950, "uni", "noDLC"]
];

vestArray = compileFinal str
[
	["Rebreather (NATO)", "V_RebreatherB", 1400, "vest"],
	["Rebreather (CSAT)", "V_RebreatherIR", 1400, "vest"],
	["Rebreather (AAF)", "V_RebreatherIA", 1400, "vest"],
	["Carrier Lite (Green)", "V_PlateCarrier1_rgr", -1, "vest"],
	["Carrier Lite (Green, No Flag)", "V_PlateCarrier1_rgr_noflag_F", -1, "vest", "noDLC"],
	["Carrier Lite (Black)", "V_PlateCarrier1_blk", -1, "vest"],
	["Carrier Lite (CTRG)", "V_PlateCarrierL_CTRG", -1, "vest"],
	["Carrier Lite (Tropic)", "V_PlateCarrier1_tna_F", -1, "vest", "noDLC"],
	["Carrier Lite (Woodland)", "V_PlateCarrier1_wdl", -1, "vest", "noDLC"],
	["Carrier Rig (Green)", "V_PlateCarrier2_rgr", -1, "vest"],
	["Carrier Rig (Black)", "V_PlateCarrier2_blk", -1, "vest"],
	["Carrier Rig (CTRG)", "V_PlateCarrierH_CTRG", -1, "vest"],
	["Carrier Rig (Tropic)", "V_PlateCarrier2_tna_F", -1, "vest", "noDLC"],
	["Carrier Rig (Woodland)", "V_PlateCarrier2_wdl", -1, "vest", "noDLC"],
	["Carrier Rig (Green, No Flag)", "V_PlateCarrier2_rgr_noflag_F", -1, "vest", "noDLC"],
	["Carrier GL Rig (Green)", "V_PlateCarrierGL_rgr", -1, "vest"],
	["Carrier GL Rig (Black)", "V_PlateCarrierGL_blk", -1, "vest"],
	["Carrier GL Rig (MTP)", "V_PlateCarrierGL_mtp", -1, "vest"],
	["Carrier GL Rig (Tropic)", "V_PlateCarrierGL_tna_F", -1, "vest", "noDLC"],
	["Carrier GL Rig (Woodland)", "V_PlateCarrierGL_wdl", -1, "vest", "noDLC"],
	["Carrier Special Rig (Green)", "V_PlateCarrierSpec_rgr", -1, "vest"],
	["Carrier Special Rig (Black)", "V_PlateCarrierSpec_blk", -1, "vest"],
	["Carrier Special Rig (MTP)", "V_PlateCarrierSpec_mtp", -1, "vest"],
	["Carrier Special Rig (Tropic)", "V_PlateCarrierSpec_tna_F", -1, "vest", "noDLC"],
	["Carrier Special Rig (Woodland)", "V_PlateCarrierSpec_wdl", -1, "vest", "noDLC"],
	["GA Carrier Lite (Digi)", "V_PlateCarrierIA1_dgtl", -1, "vest"],
	["GA Carrier Rig (Digi)", "V_PlateCarrierIA2_dgtl", -1, "vest"],
	["GA Carrier GL Rig (Digi)", "V_PlateCarrierIAGL_dgtl", -1, "vest"],
	["GA Carrier GL Rig (Olive)", "V_PlateCarrierIAGL_oli", -1, "vest"],
	["Modular Carrier GL Rig (LDF)", "V_CarrierRigKBT_01_heavy_EAF_F", -1, "vest", "noDLC"],
	["Modular Carrier GL Rig (Olive)", "V_CarrierRigKBT_01_heavy_Olive_F", -1, "vest", "noDLC"],
	["Modular Carrier Lite (LDF)", "V_CarrierRigKBT_01_light_EAF_F", -1, "vest", "noDLC"],
	["Modular Carrier Lite (Olive)", "V_CarrierRigKBT_01_light_Olive_F", -1, "vest", "noDLC"],
	["Modular Carrier Vest (LDF)", "V_CarrierRigKBT_01_EAF_F", -1, "vest", "noDLC"],
	["Modular Carrier Vest (Olive)", "V_CarrierRigKBT_01_Olive_F", -1, "vest", "noDLC"],
	["LBV Harness", "V_HarnessO_brn", -1, "vest"],
	["LBV Harness (Gray)", "V_HarnessO_gry", -1, "vest"],
	["LBV Harness (Green Hex)", "V_HarnessO_ghex_F", -1, "vest", "noDLC"],
	["LBV Grenadier Harness", "V_HarnessOGL_brn", -1, "vest"],
	["LBV Grenadier Harness (Gray)", "V_HarnessOGL_gry", -1, "vest"],
	["LBV Grenadier Harness (Green Hex)", "V_HarnessOGL_ghex_F", -1, "vest", "noDLC"],
	["Rangemaster Belt", "V_Rangemaster_belt", -1, "vest"],
	["Kipchak Vest", "V_SmershVest_01_F", -1, "vest", "noDLC"],
	["Kipchak Vest (Tactical Radio)", "V_SmershVest_01_radio_F", -1, "vest", "noDLC"],
	["Slash Bandolier (Black)", "V_BandollierB_blk", -1, "vest"],
	["Slash Bandolier (Coyote)", "V_BandollierB_cbr", -1, "vest"],
	["Slash Bandolier (Green)", "V_BandollierB_rgr", -1, "vest"],
	["Slash Bandolier (Khaki)", "V_BandollierB_khk", -1, "vest"],
	["Slash Bandolier (Olive)", "V_BandollierB_oli", -1, "vest"],
	["Slash Bandolier (Green Hex)", "V_BandollierB_ghex_F", -1, "vest", "noDLC"],
	["Chest Rig (Khaki)", "V_Chestrig_khk", -1, "vest"],
	["Chest Rig (Green)", "V_Chestrig_rgr", -1, "vest"],
	["EOD Vest (Blue)", "V_EOD_blue_F", -1, "vest", "noDLC"],
	["EOD Vest (Coyote)", "V_EOD_coyote_F", -1, "vest", "noDLC"],
	["EOD Vest (Olive)", "V_EOD_olive_F", -1, "vest", "noDLC"],
	["EOD Vest (Blue) [IDAP]", "V_EOD_IDAP_blue_F", -1, "vest", "noDLC"],
	["Safety Vest (Yellow)", "V_Safety_yellow_F", -1, "vest", "noDLC"],
	["Safety Vest (Orange)", "V_Safety_orange_F", -1, "vest", "noDLC"],
	["Safety Vest (Blue)", "V_Safety_blue_F", -1, "vest", "noDLC"],
	["Fighter Chestrig (Black)", "V_Chestrig_blk", -1, "vest"],
	["Fighter Chestrig (Olive)", "V_Chestrig_oli", -1, "vest"],
	["Tactical Vest (Black)", "V_TacVest_blk", -1, "vest"],
	["Tactical Vest (Brown)", "V_TacVest_brn", -1, "vest"],
	["Tactical Vest (Camo)", "V_TacVest_camo", -1, "vest"],
	["Tactical Vest (Khaki)", "V_TacVest_khk", -1, "vest"],
	["Tactical Vest (Olive)", "V_TacVest_oli", -1, "vest"],
	["Tactical Vest (Police)", "V_TacVest_blk_POLICE", -1, "vest"],
	["Tactical Vest (Stavrou)", "V_I_G_resistanceLeader_F", -1, "vest"],
	["Gendarmerie Vest", "V_TacVest_gen_F", -1, "vest", "noDLC"],
	["Raven Night Vest", "V_TacVestIR_blk", -1, "vest"],
	["Press Vest", "V_Press_F", -1, "vest"],
	["Identification Vest [IDAP]", "V_Plain_medical_F", -1, "vest", "noDLC"],
	["Identification Vest (Red Crystal)", "V_Plain_crystal_F", -1, "vest", "noDLC"],
	["Leg Strap Bag (Black)", "V_LegStrapBag_black_F", -1, "vest", "noDLC"],
	["Leg Strap Bag (Coyote)", "V_LegStrapBag_coyote_F", -1, "vest", "noDLC"],
	["Leg Strap Bag (Olive)", "V_LegStrapBag_olive_F", -1, "vest", "noDLC"],
	
	["Tactical Chest Rig (Coyote)", "V_TacChestrig_cbr_F", -1, "vest", "noDLC"],
	["Tactical Chest Rig (Green)", "V_TacChestrig_grn_F", -1, "vest", "noDLC"],
	["Tactical Chest Rig (Olive)", "V_TacChestrig_oli_F", -1, "vest", "noDLC"],
	["Multi-Pocket Vest (Olive)", "V_Pocketed_olive_F", -1, "vest", "noDLC"],
	["Multi-Pocket Vest (Coyote)", "V_Pocketed_coyote_F", -1, "vest", "noDLC"],
	["Multi-Pocket Vest (Black)", "V_Pocketed_black_F", -1, "vest", "noDLC"],

	["Deck Crew Vest (Blue)", "V_DeckCrew_blue_F", -1, "vest", "noDLC"],
	["Deck Crew Vest (Green)", "V_DeckCrew_green_F", -1, "vest", "noDLC"],
	["Deck Crew Vest (Yellow)", "V_DeckCrew_yellow_F", -1, "vest", "noDLC"],
	["Deck Crew Vest (Red)", "V_DeckCrew_red_F", -1, "vest", "noDLC"],
	["Deck Crew Vest (Brown)", "V_DeckCrew_brown_F", -1, "vest", "noDLC"],
	["Deck Crew Vest (Violet)", "V_DeckCrew_violet_F", -1, "vest", "noDLC"],
	["Deck Crew Vest (White)", "V_DeckCrew_white_F", -1, "vest", "noDLC"]
];

backpackArray = compileFinal str
[
	//["Parachute", "B_Parachute", 200, "backpack"],

	["Assault Pack (Black)", "B_AssaultPack_blk", 300, "backpack"],
	["Assault Pack (Coyote)", "B_AssaultPack_cbr", 300, "backpack"],
	["Assault Pack (Digital)", "B_AssaultPack_dgtl", 300, "backpack"],
	["Assault Pack (Geometric)", "B_AssaultPack_eaf_F", 300, "backpack", "noDLC"],
	["Assault Pack (Hex)", "B_AssaultPack_ocamo", 300, "backpack"],
	["Assault Pack (Khaki)", "B_AssaultPack_khk", 300, "backpack"],
	["Assault Pack (Green)", "B_AssaultPack_rgr", 300, "backpack"],
	["Assault Pack (MTP)", "B_AssaultPack_mcamo", 300, "backpack"],
	["Assault Pack (Sage)", "B_AssaultPack_sgg", 300, "backpack"],
	["Assault Pack (Tropic)", "B_AssaultPack_tna_F", 300, "backpack", "noDLC"],
	["Assault Pack (Woodland)", "B_AssaultPack_wdl_F", 300, "backpack", "noDLC"],

	["Field Pack (Black)", "B_FieldPack_blk", 400, "backpack"],
	["Field Pack (Coyote)", "B_FieldPack_cbr", 400, "backpack"],
	["Field Pack (Khaki)", "B_FieldPack_khk", 400, "backpack"],
	["Field Pack (Green)", "B_FieldPack_green_F", 400, "backpack", "noDLC"],
	["Field Pack (Olive)", "B_FieldPack_oli", 400, "backpack"],
	["Field Pack (Urban)", "B_FieldPack_oucamo", 400, "backpack"],
	["Field Pack (Hex)", "B_FieldPack_ocamo", 400, "backpack"],
	["Field Pack (G Hex)", "B_FieldPack_ghex_F", 400, "backpack", "noDLC"],
	["Field Pack (Taiga)", "B_FieldPack_taiga_F", 400, "backpack", "noDLC"],

	["Kitbag (Coyote)", "B_Kitbag_cbr", 550, "backpack"],
	["Kitbag (Green)", "B_Kitbag_rgr", 550, "backpack"],
	["Kitbag (MTP)", "B_Kitbag_mcamo", 550, "backpack"],
	["Kitbag (Sage)", "B_Kitbag_sgg", 550, "backpack"],
	["Kitbag (Tan)", "B_Kitbag_tan", 550, "backpack"],

	["Viper Light Harness (Black)", "B_ViperLightHarness_blk_F", 550, "backpack", "noDLC"],
	["Viper Light Harness (Hex)", "B_ViperLightHarness_hex_F", 550, "backpack", "noDLC"],
	["Viper Light Harness (G Hex)", "B_ViperLightHarness_ghex_F", 550, "backpack", "noDLC"],
	["Viper Light Harness (Khaki)", "B_ViperLightHarness_khk_F", 550, "backpack", "noDLC"],
	["Viper Light Harness (Olive)", "B_ViperLightHarness_oli_F", 550, "backpack", "noDLC"],

	["Viper Harness (Black)", "B_ViperHarness_blk_F", 625, "backpack", "noDLC"],
	["Viper Harness (Hex)", "B_ViperHarness_hex_F", 625, "backpack", "noDLC"],
	["Viper Harness (G Hex)", "B_ViperHarness_ghex_F", 625, "backpack", "noDLC"],
	["Viper Harness (Khaki)", "B_ViperHarness_khk_F", 625, "backpack", "noDLC"],
	["Viper Harness (Olive)", "B_ViperHarness_oli_F", 625, "backpack", "noDLC"],

	["Carryall (Khaki)", "B_Carryall_khk", 900, "backpack"],
	["Carryall (MTP)", "B_Carryall_mcamo", 900, "backpack"],
	["Carryall Backpack (Coyote)", "B_Carryall_cbr", 900, "backpack"],
	["Carryall (Olive)", "B_Carryall_oli", 900, "backpack"],
	["Carryall (Urban)", "B_Carryall_oucamo", 900, "backpack"],
	["Carryall Backpack (Hex)", "B_Carryall_ocamo", 900, "backpack"],
	["Carryall (G Hex)", "B_Carryall_ghex_F", 900, "backpack", "noDLC"],
	["Carryall Backpack (Green)", "B_Carryall_green_F", 900, "backpack", "noDLC"],
	["Carryall Backpack (Taiga)", "B_Carryall_taiga_F", 900, "backpack", "noDLC"],
	["Carryall Backpack (Woodland)", "B_Carryall_wdl_F", 900, "backpack", "noDLC"],
	["Carryall Backpack (Geometric)", "B_Carryall_eaf_F", 900, "backpack", "noDLC"],

	["Tactical Backpack (Green)", "B_TacticalPack_rgr", 700, "backpack"],
	["Tactical Backpack (Black)", "B_TacticalPack_blk", 700, "backpack"],
	["Tactical Backpack (Hex)", "B_TacticalPack_ocamo", 700, "backpack", "noDLC"],
	["Tactical Backpack (MTP)", "B_TacticalPack_mcamo", 700, "backpack", "noDLC"],
	["Tactical Backpack (Olive)", "B_TacticalPack_oli", 700, "backpack", "noDLC"],

	["Everyday Backpack (Astra)", "B_CivilianBackpack_01_Everyday_Astra_F", 450, "backpack", "noDLC"],
	["Everyday Backpack (Black)", "B_CivilianBackpack_01_Everyday_Black_F", 450, "backpack", "noDLC"],
	["Everyday Backpack (Vrana)", "B_CivilianBackpack_01_Everyday_Vrana_F", 450, "backpack", "noDLC"],
	["Everyday Backpack (IDAP)", "B_CivilianBackpack_01_Everyday_IDAP_F", 450, "backpack", "noDLC"],

	["Sport Backpack (Blue)", "B_CivilianBackpack_01_Sport_Blue_F", 475, "backpack", "noDLC"],
	["Sport Backpack (Green)", "B_CivilianBackpack_01_Sport_Green_F", 475, "backpack", "noDLC"],
	["Sport Backpack (Red)", "B_CivilianBackpack_01_Sport_Red_F", 475, "backpack", "noDLC"],

	["Bergen (Digital)", "B_Bergen_dgtl_F", 3000, "backpack", "noDLC"],
	["Bergen (Hex)", "B_Bergen_hex_F", 3000, "backpack", "noDLC"],
	["Bergen (MTP)", "B_Bergen_mcamo_F", 3000, "backpack", "noDLC"],
	["Bergen (Tropic)", "B_Bergen_tna_F", 3000, "backpack", "noDLC"],
	
	["Messenger Bag (Black)", "B_Messenger_Black_F", 175, "backpack", "noDLC"],
	["Messenger Bag (Coyote)", "B_Messenger_Coyote_F", 175, "backpack", "noDLC"],
	["Messenger Bag (Grey)", "B_Messenger_Gray_F", 175, "backpack", "noDLC"],
	["Messenger Bag (Olive)", "B_Messenger_Olive_F", 175, "backpack", "noDLC"],
	["Messenger Bag (IDAP)", "B_Messenger_IDAP_F", 175, "backpack", "noDLC"],

	["Leg Strap Bag (Black)", "B_LegStrapBag_black_F", 165, "backpack", "noDLC"],
	["Leg Strap Bag (Coyote)", "B_LegStrapBag_coyote_F", 165, "backpack", "noDLC"],
	["Leg Strap Bag (Olive)", "B_LegStrapBag_olive_F", 165, "backpack", "noDLC"],
	
	["Radio Pack (Black)", "B_RadioBag_01_black_F", 250, "backpack", "noDLC"],
	["Radio Pack (Digital)[AAF]", "B_RadioBag_01_digi_F", 250, "backpack", "noDLC"],
	["Radio Pack (Geometric)[LDF]", "B_RadioBag_01_eaf_F", 250, "backpack", "noDLC"],
	["Radio Pack (Green Hex)[CSAT]", "B_RadioBag_01_ghex_F", 250, "backpack", "noDLC"],
	["Radio Pack (Hex)", "B_RadioBag_01_hex_F", 250, "backpack", "noDLC"],
	["Radio Pack (MTP)[NATO]", "B_RadioBag_01_mtp_F", 250, "backpack", "noDLC"],
	["Radio Pack (Tropic)[NATO]", "B_RadioBag_01_tropic_F", 250, "backpack", "noDLC"],
	["Radio Pack (Urban)[CSAT]", "B_RadioBag_01_oucamo_F", 250, "backpack", "noDLC"],
	["Radio Pack (Woodland)[NATO]", "B_RadioBag_01_wdl_F", 250, "backpack", "noDLC"],
	["Combination Unit Respirator", "B_CombinationUnitRespirator_01_F", 240, "backpack", "noDLC"],
	["Self-Contained Breathing Apparatus", "B_SCBA_01_F", 240, "backpack", "noDLC"]
];

genItemArray = compileFinal str
[
	["UAV Terminal", "B_UavTerminal", 550, "gps"],
	["UAV Terminal", "O_UavTerminal", 550, "gps"],
	["UAV Terminal", "I_UavTerminal", 550, "gps"],
	["AR-2 Darter UAV", "B_UAV_01_backpack_F", 4500, "backpack"],
	["AR-2 Darter UAV", "O_UAV_01_backpack_F", 4500, "backpack"],
	["AR-2 Darter UAV", "I_UAV_01_backpack_F", 4500, "backpack"],
	["AL-6 Pelican UAV", "B_UAV_06_backpack_F", 7250, "backpack", "noDLC"],
	["AL-6 Pelican UAV", "O_UAV_06_backpack_F", 7250, "backpack", "noDLC"],
	["AL-6 Pelican UAV", "I_UAV_06_backpack_F", 7250, "backpack", "noDLC"],
	["AL-6 Pelican Medical UAV", "B_UAV_06_medical_backpack_F", 8000, "backpack", "noDLC"],
	["AL-6 Pelican Medical UAV", "O_UAV_06_medical_backpack_F", 8000, "backpack", "noDLC"],
	["AL-6 Pelican Medical UAV", "I_UAV_06_medical_backpack_F", 8000, "backpack", "noDLC"],
	["AL-6 Pelican Demining UAV", "C_IDAP_UAV_06_antimine_backpack_F", 15000, "backpack", "noDLC"],
	["ED-1E Camera UGV", "B_UGV_02_Science_backpack_F", 2000, "backpack", "noDLC"],
	["ED-1E Camera UGV", "O_UGV_02_Science_backpack_F", 2000, "backpack", "noDLC"],
	["ED-1E Camera UGV", "I_UGV_02_Science_backpack_F", 2000, "backpack", "noDLC"],
	["ED-1D Demining UGV", "B_UGV_02_Demining_backpack_F", 5000, "backpack", "noDLC"],
	["ED-1D Demining UGV", "O_UGV_02_Demining_backpack_F", 5000, "backpack", "noDLC"],
	["ED-1D Demining UGV", "I_UGV_02_Demining_backpack_F", 5000, "backpack", "noDLC"],
	["Remote Designator (Khaki)", "B_W_Static_Designator_01_weapon_F", 5750, "backpack", "noDLC"],
	["Remote Designator (Sand)", "B_Static_Designator_01_weapon_F", 5750, "backpack", "noDLC"],
	["Remote Designator (Hex)", "O_Static_Designator_02_weapon_F", 5750, "backpack", "noDLC"],
	["GPS", "ItemGPS", 500, "gps"],
	["First Aid Kit", "FirstAidKit", 125, "item"],
	["Medikit", "Medikit", 550, "item"],
	["Toolkit", "ToolKit", 950, "item"],
	["Mine Detector", "MineDetector", 300, "item"],
	["Chemical Detector", "ChemicalDetector_01_watch_F", 300, "item"],
	["Diving Goggles", "G_Diving", 100, "gogg"],
	["NV Goggles (Brown)", "NVGoggles", 500, "nvg"],
	["NV Goggles (Black)", "NVGoggles_OPFOR", 500, "nvg"],
	["NV Goggles (Green)", "NVGoggles_INDEP", 500, "nvg"],
	["NV Goggles (Tropic)", "NVGoggles_tna_F", 500, "nvg", "noDLC"],
	["Compact NVG (Hex)", "O_NVGoggles_hex_F", 650, "nvg", "noDLC"],
	["Compact NVG (G Hex)", "O_NVGoggles_ghex_F", 650, "nvg", "noDLC"],
	["Compact NVG (Green)", "O_NVGoggles_grn_F", 650, "nvg", "noDLC"],
	["Compact NVG (Urban)", "O_NVGoggles_urb_F", 650, "nvg", "noDLC"],
	["ENVG-II (Black)", "NVGogglesB_blk_F", 5000, "nvg", "HIDDEN"],
	["ENVG-II (Green)", "NVGogglesB_grn_F", 5000, "nvg", "HIDDEN"],
	["ENVG-II (Grey)", "NVGogglesB_gry_F", 5000, "nvg", "HIDDEN"],
	["Binoculars", "Binocular", 100, "binoc"],
	["Rangefinder", "Rangefinder", 350, "binoc"],
	["Laser Designator (Sand)", "Laserdesignator", 650, "binoc", "noDLC"],
	["Laser Designator (Olive)", "Laserdesignator_03", 650, "binoc", "noDLC"],
	["Laser Designator (Khaki)", "Laserdesignator_01_khk_F", 650, "binoc", "noDLC"],
	["Laser Designator (Hex)", "Laserdesignator_02", 600, "binoc", "noDLC"],
	["Laser Designator (G Hex)", "Laserdesignator_02_ghex_F", 600, "binoc", "noDLC"],
	["IR Designator Grenade", "B_IR_Grenade", 100, "mag", "WEST"],
	["IR Designator Grenade", "O_IR_Grenade", 100, "mag", "EAST"],
	["IR Designator Grenade", "I_IR_Grenade", 100, "mag", "GUER"],
	["Smoke Grenade (White)", "SmokeShell", 150, "mag"],
	["Smoke Grenade (Purple)", "SmokeShellPurple", 150, "mag"],
	["Smoke Grenade (Blue)", "SmokeShellBlue", 150, "mag"],
	["Smoke Grenade (Green)", "SmokeShellGreen", 150, "mag"],
	["Smoke Grenade (Yellow)", "SmokeShellYellow", 150, "mag"],
	["Smoke Grenade (Orange)", "SmokeShellOrange", 150, "mag"],
	["Smoke Grenade (Red)", "SmokeShellRed", 150, "mag"],
	["Chemlight (Blue)", "Chemlight_blue", 75, "mag"],
	["Chemlight (Green)", "Chemlight_green", 75, "mag"],
	["Chemlight (Yellow)", "Chemlight_yellow", 75, "mag"],
	["Chemlight (Red)", "Chemlight_red", 75, "mag"],

	["Stealth Balaclava (Black)", "G_Balaclava_TI_blk_F", 200, "gogg", "noDLC"],
	["Stealth Balaclava (Black, Goggles)", "G_Balaclava_TI_G_blk_F", 250, "gogg", "noDLC"],
	["Stealth Balaclava (Green)", "G_Balaclava_TI_tna_F", 200, "gogg", "noDLC"],
	["Stealth Balaclava (Green, Goggles)", "G_Balaclava_TI_G_tna_F", 250, "gogg", "noDLC"],
	["Regulator Facepiece", "G_RegulatorMask_F", 225, "gogg", "noDLC"],
	["APR Gasmask (NATO/Black)", "G_AirPurifyingRespirator_01_F", 325, "gogg", "noDLC"],
	["APR Gasmask (CSAT/Black)", "G_AirPurifyingRespirator_02_black_F", 325, "gogg", "noDLC"],
	["APR Gasmask (CSAT/Olive)", "G_AirPurifyingRespirator_02_olive_F", 325, "gogg", "noDLC"],
	["APR Gasmask (CSAT/Sand)", "G_AirPurifyingRespirator_02_sand_F", 325, "gogg", "noDLC"],
	["Respirator (Blue)", "G_Respirator_blue_F", 25, "gogg", "noDLC"],
	["Respirator (While)", "G_Respirator_white_F", 25, "gogg", "noDLC"],
	["Respirator (Yellow)", "G_Respirator_yellow_F", 25, "gogg", "noDLC"],
	["Blindfold (Black)", "G_Blindfold_01_black_F", 25, "gogg", "noDLC"],
	["Blindfold (White)", "G_Blindfold_01_white_F", 10, "gogg", "noDLC"],
	["Combat Goggles", "G_Combat", 125, "gogg"],
	["Combat Goggles (Green)", "G_Combat_Goggles_tna_F", 125, "gogg", "noDLC"],
	["VR Goggles", "G_Goggles_VR", 125, "gogg"],
	["Wireless Earpiece", "G_WirelessEarpiece_F", 50, "gogg", "noDLC"],
	["Balaclava (Black)", "G_Balaclava_blk", 25, "gogg"],
	["Balaclava (Combat Goggles)", "G_Balaclava_combat", 25, "gogg"],
	["Balaclava (Low Profile Goggles)", "G_Balaclava_lowprofile", 25, "gogg"],
	["Balaclava (Olive)", "G_Balaclava_oli", 25, "gogg"],
	["Bandana (Aviator)", "G_Bandanna_aviator", 25, "gogg"],
	["Bandana (Beast)", "G_Bandanna_beast", 25, "gogg"],
	["Bandana (Black)", "G_Bandanna_blk", 25, "gogg"],
	["Bandana (Khaki)", "G_Bandanna_khk", 25, "gogg"],
	["Bandana (Olive)", "G_Bandanna_oli", 25, "gogg"],
	["Bandana (Shades)", "G_Bandanna_shades", 25, "gogg"],
	["Bandana (Sport)", "G_Bandanna_sport", 25, "gogg"],
	["Bandana (Tan)", "G_Bandanna_tan", 25, "gogg"],

	["Aviator Glasses", "G_Aviator", 100, "gogg"],
	["Ladies Shades", "G_Lady_Blue", 10, "gogg"],
	["Ladies Shades (Fire)", "G_Lady_Red", 10, "gogg"],
	["Ladies Shades (Iridium)", "G_Lady_Mirror", 10, "gogg"],
	["Ladies Shades (Sea)", "G_Lady_Dark", 10, "gogg"],
	["Low Profile Goggles", "G_Lowprofile", 10, "gogg"],
	["Safety Goggles", "G_EyeProtectors_F", 10, "gogg", "noDLC"],
	["Safety Goggles (Earpiece)", "G_EyeProtectors_Earpiece_F", 10, "gogg", "noDLC"],
	["Shades (Black)", "G_Shades_Black", 10, "gogg"],
	["Shades (Blue)", "G_Shades_Blue", 10, "gogg"],
	["Shades (Green)", "G_Shades_Green", 10, "gogg"],
	["Shades (Red)", "G_Shades_Red", 10, "gogg"],
	["Spectacle Glasses", "G_Spectacles", 10, "gogg"],
	["Sport Shades (Fire)", "G_Sport_Red", 10, "gogg"],
	["Sport Shades (Poison)", "G_Sport_Blackyellow", 10, "gogg"],
	["Sport Shades (Shadow)", "G_Sport_BlackWhite", 10, "gogg"],
	["Sport Shades (Style)", "G_Sport_Checkered", 10, "gogg"],
	["Sport Shades (Vulcan)", "G_Sport_Blackred", 10, "gogg"],
	["Sport Shades (Yetti)", "G_Sport_Greenblack", 10, "gogg"],
	["Square Shades", "G_Squares_Tinted", 10, "gogg"],
	["Square Spectacles", "G_Squares", 10, "gogg"],
	["Tactical Glasses", "G_Tactical_Clear", 100, "gogg"],
	["Tactical Shades", "G_Tactical_Black", 100, "gogg"],
	["Map", "ItemMap", 100, "map"],
	["Radio", "ItemRadio", 100, "radio"],
	["Compass", "ItemCompass", 100, "compass"],
	["Watch", "ItemWatch", 100, "watch"],
	["File (Top Secret)", "FileTopSecret", 25000, "item", "HIDDEN"]
];

#define GENSTORE_ITEM_PRICE(CLASS) ((call genItemArray) select {_x select 1 == CLASS} select 0 select 2)

allStoreMagazines = compileFinal str (call ammoArray + call throwputArray + call genItemArray);
allRegularStoreItems = compileFinal str (call allGunStoreFirearms + call allStoreMagazines + call accessoriesArray);
allStoreGear = compileFinal str (call headArray + call uniformArray + call vestArray + call backpackArray);

genObjectsArray = compileFinal str
[
	["Ammo Cache", "Box_FIA_Support_F", 250, "ammocrate"],
	["Container (Resupply Crate)", "Land_Cargo10_red_F", 4000, "resupplyObject"],
	["Boom Gate", "Land_BarGate_F", 150, "object"],
	["Decon Shower", "DeconShower_01_F", 100, "object"],
	["Decon Shower (Large)	", "DeconShower_02_F", 200, "object"],
	["Razor Fence (Gate)", "Land_Mil_WiredFence_Gate_F", 200, "object"],
	["Entrance Gate (IDAP)", "Land_EntranceGate_01_narrow_F", 200, "object"],
	["Dragon's Tooth", "Land_DragonsTeeth_01_1x1_new_F", 50, "object"],
	["Dragon's Tooth (Red-White)", "Land_DragonsTeeth_01_1x1_new_redwhite_F", 50, "object"],
	["Concrete Hedgehog", "Land_ConcreteHedgehog_01_F", 65, "object"],
	["Czech Hedgehog (New)", "Land_CzechHedgehog_01_new_F", 65, "object"],
	["Czech Hedgehog", "Land_CzechHedgehog_01_old_F", 60, "object"],
	["Gas Station (Malevil, Pump)", "Land_FuelStation_01_pump_malevil_F", 2500, "object"],
	["Gas Station (Tanoil, Pump)", "Land_FuelStation_01_pump_F", 2500, "object"],
	["Gas Station (Benzyna, Pump)", "Land_FuelStation_03_pump_F", 2500, "object"],
	["Gas Station (Fuel, Pump)", "Land_fs_feed_F", 2500, "object"],
	["Gas Station (Sun Oil, Pump)", "Land_FuelStation_Feed_F", 2500, "object"],
	["Water Pump (Forest)", "WaterPump_01_forest_F", 7500, "object"],
	["Water Pump (Sand)", "WaterPump_01_sand_F", 7500, "object"],
	["Food sacks", "Land_Sacks_goods_F", 1800, "object"],
	["Water Barrel", "Land_BarrelWater_F", 1800, "object"],
	["Lamp Post (Harbour)", "Land_LampHarbour_F", 100, "object"],
	["Lamp Post (Shabby)", "Land_LampShabby_F", 100, "object"],
	["Lamp (Halogen)", "Land_LampHalogen_F", 150, "object"],
	["Street Lamp", "Land_LampStreet_02_F", 150, "object"],
	["Street Lamp (Double)", "Land_LampStreet_02_double_F", 200, "object"],
	["Street Lamp (Triple)", "Land_LampStreet_02_triple_F", 250, "object"],
	["Airport Lamp ", "Land_LampAirport_F", 350, "object"],
	["Toiletbox", "Land_ToiletBox_F", 120, "object"],
	["Field Toilet", "Land_FieldToilet_F", 120, "object"],
	["Concrete Frame", "Land_CncShelter_F", 200, "object"],
	["Concrete Ramp", "Land_RampConcrete_F", 350, "object"],
	["Concrete Ramp (High)", "Land_RampConcreteHigh_F", 500, "object"],
	["Walkover Staircase", "Land_Walkover_01_F", 120, "object"],
	["Canal Wall (Small)", "Land_Canal_WallSmall_10m_F", 400, "object"],
	["Canal Stairs", "Land_Canal_Wall_Stairs_F", 500, "object"],
	["Pier Ladder", "Land_PierLadder_F", 250, "object"],
	["Pipes", "Land_Pipes_Large_F", 200, "object"],
	["Scaffolding", "Land_Scaffolding_F", 250, "object"],
	["Scaffolding (New)", "Land_Scaffolding_New_F", 250, "object"],
	["Fireplace", "Land_FirePlace_F", 50, "object"],
	["Campfire", "Land_Campfire_F", 65, "object"]
];

genBuildingsArray = compileFinal str
[
	["Lifeguard Tower", "Land_LifeguardTower_01_F", 50, "object"],
	["HBarrier Watchtower", "Land_HBarrierTower_F", 600, "object"],
	["H-barrier Watchtower (Green)", "Land_HBarrier_01_big_tower_green_F", 600, "object"],
	["Bag Fence (Corner)", "Land_BagFence_Corner_F", 150, "object"],
	["Bag Fence (End)", "Land_BagFence_End_F", 150, "object"],
	["Bag Fence (Long)", "Land_BagFence_Long_F", 200, "object"],
	["Bag Fence (Round)", "Land_BagFence_Round_F", 150, "object"],
	["Bag Fence (Short)", "Land_BagFence_Short_F", 150, "object"],
	["Bag Fence (Corner, Green)", "Land_BagFence_01_corner_green_F", 150, "object"],
	["Bag Fence (End, Green)", "Land_BagFence_01_end_green_F", 150, "object"],
	["Bag Fence (Long, Green)", "Land_BagFence_01_long_green_F", 200, "object"],
	["Bag Fence (Round, Green)", "Land_BagFence_01_round_green_F", 150, "object"],
	["Bag Fence (Short, Green)", "Land_BagFence_01_short_green_F", 150, "object"],
	["Bag Bunker (Small)", "Land_BagBunker_Small_F", 250, "object"],
	["Bag Bunker (Large)", "Land_BagBunker_Large_F", 500, "object"],
	["Bag Bunker (Tower)", "Land_BagBunker_Tower_F", 1000, "object"],
	["Bag Bunker (Small, Green)", "Land_BagBunker_01_small_green_F", 250, "object"],
	["Bag Bunker (Large, Green)", "Land_BagBunker_01_large_green_F", 500, "object"],
	["Bag Bunker (Tower, Green)", "Land_HBarrier_01_tower_green_F", 1000, "object"],
	["Old Bunker", "Land_Bunker_02_light_double_F", 1000, "object"],
	["Modular Bunker", "Land_Bunker_01_small_F", 1000, "object"],
	["Guard Tower (Big)", "Land_GuardTower_01_F", 200, "object"],
	["Guard Tower (Small)", "Land_GuardTower_02_F", 150, "object"],
	["Slum Canvas (Blue)", "Land_cargo_addon02_V1_F", 30, "object"],
	["Slum Canvas (Black)", "Land_cargo_addon02_V2_F", 30, "object"],
	["Slum House (Small)", "Land_Slum_House01_F", 100, "object"],
	["Slum House", "Land_Slum_House02_F", 150, "object"],
	["Slum House (Big)", "Land_Slum_House03_F", 200, "object"],
	["Slum House Container", "Land_cargo_house_slum_F", 300, "object"],
	["Grey Metal Shed (Large)", "Land_Metal_Shed_F", 120, "object"],
	["Industrial Shed (Small)", "Land_Shed_Small_F", 200, "object"],
	["Industrial Shed (Big)", "Land_Shed_Big_F", 400, "object"],
	["Cargo Container (Medium, Blue)", "Land_Cargo20_blue_F", 350, "object"],
	["Cargo Container (Medium, Brick Red)", "Land_Cargo20_brick_red_F", 350, "object"],
	["Cargo Container (Medium, Cyan)", "Land_Cargo20_cyan_F", 350, "object"],
	["Cargo Container (Medium, Grey)", "Land_Cargo20_grey_F", 350, "object"],
	["Cargo Container (Medium, Light Blue)", "Land_Cargo20_light_blue_F", 350, "object"],
	["Cargo Container (Medium, Light Green)", "Land_Cargo20_light_green_F", 350, "object"],
	["Cargo Container (Medium, Military Green)", "Land_Cargo20_military_green_F", 350, "object"],
	["Cargo Container (Medium, Orange)", "Land_Cargo20_orange_F", 350, "object"],
	["Cargo Container (Medium, Red)", "Land_Cargo20_red_F", 350, "object"],
	["Cargo Container (Medium, Sand)", "Land_Cargo20_sand_F", 350, "object"],
	["Cargo Container (Medium, White)", "Land_Cargo20_white_F", 350, "object"],
	["Cargo Container (Medium, Yellow)", "Land_Cargo20_yellow_F", 350, "object"],
	["Cargo Container (Long, Blue)", "Land_Cargo40_blue_F", 600, "object"],
	["Cargo Container (Long, Brick Red)", "Land_Cargo40_brick_red_F", 600, "object"],
	["Cargo Container (Long, Cyan)", "Land_Cargo40_cyan_F", 600, "object"],
	["Cargo Container (Long, Grey)", "Land_Cargo40_grey_F", 600, "object"],
	["Cargo Container (Long, Light Blue)", "Land_Cargo40_light_blue_F", 600, "object"],
	["Cargo Container (Long, Light Green)", "Land_Cargo40_light_green_F", 600, "object"],
	["Cargo Container (Long, Military Green)", "Land_Cargo40_military_green_F", 600, "object"],
	["Cargo Container (Long, Orange)", "Land_Cargo40_orange_F", 600, "object"],
	["Cargo Container (Long, Red)", "Land_Cargo40_red_F", 600, "object"],
	["Cargo Container (Long, Sand)", "Land_Cargo40_sand_F", 600, "object"],
	["Cargo Container (Long, White)", "Land_Cargo40_white_F", 600, "object"],
	["Cargo Container (Long, Yellow)", "Land_Cargo40_yellow_F", 600, "object"],
	["Military Cargo House (Green)", "Land_Cargo_House_V1_F", 500, "object"],
	["Military Cargo Post (Green)", "Land_Cargo_Patrol_V1_F", 800, "object"],
	["Military Cargo HQ (Green)", "Land_Cargo_HQ_V1_F", 1500, "object"],
	["Military Cargo Tower (Green)", "Land_Cargo_Tower_V1_F", 5000, "object"],
	["Military Cargo Platform (Green)", "CargoPlaftorm_01_green_F", 500, "object"],
	["Military Cargo House (Rusty)", "Land_Cargo_House_V2_F", 500, "object"],
	["Military Cargo Post (Rusty)", "Land_Cargo_Patrol_V2_F", 800, "object"],
	["Military Cargo HQ (Rusty)", "Land_Cargo_HQ_V2_F", 1500, "object"],
	["Military Cargo Tower (Rusty)", "Land_Cargo_Tower_V2_F", 5000, "object"],
	["Military Cargo Platform (Rusty)", "CargoPlaftorm_01_rusty_F", 500, "object"],
	["Military Cargo House (Brown)", "Land_Cargo_House_V3_F", 500, "object"],
	["Military Cargo Post (Brown)", "Land_Cargo_Patrol_V3_F", 800, "object"],
	["Military Cargo HQ (Brown)", "Land_Cargo_HQ_V3_F", 1500, "object"],
	["Military Cargo Tower (Brown)", "Land_Cargo_Tower_V3_F", 5000, "object"],
	["Military Cargo Platform (Brown)", "CargoPlaftorm_01_brown_F", 500, "object"],
	["Military Cargo House (Jungle)", "Land_Cargo_House_V4_F", 500, "object"],
	["Military Cargo Post (Jungle)", "Land_Cargo_Patrol_V4_F", 800, "object"],
	["Military Cargo HQ (Jungle)", "Land_Cargo_HQ_V4_F", 1500, "object"],
	["Military Cargo Tower (Jungle)", "Land_Cargo_Tower_V4_F", 5000, "object"],
	["Military Cargo Platform (Jungle)", "CargoPlaftorm_01_jungle_F", 500, "object"],
	["Connector Tent (Open)", "Land_ConnectorTent_01_NATO_open_F", 75, "object"],
	["Connector Tent (Cross)", "Land_ConnectorTent_01_NATO_cross_F", 100, "object"],
	["Tent (Outer)", "Land_MedicalTent_01_NATO_generic_outer_F", 350, "object"],
	["Tent (Inner)", "Land_MedicalTent_01_NATO_generic_inner_F", 500, "object"],
	["Connector Tent (Open)[Tropic]", "Land_ConnectorTent_01_NATO_tropic_open_F", 75, "object"],
	["Connector Tent (Cross)[Tropic]", "Land_ConnectorTent_01_NATO_tropic_cross_F", 100, "object"],
	["Tent (Outer)[Tropic]", "Land_MedicalTent_01_NATO_tropic_generic_outer_F", 350, "object"],
	["Tent (Inner)[Tropic]", "Land_MedicalTent_01_NATO_tropic_generic_inner_F", 500, "object"],
	["Connector Tent (Open)[Hex]", "Land_ConnectorTent_01_CSAT_brownhex_open_F", 75, "object"],
	["Connector Tent (Cross)[Hex]", "Land_ConnectorTent_01_CSAT_brownhex_cross_F", 100, "object"],
	["Tent (Outer)[Hex]", "Land_MedicalTent_01_CSAT_brownhex_generic_outer_F", 350, "object"],
	["Tent (Inner)[Hex]", "Land_MedicalTent_01_CSAT_brownhex_generic_inner_F", 500, "object"],
	["Connector Tent (Open)[G Hex]", "Land_ConnectorTent_01_CSAT_greenhex_open_F", 75, "object"],
	["Connector Tent (Cross)[G Hex]", "Land_ConnectorTent_01_CSAT_greenhex_cross_F", 100, "object"],
	["Tent (Outer)[G Hex]", "Land_MedicalTent_01_CSAT_greenhex_generic_outer_F", 350, "object"],
	["Tent (Inner)[G Hex]", "Land_MedicalTent_01_CSAT_greenhex_generic_inner_F", 500, "object"],
	["Connector Tent (Open)[AAF]", "Land_ConnectorTent_01_AAF_open_F", 75, "object"],
	["Connector Tent (Cross)[AAF]", "Land_ConnectorTent_01_AAF_cross_F", 100, "object"],
	["Tent (Outer)[AAF]", "Land_MedicalTent_01_aaf_generic_outer_F", 350, "object"],
	["Tent (Inner)[AAF]", "Land_MedicalTent_01_aaf_generic_inner_F", 500, "object"],
	["Connector Tent (Open)[Woodland]", "Land_ConnectorTent_01_wdl_open_F", 75, "object"],
	["Connector Tent (Cross)[Woodland]", "Land_ConnectorTent_01_wdl_cross_F", 100, "object"],
	["Tent (Outer)[Woodland]", "Land_MedicalTent_01_wdl_generic_outer_F", 350, "object"],
	["Tent (Inner)[Woodland]", "Land_MedicalTent_01_wdl_generic_inner_F", 500, "object"]
];

genWallsArray = compileFinal str
[
	["Barbed Wire Fence", "Land_New_WiredFence_5m_F", 30, "object"],
	["Barbed Wire Fence (Long)", "Land_New_WiredFence_10m_F", 30, "object"],
	["Razor Fence", "Land_Mil_WiredFence_F", 30, "object"],
	["Razorwire Barrier", "Land_Razorwire_F", 75, "object"],
	["Highway Guardrail", "Land_Crash_barrier_F", 200, "object"],
	["Modular Bunker (Block)", "Land_Bunker_01_blocks_1_F", 300, "object"],
	["Concrete Barrier", "Land_CncBarrier_F", 200, "object"],
	["Concrete Barrier (Stripes)", "Land_CncBarrier_stripes_F", 200, "object"],
	["Concrete Barrier (Medium)", "Land_CncBarrierMedium_F", 350, "object"],
	["Concrete Barrier (Long)", "Land_CncBarrierMedium4_F", 500, "object"],
	["HBarrier (1 block)", "Land_HBarrier_1_F", 150, "object"],
	["HBarrier (3 blocks)", "Land_HBarrier_3_F", 200, "object"],
	["HBarrier (5 blocks)", "Land_HBarrier_5_F", 250, "object"],
	["HBarrier (1 block, Green)", "Land_HBarrier_01_line_1_green_F", 150, "object"],
	["HBarrier (3 blocks, Green)", "Land_HBarrier_01_line_3_green_F", 200, "object"],
	["HBarrier (5 blocks, Green)", "Land_HBarrier_01_line_5_green_F", 250, "object"],
	["HBarrier Big", "Land_HBarrierBig_F", 500, "object"],
	["H-barrier (Big, 4 Blocks, Green)", "Land_HBarrier_01_big_4_green_F", 500, "object"],
	["HBarrier Wall (4 blocks)", "Land_HBarrierWall4_F", 400, "object"],
	["HBarrier Wall (6 blocks)", "Land_HBarrierWall6_F", 500, "object"],
	["H-barrier Wall (Corner)", "Land_HBarrierWall_corner_F", 200, "object"],
	["H-barrier (Corridor)", "Land_HBarrierWall_corridor_F", 400, "object"],
	["HBarrier Wall (4 blocks, Green)", "Land_HBarrier_01_wall_4_green_F", 400, "object"],
	["HBarrier Wall (6 blocks, Green)", "Land_HBarrier_01_wall_6_green_F", 500, "object"],
	["H-barrier Wall (Corner, Green)", "Land_HBarrier_01_wall_corner_green_F", 200, "object"],
	["H-barrier (Corridor, Green)", "Land_HBarrier_01_wall_corridor_green_F", 400, "object"],
	["Concrete Wall", "Land_CncWall1_F", 400, "object"],
	["Concrete Military Wall", "Land_Mil_ConcreteWall_F", 400, "object"],
	["Concrete Wall (Long)", "Land_CncWall4_F", 600, "object"],
	["Military Wall (Big)", "Land_Mil_WallBig_4m_F", 600, "object"],
	["Sandbag Barricade (Short)", "Land_SandbagBarricade_01_half_F", 200, "object"],
	["Sandbag Barricade (Tall, Hole)", "Land_SandbagBarricade_01_hole_F", 300, "object"],
	["Sandbag Barricade (Tall)", "Land_SandbagBarricade_01_F", 300, "object"]
];

genMiscArray = compileFinal str
[
	["Target Human", "TargetBootcampHuman_F", 50, "object"],
	["Shooting Range Bell", "Land_MysteriousBell_01_F", 30, "object"],
	["Shoot House - Wall", "Land_Shoot_House_Wall_F", 30, "object"],
	["Shoot House - Wall (Stand)", "Land_Shoot_House_Wall_Stand_F", 30, "object"],
	["Shoot House - Wall (Crouch)", "Land_Shoot_House_Wall_Crouch_F", 30, "object"],
	["Shoot House - Wall (Prone)", "Land_Shoot_House_Wall_Prone_F", 30, "object"],
	["Shoot House - Corner", "Land_Shoot_House_Corner_F", 30, "object"],
	["Shoot House - Corner (Stand)", "Land_Shoot_House_Corner_Stand_F", 30, "object"],
	["Shoot House - Corner (Crouch)", "Land_Shoot_House_Corner_Crouch_F", 30, "object"],
	["Shoot House - Corner (Prone)", "Land_Shoot_House_Corner_Prone_F", 30, "object"],
	["Shoot House - Panels", "Land_Shoot_House_Panels_F", 30, "object"],
	["Shoot House - Panels (Crouch)", "Land_Shoot_House_Panels_Crouch_F", 30, "object"],
	["Shoot House - Panels (Prone)", "Land_Shoot_House_Panels_Prone_F", 30, "object"],
	["Shoot House - Panels (Vault)", "Land_Shoot_House_Panels_Vault_F", 30, "object"],
	["Shoot House - Panels (Window)", "Land_Shoot_House_Panels_Window_F", 30, "object"],
	["Shoot House - Tunnel", "Land_Shoot_House_Tunnel_F", 30, "object"],
	["Shoot House - Tunnel (Stand)", "Land_Shoot_House_Tunnel_Stand_F", 30, "object"],
	["Shoot House - Tunnel (Crouch)", "Land_Shoot_House_Tunnel_Crouch_F", 30, "object"],
	["Shoot House - Tunnel (Prone)", "Land_Shoot_House_Tunnel_Prone_F", 30, "object"]
];

allGenStoreVanillaItems = compileFinal str (call genItemArray + call genObjectsArray + call allStoreGear + call genBuildingsArray + call genWallsArray + call genMiscArray);

//Text name, classname, buy cost, spawn type, sell price (selling not implemented) or spawning color
landArray = compileFinal str
[
	// SKIPSAVE = will not be autosaved until first manual force save, good for cheap vehicles that usually get abandoned

	["Remote Designator (Khaki)", "B_W_Static_Designator_01_F", GENSTORE_ITEM_PRICE("B_W_Static_Designator_01_weapon_F"), "vehicle", "HIDDEN"], // hidden, for paint & sell price
	["Remote Designator (Sand)", "B_Static_Designator_01_F", GENSTORE_ITEM_PRICE("B_Static_Designator_01_weapon_F"), "vehicle", "HIDDEN"], //
	["Remote Designator (Hex)", "O_Static_Designator_02_F", GENSTORE_ITEM_PRICE("O_Static_Designator_02_weapon_F"), "vehicle", "HIDDEN"], //

	["Kart", "C_Kart_01_F", 400, "vehicle"],
	["Tractor", "C_Tractor_01_F", 500, "vehicle"],

	["Quadbike (NATO)", "B_Quadbike_01_F", 500, "vehicle", "SKIPSAVE", "HIDDEN"], //
	["Quadbike (CSAT)", "O_Quadbike_01_F", 500, "vehicle", "SKIPSAVE", "HIDDEN"], //
	["Quadbike (AAF)", "I_Quadbike_01_F", 500, "vehicle", "SKIPSAVE", "HIDDEN"], //
	["Quadbike", "I_G_Quadbike_01_F", 500, "vehicle", "SKIPSAVE"],

	["Hatchback", "C_Hatchback_01_F", 750, "vehicle", "SKIPSAVE"],
	["Hatchback Sport", "C_Hatchback_01_sport_F", 900, "vehicle"],
	["SUV", "C_SUV_01_F", 1000, "vehicle", "SKIPSAVE"],

	["MB 4WD", "C_Offroad_02_unarmed_F", 1000, "vehicle", "SKIPSAVE"],
	["MB 4WD LMG", "I_C_Offroad_02_LMG_F", 1750, "vehicle"],
	["MB 4WD AT", "I_C_Offroad_02_AT_F", 15000, "vehicle"],

	["Offroad", "C_Offroad_01_F", 1000, "vehicle", "SKIPSAVE"],
	["Offroad Police", "B_GEN_Offroad_01_gen_F", 1000, "vehicle", "SKIPSAVE", "noDLC"],
	["Offroad Covered", "I_E_Offroad_01_covered_F", 1100, "vehicle", "SKIPSAVE"],
	["Offroad Repair", "C_Offroad_01_repair_F", 4500, "vehicle", "SKIPSAVE"],
	["Offroad HMG", "I_G_Offroad_01_armed_F", 5500, "vehicle", "SKIPSAVE"],
	["Offroad AT", "I_G_Offroad_01_AT_F", 15000, "vehicle"],

	["Truck", "C_Van_01_transport_F", 700, "vehicle", "SKIPSAVE"],
	["Truck Box", "C_Van_01_box_F", 900, "vehicle", "SKIPSAVE"],
	["Fuel Truck", "C_Van_01_fuel_F", 4000, "vehicle"],

	["Van Cargo", "C_Van_02_vehicle_F", 1000, "vehicle"],
	["Van Transport", "C_Van_02_transport_F", 1000, "vehicle"],
	["Van Police Cargo", "B_GEN_Van_02_vehicle_F", 1000, "vehicle"],
	["Van Police Transport", "B_GEN_Van_02_transport_F", 1000, "vehicle"],
	["Van Ambulance", "C_Van_02_medevac_F", 3500, "vehicle"],
	["Van Repair", "C_Van_02_service_F", 5000, "vehicle"],

	["HEMTT Tractor", "B_Truck_01_mover_F", 4000, "vehicle"],
	["HEMTT Resupply", "B_Truck_01_ammo_F", 5000, "vehicle"],
	//["HEMTT Box", "B_Truck_01_box_F", 5000, "vehicle"],
	["HEMTT Transport", "B_Truck_01_transport_F", 6000, "vehicle"],
	["HEMTT Covered", "B_Truck_01_covered_F", 7000, "vehicle"],
	["HEMTT Fuel", "B_Truck_01_fuel_F", 13000, "vehicle"],
	["HEMTT Medical", "B_Truck_01_medical_F", 12000, "vehicle"],
	["HEMTT Repair", "B_Truck_01_Repair_F", 15000, "vehicle"],
	["HEMTT Flatbed", "B_Truck_01_flatbed_F", 10000, "vehicle"],
	["HEMTT Cargo", "B_Truck_01_cargo_F", 10000, "vehicle"],

	["Tempest Device", "O_Truck_03_device_F", 4000, "vehicle"],
	["Tempest Resupply", "O_Truck_03_ammo_F", 15000, "vehicle"],
	["Tempest Transport", "O_Truck_03_transport_F", 6000, "vehicle"],
	["Tempest Covered", "O_Truck_03_covered_F", 7000, "vehicle"],
	["Tempest Fuel", "O_Truck_03_fuel_F", 13000, "vehicle"],
	["Tempest Medical", "O_Truck_03_medical_F", 12000, "vehicle"],
	["Tempest Repair", "O_Truck_03_repair_F", 15000, "vehicle"],

	["Zamak Resupply", "I_Truck_02_ammo_F", 4000, "vehicle"],
	["Zamak Transport", "I_Truck_02_transport_F", 4500, "vehicle"],
	["Zamak Covered", "I_Truck_02_covered_F", 5000, "vehicle"],
	["Zamak Fuel", "I_Truck_02_fuel_F", 6000, "vehicle"],
	["Zamak Medical", "I_Truck_02_medical_F", 7000, "vehicle"],
	["Zamak Repair", "I_Truck_02_box_F", 8000, "vehicle"],

	["UGV Stomper (NATO)", "B_UGV_01_F", 2500, "vehicle"],
	["UGV Stomper RCWS (NATO)", "B_UGV_01_rcws_F", 15000, "vehicle"],
	["UGV Stomper (AAF)", "I_UGV_01_F", 2500, "vehicle"],
	["UGV Stomper RCWS (AAF)", "I_UGV_01_rcws_F", 15000, "vehicle"],
	["UGV Saif (CSAT)", "O_UGV_01_F", 2500, "vehicle"],
	["UGV Saif RCWS (CSAT)", "O_UGV_01_rcws_F", 15000, "vehicle"]
];

armoredArray = compileFinal str
[
	["Prowler Light", "B_CTRG_LSV_01_light_F", 1250, "vehicle", "SKIPSAVE"],
	["Prowler", "B_T_LSV_01_unarmed_F", 1500, "vehicle", "SKIPSAVE"],
	["Prowler HMG", "B_T_LSV_01_armed_F", 6000, "vehicle"],
	["Prowler AT", "B_T_LSV_01_AT_F", 10000, "vehicle"],
	["Qilin", "O_T_LSV_02_unarmed_F", 1500, "vehicle", "SKIPSAVE"],
	["Qilin Minigun", "O_T_LSV_02_armed_F", 5000, "vehicle"],
	["Qilin AT", "O_T_LSV_02_AT_F", 15000, "vehicle"],

	["Hunter", "B_MRAP_01_F", 4000, "vehicle", "SKIPSAVE"],
	["Hunter HMG", "B_MRAP_01_hmg_F", 15000, "vehicle"],
	["Hunter GMG", "B_MRAP_01_gmg_F", 20000, "vehicle"],
	["Ifrit", "O_MRAP_02_F", 4000, "vehicle", "SKIPSAVE"],
	["Ifrit HMG", "O_MRAP_02_hmg_F", 15000, "vehicle"],
	["Ifrit GMG", "O_MRAP_02_gmg_F", 20000, "vehicle"],
	["Strider", "I_MRAP_03_F", 4000, "vehicle", "SKIPSAVE"],
	["Strider HMG", "I_MRAP_03_hmg_F", 15000, "vehicle"],
	["Strider GMG", "I_MRAP_03_gmg_F", 20000, "vehicle"],
	["MSE-3 Marid", "O_APC_Wheeled_02_rcws_v2_F", 50000, "vehicle"],
	["AMV-7 Marshall", "B_APC_Wheeled_01_cannon_F", 67500, "vehicle"],
	["AFV-4 Gorgon", "I_APC_Wheeled_03_cannon_F", 67500, "vehicle"],
	["Rhino MGS", "B_AFV_Wheeled_01_cannon_F", 80000, "vehicle"],
	["Rhino MGS UP", "B_AFV_Wheeled_01_up_cannon_F", 90000, "vehicle"]
];

tanksArray = compileFinal str
[
	["ED-1E Camera UGV", "B_UGV_02_Science_F", GENSTORE_ITEM_PRICE("B_UGV_02_Science_backpack_F"), "vehicle", "SKIPSAVE"],
	["ED-1E Camera UGV", "O_UGV_02_Science_F", GENSTORE_ITEM_PRICE("O_UGV_02_Science_backpack_F"), "vehicle", "SKIPSAVE"],
	["ED-1E Camera UGV", "I_UGV_02_Science_F", GENSTORE_ITEM_PRICE("I_UGV_02_Science_backpack_F"), "vehicle", "SKIPSAVE"],
	["ED-1D Demining UGV", "B_UGV_02_Demining_F", GENSTORE_ITEM_PRICE("B_UGV_02_Demining_backpack_F"), "vehicle", "SKIPSAVE"],
	["ED-1D Demining UGV", "O_UGV_02_Demining_F", GENSTORE_ITEM_PRICE("O_UGV_02_Demining_backpack_F"), "vehicle", "SKIPSAVE"],
	["ED-1D Demining UGV", "I_UGV_02_Demining_F", GENSTORE_ITEM_PRICE("I_UGV_02_Demining_backpack_F"), "vehicle", "SKIPSAVE"],

	["AWC 303 Nyx Recon", "I_LT_01_scout_F", 15000, "vehicle"], //5000
	["AWC 304 Nyx Autocannon", "I_LT_01_cannon_F", 25000, "vehicle"],
	["AWC 301 Nyx AT", "I_LT_01_AT_F", 35000, "vehicle"],
	["AWC 302 Nyx AA", "I_LT_01_AA_F", 30000, "vehicle"],
	["CRV-6e Bobcat (Resupply)", "B_APC_Tracked_01_CRV_F", 50000, "vehicle"],
	["IFV-6c Panther", "B_APC_Tracked_01_rcws_F", 50000, "vehicle"],
	["FV-720 Mora", "I_APC_tracked_03_cannon_F", 65000, "vehicle"],
	["BTR-K Kamysh", "O_APC_Tracked_02_cannon_F", 70000, "vehicle"],
	["IFV-6a Cheetah AA", "B_APC_Tracked_01_AA_F", 80000, "vehicle"],
	["ZSU-39 Tigris AA", "O_APC_Tracked_02_AA_F", 80000, "vehicle"],
	["M2A1 Slammer", "B_MBT_01_cannon_F", 90000, "vehicle"],
	["M2A4 Slammer HMG", "B_MBT_01_TUSK_F", 97000, "vehicle"], // Commander gun variant
	["M2A4 Slammer HMG (Extra Tough)", "B_MBT_01_TUSK_F", 115000, "vehicle", "variant_tough"],
	["T-100 Varsuk", "O_MBT_02_cannon_F", 90000, "vehicle"],
	["MBT-52 Kuma", "I_MBT_03_cannon_F", 100000, "vehicle"],
	["T-140 Angara", "O_MBT_04_cannon_F", 110000, "vehicle"],
	["T-140K Angara", "O_MBT_04_command_F", 11000, "vehicle"],

	["Zamak MRL", "I_Truck_02_MRL_F", 275000, "vehicle"],
	["M5 Sandstorm MLRS", "B_MBT_01_mlrs_F", 280000, "vehicle"],
	["2S9 Sochor", "O_MBT_02_arty_F", 200000, "vehicle"],
	["M4 Scorcher", "B_MBT_01_arty_F", 200000, "vehicle"]
];

helicoptersArray = compileFinal str
[
	["AR-2 Darter UAV", "B_UAV_01_F", GENSTORE_ITEM_PRICE("B_UAV_01_backpack_F"), "vehicle", "SKIPSAVE"],
	["AR-2 Darter UAV", "O_UAV_01_F", GENSTORE_ITEM_PRICE("O_UAV_01_backpack_F"), "vehicle", "SKIPSAVE"],
	["AR-2 Darter UAV", "I_UAV_01_F", GENSTORE_ITEM_PRICE("I_UAV_01_backpack_F"), "vehicle", "SKIPSAVE"],
	["AL-6 Pelican UAV", "B_UAV_06_F", GENSTORE_ITEM_PRICE("B_UAV_06_backpack_F"), "vehicle", "SKIPSAVE"],
	["AL-6 Pelican UAV", "O_UAV_06_F", GENSTORE_ITEM_PRICE("O_UAV_06_backpack_F"), "vehicle", "SKIPSAVE"],
	["AL-6 Pelican UAV", "I_UAV_06_F", GENSTORE_ITEM_PRICE("I_UAV_06_backpack_F"), "vehicle", "SKIPSAVE"],
	["AL-6 Pelican Medical UAV", "B_UAV_06_medical_F", GENSTORE_ITEM_PRICE("B_UAV_06_medical_backpack_F"), "vehicle", "SKIPSAVE"],
	["AL-6 Pelican Medical UAV", "O_UAV_06_medical_F", GENSTORE_ITEM_PRICE("O_UAV_06_medical_backpack_F"), "vehicle", "SKIPSAVE"],
	["AL-6 Pelican Medical UAV", "I_UAV_06_medical_F", GENSTORE_ITEM_PRICE("I_UAV_06_medical_backpack_F"), "vehicle", "SKIPSAVE"],
	["AL-6 Pelican Demining UAV", "C_IDAP_UAV_06_antimine_F", GENSTORE_ITEM_PRICE("C_IDAP_UAV_06_antimine_backpack_F"), "vehicle", "SKIPSAVE"],

	["M-900 Civilian", "C_Heli_Light_01_civil_F", 7000, "vehicle"], // MH-6, no flares
	["MH-9 Hummingbird", "B_Heli_Light_01_F", 9000, "vehicle"], // MH-6
	["PO-30 Orca (Unarmed)", "O_Heli_Light_02_unarmed_F", 10000, "vehicle"], // Ka-60
	["WY-55 Hellcat (Unarmed)", "I_Heli_light_03_unarmed_F", 11000, "vehicle"], // AW159
	["CH-49 Mohawk", "I_Heli_Transport_02_F", 15000, "vehicle"], // AW101

	["Mi-290 Taru (Resupply)", "O_Heli_Transport_04_ammo_F", 15000, "vehicle"],
	["Mi-290 Taru (Crane)", "O_Heli_Transport_04_F", 15000, "vehicle"], // CH-54
	["Mi-290 Taru (Box)", "O_Heli_Transport_04_box_F", 8000, "vehicle"],
	["Mi-290 Taru (Fuel)", "O_Heli_Transport_04_fuel_F", 11000, "vehicle"],
	["Mi-290 Taru (Bench)", "O_Heli_Transport_04_bench_F", 9000, "vehicle"],
	["Mi-290 Taru (Transport)", "O_Heli_Transport_04_covered_F", 9500, "vehicle"],
	["Mi-290 Taru (Medical)", "O_Heli_Transport_04_medevac_F", 12000, "vehicle"],
	["Mi-290 Taru (Repair)", "O_Heli_Transport_04_repair_F", 14000, "vehicle"],

	["CH-67 Huron (Unarmed)", "B_Heli_Transport_03_unarmed_F", 15000, "vehicle"], // CH-47
	["CH-67 Huron (Armed)", "B_Heli_Transport_03_F", 30000, "vehicle"], // CH-47 with 2 side miniguns

	["UH-80 Ghost Hawk", "B_Heli_Transport_01_F", 16500, "vehicle"], // UH-60 Stealth with 2 side miniguns
	["AH-9 Pawnee (Gun-Only)", "B_Heli_Light_01_dynamicLoadout_F", 20000, "vehicle", "variant_pawneeGun"], // Armed AH-6 (no missiles)
	["AH-9 Pawnee", "B_Heli_Light_01_dynamicLoadout_F", 30000, "vehicle", "variant_pawneeNormal"], // Armed AH-6
	["PO-30 Orca (DAR)", "O_Heli_Light_02_dynamicLoadout_F", 40000, "vehicle", "variant_orcaDAR"], // Armed Ka-60
	["PO-30 Orca (DAGR)", "O_Heli_Light_02_dynamicLoadout_F", 58000, "vehicle", "variant_orcaDAGR"], // Armed Ka-60, add "HIDDEN" if you don't want it, but don't remove the line!
	["WY-55 Hellcat (Armed)", "I_Heli_light_03_dynamicLoadout_F", 50000, "vehicle"], // Armed AW159
	["AH-99 Blackfoot", "B_Heli_Attack_01_dynamicLoadout_F", 77500, "vehicle"], // RAH-66 with gunner
	["AH-99 Blackfoot AT (Extra Tough)", "B_Heli_Attack_01_dynamicLoadout_F", 100000, "vehicle", "variant_toughAT"],
	["Mi-48 Kajman", "O_Heli_Attack_02_dynamicLoadout_F", 95000, "vehicle"], // Mi-28 with gunner 
	["Mi-48 Kajman AT (Extra Tough)", "O_Heli_Attack_02_dynamicLoadout_F", 120000, "vehicle", "variant_toughAT"],

	["MQ-12 Falcon (Unarmed)", "B_T_UAV_03_dynamicLoadout_F", 35000, "vehicle", "variant_falconUnarmed"],
	["MQ-12 Falcon UAV", "B_T_UAV_03_F", 110000, "vehicle"] // Do NOT use "B_T_UAV_03_dynamicLoadout_F" (unlees you don't need ASRAAM)
];

planesArray = compileFinal str
[
	["Caesar BTT", "C_Plane_Civil_01_F", 2500, "vehicle"],
	["Caesar BTT (Cannon)", "C_Plane_Civil_01_racing_F", 10000, "vehicle"],

	["A-164 Wipeout CAS", "B_Plane_CAS_01_dynamicLoadout_F", 110000, "vehicle", "variant_wipeoutCAS"],
	["To-199 Neophron CAS", "O_Plane_CAS_02_dynamicLoadout_F", 112000, "vehicle", "variant_neophronCAS"],
	["A-143 Buzzard CAS", "I_Plane_Fighter_03_dynamicLoadout_F", 118000, "vehicle", "variant_buzzardCAS"],

	["F/A-181 Black Wasp Stealth (Gun-Only)", "B_Plane_Fighter_01_Stealth_F", 150000, "vehicle"],
	["F/A-181 Black Wasp AA", "B_Plane_Fighter_01_F", 163000, "vehicle", "variant_blackwaspAA"],
	["F/A-181 Black Wasp CAS", "B_Plane_Fighter_01_F", 180000, "vehicle", "variant_blackwaspCAS"],

	["To-201 Shikra Stealth (Gun-Only)", "O_Plane_Fighter_02_Stealth_F", 150000, "vehicle"],
	["To-201 Shikra AA", "O_Plane_Fighter_02_F", 163000, "vehicle", "variant_shikraAA"],
	["To-201 Shikra CAS", "O_Plane_Fighter_02_F", 180000, "vehicle", "variant_shikraCAS"],

	["A-149 Gryphon AA", "I_Plane_Fighter_04_F", 156000, "vehicle", "variant_gryphonAA"],
	["A-149 Gryphon CAS", "I_Plane_Fighter_04_F", 163000, "vehicle", "variant_gryphonCAS"],

	["V-44 X Blackfish (Infantry)", "B_T_VTOL_01_infantry_F", 20000, "vehicle"],
	["V-44 X Blackfish (Vehicle)", "B_T_VTOL_01_vehicle_F", 25000, "vehicle"],
	["V-44 X Blackfish (Gunship)", "B_T_VTOL_01_armed_F", 75000, "vehicle"],
	["Y-32 Xi'an (Infantry)", "O_T_VTOL_02_infantry_dynamicLoadout_F", 80000, "vehicle"],
	["Y-32 Xi'an (Vehicle)", "O_T_VTOL_02_vehicle_dynamicLoadout_F", 82500, "vehicle"],

	["KH-3A Fenghuang Missile UAV", "O_T_UAV_04_CAS_F", 95000, "vehicle"],

	["MQ4A Greyhawk (Unarmed)", "B_UAV_02_dynamicLoadout_F", 55000, "vehicle", "variant_greyhawkUnarmed"],
	["K40 Ababil-3 (Unarmed)", "O_UAV_02_dynamicLoadout_F", 55000, "vehicle", "variant_greyhawkUnarmed"],
	["K40 Ababil-3 (Unarmed)", "I_UAV_02_dynamicLoadout_F", 55000, "vehicle", "variant_greyhawkUnarmed"],

	["MQ4A Greyhawk Cluster UAV", "B_UAV_02_dynamicLoadout_F", 73000, "vehicle", "variant_greyhawkCluster"],
	["K40 Ababil-3 Cluster UAV", "O_UAV_02_dynamicLoadout_F", 73000, "vehicle", "variant_greyhawkCluster"],
	["K40 Ababil-3 Cluster UAV", "I_UAV_02_dynamicLoadout_F", 73000, "vehicle", "variant_greyhawkCluster"],

	["MQ4A Greyhawk Bomber UAV", "B_UAV_02_dynamicLoadout_F", 88000, "vehicle", "variant_greyhawkBomber"], // Bomber UAVs are a lot harder to use, hence why they are cheaper than Missile ones
	["K40 Ababil-3 Bomber UAV", "O_UAV_02_dynamicLoadout_F", 88000, "vehicle", "variant_greyhawkBomber"],
	["K40 Ababil-3 Bomber UAV", "I_UAV_02_dynamicLoadout_F", 88000, "vehicle", "variant_greyhawkBomber"],

	["MQ4A Greyhawk DAGR UAV", "B_UAV_02_dynamicLoadout_F", 95000, "vehicle", "variant_greyhawkDAGR"],
	["K40 Ababil-3 DAGR UAV", "O_UAV_02_dynamicLoadout_F", 95000, "vehicle", "variant_greyhawkDAGR"],
	["K40 Ababil-3 DAGR UAV", "I_UAV_02_dynamicLoadout_F", 95000, "vehicle", "variant_greyhawkDAGR"],

	["MQ4A Greyhawk Missile UAV", "B_UAV_02_dynamicLoadout_F", 122000, "vehicle", "variant_greyhawkMissile"],
	["K40 Ababil-3 Missile UAV", "O_UAV_02_dynamicLoadout_F", 122000, "vehicle", "variant_greyhawkMissile"],
	["K40 Ababil-3 Missile UAV", "I_UAV_02_dynamicLoadout_F", 122000, "vehicle", "variant_greyhawkMissile"],

	["UCAV Sentinel Missile", "B_UAV_05_F", 155000, "vehicle", "variant_sentinelMissile"],
	["UCAV Sentinel Bomber", "B_UAV_05_F", 140000, "vehicle", "variant_sentinelBomber"],
	["UCAV Sentinel Cluster", "B_UAV_05_F", 130000, "vehicle", "variant_sentinelCluster"]
];

antiAirArray = compileFinal str
[
	["Mk21 Centurion", "B_SAM_System_02_F", 75000],
	["Mk41 VLS", "B_Ship_MRLS_01_F", 150000],
	["Mk45 Hammer", "B_Ship_Gun_01_F", 120000],
	["Mk49 Spartan", "B_SAM_System_01_F", 80000],
	["Praetorian 1C", "B_AAA_System_01_F", 55000],
	["AN/MPQ-105 Radar", "B_Radar_System_01_F", 30000],
	["MIM-145 Defender", "B_SAM_System_03_F", 70000],
	["R-750 Cronus Radar", "O_Radar_System_02_F", 30000],
	["S-750 Rhea", "O_SAM_System_04_F", 70000]
];

boatsArray = compileFinal str
[
	["Water Scooter", "C_Scooter_Transport_01_F", 500, "boat", "SKIPSAVE"],
	["Rescue Boat", "C_Rubberboat", 500, "boat"],
	["Assault Boat", "B_Boat_Transport_01_F", 500, "boat"],
	["Motorboat", "C_Boat_Civil_01_F", 1000, "boat"],

	["RHIB", "I_C_Boat_Transport_02_F", 1500, "boat"],

	["Speedboat HMG", "O_Boat_Armed_01_hmg_F", 14000, "boat"],
	["Speedboat Minigun", "B_Boat_Armed_01_minigun_F", 14000, "boat"],
	["SDV Submarine (NATO)", "B_SDV_01_F", 3500, "submarine"],
	["SDV Submarine (CSAT)", "O_SDV_01_F", 3500, "submarine"],
	["SDV Submarine (AAF)", "I_SDV_01_F", 3500, "submarine"]
];

allVehStoreVehicles = compileFinal str (call landArray + call armoredArray + call tanksArray + call helicoptersArray + call planesArray + call antiAirArray + call boatsArray);

uavArray = compileFinal str
[
	// Deprecated
];

noColorVehicles = compileFinal str
[
	// Deprecated
];

rgbOnlyVehicles = compileFinal str
[
	// Deprecated
];

_color = "#(rgb,1,1,1)color";
_texDir = "client\images\vehicleTextures\";
_kartDir = "\A3\soft_f_kart\Kart_01\Data\";
_mh9Dir = "\A3\air_f\Heli_Light_01\Data\";
_mohawkDir = "\A3\air_f_beta\Heli_Transport_02\Data\";
_wreckDir = "\A3\structures_f\wrecks\data\";
_gorgonDir = "\A3\armor_f_gamma\APC_Wheeled_03\data\";
_cheetahDir = "\A3\armor_f_beta\apc_tracked_01\data\";
_zamakDir = "\A3\soft_f_beta\truck_02\data\";
colorsArray = compileFinal str
[
	[ // Main colors
		"All", // "All" must always be first in colorsArray
		[
			["Black", _color + "(0.01,0.01,0.01,1)"], // #(argb,8,8,3)color(0.1,0.1,0.1,0.1)
			["Gray", _color + "(0.15,0.151,0.152,1)"], // #(argb,8,8,3)color(0.5,0.51,0.512,0.3)
			["White", _color + "(0.75,0.75,0.75,1)"], // #(argb,8,8,3)color(1,1,1,0.5)
			["Dark Blue", _color + "(0,0.05,0.15,1)"], // #(argb,8,8,3)color(0,0.3,0.6,0.05)
			["Blue", _color + "(0,0.03,0.5,1)"], // #(argb,8,8,3)color(0,0.2,1,0.75)
			["Teal", _color + "(0,0.3,0.3,1)"], // #(argb,8,8,3)color(0,1,1,0.15)
			["Green", _color + "(0,0.5,0,1)"], // #(argb,8,8,3)color(0,1,0,0.15)
			["Yellow", _color + "(0.5,0.4,0,1)"], // #(argb,8,8,3)color(1,0.8,0,0.4)
			["Orange", _color + "(0.4,0.09,0,1)"], // #(argb,8,8,3)color(1,0.5,0,0.4)
			["Red", _color + "(0.45,0.005,0,1)"], // #(argb,8,8,3)color(1,0.1,0,0.3)
			["Pink", _color + "(0.5,0.03,0.3,1)"], // #(argb,8,8,3)color(1,0.06,0.6,0.5)
			["Purple", _color + "(0.1,0,0.3,1)"], // #(argb,8,8,3)color(0.8,0,1,0.1)
			["NATO Tan", _texDir + "nato.paa"], // #(argb,8,8,3)color(0.584,0.565,0.515,0.3)
			["CSAT Brown", _texDir + "csat.paa"], // #(argb,8,8,3)color(0.624,0.512,0.368,0.3)
			["AAF Green", _texDir + "aaf.paa"], // #(argb,8,8,3)color(0.546,0.59,0.363,0.2)
			["Bloodshot", _texDir + "bloodshot.paa"],
			["Carbon", _texDir + "carbon.paa"],
			["US Multicam", _texDir + "us_multicam.paa"],
			["NATO Woodland", _texDir + "nato_wooldland.paa"],
			["LDF Woodland", _texDir + "ldf_woodland.paa"],
			["AAF Digital Green", _texDir + "aaf_digital_green.paa"],
			["Opfor Hex", _texDir + "opfor_hex.paa"],
			["Green Hex", _texDir + "ghex.paa"],
			["Grey Hex", _texDir + "grey.paa"],
			["Digital", _texDir + "digi.paa"],
			["Digital Black", _texDir + "digi_black.paa"],
			["Digital Desert", _texDir + "digi_desert.paa"],
			["Digital Woodland", _texDir + "digi_wood.paa"],
			["Doritos", _texDir + "doritos.paa"],
			["Drylands", _texDir + "drylands.paa"],
			["Hello Kitty", _texDir + "hellokitty.paa"],
			["Hex", _texDir + "hex.paa"],
			["Denim", _texDir + "denim.paa"],
			["ISIS", _texDir + "isis.paa"],
			["Leopard", _texDir + "leopard.paa"],
			["Mountain Dew", _texDir + "mtndew.paa"],
			["'Murica", _texDir + "murica.paa"],
			["Nazi", _texDir + "nazi.paa"],
			["Psych", _texDir + "psych.paa"],
			["Red Camo", _texDir + "camo_red.paa"],
			["Rusty", _texDir + "rusty.paa"],
			["Sand", _texDir + "sand.paa"],
			["Snake", _texDir + "snake.paa"],
			["Stripes", _texDir + "stripes.paa"],
			["Stripes 2", _texDir + "stripes2.paa"],
			["Stripes 3", _texDir + "stripes3.paa"],
			["Swamp", _texDir + "swamp.paa"],
			["Tiger", _texDir + "tiger.paa"],
			["Union Jack", _texDir + "unionjack.paa"],
			["Weed", _texDir + "weed.paa"],
			["Woodland", _texDir + "woodland.paa"],
			["Woodland Dark", _texDir + "wooddark.paa"],
			["Woodland Tiger", _texDir + "woodtiger.paa"]
		]
	],
	[ // Kart colors
		"Kart_01_Base_F",
		[
			["Red - Kart", [[0, _kartDir + "kart_01_base_red_co.paa"]]] // no red TextureSource :(
		]
	],
	[ // MH-9 colors
		"Heli_Light_01_base_F",
		[
			["AAF Camo - MH-9", [[0, _mh9Dir + "heli_light_01_ext_indp_co.paa"]]],
			["Blue 'n White - MH-9", [[0, _mh9Dir + "heli_light_01_ext_blue_co.paa"]]],
			["Blueline - MH-9", [[0, _mh9Dir + "Skins\heli_light_01_ext_blueline_co.paa"]]],
			["Cream Gravy - MH-9", [[0, _mh9Dir + "heli_light_01_ext_co.paa"]]],
			["Digital - MH-9", [[0, _mh9Dir + "Skins\heli_light_01_ext_digital_co.paa"]]],
			["Elliptical - MH-9", [[0, _mh9Dir + "Skins\heli_light_01_ext_elliptical_co.paa"]]],
			["Furious - MH-9", [[0, _mh9Dir + "Skins\heli_light_01_ext_furious_co.paa"]]],
			["Graywatcher - MH-9", [[0, _mh9Dir + "Skins\heli_light_01_ext_graywatcher_co.paa"]]],
			["ION - MH-9", [[0, _mh9Dir + "heli_light_01_ext_ion_co.paa"]]],
			["Jeans - MH-9", [[0, _mh9Dir + "Skins\heli_light_01_ext_jeans_co.paa"]]],
			["Light - MH-9", [[0, _mh9Dir + "Skins\heli_light_01_ext_light_co.paa"]]],
			["Shadow - MH-9", [[0, _mh9Dir + "Skins\heli_light_01_ext_shadow_co.paa"]]],
			["Sheriff - MH-9", [[0, _mh9Dir + "Skins\heli_light_01_ext_sheriff_co.paa"]]],
			["Speedy - MH-9", [[0, _mh9Dir + "Skins\heli_light_01_ext_speedy_co.paa"]]],
			["Sunset - MH-9", [[0, _mh9Dir + "Skins\heli_light_01_ext_sunset_co.paa"]]],
			["Vrana - MH-9", [[0, _mh9Dir + "Skins\heli_light_01_ext_vrana_co.paa"]]],
			["Wasp - MH-9", [[0, _mh9Dir + "Skins\heli_light_01_ext_wasp_co.paa"]]],
			["Wave - MH-9", [[0, _mh9Dir + "Skins\heli_light_01_ext_wave_co.paa"]]]
		]
	],
	[ // Blackfoot paintjob
		"Heli_Attack_01_base_F",
		[
			["Rusty - AH-99 Blackfoot", [[0, _wreckDir + "wreck_heli_attack_01_co.paa"]]]
		]
	],
	[ // Kajman paintjobs
		"Heli_Attack_02_base_F",
		[
			["Rusty - Mi-48 Kajman", [
				[0, _wreckDir + "wreck_heli_attack_02_body1_co.paa"],
				[1, _wreckDir + "wreck_heli_attack_02_body2_co.paa"]
			]],
			["Mossy - Mi-48 Kajman", [
				[0, _wreckDir + "uwreck_heli_attack_02_body1_co.paa"],
				[1, _wreckDir + "uwreck_heli_attack_02_body2_co.paa"]
			]]
		]
	],
	[ // Gorgon paintjobs
		"APC_Wheeled_03_base_F",
		[
			["Tan - AFV-4 Gorgon", [
				[0, _gorgonDir + "apc_wheeled_03_ext_co.paa"],
				[1, _gorgonDir + "apc_wheeled_03_ext2_co.paa"],
				[2, _gorgonDir + "rcws30_co.paa"],
				[3, _gorgonDir + "apc_wheeled_03_ext_alpha_co.paa"]
			]]
		]
	],
	[ // Hatchback wreck paintjob
		"Hatchback_01_base_F",
		[
			["Rusty - Hatchback", [[0, _wreckDir + "civilcar_extwreck_co.paa"]]]
		]
	],
	[
		"C_Van_01_fuel_F",
		[
			["Pertamina", [
				[0, "a3\soft_f_gamma\van_01\data\van_01_ext_red_co.paa"],
				[1, _texDir + "fuel_truck_pertamina_1.paa"]
			]]
		]
	],
	[
		"B_Truck_01_fuel_F",
		[
			["Pertamina", [
				[0, _texDir + "hemtt_fuel_pertamina_0.paa"],
				[1, _texDir + "hemtt_fuel_pertamina_1.paa"],
				[2, _texDir + "hemtt_fuel_pertamina_2.paa"]
			]]
		]
	],
	[
		"B_APC_Tracked_01_AA_F",
		[
			["Hex", [
				[0, _cheetahDir + "apc_tracked_01_aa_body_opfor_co.paa"],
				[1, _cheetahDir + "apc_tracked_01_aa_body_opfor_co.paa"],
				[2, _cheetahDir + "apc_tracked_01_aa_tower_opfor_co.paa"]
			]],
			["AAF", [
				[0, _cheetahDir + "apc_tracked_01_body_indp_co.paa"],
				[1, _cheetahDir + "apc_tracked_01_body_indp_co.paa"],
				[2, _cheetahDir + "apc_tracked_01_body_indp_co.paa"]
			]]
		]
	],
	[
		"B_APC_Tracked_01_CRV_F",
		[
			["Hex", [
				[0, _cheetahDir + "apc_tracked_01_aa_body_opfor_co.paa"],
				[1, _cheetahDir + "apc_tracked_01_aa_body_opfor_co.paa"],
				[2, "\A3\data_f\vehicles\turret_opfor_co.paa"],
				[3, _cheetahDir + "apc_tracked_01_crv_opfor_co.paa"]
			]],
			["AAF", [
				[0, _cheetahDir + "apc_tracked_01_body_indp_co.paa"],
				[1, _cheetahDir + "apc_tracked_01_body_indp_co.paa"],
				[2, "\A3\data_f\vehicles\turret_indp_co.paa"]
			]]
		]
	],
	[
		"B_APC_Tracked_01_rcws_F",
		[
			["Hex", [
				[0, _cheetahDir + "apc_tracked_01_aa_body_opfor_co.paa"],
				[1, _cheetahDir + "apc_tracked_01_aa_body_opfor_co.paa"],
				[2, "\A3\data_f\vehicles\turret_opfor_co.paa"]
			]],
			["AAF", [
				[0, _cheetahDir + "apc_tracked_01_body_indp_co.paa"],
				[1, _cheetahDir + "apc_tracked_01_body_indp_co.paa"],
				[2, "\A3\data_f\vehicles\turret_indp_co.paa"]
			]]
		]
	],
	[
		"I_Truck_02_MRL_F",
		[
			["Hex", [
				[0, _zamakDir + "Truck_02_kab_opfor_co.paa"],
				[1, _zamakDir + "truck_02_int_co.paa"],
				[2, "\A3\soft_f_gamma\truck_02\data\truck_02_mrl_OPFOR_co.paa"]
			]],
			["Green Hex", [
				[0, "\A3\soft_f_exp\truck_02\data\truck_02_kab_GHEX_co.paa"],
				[1, _zamakDir + "truck_02_int_co.paa"],
				[2, "\A3\soft_f_gamma\truck_02\data\truck_02_mrl_OPFOR_co.paa"]
			]]
		]
	],
	[
		"B_Plane_CAS_01_dynamicLoadout_F",
		[
			["Blacksnake", [
				[0, _texDir + "wipeout_blacksnake_0.paa"],
				[1, _texDir + "wipeout_blacksnake_1.paa"]
			]]
		]
	],
	[
		"B_MRAP_01_F",
		[
			["Gendarmerie", [
				[0, _texDir + "hunter_gendarmerie_0.paa"],
				[1, _texDir + "hunter_gendarmerie_1.paa"]
			]]
		]
	],
	[
		"I_Heli_light_03_unarmed_F",
		[
			["Gendarmerie", [
				[0, _texDir + "hellcat_gendarmerie_0.paa"]
			]]
		]
	],
	[
		"I_Heli_Transport_02_F",
		[
			["Marine One", [
				[0, _texDir + "mohawk_marine_one_0.paa"],
				[1, _texDir + "mohawk_marine_one_1.paa"],
				[2, _texDir + "mohawk_marine_one_2.paa"]
			]]
		]
	]
];

//General Store Item List
//Display Name, Class Name, Description, Picture, Buy Price, Sell Price.
// ["Medical Kit", "medkits", localize "STR_WL_ShopDescriptions_MedKit", "client\icons\medkit.paa", 400, 200],  // not needed since there are First Ait Kits
customPlayerItems = compileFinal str
[
	["Artillery Strike", "artillery", "", "client\icons\tablet.paa", 75000, 25000, "HIDDEN"],
	["Water Bottle", "water", localize "STR_WL_ShopDescriptions_Water", "client\icons\waterbottle.paa", 50, 30],
	["Canned Food", "cannedfood", localize "STR_WL_ShopDescriptions_CanFood", "client\icons\cannedfood.paa", 50, 30],
	["Repair Kit", "repairkit", localize "STR_WL_ShopDescriptions_RepairKit", "client\icons\briefcase.paa", 1000, 300],
	["Defibrillator", "defibrillator", localize "STR_WL_ShopDescriptions_Defibrillator", "client\icons\defibrillator.paa", 13000, 5000],
	["Jerry Can (Full)", "jerrycanfull", localize "STR_WL_ShopDescriptions_fuelFull", "client\icons\jerrycan.paa", 300, 150],
	["Jerry Can (Empty)", "jerrycanempty", localize "STR_WL_ShopDescriptions_fuelEmpty", "client\icons\jerrycan.paa", 100, 50],
	["Spawn Beacon", "spawnbeacon", localize "STR_WL_ShopDescriptions_spawnBeacon", "client\icons\spawnbeacon.paa", 5000, 1500],
	["Strap-on Bomb", "straponbomb", localize "STR_WL_ShopDescriptions_strapBomb", "client\icons\straponbomb.paa", 2500, 1250],
	["Camo Net", "camonet", localize "STR_WL_ShopDescriptions_Camo", "client\icons\camonet.paa", 300, 150],
	["Syphon Hose", "syphonhose", localize "STR_WL_ShopDescriptions_SyphonHose", "client\icons\syphonhose.paa", 500, 250],
	["Energy Drink", "energydrink", localize "STR_WL_ShopDescriptions_Energy_Drink", "client\icons\energydrink.paa", 200, 100],
	["Quadbike", "quadbike", localize "STR_WL_ShopDescriptions_QuadBike", "\A3\Soft_F\Quadbike_01\Data\UI\Quadbike_01_CA.paa", 500, 250],
	["Water Scooter", "waterscooter", localize "STR_WL_ShopDescriptions_WaterScooter", "\A3\Boat_F_Exp\Scooter_Transport_01\Data\UI\Scooter_Transport_01_CA.paa", 500, 250],
	["Warchest", "warchest", localize "STR_WL_ShopDescriptions_Warchest", "client\icons\warchest.paa", 3000, 1000] 
];

call compile preprocessFileLineNumbers "mapConfig\storeOwners.sqf";

storeConfigDone = compileFinal "true";
