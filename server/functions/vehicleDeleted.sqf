
params ["_veh"];
private ["_variant", "_attachedObjs"];
if (local _veh) then
{
	_variant = _veh getVariable ["A3W_vehicleVariant", ""];
	if (_variant == "flatbed") then
	{
		_attachedObjs = attachedObjects _veh;
		{
			if (typeOf _x == "Truck_01_Rack_F") then
			{
				deleteVehicle _x;
			};
		} forEach _attachedObjs;
	};
};