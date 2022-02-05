// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: getDefaultClothing.sqf
//	@file Author: AgentRev
//	@file Created: 22/12/2013 22:04

private ["_unit", "_item", "_side", "_isSniper", "_isDiver", "_isPilot", "_result", "_ownedUniform", "_ownedSight", "_ownedSet", "_dlcOwned"];

_unit = _this select 0;
_item = _this select 1;

if (typeName _unit == "OBJECT") then
{
	_side = if (_unit == player) then { playerSide } else { side _unit };
	_unit = typeOf _unit;
}
else
{
	_side = _this select 2;
};

_isSniper = (["_sniper_", _unit] call fn_findString != -1);
_isDiver = (["_diver_", _unit] call fn_findString != -1);
_isPilot = (["_Pilot_", _unit] call fn_findString != -1);

_ownedUniform = "";
_ownedSight = "";
_ownedSet = [];
_dlcOwned = false;

_result = "";

_sniperWeapons =
	[
		"srifle_DMR_04_F", "srifle_DMR_04_tan_F", "srifle_DMR_02_F", "srifle_DMR_02_camo_F", "srifle_DMR_02_sniper_F", "srifle_DMR_03_F", "srifle_DMR_03_multicam_F", "srifle_DMR_03_khaki_F", "srifle_DMR_03_tan_F", "srifle_DMR_03_woodland_F", "srifle_DMR_05_blk_F", "srifle_DMR_05_hex_F", "srifle_DMR_05_tan_f", "srifle_DMR_06_camo_F", "srifle_DMR_06_olive_F", "srifle_EBR_F", "srifle_DMR_01_F", "srifle_DMR_07_blk_F", "srifle_DMR_07_hex_F", "srifle_DMR_07_ghex_F", "srifle_LRR_LRPS_F", "srifle_LRR_camo_LRPS_F", "srifle_LRR_tna_LRPS_F", "srifle_GM6_LRPS_F", "srifle_GM6_camo_LRPS_F", "srifle_GM6_ghex_LRPS_F"
];

_bluforRifles = [
	"arifle_MX_F", "arifle_MX_Black_F", "arifle_MX_khk_F", "arifle_SPAR_01_blk_F", "arifle_SPAR_01_khk_F", "arifle_SPAR_01_snd_F"
];

_opforRifles = [
	"arifle_Katiba_F", "arifle_Katiba_GL_F", "arifle_CTAR_blk_F", "arifle_CTAR_hex_F", "arifle_CTAR_ghex_F", "arifle_ARX_blk_F", "arifle_ARX_hex_F", "arifle_ARX_ghex_F", "arifle_AK12_F", "arifle_AK12_arid_F", "arifle_AK12_lush_F"
];

_independentRifles = [
	 "arifle_Mk20_plain_F", "arifle_Mk20_F", "arifle_Mk20_GL_plain_F", "arifle_Mk20_GL_F", "arifle_TRG21_F", "arifle_TRG21_GL_F", "arifle_MSBS65_F", "arifle_MSBS65_black_F", "arifle_MSBS65_camo_F", "arifle_MSBS65_sand_F"
];

// _closeRangeOptics = ["optic_Aco", "optic_Aco_grn", "optic_Holosight", "optic_Holosight_arid_F", "optic_Holosight_blk_F", "optic_Holosight_khk_F", "optic_Holosight_lush_F"];

_mediumRangeOptics = ["optic_MRCO", "optic_ERCO_blk_F", "optic_ERCO_khk_F", "optic_ERCO_snd_F", "optic_Arco", "optic_Arco_arid_F", "optic_Arco_blk_F", "optic_Arco_ghex_F", "optic_Arco_lush_F", "optic_Hamr", "optic_Hamr_khk_F"];

_longRangeOptics = ["optic_SOS", "optic_SOS_khk_F", "optic_DMS", "optic_DMS_ghex_F", "optic_DMS_weathered_F", "optic_DMS_weathered_Kir_F", "optic_KHS_blk", "optic_KHS_hex", "optic_KHS_tan", "optic_AMS", "optic_AMS_khk", "optic_AMS_snd", "optic_LRPS", "optic_LRPS_ghex_F", "optic_LRPS_tna_F"];

