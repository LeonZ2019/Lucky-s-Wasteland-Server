_uid = getPlayerUID player;
if (_uid call isAdmin) then
{
	if (isNil "adminUnitMarkers") then { adminUnitMarkers = false };

	if (!adminUnitMarkers) then
	{
		adminUnitMarkers = true;
		hint "Unit Markers ON";
		_eh = addMissionEventHandler ["Draw3D",
		{
			{
				_tagcolor = switch (side _x) do
				{
					case BLUFOR:      { [0, 0, 1, 1] };
					case OPFOR:       { [1, 0, 0, 1] };
					case INDEPENDENT: { [0, 1, 0, 1] };
					default           { [1, 1, 1, 1] };
				};
				_maxDistance = 1000;
				if (vehicle player isKindOf "Plane" && _speed >= 200) then
				{
					_maxDistance = _maxDistance * _speed / 200;
				}
				if (vehicle player isKindOf "Helicopter" && _speed >= 125) then
				{
					_maxDistance = _maxDistance * _speed / 125;
				};
				_dist = (_x distance player) / _maxDistance;
				_tagcolor set [3, 1 - _dist];
			drawIcon3D ["", _tagcolor, [(visiblePositionasl _x select 0), (visiblePositionasl _x select 1), (ASLToATL (visiblePositionASL _x) select 2) + 1.5 ], 1.5, 1.5, 0, name _x, 2, 0.03, "PuristaBold" ];
			} foreach ((allUnits - [player]) select { alive _x });
		}];
		player setVariable ["unitMarkers", _eh, true];
	} else
	{
		adminUnitMarkers = false;
		hint "Unit Markers OFF";
		_eh = player getVariable ["unitMarkers", -1];
		if (_eh != -1) then { removeMissionEventHandler ["Draw3D", _eh]; };
		player setVariable ["unitMarkers", -1, true];
	};

};
