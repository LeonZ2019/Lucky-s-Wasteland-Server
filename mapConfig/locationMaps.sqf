private ["_setLoc", "_locations", "_marker", "_name", "_class", "_pos", "_sizes", "_sizeX", "_sizeY", "_isRect"];

_setLoc =
{
	params ["_className", "_position", "_locationName", ["_sizeX", 100, [100]], ["_sizeY", 100, [100]], ["_isRect", false, [false]]];
	_loc = createLocation [_className, _position, _sizeX, _sizeY];
	_loc setText _locationName;
	_loc setRectangular _isRect;
};

_locations = [];

// location 1
_marker = "TERRITORY_MALDEN_OIL_RIG";
_name = "Malden Oil Rig";
_class = "NameMarine";
_pos = markerPos _marker;
_sizes = markerSize _marker;
_sizeX = _sizes select 0;
_sizeY = _sizes select 1;
_isRect = (markerShape _marker == "RECTANGLE");
_locations pushBack [_class, _pos, _name, _sizeX, _sizeY, _isRect];

//location 2
_name = "Meganisi";
_class = "NameCity";
_pos = [10675, 4130];
_sizeX = 1476;
_sizeY = 820;
_isRect = false;
_locations pushBack [_class, _pos, _name, _sizeX, _sizeY, _isRect];

// location 3
_marker = "TERRITORY_LEE_BASE";
_name = "Lee Base";
_class = "Name";
_pos = markerPos _marker;
_sizes = markerSize _marker;
_sizeX = _sizes select 0;
_sizeY = _sizes select 1;
_isRect = (markerShape _marker == "RECTANGLE");
_locations pushBack [_class, _pos, _name, _sizeX, _sizeY, _isRect];

// location 4
_marker = "TERRITORY_LUCKY_VINEYARD";
_name = "Lucky Vineyard";
_class = "Name";
_pos = markerPos _marker;
_sizes = markerSize _marker;
_sizeX = _sizes select 0;
_sizeY = _sizes select 1;
_isRect = (markerShape _marker == "RECTANGLE");
_locations pushBack [_class, _pos, _name, _sizeX, _sizeY, _isRect];

{ _x call _setLoc; } forEach _locations;

_bridge = createMarker ["MALDEN_BRIDGE", [8898.075,3780.2], 0];
_bridge setMarkerShape "RECTANGLE";
_bridge setMarkerBrush "SolidFull";
_bridge setMarkerColor "Color6_FD_F";
_bridge setMarkerAlpha 1;
_bridge setMarkerSize [431.82,7];
