private ["_item", "_ballisticArmor", "_armor"];
_item = _this select 0;

([[configfile >> "CfgWeapons" >> _item], ["passthrough", "armor"]] call BIS_fnc_configExtremes select 1) params [["_passthroughMax", 0], ["_armorMax", 0]];
_ballisticArmor = parseNumber (_passthroughMax * 100 toFixed 0);
_armor = parseNumber (_armorMax * 100 toFixed 0);

[_ballisticArmor, _armor]