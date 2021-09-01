// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: firstSpawn.sqf
//	@file Author: [404] Deadbeat
//	@file Created: 28/12/2013 19:42

client_firstSpawn = true;

[] execVM "client\functions\welcomeMessage.sqf";

player addEventHandler ["Take",
{
	_vehicle = _this select 1;

	if (_vehicle isKindOf "LandVehicle" && {!(_vehicle getVariable ["itemTakenFromVehicle", false])}) then
	{
		_vehicle setVariable ["itemTakenFromVehicle", true, true];
	};
}];

player addEventHandler ["Put",
{
	_vehicle = _this select 1;

	if (_vehicle getVariable ["A3W_storeSellBox", false] && isNil {_vehicle getVariable "A3W_storeSellBox_track"}) then
	{
		_vehicle setVariable ["A3W_storeSellBox_track", _vehicle spawn
		{
			_vehicle = _this;

			waitUntil {sleep 1; !alive player || player distance _vehicle > 25};

			_sellScript = [_vehicle, player, -1, [true, true]] execVM "client\systems\selling\sellCrateItems.sqf";
			waitUntil {sleep 0.1; scriptDone _sellScript};

			if (!alive player) then
			{
				sleep 0.5;

				if (player getVariable ["cmoney", 0] > 0) then
				{
					// _m = createVehicle ["Land_Money_F", getPosATL player, [], 0.5, "CAN_COLLIDE"];
					// _m setVariable ["cmoney", player getVariable "cmoney", true];
					// _m setVariable ["owner", "world", true];
					// player setVariable ["cmoney", 0, true];
					// [_m] remoteExec ["A3W_fnc_setItemCleanup", 2];
					["dropMoney", player, player getVariable ["cmoney", 0]] call A3W_fnc_processTransaction;
				};
			};

			_vehicle setVariable ["A3W_storeSellBox_track", nil];
		}];
	};
}];

//player addEventHandler ["WeaponDisassembled", { _this spawn weaponDisassembledEvent }]; // now handled in fn_inGameUIActionEvent.sqf
player addEventHandler ["WeaponAssembled",
{
	params ["_player", "_obj"];

	clearBackpackCargoGlobal _obj;
	clearMagazineCargoGlobal _obj;
	clearWeaponCargoGlobal _obj;
	clearItemCargoGlobal _obj;

	if (unitIsUAV _obj) then
	{
		// Don't disable UAV thermal vision here, do it at the bottom of fn_createCrewUAV.sqf

		_playerSide = side group _player;

		if (side _obj != _playerSide && count crew _obj > 0) then
		{
			(crew _obj) joinSilent createGroup _playerSide;
		};

		if (isNil {_obj getVariable "ownerUID"}) then
		{
			_obj setVariable ["A3W_skipAutoSave", true, true]; // SKIPSAVE on first assembly

			_obj allowDamage true;
			_obj setVariable ["allowDamage", true, true];

			[_obj, true] call A3W_fnc_setVehicleLoadout;
		};

		_obj setVariable ["ownerUID", getPlayerUID _player, true];
		_obj setVariable ["ownerName", name _player, true];
		_obj setPlateNumber name _player;

		[_obj, _playerSide, true] call fn_createCrewUAV;

		if (!alive getConnectedUAV _player) then
		{
			_player connectTerminalToUAV _obj;
		};

		if !(_obj getVariable ["A3W_skipAutoSave", false]) then
		{
			if (_obj isKindOf "AllVehicles" && !(_obj isKindOf "StaticWeapon")) then
			{
				if (!isNil "fn_manualVehicleSave") then { _obj call fn_manualVehicleSave };
			}
			else
			{
				if (!isNil "fn_manualObjectSave") then { _obj call fn_manualObjectSave };
			};
		};
	};
}];

