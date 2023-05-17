#define ERR_TOO_FAR_AWAY "You need to be less that 3 metres from it"
#define ERR_ON_WATER "You can't disassemble on water"
#define ERR_IN_VEHICLE "You can't disassemble it while in vehicle"

private ["_veh", "_error"];
_veh = objNull;

if (count _this == 0) then {
	_veh = call mf_items_is_workbench;
} else {
	_veh = _this select 0;
};

_error = "failed";
switch (true) do {
	case (!alive player): {_error = " "}; // Player is dead, no need for a error message
	case (surfaceIsWater position player): {_error = ERR_ON_WATER};
	case (player distance _veh > 3): {_error = ERR_TOO_FAR_AWAY};
	case (vehicle player != player): {_text = ERR_IN_VEHICLE};
	default {_error = ""};
};
_error;
