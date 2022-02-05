//	@file Name: useOther.sqf
//	@file Author: Leon

#define ANIM "AinvPknlMstpSlayWrflDnon_medic"
#define ERR_CANCELLED "Action Cancelled"
#define ERR_CLEAN_PROFILE "Your profile is clean"
#define ERR_ALREADY_HAVE "Your can't hold more than 1 Old ID Card"

private ["_hasFailed", "_success", "_wcScore"];
_wcScore = [player, "warCrimes"] call fn_getScore;
_hasFailed = {
	private ["_progress", "_failed", "_text"];
	_progress = _this select 0;
	_failed = true;
	switch (true) do {
		case (!alive player): {};
		case (doCancelAction): {doCancelAction = false; _text = ERR_CANCELLED};
		case (_wcScore == 0): {_text = ERR_CLEAN_PROFILE};
		case ("wccard" call mf_inventory_count > 0): {_text = ERR_ALREADY_HAVE};
		default {
			_text = format["Switching to new ID... %1%2", round(_progress*100), "%"];
			_failed = false;
		};
	};
	[_failed, _text];
};
_success = [MF_ITEMS_SWITCH_ID_DURATION, ANIM, _hasFailed, []] call a3w_actions_start;

if (_success) then {
	_wcScore = [player, "warCrimes"] call fn_getScore; // recache
	[player, "warCrimes", -_wcScore] call fn_addScore;
	player setVariable ["OldWCScore", _wcScore, true];
	["wccard", 1] call mf_inventory_add;
	["You switched to new ID", 5] call mf_notify_client;
};
_success;

