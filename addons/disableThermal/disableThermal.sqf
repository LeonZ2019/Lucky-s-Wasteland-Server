// disableThermal.sqf
// by CRE4MPIE
// ver 0.3
// 2015-04-29 11:44pm
// contributions from BIStudio Forums, edited by CRE4MPIE, optimized by AgentRev

#define LAYER 85125

_launchers = ["launch_I_Titan_short_F", "launch_O_Titan_short_F", "launch_B_Titan_short_F", "launch_Titan_short_F", "launch_Titan_F", "launch_O_Titan_F", "launch_I_Titan_F", "launch_B_Titan_F", "Laserdesignator"];
_vehicles = ["B_HMG_01_high_F", "B_static_AA_F", "B_static_AT_F", "B_UAV_02_dynamicLoadout_F", "O_UAV_02_dynamicLoadout_F", "I_UAV_02_dynamicLoadout_F", "O_T_UAV_04_CAS_F", "B_UAV_05_F", "I_Plane_Fighter_03_dynamicLoadout_F", "I_Plane_Fighter_04_F", "B_Plane_CAS_01_dynamicLoadout_F", "O_Plane_CAS_02_dynamicLoadout_F", "B_Plane_Fighter_01_Stealth_F", "B_T_VTOL_01_infantry_F", "O_T_VTOL_02_infantry_dynamicLoadout_F", "B_GMG_01_F"];

while {true} do
{
	waitUntil {sleep 0.1; currentVisionMode player == 2}; // check for TI Mode

	_currWep = currentWeapon player;
	_currVeh = vehicle player;

	if (dayTime > 4 && dayTime < 20 && {{_currWep == _x} count _launchers > 0 || {_currVeh isKindOf _x} count _vehicles > 0}) then
	{
		if ({_currVeh isKindOf _x} count _vehicles > 0) then
		{
			_currVeh disableTIEquipment true;
		} else
		{
			_currWep disableTIEquipment true;
		};
		LAYER cutText ["Thermal Imaging OFFLINE", "BLACK", -0.25];
		playSound "FD_CP_Not_Clear_F";
		waitUntil {sleep 0.1; currentVisionMode player != 2};
		LAYER cutText ["", "PLAIN"];
	}
	else
	{
		if (alive getConnectedUAV player) then
		{
			getConnectedUAV player disableTIEquipment true;
			LAYER cutText ["Thermal Imaging OFFLINE while connected to UAV", "BLACK", -0.25];
			playSound "FD_CP_Not_Clear_F";
			waitUntil {sleep 0.1; currentVisionMode player != 2};
			LAYER cutText ["", "PLAIN"];
		};
	};
};