_sideGears = [
	[ // blufor gear
		["U_B_GhillieSuit", "U_B_T_Sniper_F", "U_B_FullGhillie_ard", "U_B_FullGhillie_lsh", "U_B_FullGhillie_sard", "U_B_T_FullGhillie_tna_F"], // sniper ghillie
		[ // normal uniform
			["H_HelmetB", ["U_B_CombatUniform_mcam", "U_B_CombatUniform_mcam_tshirt", "U_B_CombatUniform_mcam_vest"], "V_PlateCarrier1_rgr", "B_AssaultPack_rgr"], //MTP
			["H_HelmetB_plain_wdl", ["U_B_CombatUniform_mcam_wdl_f", "U_B_CombatUniform_tshirt_mcam_wdL_f", "U_B_CombatUniform_vest_mcam_wdl_f"], "V_PlateCarrier1_wdl", "B_AssaultPack_wdl_F"], //woodland
			["H_HelmetB_tna_F", ["U_B_T_Soldier_F", "U_B_T_Soldier_AR_F", "U_B_T_Soldier_SL_F"], "V_PlateCarrier1_tna_F", "B_AssaultPack_tna_F"], //Tropic
			["H_HelmetB_TI_tna_F", ["U_B_CTRG_1", "U_B_CTRG_2", "U_B_CTRG_3", "U_B_CTRG_Soldier_F", "U_B_CTRG_Soldier_3_F", "U_B_CTRG_Soldier_2_F"], "V_TacVest_oli", "B_AssaultPack_rgr"] //CTRG
		]
	],
	[ // opfor gear
		["U_O_GhillieSuit", "U_O_T_Sniper_F", "U_O_FullGhillie_ard", "U_O_FullGhillie_lsh", "U_O_FullGhillie_sard", "U_O_T_FullGhillie_tna_F"], // sniper ghillie
		[ // normal uniform
			["H_HelmetO_ocamo", ["U_O_V_Soldier_Viper_hex_F", "U_O_officer_noInsignia_hex_F", "U_O_SpecopsUniform_ocamo", "U_O_CombatUniform_ocamo"], "V_TacVest_khk", "B_AssaultPack_cbr"], //Hex
			["H_HelmetO_ghex_F", ["U_O_V_Soldier_Viper_F", "U_O_T_Soldier_F"], "V_TacVest_oli", "B_FieldPack_ghex_OTAA_F"], //Green Hex
			["H_HelmetAggressor_F", ["U_O_R_Gorka_01_F", "U_O_R_Gorka_01_brown_F", "U_O_R_Gorka_01_camo_F", "U_O_R_Gorka_01_black_F"], "V_SmershVest_01_radio_F", "B_FieldPack_green_F"] //Granit
		]
	],
	[ // indi gear
		["U_I_GhillieSuit", "U_I_FullGhillie_ard", "U_I_FullGhillie_lsh", "U_I_FullGhillie_sard", "U_B_T_FullGhillie_tna_F"], // sniper ghillie
		[ // normal uniform
			["H_HelmetIA", ["U_I_CombatUniform", "U_I_CombatUniform_shortsleeve"], "V_PlateCarrierIA1_dgtl", "B_AssaultPack_dgtl"], //Digital
			["H_HelmetHBK_headset_F", ["U_I_E_Uniform_01_shortsleeve_F", "U_I_E_Uniform_01_sweater_F", "U_I_E_Uniform_01_tanktop_F", "U_I_E_Uniform_01_F"], "V_CarrierRigKBT_01_light_EAF_F", "B_AssaultPack_eaf_F"], //Geometric
			["H_HelmetIA", ["U_IG_leader", "U_BG_Guerilla2_1", "U_IG_Guerilla1_1", "U_BG_Guerilla2_2", "U_BG_Guerilla2_3", "U_BG_Guerrilla_6_1", "U_BG_Guerilla1_1", "U_BG_Guerilla3_1", "U_I_G_resistanceLeader_F"], "V_TacVest_camo", "B_AssaultPack_khk"] //Guerilla
		]
	]
];

