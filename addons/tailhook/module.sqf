TTT_Get_Carrier =
{
	params ["_plane"];
	private ["_nearbyCarrier", "_carrier"];
	_nearbyCarrier = nearestObjects [_plane, ["Land_Carrier_01_hull_08_1_F"], 5000]; // official aircraft carrier only
	_carrier = objNull;
	{
		if (((getPosASL _plane) select 2 > 20) && (speed _plane > 150) && (speed _plane < 500) && ([_x, _plane] call BIS_fnc_relativeDirTo > 290 || [_x, _plane] call BIS_fnc_relativeDirTo < 70)) exitWith
		{
			_carrier = _x;
		};
	} forEach _nearbyCarrier;
	_carrier
};

TTT_Check_Carrier =
{
	params ["_plane"];
	!(isNull ([_plane] call TTT_Get_Carrier)) && (isNil {_plane getVariable "TTT_TailhookUp"})
};

TTT_Tailhook_Init =
{
	params ["_plane"];
	_plane addAction ["Tailhook Down", {call TTT_Tailhook_Down}, nil, 5, false, true, "", "[_target] call TTT_Check_Carrier"];
};

TTT_Tailhook_Down =
{
	private ["_plane", "_actionID"];
	_plane = _this select 0;
	if (isNil {_plane getVariable "TTT_TailhookUp"}) then
	{
		_actionID = _plane addAction ["Tailhook Up", {call TTT_Tailhook_Up} , nil, 5, false, true, "", "driver _target == player"];
		_plane setVariable ["TTT_TailhookUp", _actionID, true];
	};
	[_plane] call TTT_Use_Tailhook;
};

TTT_Tailhook_Up =
{
	private ["_plane"];
	_plane = _this select 0;
	if (!(isNil {_plane getVariable "TTT_TailhookUp"})) then
	{
		_plane removeAction (_plane getVariable "TTT_TailhookUp");
		_plane setVariable ["TTT_TailhookUp", nil, true];
	};
};

TTT_Use_Tailhook =
{
	private ["_plane", "_pilot", "_carrier", "_posWires", "_maxDistZ", "_distZ", "_brakeSpeed", "_slowDown", "_velInitial", "_dirPlane"];
	systemChat "Tailhook down, ready to land on carrier";
	_plane = _this select 0;
	_pilot = driver _plane;
	_carrier = [_plane] call TTT_Get_Carrier;
	_posWires = _carrier modelToWorld (_carrier selectionPosition "pos_cable_1");
	_maxDistZ = 0.4;
	_distZ = 0;

	while {alive _plane} do
	{
		_distZ =  (getposASL _plane select 2) - (_posWires select 2);
		if ((isNil {_plane getVariable "TTT_TailhookUp"}) || _distZ < _maxDistZ) exitWith { [_plane] call TTT_Tailhook_Up };
		sleep 0.1;
	};
	if (_plane distance _posWires > 100 || _distZ > 3) exitWith
	{
		if (_plane distance _posWires > 100) then
		{
			systemChat "Too far from arresting cable, tailhook hook up";
		} else
		{
			if (_distZ > 3) then
			{
				systemChat "Too high from arresting cable, tailhook hook up";
			};
		};
		[_plane] call TTT_Tailhook_Up;
	};
	_plane say3D "Land_Carrier_01_wire_trap_sound";
	systemChat "Touch down!";
	_brakeSpeed = -12;
	_slowDown = 0.7;
	while {alive _plane && speed _plane > -10} do
	{
		_velInitial = velocity _plane;
		_dirPlane = direction _plane;
		_plane setVelocity (_velInitial vectorAdd [sin _dirPlane * _brakeSpeed, cos _dirPlane * _brakeSpeed, 0]);

		sleep _slowDown;
		if (_brakeSpeed >= -3) then {_brakeSpeed = -3;} else {_brakeSpeed = _brakeSpeed + 0.1;};
		if (_slowDown <= 0.2) then {_slowDown = 0.03} else {_slowDown = _slowDown - 0.1};
	};
	sleep 2;
	[_plane] call TTT_Tailhook_Up;
};

[_this select 0] call TTT_Tailhook_Init;
