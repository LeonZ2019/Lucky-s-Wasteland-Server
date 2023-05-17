params ["_target", "", "", "", "_text"];

private _stringtable = ["$STR_A3_C_CfgVehicles_DeconShower_01_base_F_UserActions_Deactivate0", "STR_A3_C_CfgVehicles_DeconShower_02_base_F_UserActions_Activate1"] apply { localize _x };
if (CBRN_shower_list findIf {_x == (typeOf _target)} != -1 && _text in _stringtable) then
{
	_this spawn CBRN_Decon_Shower;
};