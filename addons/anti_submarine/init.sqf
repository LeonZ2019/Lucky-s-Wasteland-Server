private ["_vehicles", "_carrierCompat", "_carrierPos", "_carrier"];

LEON_SENSOR_INIT = compile preprocessFile "addons\anti_submarine\module.sqf";

while {true} do
{
	if (!isNull player) then
	{
		if ((vehicle player) != player && (vehicle player) isKindOf "Heli_Transport_02_base_F") then
		{
			_veh = vehicle player;
			if !(_veh getVariable ["LEON_SENSOR_APPLY", false]) then
			{
				[_veh] spawn LEON_SENSOR_INIT;
				_veh setVariable ["LEON_SENSOR_APPLY", true, true];
			};
		};
	};
	sleep 40;
}
