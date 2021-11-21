// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: setupMissionArrays.sqf
//	@file Author: AgentRev

if (!isServer) exitWith {};

MainMissions =
[
	// Mission filename, weight
	["mission_ArmedDiversquad", 1],
	["mission_Coastal_Convoy", 1],
	["mission_Convoy", 1],
	["mission_HostileHeliFormation", 0.5],
	["mission_APC", 1],
	["mission_MBT", 1],
	["mission_LightArmVeh", 1],
	["mission_ArmedHeli", 0.5],
	["mission_CivHeli", 1],
	["mission_deviceDelivery", 0.8]
];

SideMissions =
[
	["mission_HostileHelicopter", 0.5],
	["mission_SunkenSupplies", 1],
	["mission_TownInvasion", 1],
	["mission_Outpost", 1],
	["mission_Truck", 1],
	["mission_geoCache", 0.3],
	["mission_RescueHostage", 1],
	["mission_Demining", 1.15],
	["mission_Medevac", 0]
];

MoneyMissions =
[
	["mission_MoneyShipment", 1],
	["mission_SunkenTreasure", 1]
];

MilitaryMissions =
[
	["mission_HostileJet", 0.75],
	["mission_HostileJetFormation", 0.6],
	["mission_AbandonedJet", 1],
	["mission_Sniper", 0.95],
	["mission_Roadblock", 1],
	["mission_policePatrol", 1.25],
	["mission_militaryPatrol", 1],
	["mission_RescueWarCrime", 1],
	["mission_AntiAir", 1]
];

LogisticsMissions =
[
	["mission_MiniConvoy", 1],
	["mission_Airdrop", 1],
	["mission_DeliverySupply", 1]
];

MissionSpawnMarkers = (allMapMarkers select {["Mission_", _x] call fn_startsWith}) apply {[_x, false]};
ForestMissionMarkers = (allMapMarkers select {["ForestMission_", _x] call fn_startsWith}) apply {[_x, false]};
SunkenMissionMarkers = (allMapMarkers select {["SunkenMission_", _x] call fn_startsWith}) apply {[_x, false]};
SniperMissionMarkers = (allMapMarkers select {["Sniper_", _x] call fn_startsWith}) apply {[_x, false]}; // the mission file need create sniper_01 something
RoadblockMissionMarkers = (allMapMarkers select {["RoadBlock_", _x] call fn_startsWith}) apply {[_x, false]};
JetMarkers = (allMapMarkers select {["Jet_", _x] call fn_startsWith}) apply {[_x, false]};
HQSafePosMarkers = (allMapMarkers select {["EvacHQ_", _x] call fn_startsWith}) apply {[_x, false]};

if !(ForestMissionMarkers isEqualTo []) then
{
	SideMissions append
	[
		["mission_AirWreck", 0.75]
	];
};

LandConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\landConvoysList.sqf") apply {[_x, false]};
CoastalConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\coastalConvoysList.sqf") apply {[_x, false]};
PatrolConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\patrolConvoysList.sqf") apply {[_x, false]};

MainMissions = [MainMissions, [["A3W_heliPatrolMissions", ["mission_Coastal_Convoy", "mission_HostileHeliFormation"]], ["A3W_underWaterMissions", ["mission_ArmedDiversquad"]]]] call removeDisabledMissions;
SideMissions = [SideMissions, [["A3W_heliPatrolMissions", ["mission_HostileHelicopter"]], ["A3W_underWaterMissions", ["mission_SunkenSupplies"]]]] call removeDisabledMissions;
MoneyMissions = [MoneyMissions, [["A3W_underWaterMissions", ["mission_SunkenTreasure"]]]] call removeDisabledMissions;
MilitaryMissions = [MilitaryMissions, [["A3W_jetPatrolMissions", ["mission_HostileJet", "mission_HostileJetFormation"]], ["A3W_policeMissions", ["mission_Roadblock","mission_policePatrol"]]]] call removeDisabledMissions;

{ _x set [2, false] } forEach MainMissions;
{ _x set [2, false] } forEach SideMissions;
{ _x set [2, false] } forEach MoneyMissions;
{ _x set [2, false] } forEach MilitaryMissions;
{ _x set [2, false] } forEach LogisticsMissions;
