private ["_vehicle", "_carrierCompat"];

TTT_Tailhook_Module = compile preprocessFile "addons\tailhook\module.sqf";

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
					_vehicle setVariable ["TTT_Tailhook_Done", true, true];
				};
			};
		};
	};
	sleep 5;
}
