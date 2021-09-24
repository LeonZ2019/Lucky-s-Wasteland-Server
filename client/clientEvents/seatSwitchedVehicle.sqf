params ["_unit1", "_unit2", "_vehicle"];

if (player getVariable ["moveInDLC", 0] in [304380, 395180]) then
{
	if ((getText (configfile >> 'CfgVehicles' >> typeOf cursorTarget >> 'DLC')) in ['Expansion', 'Heli']) then
	{
		if (assignedVehicleRole _unit1 select 0 != "cargo") then
		{
			playSound "FD_CP_Not_Clear_F";
			player globalChat "Passenger seat only.";
			moveOut player;
			player moveInCargo _vehicle;
		}
	};
};
