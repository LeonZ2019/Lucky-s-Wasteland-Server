#define ANIM "AinvPknlMstpSlayWrflDnon_medic"
#define ERR_CANCELLED "Action Cancelled"
#define ERR_IN_VEHICLE "Action Failed! You can't do this in a vehicle"
private ["_hasFailed", "_success","_pos","_uid","_veh"];
_hasFailed = {
	private ["_progress", "_failed", "_text"];
	_progress = _this select 0;
	_failed = true;
	switch (true) do {
		case (!alive player): {};
		case (doCancelAction): {doCancelAction = false; _text = ERR_CANCELLED;};
		case (vehicle player != player): {_text = ERR_IN_VEHICLE};
		default {
			_text = format["Workbench %1%2 Assembled", round(_progress*100), "%"];
			_failed = false;
		};
	};
	[_failed, _text];
};
_success = [MF_ITEMS_WORKBENCH_DURATION, ANIM, _hasFailed, []] call a3w_actions_start;

if (_success) then {
	_uid = getPlayerUID player;
	_class = MF_ITEMS_WORKBENCH_CLASS;
	_pos = [player, [0.3,1.5,0]] call relativePos; // need do calculate for PosATL
	_terrianHeight = (getPosATL player) select 2;
	_pos set [2, _terrianHeight];
	_wb = createVehicle [_class, _pos, [], 0, "NONE"];
	_wb setDir getDir player;
	// _wb setPosATL _pos; // fuck player?
	_wb setVariable ["a3w_workbench", true, true];
	_wb setVariable ["R3F_LOG_disabled", true];
	_wb setVariable ["side", playerSide, true];
    _wb setVariable ["ownerUID", _uid];
	_pc = createVehicle ["Land_MultiScreenComputer_01_olive_F", _pos, [], 0, "CAN_COLLIDE"];
	_pc attachTo [_wb, [0,0,0.569339]];
	["You've assembled workbench successfully!", 5] call mf_notify_client;
};
_success;

