// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_Artillery.sqf

if (!isServer) exitwith {};
#include "mainMissionDefines.sqf";

private ["_vehicleClass", "_nbUnits"];

_setupVars =
{
	_vehicleClass = ["I_Truck_02_MRL_F", "B_MBT_01_mlrs_F", "O_MBT_02_arty_F", "B_MBT_01_arty_F"];

	_missionType = "Artillery Vehicle";

	_locationsArray = MissionSpawnMarkers;

	_nbUnits = if (missionDifficultyHard) then { [AI_GROUP_LARGE * 1.3, 0] call BIS_fnc_cutDecimals } else { AI_GROUP_LARGE };
};

_this call mission_VehicleCapture;
