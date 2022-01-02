
_target = cursorTarget;
_action = _this select 3 select 0;

switch (_action) do {
	case ("gear"): {player action ["Gear", _target]};
	case ("money"):
	{
		_targetMoney = _target getVariable ["cmoney",0];
		if (_targetMoney == 0) then
		{
			player groupChat "This player is poor.";
		} else
		{
			[player, _targetMoney] call A3W_fnc_setCMoney;
			[_target, -_targetMoney] call A3W_fnc_setCMoney;
			player groupChat format ["You have grab $%1 in %2's pockets.", _targetMoney, name _target];
		};
	};
	case ("untie"): {
		_target setVariable ["isTied",false,true];
	};
	case ("tie"): {
		_target setVariable ["isTied",true,true];
	};
};