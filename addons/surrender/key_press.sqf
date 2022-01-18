private ["_pressedKey", "_shift", "_handled", "_isSurrender"];
_pressedKey = _this select 1;
_shift = _this select 2;
_handled = false;

if (_pressedKey == 35 && _shift) then // shift + H
{
	_handled = true;
	_isSurrender = player getVariable ["isSurrender", false];
	if (_isSurrender) then
	{
		if (player getVariable ["isTied", false]) then
		{
			if (random 100 >= 90) then
			{
				player setVariable ["isSurrender", false, true];
				player setVariable ["isTied", false, true];
				playSound3D [getMissionPath "client\sounds\zipBreak.ogg", player, true, getPosASL player, 5, 1, 10];
				["Your have release yourself from zip tie!", 5] call mf_notify_client;
				if (vehicle player == player) then { [player, ""] call switchMoveGlobal; };
			} else
			{
				["Your hand are tied, try again!", 5] call mf_notify_client;
			};
		} else
		{
			player setVariable ["isSurrender", false, true];
			["Your are not surrendering!", 5] call mf_notify_client;
			if (vehicle player == player) then { [player, ""] call switchMoveGlobal; };
		};
	} else
	{
		if (vehicle player == player) then
		{
			player setVariable ["isSurrender", true, true];
			["Your are surrendering!", 5] call mf_notify_client;
			player action ["Surrender", player];
		} else
		{
			["You can't surrender in vehicle!", 5] call mf_notify_client;
		};
	};
};

_handled
