#define ANIM "AinvPknlMstpSlayWrflDnon_medic"
#define DURATION MF_ITEMS_WORKBENCH_DURATION
#define ERR_CANCELLED "Disassemble Workbench Cancelled"
#define ERR_TOO_FAR_AWAY "Disassembling Workbench Failed! You moved too far away from the workbench"
#define ERR_SOMEONE_ELSE_TAKEN "Packing Workbench Failed! Someone else finished disassembling it up before you"

private ["_wb", "_error", "_hasFailed", "_success"];
_wb = call mf_items_is_workbench;
_error = [_wb] call mf_items_workbench_can_disassemble;
if (_error != "") exitWith {[_error, 5] call mf_notify_client};

_hasFailed = {
	private ["_progress", "_wb", "_caller", "_failed", "_text"];
	_progress = _this select 0;
	_wb = _this select 1;
	_text = "";
	_failed = true;
	switch (true) do {
		case (!alive player): {}; // player dead, no error msg needed
		case (vehicle player != player): {};
		case (isNull _wb): {_text = ERR_SOMEONE_ELSE_TAKEN};
		case (player distance _wb > 3): {_text = ERR_TOO_FAR_AWAY};
		case (doCancelAction): {doCancelAction = false; _text = ERR_CANCELLED};
		default {
			_text = format["Workbench is %1%2 Disassembled", round(_progress*100), "%"];
			_failed = false;
		};
	};
	[_failed, _text];
};

_success =  [DURATION, ANIM, _hasFailed, [_wb]] call a3w_actions_start;

if (_success) then {
	_posATL = getPosATL _wb;
	deleteVehicle _wb;
	deleteVehicle (attachedObjects _wb select 0);	 
	if (MF_ITEMS_WORKBENCH call mf_inventory_is_full) then
	{
		_obj = createVehicle ["Land_WoodenCrate_01_F", _posATL, [], 1, "CAN_COLLIDE"];
		_obj setDir random 360;
		_obj setVariable ["mf_item_id", "workbench", true];
		_obj call A3W_fnc_setItemCleanup;
	} else
	{
		[MF_ITEMS_WORKBENCH, 1] call mf_inventory_add;
	};
	["You successfully disassemble the Workbench", 5] call mf_notify_client;
};
