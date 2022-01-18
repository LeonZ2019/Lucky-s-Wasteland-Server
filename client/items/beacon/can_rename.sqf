// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Version: 1.0
//@file Name: can_rename.sqf
//@file Author: Leon
//@file Created: 14/1/2022 19:55
//@file Description: Check if you can rename the spawn beacon
//@file Argument: [_beacon] the (object that is a) beacon to check if it can rename
//@file Argument: [] automatically find the closest beacon to check.

#define ERR_NOT_OWNER "You are not the owner of that beacon"
#define ERR_TOO_FAR_AWAY "You need to be less that 5 metres from it"
private ["_beacon", "_beacons", "_error"];
_beacon = objNull;

if (count _this == 0) then {
	_beacon = [] call mf_items_spawn_beacon_nearest;
} else {
	_beacon = _this select 0;
};

_error = "failed";
switch (true) do {
	case (!alive player): {_error = " "}; // Player is dead, no need for a error message
	case (player distance _beacon > 5): {_error = ERR_TOO_FAR_AWAY};
	case (_beacon getVariable ["ownerUID", "0"] != getPlayerUID player): {_error = ERR_NOT_OWNER};
	default {_error = ""};
};
_error;
