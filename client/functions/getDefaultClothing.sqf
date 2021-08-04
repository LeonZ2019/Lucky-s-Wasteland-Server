// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: getDefaultClothing.sqf
//	@file Author: AgentRev
//	@file Created: 22/12/2013 22:04

private ["_unit", "_item", "_side", "_isSniper", "_isDiver", "_result"];

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
_result = "";

switch (_side) do
{
	case BLUFOR:
	{
		switch (true) do
		{
			case (_isSniper):
			{
				if (_item == "uniform") then { _result = "U_B_Ghilliesuit" };
				if (_item == "vest") then { _result = "V_PlateCarrier1_rgr" };
				if (_item == "weapon") then { _result = "arifle_MXM_F" };
				if (_item == "weaponItem") then { _result = ["optic_DMS", "30Rnd_65x39_caseless_mag"] };
				if (_item == "backpack") then { _result = "B_AssaultPack_mcamo" };
			};
			case (_isDiver):
			{
				if (_item == "uniform") then { _result = "U_B_Wetsuit" };
				if (_item == "vest") then { _result = "V_RebreatherB" };
				if (_item == "goggles") then { _result = "G_Diving" };
				if (_item == "weapon") then { _result = "arifle_SDAR_F" };
				if (_item == "weaponItem") then { _result = ["", "30Rnd_556x45_Stanag_Tracer_Green", "20Rnd_556x45_UW_mag"] };
				if (_item == "backpack") then { _result = "B_AssaultPack_blk" };
			};
			default
			{
				if (_item == "uniform") then { _result = "U_B_CombatUniform_mcam" };
				if (_item == "vest") then { _result = "V_PlateCarrier1_rgr" };
				if (_item == "weapon") then { _result = "arifle_MX_F" };
				if (_item == "weaponItem") then { _result = ["optic_Hamr", "30Rnd_65x39_caseless_mag_Tracer"] };
				if (_item == "backpack") then { _result = "B_AssaultPack_mcamo" };
			};
		};
		if (_item == "headgear") then { _result = "H_HelmetB" };
	};
	case OPFOR:
	{
		switch (true) do
		{
			case (_isSniper):
			{
				if (_item == "uniform") then { _result = "U_O_Ghilliesuit" };
				if (_item == "vest") then { _result = "V_TacVest_khk" };
				if (_item == "weapon") then { _result = "srifle_DMR_07_blk_F" };
				if (_item == "weaponItem") then { _result = ["optic_DMS", "20Rnd_650x39_Cased_Mag_F"] };
				if (_item == "backpack") then { _result = "B_AssaultPack_ocamo" };
			};
			case (_isDiver):
			{
				if (_item == "uniform") then { _result = "U_O_Wetsuit" };
				if (_item == "vest") then { _result = "V_RebreatherIR" };
				if (_item == "goggles") then { _result = "G_Diving" };
				if (_item == "weapon") then { _result = "arifle_SDAR_F" };
				if (_item == "weaponItem") then { _result = ["", "30Rnd_556x45_Stanag_Tracer_Green", "20Rnd_556x45_UW_mag"] };
				if (_item == "backpack") then { _result = "B_AssaultPack_blk" };
			};
			default
			{
				if (_item == "uniform") then { _result = "U_O_CombatUniform_ocamo" };
				if (_item == "vest") then { _result = "V_TacVest_khk" };
				if (_item == "weapon") then { _result = "arifle_Katiba_F" };
				if (_item == "weaponItem") then { _result = ["optic_Hamr", "30Rnd_65x39_caseless_green_mag_Tracer"] };
				if (_item == "backpack") then { _result = "B_AssaultPack_ocamo" };
			};
		};
		if (_item == "headgear") then { _result = "H_HelmetO_ocamo" };
	};
	default
	{
		switch (true) do
		{
			case (_isSniper):
			{
				if (_item == "uniform") then { _result = "U_I_Ghilliesuit" };
				if (_item == "vest") then { _result = "V_TacVest_camo" };
				if (_item == "weapon") then { _result = "srifle_EBR_F" };
				if (_item == "weaponItem") then { _result = ["optic_DMS", "20Rnd_762x51_Mag"] };
				if (_item == "backpack") then { _result = "B_AssaultPack_dgtl" };
			};
			case (_isDiver):
			{
				if (_item == "uniform") then { _result = "U_I_Wetsuit" };
				if (_item == "vest") then { _result = "V_RebreatherIA" };
				if (_item == "goggles") then { _result = "G_Diving" };
				if (_item == "weapon") then { _result = "arifle_SDAR_F" };
				if (_item == "weaponItem") then { _result = ["", "30Rnd_556x45_Stanag_Tracer_Green", "20Rnd_556x45_UW_mag"] };
				if (_item == "backpack") then { _result = "B_AssaultPack_blk" };
			};
			default
			{
				if (_item == "uniform") then { _result = "U_I_CombatUniform" };
				if (_item == "vest") then { _result = "V_TacVest_camo" };
				if (_item == "weapon") then { _result = "arifle_Mk20_F" };
				if (_item == "weaponItem") then { _result = ["optic_Hamr", "30Rnd_556x45_Stanag_Tracer_Green"] };
				if (_item == "backpack") then { _result = "B_AssaultPack_dgtl" };
			};
		};
		if (_item == "headgear") then { _result = "H_HelmetIA_net" };
	};
};

_result
