// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_AltisHasFallen.sqf
//	@file Author: Leon

if (!isServer) exitwith {};
#include "logisticsMissionDefines.sqf";

private ["_locArray", "_buildingRadius", "_townName", "_createVehicle", "_safePos", "_heli", "_ssaGroup", "_president", "_airportPos", "_distanceMin", "_taxiIn", "_taxiDistance", "_airforceOne", "_planeDir", "_extractedPoint", "_AAgroup"];

_setupVars =
{
	_missionType = "Altis Has Fallen";
	_locArray = ((call cityList) call BIS_fnc_selectRandom);
	_missionPos = markerPos (_locArray select 0);
	_buildingRadius = _locArray select 1;
	_townName = _locArray select 2;
};

_setupObjects =
{
	_createVehicle =
	{
		private ["_heli", "_pilot", "_boxes", "_box", "_attachedPos", "_loopPos"];
		_heli = createVehicle ["I_Heli_Transport_02_F", _this, [], 0, "NONE"];
		_heli setVariable ["R3F_LOG_disabled", false, true];
		[_heli, (call colorsArray) select { _x select 0 == "I_Heli_Transport_02_F"} select 0 select 1 select { _x select 0 == "Marine One"} select 0 select 1] call applyVehicleTexture;
		[_heli] call vehicleSetup;
		_heli setDir (random 360);
		_aiGroup = createGroup CIVILIAN;
		_aiGroup addVehicle _heli;
		_pilot = [_aiGroup, position _heli] call createRandomPilot;
		_pilot moveInDriver _heli;
		moveOut _pilot;
		_pilot setDamage 1;
		/*_boxes = [];
		for "_i" from 1 to 2 do
		{
			_box = createVehicle [["Box_East_WpsSpecial_F","Box_NATO_WpsSpecial_F"] call BIS_fnc_selectRandom, position _heli, [], 3, "NONE"];
			[_box, ["mission_USLaunchers","mission_RULaunchers"] call BIS_fnc_selectRandom] call fn_refillbox;
			_box setVariable ["cmoney", 25000, true];
			_box setVariable ["R3F_LOG_disabled", false, true];
			_attachedPos = [random 3000, random 3000, (10000 + (random 3000))];
			_loopPos = 1;
			while {(!isNull (nearestObject _attachedPos)) && (_loopPos < 10)} do
			{
				_attachedPos = [random 3000, random 3000, (10000 + (random 3000))];
				_loopPos = _loopPos + 1;
			};
			[R3F_LOG_PUBVAR_point_attache, true] call fn_enableSimulationGlobal;
			[_box, true] call fn_enableSimulationGlobal;
			_box attachTo [R3F_LOG_PUBVAR_point_attache, _attachedPos];
			_box setVariable ["R3F_LOG_est_transporte_par", _heli, true];
			_boxes = _boxes + [_box];
		};
		_heli setVariable ["R3F_LOG_objets_charges", _boxes, true];*/
		_heli setVariable ["Mission_Vehicle", true, true];
		_heli allowCrewInImmobile true;
		_heli
	};

	_safePos = [_missionPos, 0, _buildingRadius * 1.5, sizeOf "I_Heli_Transport_02_F" * 0.5, 0, 7.5, 0] call BIS_fnc_findSafePos;
	_heli = _safePos call _createVehicle;
	_ssaGroup = createGroup CIVILIAN;
	_president = [_ssaGroup, _safePos, "president"] call createStoryMen;
	_president moveInCargo _heli;
	_president setCaptive true;
	_president disableAI "all";
	_airportPos = [];
	_distanceMin = worldSize;
	for "_i" from 1 to 5 do
	{
		_taxiIn = getArray (configfile >> "CfgWorlds" >> "Altis" >> "SecondaryAirports" >> format ["Airstrip_%1", _i] >> "ilsTaxiIn");
		_taxiDistance = _safePos distance2D [_taxiIn select 0, _taxiIn select 1];
		if (_taxiDistance >= 3500 && _taxiDistance < _distanceMin) then
		{
			_distanceMin = _taxiDistance;
			_airportPos = _taxiIn;
		};
	};
	_airforceOne = createVehicle ["B_T_VTOL_01_infantry_F", [_airportPos select 0, _airportPos select 1, 0], [], 0, "NONE"];
	_airforceOne allowDamage false;
	_airforceOne setVariable ["R3F_LOG_disabled", true, true];
	_airforceOne lock 3;
	_planeDir = _airforceOne getRelDir [_airportPos select 2, _airportPos select 3];
	_airforceOne setDir _planeDir;
	_extractedPoint = createMarker ["missionAirForceOne", getPos _airforceOne];
	_extractedPoint setMarkerType "loc_plane";
	_extractedPoint setMarkerText "Air Force One";
	_extractedPoint setMarkerColor "ColorWhite";
	_extractedPoint setMarkerSize [0.5, 0.5];

	_AAgroup = createGroup CIVILIAN;
	_AAgroup setBehaviour "COMBAT";
	_AAgroup setCombatMode "RED";
	[_heli, _AAgroup, _president, _airforceOne] spawn {
		params ["_heli", "_AAgroup", "_president", "_airforceOne", "_boxes", "_box", "_attachedPos", "_loopPos"];
		private ["_alive", "_aiPos"];
		waitUntil
		{
			sleep 0.5;
			(getPos _heli select 2 >= 10) && ((vectorMagnitude velocity _heli) * 3.6 >= 50)
		};
		while {!(isNull _president) && {alive _president} && _heli distance _airforceOne >= 800} do
		{
			sleep 2.5;
			_alive = units _AAgroup select {alive _x};
			if ((count _alive == 0) || (count _alive > 0 && {((_alive select 0) distance _heli) > 550})) then
			{
				{ deleteVehicle _x } forEach _alive;
				
				for "_i" from 1 to 2 do
				{
					_aiPos = _heli getRelPos [((random 50) + (speed _heli / 3.6 * 5)) min ((_heli distance _airforceOne) * 0.5), random 90 + 135];
					[_AAgroup, _aiPos] call createAASoldier;
				};
				_AAgroup reveal [_heli, 1];
			};
		};
		_boxes = [];
		for "_i" from 1 to 2 do
		{
			_box = createVehicle [["Box_East_WpsSpecial_F","Box_NATO_WpsSpecial_F"] call BIS_fnc_selectRandom, position _heli, [], 3, "NONE"];
			[_box, ["mission_USLaunchers","mission_RULaunchers"] call BIS_fnc_selectRandom] call fn_refillbox;
			_box setVariable ["cmoney", 25000, true];
			_box setVariable ["R3F_LOG_disabled", false, true];
			_attachedPos = [random 3000, random 3000, (10000 + (random 3000))];
			_loopPos = 1;
			while {(!isNull (nearestObject _attachedPos)) && (_loopPos < 10)} do
			{
				_attachedPos = [random 3000, random 3000, (10000 + (random 3000))];
				_loopPos = _loopPos + 1;
			};
			[R3F_LOG_PUBVAR_point_attache, true] call fn_enableSimulationGlobal;
			[_box, true] call fn_enableSimulationGlobal;
			_box attachTo [R3F_LOG_PUBVAR_point_attache, _attachedPos];
			_box setVariable ["R3F_LOG_est_transporte_par", _heli, true];
			_boxes = _boxes + [_box];
		};
		_heli setVariable ["R3F_LOG_objets_charges", _boxes, true];
		{ deleteVehicle _x } forEach ((units _AAgroup) select {alive _x});
	};
	//_missionPicture = getText (configFile >> "CfgVehicles" >> _vehicleClass >> "picture");
	_missionHintText = "A terrorist group is ambusing the President and his heli, the pilot is dead, take control of the heli and take him back to his aircraft";
};

