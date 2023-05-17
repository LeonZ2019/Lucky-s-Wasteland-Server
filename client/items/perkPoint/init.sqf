#define build(file) format["%1\%2", _this, file] call mf_compile
#define path(file) format["%1\%2",_this, file]

MF_ITEMS_PERKS = "perkPoint";
MF_ITEMS_PERKS_DURATION = 1;

_store = build("store.sqf");
_icon = "\A3\Soft_F\Quadbike_01\Data\UI\Quadbike_01_CA.paa";
[MF_ITEMS_PERKS, "Perk Point", _store, "CBRNContainer_01_closed_yellow_F", _icon, 10] call mf_inventory_create;

mf_items_can_take_perk_point = build("canTakeFromCrate.sqf");

private _label = format ["<img image='%1'/>Take Perk Point", _icon];
private _action = [_label, build("takeFromCrate.sqf"), [], 5.05, false, false, "", "call mf_items_can_take_perk_point == ''"];
["take-perkPoint", _action] call mf_player_actions_set;

mf_items_perk_point_can_store = build("canStoreToWorkbench.sqf");

get_front_workbench =
{
	params [["_justWorkbench", true, [true]]];
	private ["_wb", "_types", "_objects"];
	_wb = objNull;
	_types = ["Land_Workbench_01_F"];
	if (!_justWorkbench) then
	{
		_types append ["ReammoBox_F", "CBRNContainer_01_closed_yellow_F"];
	};
	_objects = nearestObjects [player, _types, 3];
	{
		if ([_x, player] call BIS_fnc_relativeDirTo > 150 && [_x, player] call BIS_fnc_relativeDirTo < 220) exitWith
		{
			_wb = _x
		};
	} forEach _objects;
	_wb
};