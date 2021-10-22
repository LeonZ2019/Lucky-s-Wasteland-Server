{
	if (vehicleVarName _x select [0,13] == "ResupplyTruck") then
	{
		_truckPos = getPosATL _x;

		_markerName = format["resupply_truck_title_%1",_x];
		deleteMarkerLocal _markerName;
		_marker = createMarkerLocal [_markerName, _truckPos];
		_markerName setMarkerShapeLocal "ICON";
		_markerName setMarkerTypeLocal "mil_dot";
		_markerName setMarkerColorLocal "ColorPink";
		_markerName setMarkerSizeLocal [1, 1];
	};
} forEach entities "C_Truck_02_box_F";
