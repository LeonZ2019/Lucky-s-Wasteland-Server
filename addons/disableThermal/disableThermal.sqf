// disableThermal.sqf
// by CRE4MPIE
// ver 0.3
// 2015-04-29 11:44pm
// contributions from BIStudio Forums, edited by CRE4MPIE, optimized by AgentRev

#define LAYER 85125
private ["_launchers", "_vehicles", "_turrets", "_currWep", "_currVeh", "_currUAV", "_role", "_uavRoleEnabled", "_disabled", "_uavSoldier", "_text"];

_launchers = ["launch_Titan_short_base", "launch_Titan_F", "launch_O_Titan_F", "launch_I_Titan_F", "launch_B_Titan_F", "Laserdesignator", "launch_Vorona_base_F"];
_vehicles = ["AA_01_base_F", "AT_01_base_F", "LT_01_base_F", "LSV_02_AT_base_F", "LSV_01_armed_base_F", "LSV_01_AT_base_F", "MRAP_01_base_F", "MRAP_02_base_F", "MRAP_03_base_F", "AFV_Wheeled_01_base_F", "APC_Wheeled_01_base_F", "APC_Wheeled_02_base_F", "APC_Wheeled_03_base_F", "APC_Tracked_01_base_F", "APC_Tracked_01_base_F", "APC_Tracked_02_base_F", "APC_Tracked_03_base_F", "MBT_01_base_F", "MBT_02_base_F", "MBT_03_base_F", "MBT_04_base_F", "Heli_Attack_01_base_F", "Heli_Attack_02_base_F", "Heli_light_03_base_F", "Plane_CAS_01_base_F", "Plane_CAS_02_base_F", "Plane_Fighter_01_Base_F", "Plane_Fighter_02_Base_F", "Plane_Fighter_03_base_F", "Plane_Fighter_04_Base_F", "VTOL_01_base_F", "VTOL_02_base_F"];
_turrets = ["GMG_01_A_base_F", "HMG_01_A_base_F", "UGV_01_rcws_base_F", "UAV_01_base_F", "UAV_02_base_F", "UAV_03_base_F", "UAV_04_base_F", "UAV_05_Base_F", "SAM_System_01_base_F", "SAM_System_02_base_F", "SAM_System_03_base_F", "SAM_System_04_base_F", "AAA_System_01_base_F", "B_Ship_Gun_01_base_F", "B_Ship_MRLS_01_base_F", "Radar_System_01_base_F", "Radar_System_02_base_F"];
_uavRoleEnabled = ["UAV_01_base_F", "UAV_02_base_F", "UAV_03_base_F", "Radar_System_01_base_F", "Radar_System_02_base_F"];

while {true && player getVariable ["donator", 0] == 0} do
{
	waitUntil {sleep 0.1; currentVisionMode player == 2 && cameraView == "GUNNER"}; // check for TI Mode

	_currWep = currentWeapon player;
	_currVeh = vehicle player;
	if ({_currWep isKindOf [_x, configfile >> "CfgWeapons"]} count _launchers > 0 || {_currVeh isKindOf _x} count _vehicles > 0) then
	{
		if (_currVeh == player && !(_currWep isKindOf ["launch_Titan_short_base", configfile >> "CfgWeapons"]) && _currWep isKindOf ["launch_Titan_base", configfile >> "CfgWeapons"]) then // titan aa only
		{
			if (daytime <= 20.5 && daytime > 3.5) then // allow titan use at night
			{
				LAYER cutText ["THERMAL IMAGING OFFLINE at DAY, try at NIGHT", "BLACK", 0.001];
				playSound "FD_CP_Not_Clear_F";
				waitUntil {sleep 0.1; currentVisionMode player != 2};
				LAYER cutText ["", "PLAIN"];
			};
		} else
		{
			LAYER cutText ["THERMAL IMAGING OFFLINE", "BLACK", 0.001];
			playSound "FD_CP_Not_Clear_F";
			waitUntil {sleep 0.1; currentVisionMode player != 2};
			LAYER cutText ["", "PLAIN"];
		};
	} else
	{
		_currUAV = getConnectedUAV player;
		if (alive _currUAV) then
		{
			if ({_currUAV isKindOf _x} count _turrets > 0) then
			{
				_uavSoldier = ["_soldier_UAV_", typeOf player] call fn_findString != -1;
				if !(_currUAV getVariable ["A3W_vehicleVariant", ""] in ["greyhawkUnarmed", "falconUnarmed"] && _uavSoldier && _uavRoleEnabled findIf {_currUAV isKindOf _x} != -1) then
				{
					_role = UAVControl _currUAV select 1;
					if (_role != "") then
					{
						_text = if (_uavSoldier) then { "THERMAL IMAGING OFFLINE for Armed Vehicle" } else {"THERMAL IMAGING OFFLINE for None UAV Operator" };
						LAYER cutText [_text, "BLACK", 0.001];
						playSound "FD_CP_Not_Clear_F";
						waitUntil {sleep 0.1; currentVisionMode player != 2};
						LAYER cutText ["", "PLAIN"];
					};
				};
			};
		};
	};
};

