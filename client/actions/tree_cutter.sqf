
#define DURATION 2
#define ANIMATION "AinvPknlMstpSnonWnonDnon_medic_1"
#define ERR_CANCELLED "Chop Tree Cancelled!"
private ["_checks", "_success", "_tree"];

if (mutexScriptInProgress) exitWith
{
	["You are already performing another action.", 5] call mf_notify_client;
};

_tree = cursorObject;
_checks = {
	private ["_progress","_failed", "_text"];
	_progress = _this select 0;
	_text = "";
	_failed = true;
	switch (true) do {
		case (!alive player): {}; // player is dead, no need for a notification
		case (doCancelAction): {_text = ERR_CANCELLED; doCancelAction = false;};
		default {
			_text = format["Chopping tree %1%2 Complete", round(100 * _progress), "%"];
			_failed = false;
		};
	};
	[_failed, _text];
};

mutexScriptInProgress = true;
_sound = playSound3D [getMissionPath "client\sounds\chopTree.ogg", player];
_success = [DURATION, ANIMATION, _checks, []] call a3w_actions_start;
/*_sound spawn
{
	if (!isNull _this) then { deleteVehicle _this };
};*/
mutexScriptInProgress = false;

if (_success) then {
	_tree setDamage 1;
	["Action Completed!", 5] call mf_notify_client;
};
