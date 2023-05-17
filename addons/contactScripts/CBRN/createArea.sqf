params ["_name", "_pos", "_dir", "_sizeX", "_sizeY", "_isRectangle"];
private ["_success"];
_success = false;
if !(_name in CBRN_contaminants) then
{
	_success = true;
	_marker = createMarker [_name, _pos, 0];
	_marker setMarkerDir _dir;
	_marker setMarkerSize [_sizeX, _sizeY];
	_marker setMarkerShape (["ELLIPSE", "RECTANGLE"] select (_isRectangle));
	_marker setMarkerAlpha 0;

	CBRN_contaminants pushBack _marker;
	publicVariable "CBRN_contaminants";
};
_success