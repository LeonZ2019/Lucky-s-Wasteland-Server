// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_Demining.sqf
//	@file Author: Leon

if (!isServer) exitwith {};

#include "sideMissionDefines.sqf"

private ["_box1", "_box2", "_townName", "_missionPos", "_buildingRadius", "_mines", "_armedMines", "_totalMines"];

_setupVars =
{
	_missionType = "Town Demining";

	_locArray = ((call cityList) call BIS_fnc_selectRandom);
	_missionPos = markerPos (_locArray select 0);
	_buildingRadius = _locArray select 1;
    _buildingRadius = (_buildingRadius * 0.67) max 10 min 50;
	_townName = _locArray select 2;
};

_setupObjects =
{
    _mines = ["APERSBoundingMine", "APERSMine", "SLAMDirectionalMine"];
    _armedMines = [];
    _totalMines = parseNumber ((_buildingRadius * 0.27) toFixed 0) + 1;
    for "_i" from 1 to _totalMines do
    {
        _pos = [_missionPos, random (_buildingRadius * 0.5) + 2, _buildingRadius, 2, 0, 0, 0] call findSafePos;
        _armedMines pushBack (createMine [_mines call BIS_fnc_selectRandom, _pos, [], 1.5]);
    };

	_boxTypes = ["mission_USSpecial","mission_USRifles","mission_RURifles","mission_Main_A3snipers","mission_RUSniper"];
	_box1Type = _boxTypes call BIS_fnc_selectRandom;
	_box1 = createVehicle ["Box_East_Wps_F", _missionPos, [], 5, "None"];
	_box1 setDir random 360;
	[_box1, _box1Type] call fn_refillbox;
	_box2Type = _boxTypes call BIS_fnc_selectRandom;
	_box2 = createVehicle ["Box_East_Wps_F", _missionPos, [], 5, "None"];
	_box2 setDir random 360;
	[_box2, _box2Type] call fn_refillbox;
    { _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_box1, _box2];

	_missionHintText = format ["A minefield found at <br/><t size='1.25' color='%1'>%2</t><br/><br/>There seem to be <t color='%1'>%3 mines</t> placed at the town. Disarm all mines, and take the supplies!", sideMissionColor, _townName, _totalMines];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;
_ignoreAiDeaths = true;
_waitUntilSuccessCondition = {
    { !isNull _x } count _armedMines == 0
};
_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2];
	{
        if (!isNull _x) then
        {
            deleteVehicle _x;
        };
    } forEach [_armedMines];
};

_successExec =
{
	// Mission completed
    { _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];
	_successHintMessage = format ["Nice work on demine!<br/><br/><t color='%1'>%2</t><br/>is a safe place again!", sideMissionColor, _townName];
};

_this call sideMissionProcessor;
