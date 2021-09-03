// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: sellVehicle.sqf
//	@file Author: AgentRev
//  @file edited: CRE4MPIE
//  @credits to: Cael817, lodac, Wiking

#include "sellIncludesStart.sqf";

storeSellingHandle = _this spawn
{
	#define CHOPSHOP_PRICE_RELATIONSHIP 2
	#define VEHICLE_MAX_SELLING_DISTANCE 50

	_storeNPC = _this select 0;
	_vehicle = objectFromNetId (player getVariable ["lastVehicleRidden", ""]);

	if (isNull _vehicle) exitWith
	{
		playSound "FD_CP_Not_Clear_F";
		["Your previous vehicle was not found.", "Error"] call  BIS_fnc_guiMessage;
	};

	_type = typeOf _vehicle;
	_objName = getText (configFile >> "CfgVehicles" >> _type >> "displayName");

	_checkDamage =
	{
		if (damage _vehicle > 0.99) then
		{
			playSound "FD_CP_Not_Clear_F";
			[format ['"%1" is too much damaged to be sold.', _objName], "Error"] call  BIS_fnc_guiMessage;
			false
		} else { true };
	};

	_checkValidDistance =
	{
		if (_vehicle distance _storeNPC > VEHICLE_MAX_SELLING_DISTANCE) then
		{
			playSound "FD_CP_Not_Clear_F";
			[format ['"%1" is further away than %2m from the store.', _objName, VEHICLE_MAX_SELLING_DISTANCE], "Error"] call  BIS_fnc_guiMessage;
			false
		} else { true };
	};

	_checkValidOwnership =
	{
		if (!local _vehicle) then
		{
			playSound "FD_CP_Not_Clear_F";
			[format ['You are not the owner of "%1", try getting in the driver seat.', _objName], "Error"] call  BIS_fnc_guiMessage;
			false
		} else { true };
	};

	_checkIfMission =
	{
		if (_vehicle getVariable ["Mission_Vehicle", false]) then
		{
			playSound "FD_CP_Not_Clear_F";
			[format ['You cant sell this "%1" from mission.', _objName], "Error"] call  BIS_fnc_guiMessage;
			false
		} else { true };
	};

	if (!call _checkDamage) exitWith {};
	if (!call _checkValidDistance) exitWith {};
	if (!call _checkValidOwnership) exitWith {};
	if (!call _checkIfMission) exitWith {};

	private _variant = _vehicle getVariable ["A3W_vehicleVariant", ""];
	if (_variant != "") then { _variant = "variant_" + _variant };

	_price = 1000;

	{
		if (_type == _x select 1 && (_variant == "" || {_variant in _x})) exitWith
		{
			_price = (ceil (((_x select 2) / CHOPSHOP_PRICE_RELATIONSHIP) / 5)) * 5;
		};
	} forEach (call allVehStoreVehicles + call staticGunsArray);

	if (!isNil "_price") then
	{
		// Add total sell value to confirm message
		_confirmMsg = format ["Selling the %1 will give you $%2<br/>", _objName, [_price] call fn_numbersText];

		// Display confirm message
		if ([parseText _confirmMsg, "Confirm", "Sell", true] call BIS_fnc_guiMessage) then
		{
			if (!call _checkValidDistance) exitWith {};
			if (!call _checkValidOwnership) exitWith {};

			if (_vehicle distance _storeNPC > VEHICLE_MAX_SELLING_DISTANCE) exitWith
			{
				playSound "FD_CP_Not_Clear_F";
				[format ['The %1 has already been sold!', _objname, VEHICLE_MAX_SELLING_DISTANCE], "Error"] call  BIS_fnc_guiMessage;
			};

			private _items = _vehicle getVariable ["R3F_LOG_objets_charges", []];
			if (count _items > 0) then {
				{
					if (!isNull attachedTo _x) then
					{
						detach _x;
						_x setVariable ["R3F_LOG_est_transporte_par", objNull, true];
						[_x, true] call fn_enableSimulationGlobal;
						if (unitIsUAV _x) then
						{
							[_x, 1] call A3W_fnc_setLockState;
							["enableDriving", _x] call A3W_fnc_towingHelper;
						};
						_dimension_max = (((boundingBox _x select 1 select 1) max (-(boundingBox _x select 0 select 1))) max ((boundingBox _x select 1 select 0) max (-(boundingBox _x select 0 select 0))));
						_safePos = [
							(getPos _veh select 0) - ((_dimension_max+(random 5)-(boundingBox _veh select 0 select 1))*sin (getDir _veh - 90+random 180)),
							(getPos _veh select 1) - ((_dimension_max+(random 5)-(boundingBox _veh select 0 select 1))*cos (getDir _veh - 90+random 180)),
							0
						];
						_x setPos _safePos;
						_x setVelocity [0,0,0];
					};
				} forEach _items;
				_veh setVariable ["R3F_LOG_objets_charges", [], true];
			};

			private _attachedObjs = attachedObjects _vehicle;
			deleteVehicle _vehicle;
			{
				["detach", _x] call A3W_fnc_towingHelper;
			} forEach _attachedObjs;

			//player setVariable ["cmoney", (player getVariable ["cmoney",0]) + _price, true];
			[player, _price] call A3W_fnc_setCMoney;
			[format ['The %1 has been sold!', _objname, VEHICLE_MAX_SELLING_DISTANCE], "Thank You"] call  BIS_fnc_guiMessage;

			if (["A3W_playerSaving"] call isConfigOn) then
			{
				[] spawn fn_savePlayerData;
			};
		};
	}
	else
	{
		hint parseText "<t color='#FFFF00'>An unknown error occurred.</t><br/>Vehicle sale cancelled.";
		playSound "FD_CP_Not_Clear_F";
	};
};

#include "sellIncludesEnd.sqf";
