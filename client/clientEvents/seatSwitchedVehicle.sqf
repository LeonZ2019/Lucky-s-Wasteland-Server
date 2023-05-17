params ["_unit1", "", "_vehicle"];

if (player getVariable ["moveInDLC", 0] in [304380, 395180, 1021790, 571710]) then
{
	if ((getText (configfile >> 'CfgVehicles' >> typeOf cursorTarget >> 'DLC')) in ['Expansion', 'Heli']) then
	{
		if ("cargo" in (assignedVehicleRole _unit1)) then
		{
			_unit1 setVariable ["moveInIndex", (fullCrew [_vehicle, "cargo", false]) select {_x select 0 == _unit1} select 0 select 2, true];
		} else
		{
			playSound "FD_CP_Not_Clear_F";
			_unit1 globalChat "Passenger seat only.";
			_unit1 action ["MoveToCargo", _vehicle, _unit1 getVariable ["moveInIndex", 0]];
		};
	};
};
