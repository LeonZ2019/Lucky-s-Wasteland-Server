private ["_vehicles", "_carrierCompat", "_carrierPos", "_carrier"];

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
	if (!isNull player) then
	{
		_vehicles = [vehicle player, getConnectedUAV player];
		{
			if ((_x != player || (!isNull _x && _x isKindOf "UAV")) && _x isKindOf "Plane") then
			{
				_carrierCompat = configFile >> "CfgVehicles" >> typeOf _x >> "CarrierOpsCompatability";
				if (isNil "_carrierCompat" || isNull _carrierCompat) then {
					if !(_x getVariable ["TTT_Tailhook_Done", false]) then
					{
						[_x] spawn TTT_Tailhook_Module;
						_x setVariable ["TTT_Tailhook_Done", true];
					};
				};
			};
		} forEach _vehicles;
	};
	sleep 40;
}
