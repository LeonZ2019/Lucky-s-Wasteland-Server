//armed suicide vest
private ["_pressedKey", "_handled", "_isWearing", "_explosive", "_items", "_straponbomb"];
_pressedKey = _this select 1;
_handled = false;

if (_pressedKey == 14) then // backspace
{
	if (vest_detonate) exitWith
	{
		_handled = true;
	};
	if (vest player != "") then
	{
		_isWearing = player getVariable ["isVestArmed", false];
		if (_isWearing) then 
		{
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
				player setVariable ["VestClass", "", true];
			};
			[] spawn {
				sleep 1;
				vest_detonate = false;
			};
		} else
		{
			//_items = player getVariable ["mf_inventory_list", []];
			_items = true call mf_inventory_list;
			_straponbomb = _items select {(_x select 0) == "straponbomb"};
			if (_straponbomb select 1 == 0) then
			{
				titleText ["Go get yourself one from General Store", "PLAIN", 0.5];
			} else {
				titleText ["Wear it at Player Menu", "PLAIN", 0.5];
			};
		};
	} else
	{
		titleText ["You need wear vest", "PLAIN", 0.5];
	};
};

_handled
