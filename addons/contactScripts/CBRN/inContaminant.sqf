private ["_inArea", "_inVehicle", "_tempArea"];
_inArea = false;
diag_log "Run inContaminant";

while { true } do
{
	// cache area
	if (!_inArea) then
	{
		_inArea = CBRN_contaminants findIf { player inArea _x && markerShape _x in ["RECTANGLE", "ELLIPSE"] } != -1;
	};
	if (_inArea) then // this is where we check
	{
		_tempArea = CBRN_contaminants select { player inArea _x && markerShape _x in ["RECTANGLE", "ELLIPSE"] };
		if (count _tempArea == 0) then
		{
			_inArea = false;
			contaminateArea = [];
		} else
		{
			contaminateArea = [_tempArea, [], { player distance (markerPos _x) }, "ASCEND"] call BIS_fnc_sortBy;
			if !(player getVariable ["inArea", false]) then
			{
				[player] execVM "addons\contactScripts\CBRN\contaminate.sqf";
			};
		};
	};
	sleep 1;
};