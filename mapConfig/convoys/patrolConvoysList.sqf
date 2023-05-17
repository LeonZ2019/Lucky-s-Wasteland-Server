// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: patrolConvoysList.sqf
//	@file Author: Leon

[
	"PatrolConvoy_1",
	"PatrolConvoy_2",
	"PatrolConvoy_3"
]

/*
// variable for end user
// MY_WAYPOINTS
// direction player

//script log marker
MY_MARKER = createMarker ["MYMARKER", player];
MY_MARKER setMarkerType "hd_dot";
MY_MARKER setMarkerText "0";
MY_MARKER setMarkerPos (getPos player);

MY_WAYPOINTS = [];
["A3W_WaypointMarker", "onMapSingleClick",
{
	_pos deleteAt 2;
	MY_WAYPOINTS pushBack _pos;
	MY_MARKER setMarkerText str (count MY_WAYPOINTS);
	MY_MARKER setMarkerPos _pos;
	systemChat str (count MY_WAYPOINTS);
}] call BIS_fnc_addStackedEventHandler;

//script draw waypoint
_waypoints = []; // [[x0,y0],[x1,y1]...]
_color = "colorCivilian";
openMap true;
_pos2ds = [];
{
    _pos2ds append _x;
} forEach _waypoints;
deleteMarker WAYPOINTS_MARKER;
WAYPOINTS_MARKER = createMarkerLocal [format["test%1%2", random 100, random 100], _waypoints select 0];
WAYPOINTS_MARKER setMarkerShapeLocal "polyline";
WAYPOINTS_MARKER setMarkerPolylineLocal _pos2ds;
WAYPOINTS_MARKER setMarkerColorLocal _color;
player setPos (_waypoints select 0);
MY_WAYPOINTS = [];

//script remove marker event
["A3W_WaypointMarker", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
*/