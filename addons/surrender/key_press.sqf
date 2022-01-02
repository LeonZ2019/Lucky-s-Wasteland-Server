private ["_pressedKey", "_shift", "_handled", "_isSurrender"];
_pressedKey = _this select 1;
_shift = _this select 2;
_handled = false;

if (_pressedKey == 35 && _shift) then // shift + H
{
	_isSurrender = player getVariable ["isSurrender", false];
	if (_isSurrender) then
	{
		if (player getVariable ["isTied", false]) then
		{
			["Your hand are tied!", 5] call mf_notify_client;
		} else
		{
			player setVariable ["isSurrender", false, true];
			[player, ""] call switchMoveGlobal;
			_handled = true;
		};
	} else
	{
		player setVariable ["isSurrender", true, true];
		player action ["Surrender", player];
		_handled = true;
	};
};

_handled
