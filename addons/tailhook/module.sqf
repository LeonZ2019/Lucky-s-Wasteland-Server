LEON_Get_Carrier =
{
	params ["_plane"];
	private ["_carrier"];
	_carrier = objNull;
	{
		if (_plane distance _x < 2500 && ((getPosASL _plane) select 2 > 20) && (speed _plane > 150) && (speed _plane < 500) && ([_x, _plane] call BIS_fnc_relativeDirTo > 290 || [_x, _plane] call BIS_fnc_relativeDirTo < 70)) exitWith
		{
			_carrier = _x;
		};
	} forEach LEON_Carriers;
	_carrier
};

LEON_Check_Carrier =
{
	params ["_plane"];
	!(isNull ([_plane] call LEON_Get_Carrier)) && (isNil {_plane getVariable "LEON_TailhookUp"})
};

LEON_Tailhook_Init =
{
	params ["_plane"];
	_plane addAction ["Tailhook Down", {call LEON_Tailhook_Down}, nil, 5, false, true, "", "[_target] call LEON_Check_Carrier"];
};

LEON_Tailhook_Down =
{
	private ["_plane", "_actionID"];
	_plane = _this select 0;
	playSound3D ["a3\sounds_f_jets\vehicles\air\shared\FX_Plane_Jet_tailhook_down.wss", _plane];
	systemChat "Tailhook down, ready to land on carrier";
	if (isNil {_plane getVariable "LEON_TailhookUp"}) then
	{
		_actionID = _plane addAction ["Tailhook Up", {call LEON_Tailhook_Up} , nil, 5, false, true, "", "driver _target == player"];
		_plane setVariable ["LEON_TailhookUp", _actionID, true];
	};
	[_plane] call LEON_Use_Tailhook;
};

LEON_Tailhook_Up =
{
	private ["_plane"];
	_plane = _this select 0;
	if !(isNil {_plane getVariable "LEON_TailhookUp"}) then
	{
		systemChat "Tailhook up";
		playSound3D ["a3\sounds_f_jets\vehicles\air\shared\FX_Plane_Jet_tailhook_up.wss", _plane];
		_plane removeAction (_plane getVariable "LEON_TailhookUp");
		_plane setVariable ["LEON_TailhookUp", nil, true];
	};
};

LEON_Use_Tailhook =
{
	private ["_plane", "_pilot", "_carrier", "_posWires", "_maxDistZ", "_distZ", "_brakeSpeed", "_slowDown", "_velInitial", "_dirPlane"];
	_plane = _this select 0;
	_pilot = driver _plane;
	_carrier = [_plane] call LEON_Get_Carrier;
	_posWires = _carrier modelToWorld (_carrier selectionPosition "pos_cable_1");
	_maxDistZ = 0.4;
	_distZ = 0;

	while {alive _plane} do
	{
		_distZ =  (getposASL _plane select 2) - (_posWires select 2);
		if ((isNil {_plane getVariable "LEON_TailhookUp"}) || _distZ < _maxDistZ) exitWith {};
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
		[_plane] call LEON_Tailhook_Up;
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
	[_plane] call LEON_Tailhook_Up;
};

[_this select 0] call LEON_Tailhook_Init;
