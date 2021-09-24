//armed suicide vest
private ["_pressedKey", "_handled", "_isWearing", "_explosive"];
_pressedKey = _this select 1;
_handled = false;

if (_pressedKey == 14) then // backspace
{
	if (vest_detonate) exitWith
	{
		_handled = true;
	};
	_isWearing = player getVariable ["isVestArmed", false];
	if ("straponbomb" call mf_inventory_count > 0 && _isWearing) then
	{
		player setVariable ["performingDuty", true];
		["straponbomb", 1] call mf_inventory_remove;
		_explosive = createMine ["IEDUrbanBig_F", player modelToWorld [0,0.2,1], [], 0];
		_explosive setDamage 1;
		vest_detonate = true;
		_handled = true;
		if (damage player < 1) then
		{
			player setVariable ["A3W_deathCause_local", ["suicide"]];
			player setDamage 1;
		};
		if (player getVariable ["isVestArmed", false]) then
		{
			player setVariable ["isVestArmed", false, true];
		};
		[] spawn {
			sleep 1;
			vest_detonate = false;
		};
		player setVariable ["performingDuty", nil];
	} else
	{
		if ("straponbomb" call mf_inventory_count == 0) then
		{
			if (_isWearing) then
			{
				player setVariable ["isVestArmed", false, true];
			};
			titleText ["Go get yourself one from General Store", "PLAIN", 0.5];
		} else
		{
			titleText ["Please wear Strap-on Bomb at Player Inventory", "PLAIN", 0.5];
		};
	};
};

_handled
