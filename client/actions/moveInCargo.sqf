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
};
player setVariable ["moveInDLC", _dlc, true];
player moveInCargo cursorTarget;