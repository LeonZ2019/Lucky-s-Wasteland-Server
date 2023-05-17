#define ERR_IN_VEHICLE "Can't do that while in a vehicle"
#define ERR_TOO_FAR "You are too far away"

_crate = [false] call get_front_workbench;
private _error = "failed";

switch (true) do
{
	case (isNull _crate): {};
	case (!alive player): {};
	case (_crate getVariable ["objectLocked", false]): {};
	case (player distance _crate > 3): {_error = ERR_TOO_FAR};
	case (vehicle player != player): {_error = ERR_IN_VEHICLE};
	case (_crate getVariable ["A3W_inventoryLockR3F", false] && _crate getVariable ["R3F_LOG_disabled", false]): {};
	case (_crate getVariable ["perkPoints", 0] < 1): {};
	default {_error = ""};
};

_error
