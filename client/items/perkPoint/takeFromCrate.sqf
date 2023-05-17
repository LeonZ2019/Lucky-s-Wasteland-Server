#include "mutex.sqf"

private "_crate";
private _error = if ("perkPoint" call mf_inventory_is_full) then { "You have reached the maximum number\n of Perk Points you can carry. " } else mf_items_can_take_perk_point;
if (_error != "") exitWith
{
	[_error, 5] call a3w_actions_notify;
	playSound "FD_CP_Not_Clear_F";
};

MUTEX_LOCK_OR_FAIL;
player playActionNow "PutDown";
_perkInfo = "perkPoint" call mf_inventory_get;
_perkPts = (_perkInfo select 6) - (_perkInfo select 1);
systemChat str _perkPts;
sleep 0.25;
[player, _crate, false, _perkPts] remoteExecCall ["A3W_fnc_takePerkPoints", 2];
sleep 0.75;
MUTEX_UNLOCK;
