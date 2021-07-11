
{
	if ((vehicleVarName _x) select [0,6] == "Portal") then
	{
		_laptopPos = getPosATL _x;

		_markerName = format["marker_shop_title_%1",_x];
		deleteMarkerLocal _markerName;
		_marker = createMarkerLocal [_markerName, _laptopPos];
		_markerName setMarkerShapeLocal "ICON";
		_markerName setMarkerTypeLocal "mil_dot";
		_markerName setMarkerColorLocal "ColorGreen";
		_markerName setMarkerSizeLocal [1,1];
	};
} forEach entities "Land_Laptop_device_F";
