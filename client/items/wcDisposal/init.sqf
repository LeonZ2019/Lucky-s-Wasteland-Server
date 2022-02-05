//	@file Name: use.sqf
//	@file Author: Leon

#define build(file) format["%1\%2", _this, file] call mf_compile

MF_ITEMS_SWITCH_ID_DURATION = 5;
_icon = "client\icons\idcard.paa";
_class = "Land_Wallet_01_F";
["wcdisposal", "New ID Card", build("use.sqf"), _class, _icon, 2] call mf_inventory_create;
["wccard", "Old ID Card", build("reuse.sqf"), _class, _icon, 1] call mf_inventory_create;
