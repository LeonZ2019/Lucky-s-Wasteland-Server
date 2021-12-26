
#define DURATION 2.5
#define ANIMATION "AinvPknlMstpSnonWnonDnon_medic_1"
#define ERR_CANCELLED "Chop Tree Cancelled!"
#define ERR_NO_TREE "No Tree on found on cursor!"
private ["_checks", "_success"];

if (mutexScriptInProgress) exitWith
{
	["You are already performing another action.", 5] call mf_notify_client;
};

// condition
/*
_tree = objNull;
{
	_relDir = player getRelDir _x;
	if (_relDir > 180) then { _relDir = _relDir - 360 };
	if (abs _relDir <= 45 && player distance2D _x <= 5) exitWith {
		_tree = _x;
	}
} forEach nearestTerrainObjects [player, ["Tree"], 16];
_tree

cursorObject distance2D player <= 5 && (getModelInfo cursorObject select 0) in ["t_broussonetiap1s_f.p3d","t_ficusb1s_f.p3d","t_ficusb2s_f.p3d","t_fraxinusav2s_f.p3d","t_oleae1s_f.p3d","t_oleae2s_f.p3d","t_phoenixc1s_f.p3d","t_phoenixc3s_f.p3d","t_pinusp3s_f.p3d","t_pinuss1s_f.p3d","t_pinuss2s_b_f.p3d","t_pinuss2s_f.p3d","t_poplar2f_dead_f.p3d","t_populusn3s_f.p3d","t_quercusir2s_f.p3d"]
*/

_tree = objNull;
if (cursorObject distance2D player <= 4 && (getModelInfo cursorObject select 0) in ["t_broussonetiap1s_f.p3d","t_ficusb1s_f.p3d","t_ficusb2s_f.p3d","t_fraxinusav2s_f.p3d","t_oleae1s_f.p3d","t_oleae2s_f.p3d","t_phoenixc1s_f.p3d","t_phoenixc3s_f.p3d","t_pinusp3s_f.p3d","t_pinuss1s_f.p3d","t_pinuss2s_b_f.p3d","t_pinuss2s_f.p3d","t_poplar2f_dead_f.p3d","t_populusn3s_f.p3d","t_quercusir2s_f.p3d"]) then
{
	_tree = cursorObject;
};
_checks = {
	private ["_progress","_failed", "_text"];
	_progress = _this select 0;
	_text = "";
	_failed = true;
	switch (true) do {
		case (!alive player): {}; // player is dead, no need for a notification
		case (isNull _tree): {_text = ERR_NO_TREE};
		case (doCancelAction): {_text = ERR_CANCELLED; doCancelAction = false;};
		default {
			_text = format["Chopping tree %1%2 Complete", round(100 * _progress), "%"];
			_failed = false;
		};
	};
	[_failed, _text];
};

mutexScriptInProgress = true;

_success = [DURATION, ANIMATION, _checks, []] call a3w_actions_start;

mutexScriptInProgress = false;

if (_success) then {
	_tree setDamage 1;
	["Action Completed!", 5] call mf_notify_client;
};
