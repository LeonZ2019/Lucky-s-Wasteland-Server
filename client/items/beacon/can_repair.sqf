// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Version: 1.0
//@file Name: can_repair.sqf
//@file Author: Leon
//@file Created: 17/1/2022 02:30
//@file Description: Check if the spawn beacon is damaged/not alive
//@file Argument: [_beacon] the (object that is a) beacon to check if it can repair
//@file Argument: [] automatically find the closest beacon to check.

#define ERR_NOT_FRIENDLY "You cannot repair enemy beacon!"
#define ERR_TOO_FAR_AWAY "You need to be less that 5 metres from it"
#define ERR_STILL_ALIVE "The beacon is not damage"
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
	case (!([_beacon] call mf_items_spawn_beacon_can_use)): {_error = ERR_NOT_FRIENDLY};
	case (alive _beacon): {_error = ERR_STILL_ALIVE};
	default {_error = ""};
};
_error;
