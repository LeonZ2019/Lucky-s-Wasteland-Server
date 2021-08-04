//	@file Name: use.sqf
//	@file Author: Leon

#define build(file) format["%1\%2", _this, file] call mf_compile

MF_ITEMS_IED = "straponbomb";
MF_ITEMS_IED_DURATION = 5;
_icon = "client\icons\straponbomb.paa";
[MF_ITEMS_IED, "Strap-on bomb", build("use.sqf"), "Land_MobilePhone_old_F", _icon, 2] call mf_inventory_create;
