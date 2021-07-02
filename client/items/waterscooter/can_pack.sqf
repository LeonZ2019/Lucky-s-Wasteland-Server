// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Version: 1.0
//@file Name: can_pack.sqf
//@file Author: MercyfulFate
//@file Created: 21/7/2013 16:00
//@file Description: Check if you can pack the spawn beacon
//@file Argument: [_beacon] the (object that is a) beacon to check if its packable
//@file Argument: [] automatically find the closest beacon to check.

#define ERR_TOO_FAR_AWAY "You need to be less that 5 metres from it"
#define ERR_ALREADY_HAVE_WATERSCOOTER "You can not carry another water scooter"
#define ERR_IN_VEHICLE "You can't pack water scooter in a vehicle"
#define ERR_VEHICLE_NOT_EMPTY "Water scooter is not empty"
#define ERR_VEHICLE_NOT_ALIVE "Water scooter has destroyed"

private ["_veh", "_error"];
_veh = objNull;

if (count _this == 0) then {
	_veh = [] call mf_items_water_scooter_nearest;
} else {
	_veh = _this select 0;
};

_error = "failed";
switch (true) do {
	case (!alive player): {_error = " "}; // Player is dead, no need for a error message
	case (player distance _veh > 5): {_error = ERR_TOO_FAR_AWAY};
	case (vehicle player != player): {_text = ERR_IN_VEHICLE};
	case (MF_ITEMS_WATER_SCOOTER call mf_inventory_is_full): {_error = ERR_ALREADY_HAVE_WATERSCOOTER};
	case (!alive _veh): {_error = ERR_VEHICLE_NOT_ALIVE};
	case ((count (crew _veh)) != 0): {_error = ERR_VEHICLE_NOT_EMPTY};
	default {_error = ""};
};
_error;