player addEventHandler ["InventoryOpened",
{
    params ["_unit", "_container"];
    private _isBackpack = getNumber (configFile >> "CfgVehicles" >> (typeOf _container) >> "isBackpack");
	[_unit, _container, _isBackpack] spawn {
		if (isNil { missionNamespace getVariable "BL_fnc_LockButton" }) then {
			BL_fnc_LockButton = compileFinal '
				if (!isNull ((findDisplay 602) displayCtrl 12346)) then {
					private _lockState = player getVariable ["BL_lockState", false];
					if (_lockState) then {
						["Backpack unlocked", 2] call mf_notify_client;
						player setVariable ["BL_lockState", false, true];
					} else {
						["Backpack locked", 2] call mf_notify_client;
						player setVariable ["BL_lockState", true, true];
					};
					player setVariable ["BL_lockTime", (time + 1)];
				};
			';
		};
		disableSerialization;
		params ["_unit", "_container", "_isBackpack"];
		private ["_BL_buttonCtrl", "_myPicture", "_isOthersBackpack", "_objectParent", "_BL_ctrlCreateArray"];
		waitUntil {(!isNull (findDisplay 602))};
		_display = findDisplay 602;
		_BL_ctrlCreateArray = ["RscPicture", 12345];
		_myPicture = _display ctrlCreate _BL_ctrlCreateArray;
		_myPicture ctrlSetPosition [
			(((ctrlPosition ((findDisplay 602) displayCtrl 6191)) select 0) + ((ctrlPosition ((findDisplay 602) displayCtrl 6191)) select 2)),
			((ctrlPosition ((findDisplay 602) displayCtrl 6191)) select 1)
		];
		_myPicture ctrlShow true;
		_myPicture ctrlSetScale 0.175;
		_myPicture ctrlCommit 0;
		_BL_ctrlCreateArray = ["RscButtonArsenal", 12346];
		_BL_buttonCtrl = _display ctrlCreate _BL_ctrlCreateArray;
		_BL_buttonCtrl ctrlSetPosition (ctrlPosition _myPicture);
		if (player getVariable "BL_lockState") then {
			_BL_buttonCtrl ctrlSetText "\A3\Modules_f\data\iconLock_ca.paa";
		} else {
			_BL_buttonCtrl ctrlSetText "\A3\Modules_f\data\iconUnlock_ca.paa";
		};
		_BL_buttonAction = "[] call BL_fnc_LockButton";
		_BL_buttonCtrl buttonSetAction _BL_buttonAction;
		_BL_buttonCtrl ctrlShow true;
		_BL_buttonCtrl ctrlSetScale 0.175;
		_BL_buttonCtrl ctrlCommit 0;
		ctrlDelete _myPicture;
		while {(!isNull (findDisplay 602))} do {
			if (player getVariable ["BL_lockState", false]) then {
				_BL_buttonCtrl ctrlSetText "\a3\Modules_f\data\iconlock_ca.paa";
			} else {
				_BL_buttonCtrl ctrlSetText "\a3\Modules_f\data\iconunlock_ca.paa";
			};
			if (time > (player getVariable "BL_lockTime")) then {
				if ((backpack player) isEqualTo "") then {
					if (ctrlEnabled _BL_buttonCtrl) then {
						_BL_buttonCtrl ctrlShow false;
						_BL_buttonCtrl ctrlEnable false;
					};
				} else {
					if (!(ctrlEnabled _BL_buttonCtrl)) then {
						_BL_buttonCtrl ctrlShow true;
						_BL_buttonCtrl ctrlEnable true;
					};
				};
			} else {
				if (ctrlEnabled _BL_buttonCtrl) then {
					_BL_buttonCtrl ctrlEnable false;
				};
			};
			uiSleep 0.01;
		};
	};
	_blocked = false;
	if !(_container isKindOf "Man") then
	{
		if ((locked _container > 1 && _container getVariable ["ownerUID", "0"] != getPlayerUID player) ||
		    (_container getVariable ["A3W_inventoryLockR3F", false] && _container getVariable ["R3F_LOG_disabled", false])) then
		{
			playSound "FD_CP_Not_Clear_F";

			if (_container isKindOf "AllVehicles") then
			{
				["This vehicle is locked.", 5] call mf_notify_client;
			}
			else
			{
				["This object is locked.", 5] call mf_notify_client;
			};

			_blocked = true;
		} else
		{
			if (_isBackpack isEqualTo 1) then {
				_objectParent = objectParent _container;
				if (!isNull _objectParent && alive _objectParent && isPlayer _objectParent && _objectParent getVariable ["BL_lockState", false]) then {
					playSound "FD_CP_Not_Clear_F";
					[format ["%1's backpack is locked",(name _objectParent)], 5] call mf_notify_client;
					_blocked = true;
				};
			};

		}
	};

	if (!_blocked) then
	{
		if (!simulationEnabled _container) then { _container enableSimulation true };
		_container setVariable ["inventoryIsOpen", true];
	};

	_blocked
}];

