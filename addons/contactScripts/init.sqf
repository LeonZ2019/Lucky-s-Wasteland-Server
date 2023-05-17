diag_log "[CBRN] Setting Up";
CBRN_gear_list = ["G_AirPurifyingRespirator_01_F", "G_AirPurifyingRespirator_01_nofilter_F", "G_AirPurifyingRespirator_02_black_F", "G_AirPurifyingRespirator_02_black_nofilter_F", "G_AirPurifyingRespirator_02_olive_F", "G_AirPurifyingRespirator_02_olive_nofilter_F", "G_AirPurifyingRespirator_02_sand_F", "G_AirPurifyingRespirator_02_sand_nofilter_F", "G_RegulatorMask_F", "G_Blindfold_01_black_F", "G_Blindfold_01_white_F", "B_CombinationUnitRespirator_01_F", "B_SCBA_01_F", "ChemicalDetector_01_watch_F", "G_Respirator_blue_F", "G_Respirator_white_F", "G_Respirator_yellow_F"];
CBRN_uniform_list = ["U_I_CBRN_Suit_01_AAF_F", "U_C_CBRN_Suit_01_Blue_F", "U_I_E_CBRN_Suit_01_EAF_F", "U_B_CBRN_Suit_01_MTP_F", "U_B_CBRN_Suit_01_Tropic_F", "U_C_CBRN_Suit_01_White_F", "U_B_CBRN_Suit_01_Wdl_F", "U_B_Wetsuit", "U_O_Wetsuit", "U_I_Wetsuit"];
CBRN_radio_list = ["B_RadioBag_01_black_F", "B_RadioBag_01_digi_F", "B_RadioBag_01_eaf_F", "B_RadioBag_01_ghex_F", "B_RadioBag_01_hex_F", "B_RadioBag_01_mtp_F", "B_RadioBag_01_tropic_F", "B_RadioBag_01_oucamo_F", "B_RadioBag_01_wdl_F"];
CBRN_item_list = ["Item_AntidoteKit_01_F", "Item_DeconKit_01_F"];
CBRN_shower_list = ["DeconShower_01_F", "DeconShower_02_F"];

CBRN_Decon_Shower = compile preprocessFileLineNumbers "addons\contactScripts\CBRN\deconShower.sqf";
CBRN_Shower_Action = compile preprocessFileLineNumbers "addons\contactScripts\CBRN\showerAction.sqf";
CBRN_decon = compile preprocessFileLineNumbers "addons\contactScripts\CBRN\decon.sqf";
CBRN_antidote = compile preprocessFileLineNumbers "addons\contactScripts\CBRN\antidote.sqf";
CBRN_gear_update = compile preprocessFileLineNumbers "addons\contactScripts\GEAR\gearUpdate.sqf";

if (isServer) then
{
	CBRN_contaminants = [];
	publicVariable "CBRN_contaminants";
};

if (hasInterface) then
{
	player addEventHandler ["Respawn", {
		params ["_unit"];
		diag_log "[CBRN] Respawn";
		_unit setVariable ["killByChemical", false, true];
		_unit setVariable ["CBRN_Exposure", 0, true];
		_unit setVariable ["CBRN_Contaminate", false, true];
	}];
	waitUntil {["playerSetupComplete", false] call getPublicVar};
	contaminateArea = [];
	[] execVM "addons\contactScripts\CBRN\actions.sqf";
	[] execVM "addons\contactScripts\GEAR\switchAntenna.sqf";
	[] execVM "addons\contactScripts\GEAR\spectrum_device.sqf";
	[] execVM "addons\contactScripts\fn_grenadeThrowback.sqf";
	[] execVM "addons\contactScripts\LightSwitch.sqf";
	[] execVM "addons\contactScripts\CBRN\inContaminant.sqf";

	[player] call CBRN_gear_update;
	diag_log "[CBRN] Initialed";
	// [] execVM "addons\contactScripts\CBRN\contaminate.sqf";
	// [] execVM "addons\contactScripts\CBRN\";
};