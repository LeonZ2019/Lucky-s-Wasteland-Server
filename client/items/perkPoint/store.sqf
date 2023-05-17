// use to workbench
#define ANIM "AinvPknlMstpSlayWrflDnon_medic"
#define ERR_CANCELLED "Action Cancelled"
#define ERR_IN_VEHICLE "Action Failed! You can't do this in a vehicle"
private ["_hasFailed", "_success","_wb","_havePts"];
_wb = [] call get_front_workbench;

_hasFailed = {
	private ["_progress", "_failed", "_text"];
	_progress = _this select 0;
	_error = [_wb] call mf_items_perk_point_can_store;
	_failed = true;
	switch (true) do {
		case (_error != ""): {_text = _error};
		case (!alive player): {};
		case (doCancelAction): {doCancelAction = false; _text = ERR_CANCELLED;};
		case (vehicle player != player): {_text = ERR_IN_VEHICLE};
		default {
			_text = format["1 Perk Points %1%2 Inserted", round(_progress*100), "%"];
			_failed = false;
		};
	};
	[_failed, _text];
};
_success = [MF_ITEMS_PERKS_DURATION, ANIM, _hasFailed, []] call a3w_actions_start;

if (_success) then {
	_havePts = _wb getVariable ["perkPoints", 0];
    _wb setVariable ["perkPoints", _havePts + 1, true];
	["You inserted 1 perk point successfully!", 5] call mf_notify_client;
};
_success