player addEventHandler ["InventoryClosed",
{
	_obj = _this select 1;
	_obj setVariable ["inventoryIsOpen", nil];
}];

[] spawn
{
	waitUntil
	{
		// Prevent usage of commander camera
		if (cameraView == "GROUP" && cameraOn in [player, vehicle player]) then
		{
			cameraOn switchCamera "EXTERNAL";
		};

		false
	};
};

player addEventHandler ["HandleDamage", unitHandleDamage];

if (["A3W_remoteBombStoreRadius", 0] call getPublicVar > 0) then
{
	player addEventHandler ["Fired",
	{
		// Remove explosives if within 100m of a store
		if (_this select 1 == "Put") then
		{
			_ammo = _this select 4;

			//if ({_ammo isKindOf _x} count ["PipeBombBase", "ClaymoreDirectionalMine_Remote_Ammo"] > 0) then // "touchable" remote explosives only
			if (_ammo isKindOf "TimeBombCore") then // all explosives
			{
				_mag = _this select 5;
				_bomb = _this select 6;
				_minDist = ["A3W_remoteBombStoreRadius", 100] call getPublicVar;

				{
					if (_x getVariable ["storeNPC_setupComplete", false] && {_bomb distance _x < _minDist}) exitWith
					{
						deleteVehicle _bomb;
						[player, _mag] call fn_forceAddItem;
						playSound "FD_CP_Not_Clear_F";
						titleText [format ["You are not allowed to place explosives within %1m of a store.\nThe explosive has been re-added to your inventory.", _minDist], "PLAIN DOWN", 0.5];
					};
				} forEach entities "CAManBase";
			};
		};
	}];
};

if (["A3W_combatAbortDelay", 0] call getPublicVar > 0) then
{
	player addEventHandler ["FiredNear",
	{
		// Prevent aborting if event is not for placing an explosive
		if (_this select 3 != "Put") then {
			combatTimestamp = diag_tickTime;
		};
	}];

	player addEventHandler ["Hit",
	{
		_source = effectiveCommander (_this select 1);
		if (!isNull _source && _source != player) then {
			combatTimestamp = diag_tickTime;
		};
	}];
};

player addEventHandler ["GetInMan", { [_this select 2] call getInVehicle }];
player addEventHandler ["GetOutMan", { [_this select 2] call getOutVehicle }];

_uid = getPlayerUID player;

if (playerSide in [BLUFOR,OPFOR] && {{_x select 0 == _uid} count pvar_teamSwitchList == 0}) then
{
	_startTime = diag_tickTime;
	waitUntil {sleep 1; diag_tickTime - _startTime >= 180};

	pvar_teamSwitchLock = [_uid, playerSide];
	publicVariableServer "pvar_teamSwitchLock";

	_side = switch (playerSide) do
	{
		case BLUFOR: { "BLUFOR" };
		case OPFOR:  { "OPFOR" };
	};

	titleText [format ["You have been locked to %1", _side], "PLAIN", 0.5];
};
