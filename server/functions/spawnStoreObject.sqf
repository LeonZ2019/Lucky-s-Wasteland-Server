// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: spawnStoreObject.sqf
//	@file Author: AgentRev
//	@file Created: 11/10/2013 22:17
//	@file Args:

if (!isServer) exitWith {};

scopeName "spawnStoreObject";
private ["_isGenStore", "_isGunStore", "_isVehStore", "_timeoutKey", "_objectID", "_playerSide", "_objectsArray", "_results", "_itemEntry", "_itemPrice", "_safePos", "_object"];

params [["_player",objNull,[objNull]], ["_itemEntrySent",[],[[]]], ["_npcName","",[""]], ["_key","",[""]]];

_itemEntrySent params [["_class","",[""]]];

_isGenStore = ["GenStore", _npcName] call fn_startsWith;
_isGunStore = ["GunStore", _npcName] call fn_startsWith;
_isVehStore = ["VehStore", _npcName] call fn_startsWith;

private _storeNPC = missionNamespace getVariable [_npcName, objNull];
private _marker = _npcName;

if (_key != "" && _player isKindOf "Man" && {_isGenStore || _isGunStore || _isVehStore}) then
{
	_timeoutKey = _key + "_timeout";
	_objectID = "";
	private _seaSpawn = false;
	private _playerGroup = group _player;
	_playerSide = side _playerGroup;

	if (_isGenStore || _isGunStore) then
	{
		_npcName = _npcName + "_objSpawn";

		switch (true) do
		{
			case _isGenStore: {
				_objectsArray = call genObjectsArray;
				{ _objectsArray pushBack _x } forEach (call genBuildingsArray);
				{ _objectsArray pushBack _x } forEach (call genWallsArray);
			};
			case _isGunStore: { _objectsArray = call staticGunsArray};
		};
		_results = _objectsArray select {_x select [1,999] isEqualTo _itemEntrySent};

		if (count _results > 0) then
		{
			_itemEntry = _results select 0;
			_marker = _marker + "_objSpawn";
		};
	};

	if (_isVehStore) then
	{
		// LAND VEHICLES
		{
			_results = (call _x) select {_x select [1,999] isEqualTo _itemEntrySent};

			if (count _results > 0) then
			{
				_itemEntry = _results select 0;
				_marker = _marker + "_landSpawn";
			};
		} forEach [landArray, armoredArray, tanksArray];

		// SEA VEHICLES
		if (isNil "_itemEntry") then
		{
			_results = (call boatsArray) select {_x select [1,999] isEqualTo _itemEntrySent};

			if (count _results > 0) then
			{
				_itemEntry = _results select 0;
				_marker = _marker + "_seaSpawn";
				_seaSpawn = true;
			};
		};

		// HELICOPTERS
		if (isNil "_itemEntry") then
		{
			_results = (call helicoptersArray) select {_x select [1,999] isEqualTo _itemEntrySent};

			if (count _results > 0) then
			{
				_itemEntry = _results select 0;
				_marker = _marker + "_heliSpawn";
			};
		};

		// AIRPLANES
		if (isNil "_itemEntry") then
		{
			_results = (call planesArray) select {_x select [1,999] isEqualTo _itemEntrySent};

			if (count _results > 0) then
			{
				_itemEntry = _results select 0;
				_marker = _marker + "_planeSpawn";
			};
		};
		
		// ANTI-AIR
		if (isNil "_itemEntry") then
		{
			_results = (call antiAirArray) select {_x select [1,999] isEqualTo _itemEntrySent};

			if (count _results > 0) then
			{
				_itemEntry = _results select 0;
				_marker = _marker + "_antiAirSpawn";
			};
		};
		_itemPrice = _itemEntry select 2;
		switch (_npcName) do
		{
			case "VehStore8";
			case "VehStore9":
			{
				_itemPrice = _itemPrice * 1.05;
			};
			case "VehStore5":
			{
				_itemPrice = _itemPrice * 0.9;
			};
			case "VehStore1";
			case "VehStore2";
			case "VehStore3";
			case "VehStore6";
			case "VehStore7":
			{
				_itemPrice = _itemPrice * 0.95;
			};
		};
		_itemEntry set [2, _itemPrice];
	};

	if (!isNil "_itemEntry" && markerShape _marker != "") then
	{
		_itemPrice = _itemEntry select 2;
		_skipSave = "SKIPSAVE" in (_itemEntry select [3,999]);

		/*if (_class isKindOf "Box_NATO_Ammo_F") then
		{
			switch (side _player) do
			{
				case OPFOR:       { _class = "Box_East_Ammo_F" };
				case INDEPENDENT: { _class = "Box_IND_Ammo_F" };
			};
		};*/

		if (_player getVariable ["cmoney", 0] >= _itemPrice) then
		{
			private _markerPos = markerPos _marker;
			private _npcPos = getPosATL _storeNPC;
			//private _canFloat = (round getNumber (configFile >> "CfgVehicles" >> _class >> "canFloat") > 0);
			private _waterNonBoat = false;
			private "_spawnPosAGL";

			// non-boat spawn over water (e.g. aircraft carrier)
			if (!isNull _storeNPC && surfaceIsWater _npcPos) then
			{
				_markerPos set [2, _npcPos select 2];
				_spawnPosAGL = ASLToAGL _markerPos;
				_safePos = _spawnPosAGL;
				_waterNonBoat = true;
			}
			else // normal spawn
			{
				_safePos = _markerPos findEmptyPosition [0, 50, _class];
				if (count _safePos == 0) then { _safePos = _markerPos };
				_spawnPosAGL = _safePos;
				if (_seaSpawn) then { _safePos vectorAdd [0,0,0.05] };
			};

			// delete wrecks near spawn
			private _wreckPos = if (_waterNonBoat) then { ATLToASL _spawnPosAGL } else { _spawnPosAGL };
			{
				if (!alive _x) then
				{
					deleteVehicle _x;
				};
			} forEach nearestObjects [_wreckPos, ["LandVehicle","Air","Ship"], 25 max sizeOf _class];

			if (_player getVariable [_timeoutKey, true]) then { breakOut "spawnStoreObject" }; // Timeout

			_object = createVehicle [_class, _safePos, [], 0, "NONE"];

			if (_waterNonBoat) then
			{
				//_object setPosATL [_safePos select 0, _safePos select 1, (_safePos select 2 + 0.25)];
				_newPos = [_safePos select 0, _safePos select 1, (_safePos select 2 + 0.25)];
 				_object allowDamage false;
				_object setVehiclePosition [_newPos,[],10,"CAN_COLLIDE"];
 				_object allowDamage true;
			};

			if (_player getVariable [_timeoutKey, true]) then // Timeout
			{
				deleteVehicle _object;
				breakOut "spawnStoreObject";
			};

			_objectID = netId _object;
			_object setVariable ["A3W_purchasedStoreObject", true];
			_object setVariable ["ownerUID", getPlayerUID _player, true];
			_object setVariable ["ownerName", name _player, true];
			if (isPlayer _player) then { _object setPlateNumber name _player };

			private _variant = (_itemEntry select {_x isEqualType "" && {_x select [0,8] == "variant_"}}) param [0,""];

			if (_variant != "") then
			{
				_object setVariable ["A3W_vehicleVariant", _variant select [8], true];
			};

			private _isUAV = (round getNumber (configFile >> "CfgVehicles" >> _class >> "isUav") > 0);

			if (_isUAV) then
			{
				createVehicleCrew _object;

				//assign AI to the vehicle so it can actually be used
				[_object, _playerSide, _playerGroup] spawn
				{
					params ["_uav", "_playerSide", "_playerGroup"];

					_grp = [_uav, _playerSide, true] call fn_createCrewUAV;

					if (isNull (_uav getVariable ["ownerGroupUAV", grpNull])) then
					{
						_uav setVariable ["ownerGroupUAV", _playerGroup, true]; // not currently used
					};
				};
			};

			if (_skipSave) then
			{
				_object setVariable ["A3W_skipAutoSave", true, true];
			};

			if !(_player getVariable [_timeoutKey, true]) then
			{
				[_player, -_itemPrice] call A3W_fnc_setCMoney;
				_player setVariable [_key, _objectID, true];
			}
			else // Timeout
			{
				if (!isNil "_object") then { deleteVehicle _object };
				breakOut "spawnStoreObject";
			};

			if (_object isKindOf "AllVehicles" && !(_object isKindOf "StaticWeapon")) then
			{
				if (!surfaceIsWater _safePos) then
				{
					_object setPosATL [_safePos select 0, _safePos select 1, 0.25];
				};

				_object setVelocity [0,0,0.01];
				// _object spawn cleanVehicleWreck;
				_object setVariable ["A3W_purchasedVehicle", true, true];

				if (["A3W_vehicleLocking"] call isConfigOn && !_isUAV) then
				{
					[_object, 2] call A3W_fnc_setLockState; // Lock
				};
			};

			_object setDir (markerDir _marker);

			_isDamageable = !(_object isKindOf "ReammoBox_F"); // ({_object isKindOf _x} count ["AllVehicles", "Lamps_base_F", "Cargo_Patrol_base_F", "Cargo_Tower_base_F"] > 0);

			[_object] call vehicleSetup;
			_object allowDamage _isDamageable;
			_object setVariable ["allowDamage", _isDamageable, true];

			clearBackpackCargoGlobal _object;

			// give diving gear to RHIB, Speedboat, and SDV
			if ({_object isKindOf _x} count ["Boat_Transport_02_base_F","Boat_Armed_01_base_F","SDV_01_base_F"] > 0) then
			{
				switch (side _player) do
				{
					case BLUFOR:
					{
						_object addItemCargoGlobal ["U_B_Wetsuit", 1];
						_object addItemCargoGlobal ["V_RebreatherB", 1];
					};
					case OPFOR:
					{
						_object addItemCargoGlobal ["U_O_Wetsuit", 1];
						_object addItemCargoGlobal ["V_RebreatherIR", 1];
					};
					default
					{
						_object addItemCargoGlobal ["U_I_Wetsuit", 1];
						_object addItemCargoGlobal ["V_RebreatherIA", 1];
					};
				};

				_object addItemCargoGlobal ["G_Diving", 1];
				_object addWeaponCargoGlobal ["arifle_SDAR_F", 1];
				_object addMagazineCargoGlobal ["20Rnd_556x45_UW_mag", 4];
				_object addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 2];
			};

			if (!_skipSave) then
			{
				if (_object getVariable ["A3W_purchasedVehicle", false] && !isNil "fn_manualVehicleSave") then
				{
					_object call fn_manualVehicleSave;
				};
			};

			if (_object isKindOf "AllVehicles") then
			{
				if (isNull group _object) then
				{
					_object setOwner owner _player; // tentative workaround for exploding vehicles
				}
				else
				{
					(group _object) setGroupOwner owner _player;
				};
			};
			if (typeOf _object == "Land_Sacks_goods_F") then
			{
				_object setVariable ["food", 40, true];
			};
			if (typeOf _object == "Land_BarrelWater_F") then
			{
				_object setVariable ["water", 50, true];
			};
			if (typeOf _object == "Land_Cargo10_red_F") then
			{
				_object setVariable ["resupplyObject", true, true];
				[_object] remoteExecCall ["A3W_fnc_setupResupplyTruck", 0, _object];
			};
		};
	};
};
