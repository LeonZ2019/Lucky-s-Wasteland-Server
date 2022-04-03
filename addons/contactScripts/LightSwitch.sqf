while {true} do
{
	if !(isNull player) then
	{
		_pls = nearestObjects [player, ["Land_PortableLight_02_base_F"], 10];
		if (count _pls > 0) then
		{
			{
				if (_x getVariable ["LEON_PL_Setup", false] == false) then
				{
					_x addAction ["Turn Light Off", {call LEON_PL_Switch}, 1, 1, false, true, "", "_target call LEON_PL_Check" ];
					_x addAction ["Turn Light On", {call LEON_PL_Switch}, 0, 1, false, true, "", "!(_target call LEON_PL_Check)" ]; // arg is damage value
					_x setVariable ["LEON_PL_Setup", true, true];
				};
			} forEach _pls;
		} else
		{
			sleep 3;
		}
	} else
	{
		sleep 1;
	};
};

LEON_PL_GetHitPoint =
{
	private ["_portableLight", "_hitPoints"];
	_portableLight = _this;
	_hitPoints = if (_portableLight isKindOf "Land_PortableLight_02_quad_base_F") then
	{
		["hit_light_1", "hit_light_2", "hit_light_3", "hit_light_4"]
	} else
	{
		if (_portableLight isKindOf "Land_PortableLight_02_double_base_F") then
		{
			["hit_light_1", "hit_light_2"]
		} else
		{
			if (_portableLight isKindOf "Land_PortableLight_02_single_base_F") then
			{
				["hit_light_1"]
			} else
			{
				if (_portableLight isKindOf "Land_PortableLight_02_single_folded_base_F") then
				{
					["hit_light_1"]
				} else
				{
					[] // safe value
				};
			};
		};
	};
	_hitPoints
};

LEON_PL_Check =
{
	private ["_portableLight", "_hitPoints", "_lightOff"];
	_portableLight = _this;
	_hitPoints = _portableLight call LEON_PL_GetHitPoint;
	_lightOff = false;
	{
		if (_portableLight getHitPointDamage _x == 1) exitWith
		{
			_lightOff = true;
		};
	} forEach _hitPoints;
	_lightOff
};

LEON_PL_Switch =
{
	private ["_portableLight", "_hitPoints", "_switch"];
	_portableLight = _this select 0;
	_switch = _this select 3;
	_hitPoints = _portableLight call LEON_PL_GetHitPoint;
	{
		_portableLight setHitPointDamage [_x, _switch];
	} forEach _hitPoints;
};
