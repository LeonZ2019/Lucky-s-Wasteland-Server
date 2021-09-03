private ["_vehicle", "_carrierCompat", "_carrierPos", "_carrier"];

TTT_Tailhook_Module = compile preprocessFile "addons\tailhook\module.sqf";
TTT_Carriers = [];
{
	_carrierPos = markerPos _x;
	_carrierPos set [2, 200];
	_carrier = _carrierPos nearObjects ["Land_Carrier_01_hull_08_1_F", 250];
	TTT_Carriers append _carrier;
} forEach allMapMarkers;

while {true} do
{
	if !(isNull player) then
	{
		_vehicle = vehicle player;
		if (_vehicle != player && _vehicle isKindOf "Plane") then
		{
			_carrierCompat = configFile >> "CfgVehicles" >> typeOf _vehicle >> "CarrierOpsCompatability";
			if (isNil "_carrierCompat" || isNull _carrierCompat) then {
				if (!(_vehicle getVariable ["TTT_Tailhook_Done", false])) then
				{
					[_vehicle] spawn TTT_Tailhook_Module;
					_vehicle setVariable ["TTT_Tailhook_Done", true];
				};
			};
		};
	};
	sleep 40;
}
