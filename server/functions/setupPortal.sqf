
#define PORTAL_ACTIVATE_CONDITION "(player distance _target < 5 && cursorTarget == _target)"

private ["_laptop", "_laptopVarName", "_startsWith", "_structure", "_table"];

_laptop = _this select 0;
_laptopVarName = vehicleVarName _laptop;
_structure = (_laptop modelToWorld [0,0,0]) nearestObject "Land_Research_house_V1_F";
_table = (_laptop modelToWorld [0,0,0]) nearestObject "Land_CampingTable_small_white_F";

_structure allowDamage false;
_table allowDamage false;
_laptop allowDamage false;
_laptop enableSimulationGlobal false;
_table enableSimulationGlobal false;

if (hasInterface) then
{
	_startsWith =
	{
		private ["_needle", "_testArr"];
		_needle = _this select 0;
		_testArr = toArray (_this select 1);
		_testArr resize count toArray _needle;
		(toString _testArr == _needle)
	};
	if (["Portal", _laptopVarName] call _startsWith) then
	{
		_laptop addAction ["<img image='client\icons\portal.paa'/> Open Portal", "client\systems\portalTP\openPortal.sqf", [_laptopVarName], 1, true, true, "", PORTAL_ACTIVATE_CONDITION];
	};
};
