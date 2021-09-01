// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: logisticsMissionController.sqf

#define MISSION_CTRL_PVAR_LIST LogisticsMissions
#define MISSION_CTRL_TYPE_NAME "Logistics"
#define MISSION_CTRL_FOLDER "logisticsMissions"
#define MISSION_CTRL_DELAY (["A3W_logisticsMissionDelay", 15*60] call getPublicVar)
#define MISSION_CTRL_COLOR_DEFINE logisticsMissionColor

#include "logisticsMissions\logisticsMissionDefines.sqf"
#include "missionController.sqf";
