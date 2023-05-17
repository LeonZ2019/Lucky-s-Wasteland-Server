params["_unit"];
if (!local _unit) exitWith {};

_gear = goggles _unit;
_backpack = backpackContainer _unit;
_backpackType = backpack _unit;
_uniform = uniform _unit;
_overlay = "";

switch(true) do
{
	case (_gear in ["G_AirPurifyingRespirator_01_F", "G_AirPurifyingRespirator_01_nofilter_F", "G_AirPurifyingRespirator_02_black_F", "G_AirPurifyingRespirator_02_black_nofilter_F", "G_AirPurifyingRespirator_02_olive_F", "G_AirPurifyingRespirator_02_olive_nofilter_F", "G_AirPurifyingRespirator_02_sand_F", "G_AirPurifyingRespirator_02_sand_nofilter_F"]):
	{
		if (_gear in ["G_AirPurifyingRespirator_01_F", "G_AirPurifyingRespirator_01_nofilter_F"]) then
		{
			_overlay = "RscCBRN_APR";
		} else
		{
			if (_gear in ["G_AirPurifyingRespirator_02_black_F", "G_AirPurifyingRespirator_02_black_nofilter_F", "G_AirPurifyingRespirator_02_olive_F", "G_AirPurifyingRespirator_02_olive_nofilter_F", "G_AirPurifyingRespirator_02_sand_F", "G_AirPurifyingRespirator_02_sand_nofilter_F"]) then
			{
				_overlay = "RscCBRN_APR_02";
			};
		};
		switch true do
		{
			case (_backpackType == "B_CombinationUnitRespirator_01_F"):
			{
				if (count (_gear splitString "_") == 4) then { _unit linkItem (_gear insert [34, "nofilter_"] ); };

				_backpack setObjectTexture [1, "a3\supplies_f_enoch\bags\data\b_cur_01_co.paa"];
				_backpack setObjectTexture [2, "a3\supplies_f_enoch\bags\data\b_cur_01_co.paa"];
				_backpack setObjectTexture [3, ""];
			};
			case (_backpackType == "B_SCBA_01_F"):
			{
				if (count (_gear splitString "_") == 4) then { _unit linkItem (_gear insert [34, "nofilter_"] ); };

				_backpack setObjectTexture [1, "a3\supplies_f_enoch\bags\data\b_scba_01_co.paa"];
				_backpack setObjectTexture [2, ""];
			};
		};
	};
	case (_gear == "G_RegulatorMask_F"):
	{
		_overlay = "RscCBRN_Regulator";
		switch true do
		{
			case (_backpackType == "B_CombinationUnitRespirator_01_F"):
			{
				_backpack setObjectTexture [1, "a3\supplies_f_enoch\bags\data\b_cur_01_co.paa"];
				_backpack setObjectTexture [2, ""];
				_backpack setObjectTexture [3, "a3\supplies_f_enoch\bags\data\b_cur_01_co.paa"];
			};
			case (_backpackType == "B_SCBA_01_F"):
			{
				_backpack setObjectTexture [1, ""];
				_backpack setObjectTexture [2, "a3\supplies_f_enoch\bags\data\b_scba_01_co.paa"];
			};
		};
	};
	default
	{
		switch true do
		{
			case (_backpackType == "B_CombinationUnitRespirator_01_F"):
			{
				_backpack setObjectTexture [1, ""];
				_backpack setObjectTexture [2, ""];
				_backpack setObjectTexture [3, ""];
			};
			case (_backpackType == "B_SCBA_01_F"):
			{
				_backpack setObjectTexture [1, ""];
				_backpack setObjectTexture [2, ""];
			};
		};
	};
};
if (_gear in ["G_Blindfold_01_black_F", "G_Blindfold_01_white_F"]) then
{
	_overlay = "RscBlindfold";
};
if (_overlay == "") then
{
	"CBRN_Layer" cutText ["", "PLAIN"];
} else
{
	"CBRN_Layer" cutRsc [_overlay, "PLAIN", -1, false];
};

if ("ChemicalDetector_01_watch_F" in (assignedItems _unit)) then
{
	if (!(_unit getVariable ["CBRN_haveDetector", false])) then
	{
		_unit setVariable ["CBRN_haveDetector", true, true];
		[_unit] execVM "addons\contactScripts\GEAR\chemical_detector.sqf";
	};
} else {
	_unit setVariable ["CBRN_haveDetector", false, true];
	"CBRN_Detector" cutText ["", "PLAIN"];
};
if (_uniform in CBRN_uniform_list) then
{
	_unit setVariable ["CBRN_haveUniform", true, true];
} else
{
	_unit setVariable ["CBRN_haveUniform", false, true];
};
if (_backpack in CBRN_gear_list) then
{
	_unit setVariable ["CBRN_haveBackpack", true, true];
} else
{
	_unit setVariable ["CBRN_haveBackpack", false, true];
};
if (_gear in CBRN_gear_list) then
{
	_unit setVariable ["CBRN_haveMask", true, true];
	[_unit] execVM "addons\contactScripts\GEAR\facewear.sqf";
} else
{
	_unit setVariable ["CBRN_haveMask", false, true];
};
if (_backpack in CBRN_radio_list) then
{
	_unit setVariable ["CBRN_haveRadio", true, true];
} else
{
	_unit setVariable ["CBRN_haveRadio", false, true];
};

/*

// no uniform = direct damage, keep damage until decon
// no mask = direct damage, only in comtaminant area

// no backpack = direct damage, only in comtaminant area
// backpack = direct damage, only in comtaminant area

// mask = no fuzzy view

// mask + backpack = normal
*/

/*
["test", position player, direction player, 5,5, false] execVM "addons\contactScripts\CBRN\createArea.sqf";
*/