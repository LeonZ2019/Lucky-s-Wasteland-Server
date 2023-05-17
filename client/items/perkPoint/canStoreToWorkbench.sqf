#define ERR_NO_WORKBENCH "Action Failed! No workbench nearby"
#define ERR_IN_VEHICLE "You can't do this while in a vehicle."
#define ERR_NO_PERKPOINT "You have no perk points."
private ["_wb", "_error"];
_wb = objNull;
if (count _this == 0) then {
	_wb = [] call get_front_workbench;
} else {
	_wb = _this select 0;
};

_error = "";
switch (true) do {
	case (isNull _wb): {_error = ERR_NO_WORKBENCH};
	case (vehicle player != player): {_error = ERR_IN_VEHICLE};
	// case ((MF_ITEMS_PERKS call mf_inventory_count) <= 0): {_error = ERR_NO_PERKPOINT};
};
_error
