
_target = cursorTarget;
_action = _this select 3 select 0;

switch (_action) do {
	case ("gear"): {player action ["Gear", _target]};
	case ("money"):
	{
		_targetMoney = _target getVariable ["cmoney", 0];
		if (_targetMoney == 0) then
		{
			player groupChat "This player is poor.";
		} else
		{
			player groupChat format ["%1's pockets have $%2.", name _target, _targetMoney];
		};
	};
	case ("untie"): {
		_target setVariable ["isTied",false,true];
		_target setVariable ["timeoutUntie", diag_tickTime, true];
		playSound3D [getMissionPath "client\sounds\untie.ogg", player, true, getPosASL player, 5, 1, 10];
	};
	case ("tie"): {
		_target setVariable ["isTied",true,true];
		_target setVariable ["timeoutUntie", diag_tickTime + 30, true];
		playSound3D [getMissionPath "client\sounds\zipTie.ogg", player, true, getPosASL player, 5, 1, 10];
	};
};