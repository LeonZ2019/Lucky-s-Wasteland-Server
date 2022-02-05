// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_deviceDelivery.sqf
//	@file Author: Leon
//	@file Created: 07/26/2021 01:34

if (!isServer) exitwith {};
#include "logisticsMissionDefines.sqf"

private ["_safePos", "_nearestRoad", "_startOfRoad", "_endOfRoad", "_roadCenter", "_roadDir", "_millerGrp", "_millerMarker", "_miller", "_vehicle", "_cash", "_box1", "_currBox1", "_pos"];

_setupVars =
{
	_missionType = "Miller's Truck";
	_locationsArray = MissionSpawnMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;

	_town = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);
	while {_town distance _missionPos < 4000 || _town distance _missionPos > 6500} do {
		_town = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);
	};
	_safePos = [_town, 50, 100, 5, 0, 0, 0] call findSafePos;
	_nearestRoad = getRoadInfo ((_safePos nearRoads 100) select 0);
	_startOfRoad = _nearestRoad select 6;
	_endOfRoad = _nearestRoad select 7;
	_edgeOfRoad = (round (- ((_nearestRoad select 1) / 2 * 1000))) / 1000;
	_roadCenter = [((_startOfRoad select 0) + (_endOfRoad select 0)) / 2, ((_startOfRoad select 1) + (_endOfRoad select 1)) / 2, 0];
	_roadDir = round (([_startOfRoad, _endOfRoad] call BIS_fnc_dirTo) - 90);
	if (_roadDir > 360) then {_roadDir = _roadDir - 360 };
	if (_roadDir < 0) then {_roadDir = _roadDir + 360 };
	_millerGrp = createGroup CIVILIAN;
	_miller = [_millerGrp, _roadCenter, "miller"] call createStoryMen;
	_miller setDir _roadDir;
	_miller setPos (_miller modelToWorld [0, _edgeOfRoad, 0]);

	_millerMarker = createMarker ["missionMiller", getPos _miller];
	_millerMarker setMarkerType "loc_talk";
	_millerMarker setMarkerText "Miller";
	_millerMarker setMarkerColor "ColorWhite";
	_millerMarker setMarkerSize [0.5, 0.5];

	_vehicle = createVehicle ["O_Truck_03_device_F", _missionPos, [], 0, "NONE"]; //unlocked
	_vehicle setVariable ["ownerName", "Miller", true];
	_vehicle setVariable ["Mission_Vehicle", true, true];
	[_vehicle] call vehicleSetup;

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_missionPos, 10, 20] spawn createCustomGroup;

	_missionHintText = format ["A <t color='%1'>Tempest (Device)</t> has been found, recover and delivery to Miller!", logisticsMissionColor];
	[_miller, _vehicle] spawn {
		params ["_miller", "_vehicle"];
		waitUntil
		{
			sleep 1;
			(count (crew _vehicle) == 0) && (_miller distance _vehicle) < 12.5 && ((getPos _vehicle) select 2 < 5) && (vectorMagnitude velocity _vehicle < 1)
		};
		_miller enableAI "MOVE";
		_miller assignAsDriver _vehicle;
		_vehicle disableAI "LIGHTS";
		[_miller] orderGetIn true;
	};
};

_ignoreAiDeaths = true;
_waitUntilMarkerPos = {getPos _vehicle};
_waitUntilExec = nil;
_waitUntilCondition = {!alive _miller || !alive _vehicle};
_waitUntilSuccessCondition = {
	count (crew _vehicle) == 1 && vehicle _miller == _vehicle
};

_failedExec =
{
	deleteMarker _millerMarker;
	if (alive _miller) then {
		deleteVehicle _miller;
	};
};

_successExec =
{
	_pos = getPosATL _vehicle;
	deleteMarker _millerMarker;
	{ deleteVehicle _x } forEach [_vehicle, _miller];
	_cash = createVehicle ["Land_Money_F", _pos, [], 5, "None"];
	_cash setPos ([_pos, [[0,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
	_cash setVariable ["owner", "world", true];
	_cash setVariable ["cmoney", 10000, true];

	_currBox1 = ["Box_East_WpsSpecial_F","Box_NATO_WpsSpecial_F"] call BIS_fnc_selectRandom;
	_box1 = createVehicle [_currBox1, _pos, [], 0, "None"];
	_box1 setDir random 360;
	[_box1, "mission_CTRGGears"] call fn_refillbox;

	_successHintMessage = "The Tempest (Device) has been delivered to Miller.";
};
_this call logisticsMissionProcessor;
