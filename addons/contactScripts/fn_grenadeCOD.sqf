if (!isNil "LEON_GRENADE_ICON_ID") then { removeMissionEventHandler ["Draw3D", LEON_GRENADE_ICON_ID]; };
LEON_GRENADE_ICON_ID = addMissionEventHandler ["Draw3D",
{
	if ((vehicle player != player) || (player getVariable ["FAR_isUnconscious", 0] == 1)) exitWith
	{
		LEON_PICKABLE_GRENADE = [];
		if (!isNil "LEON_GRENADE_ICON_ID") then { removeMissionEventHandler ["Draw3D", LEON_GRENADE_ICON_ID]; };
	};
	if (LEON_PICKABLE_GRENADE findIf { isNull (attachedTo _x) && alive _x && player distance _x <= 3 && vectorMagnitude velocity _x <= 10 && !lineIntersects [eyePos player, getPosASLVisual _x vectorAdd [0,0,(sizeOf (typeOf _x)) / 2], player, _x] } == -1) exitWith {
		LEON_PICKABLE_GRENADE = [];
		if (!isNil "LEON_GRENADE_ICON_ID") then { removeMissionEventHandler ["Draw3D", LEON_GRENADE_ICON_ID]; };
	};
	{
		_zoom = round ((([0.5, 0.5] distance2D (worldToScreen (positionCameraToWorld [0, 3, 2]))) * (getResolution select 5) / 2) * 10);
		_dir = round ([player, _x] call BIS_fnc_relativeDirTo);
		_dis = 3 / _zoom;
		_pos = [0,0,0];
		switch (true) do
		{
			case (_dir == 0):
			{
				_pos = [0,_dis,2];
			};
			case (_dir == 90):
			{
				_pos = [_dis,0,2];
			};
			case (_dir == 180):
			{
				_pos = [0,-_dis,2];
			};
			case (_dir == 270):
			{
				_pos = [-_dis,0,2];
			};
			default
			{
				if ((_dir > 90 && _dir < 180) || (_dir > 270 && _dir < 360)) then
				{
					_pos = [(cos (_dir % 90)) * _dis, (sin (_dir % 90)) * _dis, 2];
				} else {
					_pos = [(sin (_dir % 90)) * _dis, (cos (_dir % 90)) * _dis, 2];
				};
				if (_dir > 180) then { _pos set [0, (_pos select 0) * (-1)] };
				if (_dir > 90 && _dir < 270) then { _pos set [1, (_pos select 1) * (-1)] };
			};
		};
		_iconPos = positionCameraToWorld _pos;
		_text = "";
		if (_forEachIndex == 0 && isNull LEON_PICKED_GRENADE) then
		{
			_text = "Shift + G";
		};
		drawIcon3D [getMissionPath "addons\contactScripts\grenade.paa", [0.94,0.24,0.24,1], _iconPos, 2.5, 2.5, 0, _text, 2]; 
	} forEach LEON_PICKABLE_GRENADE;
}];
