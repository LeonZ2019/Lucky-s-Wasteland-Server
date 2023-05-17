LEON_SENSOR_ADDACTION =
{
	params ["_heli"];
	_heli addAction ["Deploy Sensor", {call LEON_SENSOR_DEPLOY}, [_heli], 5, false, true, "", "getPosASLVisual _target select 2 >= 10 && !(_target getVariable ['LEON_SENSOR_DEPLOY', false]) && _this == driver _originalTarget"];
	_heli addAction ["Detach Sensor", {(_this select 0) setVariable ['LEON_SENSOR_DEPLOY', false, true]}, nil, 5, false, true, "", "(_target getVariable ['LEON_SENSOR_DEPLOY', false]) && _this == driver _originalTarget"];
	
	_heli addEventHandler ["RopeBreak", {
		params ["_heli", "_rope", "_tank"];
		if (_heli getVariable ['LEON_SENSOR_DEPLOY', false]) then
		{
			ropeDestroy _rope;
			ropeCreate [_heli, [0,2.00513,-2.36587], _tank, [0,0,0], 40];
		};
	}];
};

LEON_SENSOR_DEPLOY =
{
	params ["_heli"];
	_tempParts = []; // ["Land_FoodContainer_01_F",[0,2.00513,-5.00309],[0,0,1],[0,1,0]],
	_parts = [["Land_GasTank_02_F",[0,2.00513,-4.36587], [0,0,1],[0,1,0]],["Land_TankSprocketWheels_01_single_F",[0,2.00513,-3.16215], [0,0,1],[0,1,0]],["Land_PressureWasher_01_F",[0,2.00513,-1.97412], [0,0,1],[0,1,0]]];
	{
	    _part = createVehicle [_x select 0, _x select 1, [], 0, "CAN_COLLIDE"];
	    {
        	_part disableCollisionWith _x;
    	} forEach  _tempParts + [_heli];
    	_part attachTo [_heli, _x select 1];
    	_part setVectorDirAndUp [_x select 2 , _x select 3];
    	_tempParts pushBack _part;
	} forEach _parts;
	_heli setVariable ["LEON_SENSOR_PART", _tempParts, true];
	_tank = (_tempParts select { typeOf _x == "Land_GasTank_02_F"}) select 0;
	_tank setMass 240;
	detach _tank;
	_rope = ropeCreate [_heli, [0,2.00513,-2.36587], _tank, [0,0,0], 40];
	_heli setVariable ['LEON_SENSOR_DEPLOY', true, true];
	[_heli, _tank] spawn LEON_SONAR_SCAN;
	while {alive _heli} do
	{
		if (!(_heli getVariable ['LEON_SENSOR_DEPLOY', false])) exitWith {};
		sleep 0.1;
	};
	{ ropeDestroy _x } forEach (ropes _heli);
	{
		if (typeOf _x == "Land_GasTank_02_F") then
		{
			[_x] spawn {
				params ["_tank"];
				uiSleep 10;
				deleteVehicle _tank;
			}
		} else
		{
			deleteVehicle _x;
		};
	} forEach _tempParts;
	_heli  setVariable ["LEON_SENSOR_DEPLOY", false, true];
	_heli setVariable ["LEON_SENSOR_PART", nil, true];
};

LEON_SONAR_SCAN =
{
	params ["_heli", "_tank"];
	_sub = allSimpleObjects ["Submarine_01_F"];
	if (count _sub > 0) then
	{
		["Sonar now is activate", 5] call mf_notify_client;
		_sub = _sub select 0;
		while { !(isNull _sub) && _heli getVariable ['LEON_SENSOR_DEPLOY', false] && alive _heli} do
		{
			
			_time = 3.2;
			if (getPosASL _tank select 2 < -0.5) then
			{
				_dist = _tank distance _sub;
				if (_dist <= 2400) then // max range of sonar
				{
					_time = _dist * 2 / 1500; // sonar speed
					if (_dist < 200) then
					{
						if (_tank distance2D _sub <= 50) then
						{
							_sub setVariable ["detected", true, true];
						};
					};
				};
			};
			sleep _time;
			if (_time < 3.2) then {
				playSound "sonarPing";
			};
		};
		_heli setVariable ['LEON_SENSOR_DEPLOY', false, true];
		["Sonar Detach.", 5] call mf_notify_client;
	} else
	{
		["Hunter Killer mission is not running.", 5] call mf_notify_client;
		_heli setVariable ['LEON_SENSOR_DEPLOY', false, true];
	};
};

_this call LEON_SENSOR_ADDACTION;
