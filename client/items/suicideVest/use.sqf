//	@file Name: useOther.sqf
//	@file Author: Leon

#define ANIM "AinvPknlMstpSlayWrflDnon_medic"
#define ERR_CANCELLED "Action Cancelled"
#define ERR_NO_VEST "No vest found"
#define ERR_ALREADY_HAVE "You are wearing it"

private ["_hasFailed", "_success"];
_hasFailed = {
	private ["_progress", "_failed", "_text"];
	_progress = _this select 0;
	_failed = true;
	switch (true) do {
		case (!alive player): {};
		case (doCancelAction): {doCancelAction = false; _text = ERR_CANCELLED;};
        case (vest player == ""): {_text = ERR_NO_VEST};
        case (player getVariable ["isVestArmed", false]): {_text = ERR_ALREADY_HAVE};
		default {
			_text = format["Putting dynamite on vest... %1%2", round(_progress*100), "%"];
			_failed = false;
		};
	};
	[_failed, _text];
};
_success = [MF_ITEMS_IED_DURATION, ANIM, _hasFailed, []] call a3w_actions_start;

if (_success) then {
	player setVariable ["isVestArmed", true, true];
	["You have put the dynamite on your vest", 5] call mf_notify_client;
};
_success;