_ignoreAiDeaths = true;
_waitUntilMarkerPos = {getPos _president};
_waitUntilExec = nil;
_waitUntilCondition = {!alive _president || !alive _heli}; // let focus on the man instead of heli, heli down mean man down
_waitUntilSuccessCondition = {
	((getPosATL _heli) select 2 <= 1) && (vectorMagnitude velocity _heli < 1) && alive _president && (vehicle _president distance _airforceOne <= 75)
};

_failedExec =
{
	// Mission failed
	// get killer and terrorist give him reward for killing President
	_failedhintMessage = "POTUS didn't survive on the way back to his aircraft";
	deleteMarker _extractedPoint;
	_heli setVariable ["Mission_Vehicle", false, true];
	{ if (alive _x) then { deleteVehicle _x }; } forEach [_president, _airforceOne];
};

_successExec =
{
	// Mission complete
	deleteMarker _extractedPoint;
	if !(isNull (driver _heli)) then
	{
		[_heli, driver _heli] call A3W_fnc_takeOwnership;
	};
	{ if (alive _x) then { deleteVehicle _x }; } forEach [_president, _airforceOne];
	_heli setVariable ["Mission_Vehicle", false, true];
	_successHintMessage = "The president is safe, well done.";
};

_this call logisticsMissionProcessor;