switch (_side) do
{
	case BLUFOR:
	{
		if (_item == "uniform") then { _result = ["H_HelmetB"] };
		switch (true) do
		{
			case (_isSniper):
			{
				if (_item == "uniform") then
				{
					while {!_dlcOwned } do
					{
						_ownedUniform = _sideGears select 0 select 0 call BIS_fnc_selectRandom;
						_dlcOwned = getAssetDLCInfo [_ownedUniform, configFile >> "CfgWeapons"] select 1;
					};
					_result append [_ownedUniform, "V_PlateCarrier1_rgr", "B_AssaultPack_rgr"];
				};
				if (_item == "weapon") then
				{
					while {!_dlcOwned } do
					{
						_result = _sniperWeapons call BIS_fnc_selectRandom;
						_dlcOwned = getAssetDLCInfo [_result, configFile >> "CfgWeapons"] select 1;
					};
				};
				if (_item == "weaponItem") then {
					while {!_dlcOwned } do
					{
						_ownedSight = _longRangeOptics call BIS_fnc_selectRandom;
						_dlcOwned = getAssetDLCInfo [_ownedSight, configFile >> "CfgWeapons"] select 1;
					};
					_result = [_ownedSight];
				};
			};
			case (_isDiver):
			{
				if (_item == "uniform") then { _result append ["U_B_Wetsuit", "V_RebreatherB", "B_AssaultPack_blk"] };
				if (_item == "goggles") then { _result = "G_Diving" };
				if (_item == "weapon") then { _result = "arifle_SDAR_F" };
				if (_item == "weaponItem") then { _result = ["", "20Rnd_556x45_UW_mag"] };
			};
			case (_isPilot):
			{
				if (_item == "uniform") then { _result = ["H_PilotHelmetFighter_B", "U_B_PilotCoveralls", "V_PlateCarrier1_blk", "B_FieldPack_blk"] };
				if (_item == "goggles") then { _result = "G_Aviator" };
				if (_item == "weapon") then { _result = "SMG_02_F" };
				if (_item == "weaponItem") then {
					while {!_dlcOwned } do
					{
						_ownedSight = _mediumRangeOptics call BIS_fnc_selectRandom;
						_dlcOwned = getAssetDLCInfo [_ownedSight, configFile >> "CfgWeapons"] select 1;
					};
					_result = [_ownedSight];
				};
			};
			default
			{
				if (_item == "uniform") then
				{
					while {!_dlcOwned } do
					{
						_ownedSet = _sideGears select 0 select 1 call BIS_fnc_selectRandom;
						_ownedUniform = _ownedSet select 1 call BIS_fnc_selectRandom;
						_dlcOwned = getAssetDLCInfo [_ownedUniform, configFile >> "CfgWeapons"] select 1;
					};
					_result = [_ownedSet select 0, _ownedUniform, _ownedSet select 2, _ownedSet select 3];
				};
				if (_item == "weapon") then
				{
					while {!_dlcOwned } do
					{
						_result = _bluforRifles call BIS_fnc_selectRandom;
						_dlcOwned = getAssetDLCInfo [_result, configFile >> "CfgWeapons"] select 1;
					};
				};
				if (_item == "weaponItem") then {
					while {!_dlcOwned } do
					{
						_ownedSight = _mediumRangeOptics call BIS_fnc_selectRandom;
						_dlcOwned = getAssetDLCInfo [_ownedSight, configFile >> "CfgWeapons"] select 1;
					};
					_result = [_ownedSight];
				};
			};
		};
		if (_item == "nvg") then { _result = "NVGoggles" };
	};
	case OPFOR:
	{
		if (_item == "uniform") then { _result = ["H_HelmetO_ocamo"] };
		switch (true) do
		{
			case (_isSniper):
			{
				if (_item == "uniform") then
				{
					while {!_dlcOwned } do
					{
						_ownedUniform = _sideGears select 1 select 0 call BIS_fnc_selectRandom;
						_dlcOwned = getAssetDLCInfo [_ownedUniform, configFile >> "CfgWeapons"] select 1;
					};
					_result append [_ownedUniform, "V_TacVest_khk", "B_AssaultPack_cbr"];
				};
				if (_item == "weapon") then
				{
					while {!_dlcOwned } do
					{
						_result = _sniperWeapons call BIS_fnc_selectRandom;
						_dlcOwned = getAssetDLCInfo [_result, configFile >> "CfgWeapons"] select 1;
					};
				};
				if (_item == "weaponItem") then {
					while {!_dlcOwned } do
					{
						_ownedSight = _longRangeOptics call BIS_fnc_selectRandom;
						_dlcOwned = getAssetDLCInfo [_ownedSight, configFile >> "CfgWeapons"] select 1;
					};
					_result = [_ownedSight];
				};
			};
			case (_isDiver):
			{
				if (_item == "uniform") then { _result append ["U_O_Wetsuit", "V_RebreatherIR", "B_AssaultPack_blk"] };
				if (_item == "goggles") then { _result = "G_Diving" };
				if (_item == "weapon") then { _result = "arifle_SDAR_F" };
				if (_item == "weaponItem") then { _result = ["", "20Rnd_556x45_UW_mag"] };
			};
			case (_isPilot):
			{
				if (_item == "uniform") then { _result = ["H_PilotHelmetFighter_O", "U_O_PilotCoveralls", "V_TacVest_brn", "B_FieldPack_cbr"] };
				if (_item == "goggles") then { _result = "G_Aviator" };
				if (_item == "weapon") then { _result = "SMG_02_F" };
				if (_item == "weaponItem") then {
					while {!_dlcOwned } do
					{
						_ownedSight = _mediumRangeOptics call BIS_fnc_selectRandom;
						_dlcOwned = getAssetDLCInfo [_ownedSight, configFile >> "CfgWeapons"] select 1;
					};
					_result = [_ownedSight];
				};
			};
			default
			{
				if (_item == "uniform") then
				{
					while {!_dlcOwned } do
					{
						_ownedSet = _sideGears select 1 select 1 call BIS_fnc_selectRandom;
						_ownedUniform = _ownedSet select 1 call BIS_fnc_selectRandom;
						_dlcOwned = getAssetDLCInfo [_ownedUniform, configFile >> "CfgWeapons"] select 1;
					};
					_result = [_ownedSet select 0, _ownedUniform, _ownedSet select 2, _ownedSet select 3];
				};
				if (_item == "weapon") then
				{
					while {!_dlcOwned } do
					{
						_result = _opforRifles call BIS_fnc_selectRandom;
						_dlcOwned = getAssetDLCInfo [_result, configFile >> "CfgWeapons"] select 1;
					};
				};
				if (_item == "weaponItem") then {
					while {!_dlcOwned } do
					{
						_ownedSight = _mediumRangeOptics call BIS_fnc_selectRandom;
						_dlcOwned = getAssetDLCInfo [_ownedSight, configFile >> "CfgWeapons"] select 1;
					};
					_result = [_ownedSight];
				};
			};
		};
		if (_item == "headgear") then { _result = "H_HelmetO_ocamo" };
		if (_item == "nvg") then { _result = "NVGoggles_OPFOR" };
	};
	default
	{
		if (_item == "uniform") then { _result = ["H_HelmetIA_net"] };
		switch (true) do
		{
			case (_isSniper):
			{
				if (_item == "uniform") then
				{
					while {!_dlcOwned } do
					{
						_ownedUniform = _sideGears select 2 select 0 call BIS_fnc_selectRandom;
						_dlcOwned = getAssetDLCInfo [_ownedUniform, configFile >> "CfgWeapons"] select 1;
					};
					_result append [_ownedUniform, "V_PlateCarrierIA1_dgtl", "B_AssaultPack_dgtl"];
				};
				if (_item == "weapon") then
				{
					while {!_dlcOwned } do
					{
						_result = _sniperWeapons call BIS_fnc_selectRandom;
						_dlcOwned = getAssetDLCInfo [_result, configFile >> "CfgWeapons"] select 1;
					};
				};
				if (_item == "weaponItem") then {
					while {!_dlcOwned } do
					{
						_ownedSight = _longRangeOptics call BIS_fnc_selectRandom;
						_dlcOwned = getAssetDLCInfo [_ownedSight, configFile >> "CfgWeapons"] select 1;
					};
					_result = [_ownedSight];
				};
			};
			case (_isDiver):
			{
				if (_item == "uniform") then { _result append ["U_I_Wetsuit", "V_RebreatherIA", "B_AssaultPack_blk"] };
				if (_item == "goggles") then { _result = "G_Diving" };
				if (_item == "weapon") then { _result = "arifle_SDAR_F" };
				if (_item == "weaponItem") then { _result = ["", "20Rnd_556x45_UW_mag"] };
			};
			case (_isPilot):
			{
				if (_item == "uniform") then { _result = ["H_PilotHelmetFighter_I", "U_I_pilotCoveralls", "V_TacVest_oli", "B_FieldPack_oli"] };
				if (_item == "goggles") then { _result = "G_Aviator" };
				if (_item == "weapon") then { _result = "SMG_02_F" };
				if (_item == "weaponItem") then {
					while {!_dlcOwned } do
					{
						_ownedSight = _mediumRangeOptics call BIS_fnc_selectRandom;
						_dlcOwned = getAssetDLCInfo [_ownedSight, configFile >> "CfgWeapons"] select 1;
					};
					_result = [_ownedSight];
				};
			};
			default
			{
				if (_item == "uniform") then
				{
					while {!_dlcOwned } do
					{
						_ownedSet = _sideGears select 2 select 1 call BIS_fnc_selectRandom;
						_ownedUniform = _ownedSet select 1 call BIS_fnc_selectRandom;
						_dlcOwned = getAssetDLCInfo [_ownedUniform, configFile >> "CfgWeapons"] select 1;
					};
					_result = [_ownedSet select 0, _ownedUniform, _ownedSet select 2, _ownedSet select 3];
				};
				if (_item == "weapon") then
				{
					while {!_dlcOwned } do
					{
						_result = _independentRifles call BIS_fnc_selectRandom;
						_dlcOwned = getAssetDLCInfo [_result, configFile >> "CfgWeapons"] select 1;
					};
				};
				if (_item == "weaponItem") then {
					while {!_dlcOwned } do
					{
						_ownedSight = _mediumRangeOptics call BIS_fnc_selectRandom;
						_dlcOwned = getAssetDLCInfo [_ownedSight, configFile >> "CfgWeapons"] select 1;
					};
					_result = [_ownedSight];
				};
			};
		};
		if (_item == "nvg") then { _result = "NVGoggles_INDEP" };
	};
};

_result
