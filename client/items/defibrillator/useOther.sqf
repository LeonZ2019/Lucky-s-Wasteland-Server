//	@file Name: useOther.sqf
//	@file Author: Leon

#define ANIM "UnconsciousReviveMedic_B"
#define ERR_CANCELLED "Action Cancelled"
#define ERR_IN_VEHICLE "Action Failed! You can't do this in a vehicle"
#define ERR_USE_ON_DEAD_BODY "Action Failed! You can't use it on dead body"
#define ERR_TOO_FAR "You are too far away"
#define ERR_NO_TARGET "No unconscious player around you"
#define ERR_MISSION_MAN "You can't use defibrillator on mission character"

mf_items_nearest_unconscious_player = {
    private ["_target", "_targets", "_distances"];
	_target = objNull;
	_targets = nearestObjects [player, ["Man"], 5] select {_x getVariable ["FAR_isUnconscious", 0] == 1};
    _distances = [];
    {
        _distances pushBack (_x distance player);
    } forEach _targets;
    _distances sort true;
    {
        if ((_x distance player) == (_distances select 0)) then {
            _target = _x;
        };
    } forEach _targets;
	_target;
} call mf_compile;

_target = [] call mf_items_nearest_unconscious_player;

private ["_hasFailed", "_success"];
_hasFailed = {
	private ["_progress", "_failed", "_text"];
	_progress = _this select 0;
	_failed = true;
	switch (true) do {
		case (!alive player): {};
		case (doCancelAction): {doCancelAction = false; _text = ERR_CANCELLED;};
		case (vehicle player != player): {_text = ERR_IN_VEHICLE};
		case (isNull _target): {_text = ERR_NO_TARGET};
		case (!alive _target): {_text = ERR_USE_ON_DEAD_BODY};
		case (_target getVariable ["Mission_Man", false]): {_text = ERR_MISSION_MAN};
        case (player distance _target > 5): {_text = ERR_TOO_FAR};
		default {
			_text = format["Restoring %3 heartbeat %1%2", round(_progress*100), "%", name _target];
			_failed = false;
		};
	};
	[_failed, _text];
};
_target setVariable ["FAR_treatedBy", player, true];
player setVariable ["FAR_isTreating", _target];
_success = [MF_ITEMS_AED_DURATION, ANIM, _hasFailed, []] call a3w_actions_start;

if (_success) then {
	[player, "reviveCount", 1] call fn_addScore;
	_target setVariable ["FAR_isUnconscious", 0, true];
	_target setDamage 0.25;
    ["defibrillator", 1] call mf_inventory_remove;
	["You bring back player from dead", 5] call mf_notify_client;
};
_target setVariable ["FAR_treatedBy", nil, true];
player setVariable ["FAR_isTreating", nil];
_success;

