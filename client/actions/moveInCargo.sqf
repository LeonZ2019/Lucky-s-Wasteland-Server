private ["_dlc"];
switch (getText (configfile >> 'CfgVehicles' >> typeOf cursorTarget >> 'DLC')) do
{
	case "Expansion":
	{
		_dlc = 395180;
	};
	case "Heli":
	{
		_dlc = 304380;
	};
	case "Enoch":
	{
		_dlc = 1021790;
	};
	case "Orange":
	{
		_dlc = 571710;
	};
};
player setVariable ["moveInDLC", _dlc, true];
player moveInCargo cursorTarget;
player setVariable ["moveInIndex", (fullCrew [vehicle player, "cargo", false]) select {_x select 0 == player} select 0 select 2, true];