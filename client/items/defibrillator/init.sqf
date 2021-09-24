//	@file Name: use.sqf
//	@file Author: Leon

#define build(file) format["%1\%2", _this, file] call mf_compile

MF_ITEMS_AED = "defibrillator";
MF_ITEMS_AED_DURATION = 5;
_icon = "client\icons\defibrillator.paa";
[MF_ITEMS_AED, "Defibrillator", build("useOther.sqf"), "Land_Defibrillator_F", _icon, 3] call mf_inventory_create;
