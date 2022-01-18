#define ERR_TOO_FAR_AWAY "You are too far away from the beacon"
#define ERR_BEACON_GONE "Can't find Spawn Beacon"

private ["_beacon", "_text", "_hasFailed", "_success"];
_beacon = [] call mf_items_spawn_beacon_nearest;
_text = [_beacon] call mf_items_spawn_beacon_can_rename;

_displayRename = uiNamespace getVariable "beaconRename";
if (_text != "") exitWith {closeDialog 3666; [_text, 5] call mf_notify_client};

switch (true) do {
	case (!alive player): {};
	case (vehicle player != player): {};
	case (isNull _beacon): {_text = ERR_BEACON_GONE};
	case (player distance _beacon > 5): {_text = ERR_TOO_FAR_AWAY};
	default {
		_beaconName = ctrlText (_displayRename displayCtrl 3667);
		_text = format["Beacon successfully rename to '%1'", _beaconName];
		if (_beaconName == "") then
		{
			_beaconName = _beacon getVariable "ownerName";
			_text = format["Reset beacon name to '%1'", _beaconName];
		};
		_beacon setVariable ["beaconName", _beaconName, true];
		pvar_manualObjectSave = netId _beacon;
		publicVariableServer "pvar_manualObjectSave";
	};
};
if (_text != "") then {closeDialog 3666; [_text, 5] call mf_notify_client };
