//AlPMaker
_max = 10; snext = false; plist = []; pselect5 = "";
{if ((_x != player) && (getPlayerUID _x != "")) then {plist set [count plist, name _x];};} forEach entities "CAManBase";
{if ((count crew _x) > 0) then {{if ((_x != player) && (getPlayerUID _x != "")) then {plist set [count plist, name _x];};} forEach crew _x;};} foreach (entities "LandVehicle" + entities "Air" + entities "Ship");
smenu =
{
	_pmenu = [["Teleport Me To",true]];
	for "_i" from (_this select 0) to (_this select 1) do
	{_arr = [format['%1', plist select (_i)], [12],  "", -5, [["expression", format ["pselect5 = plist select %1;", _i]]], "1", "1"]; _pmenu set [_i + 2, _arr];};
	if (count plist > (_this select 1)) then {_pmenu set [(_this select 1) + 2, ["Next", [13], "", -5, [["expression", "snext = true;"]], "1", "1"]];}
	else {_pmenu set [(_this select 1) + 2, ["", [-1], "", -5, [["expression", ""]], "1", "0"]];};
	_pmenu set [(_this select 1) + 3, ["Exit", [13], "", -5, [["expression", "pselect5 = 'exit';"]], "1", "1"]];
	showCommandingMenu "#USER:_pmenu";
};
_j = 0; _max = 10; if (_max>9) then {_max = 10;};
while {pselect5 == ""} do
{
	[_j, (_j + _max) min (count plist)] call smenu; _j = _j + _max;
	WaitUntil {pselect5 != "" or snext};	
	snext = false;
};
if (pselect5 != "exit") then
{
	_name = pselect5;
	{
		if (isPlayer _x && (name _x == _name)) then
		{
			private ["_waterPos", "_oldVelocity", "_alt", "_top", "_buildings"];
			if (vehicle _x != _x && vehicle player == player) then
			{
				player moveInAny (vehicle _x);
			} else
			{
				_oldVelocity = velocity (vehicle player);
				_alt = getPos (vehicle player) select 2;
				_pos = position _x;
				if (surfaceIsWater _pos) then
				{
					_top = +_pos;
					_top set [2, (_top select 2) + 1000];
					_buildings = (lineIntersectsSurfaces [_top, _pos, objNull, objNull, true, -1, "GEOM", "NONE"]) select {(_x select 2) isKindOf "Building"};
					if !(_buildings isEqualTo []) then
					{
						_waterPos = _buildings select 0 select 0;
					};
				};
				_oldVector = vectorUp (vehicle player);
				if (isNil "_waterPos") then
				{
					_pos = _pos vectorAdd [0,0, (0 max _alt)];
					vehicle player setPos _pos;
				} else
				{
					_waterPos = _waterPos vectorAdd [0,0, (0 max _alt)];
					vehicle player setPosASL _waterPos;
				};
				vehicle player setVelocity _oldVelocity;
				if (vehicle player isKindOf "Plane") then
				{
					vehicle player setVectorUp _oldVector;
				};
			};
		};
	} forEach playableUnits;
};
