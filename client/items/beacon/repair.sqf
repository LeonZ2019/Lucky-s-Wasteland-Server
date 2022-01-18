
#define ANIM "AinvPknlMstpSlayWrflDnon_medic"
#define ERR_CANCELLED "Action Cancelled"
#define ERR_IN_VEHICLE "Action Failed! You can't do this in a vehicle"
#define ERR_NOSTANCE "Action Failed! You can't do this in current stance"
private ["_hasFailed", "_success","_pos","_uid","_beacon"];
_hasFailed = {
	private ["_progress", "_failed", "_text"];
	_progress = _this select 0;
	_failed = true;
	switch (true) do {
		case (!alive player): {};
		case (doCancelAction) :{doCancelAction = false; _text = ERR_CANCELLED;};
		case (vehicle player != player): {_text = ERR_IN_VEHICLE};
		case (stance player == "UNDEFINED"): {_text = ERR_NOSTANCE};
		default {
			_text = format["Spawn Beacon %1%2 Repaired", round(_progress*100), "%"];
			_failed = false;
		};
	};
	[_failed, _text];
};

_success = [[MF_ITEMS_SPAWN_BEACON_DURATION * 0.4, 0] call BIS_fnc_cutDecimals, ANIM, _hasFailed, []] call a3w_actions_start;

if (_success) then {
    _beacon setDamage 0;
	["You repaired the Spawn Beacon successfully!", 5] call mf_notify_client;
};
_success;
