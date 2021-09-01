// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: logisticsMissionProcessor.sqf

#define MISSION_PROC_TYPE_NAME "Logistics"
#define MISSION_PROC_TIMEOUT (["A3W_logisticsMissionTimeout", 60*60] call getPublicVar)
#define MISSION_PROC_COLOR_DEFINE logisticsMissionColor

#include "logisticsMissions\logisticsMissionDefines.sqf"
#include "missionProcessor.sqf";
