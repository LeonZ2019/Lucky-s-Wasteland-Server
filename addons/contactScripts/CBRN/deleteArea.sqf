params ["_name"];
private ["_found", "_removed"];

_removed = false;
_found = CBRN_contaminants findIf { _x == _name };

if (_found != -1) then
{
	CBRN_contaminants deleteAt _found;
	_removed = true;
	publicVariable "CBRN_contaminants";
};

_removed