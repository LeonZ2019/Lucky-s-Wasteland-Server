["A3W_LegendFinder", "onMapSingleClick",
{
	private ["_marker", "_distance", "_message"];
	_marker = "";
	_distance = worldSize;
	{
		//_markerText = markerText _x;
		if (markerType _x == "mil_dot") then
		{
			if (_pos distance2D (markerPos _x) < _distance) then
			{
				_marker = _x;
				_distance = _pos distance2D (markerPos _x);
			};
		};
	} forEach (allMapMarkers select {["LegendMarker",_x] call fn_startsWith});
	if (_marker != "" && _distance <= 400) then
	{
		_searchText = "marker_shop_title_";
		if (markerText _marker == "Resupply Truck") then { _searchText = "resupply_truck_title_" };
		if (markerText _marker == "Storage") then { _searchText = "storage_box_" };
		if (markerText _marker == "Parking") then { _searchText = "parking_terminal_" };
		_matched = allMapMarkers select {markerColor _x == markerColor _marker && markerType _x == markerType _marker && [_searchText, _x] call fn_startsWith };
		if (count _matched == 0) then
		{
			playSound "FD_CP_Not_Clear_F";
			["Not found on this legend", 5] call mf_notify_client;
		} else
		{
			_matched = _matched apply {[(markerPos _x) distance player, _x]};
			_matched sort true;
			mapAnimAdd [1.5, 0.01, markerPos (_matched select 0 select 1)];
			mapAnimCommit;
		};
	};
}] call BIS_fnc_addStackedEventHandler;