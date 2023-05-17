if (!hasInterface) exitWith {};

LEON_lockedPos = AGLtoASL (screenToWorld [0.5,0.5]);
LEON_isLocked = false;
LEON_lockedObject = objNull;
LEON_lockedObjectOffset = [0,0,0];
LEON_tmpTarget = objNull;
LEON_WeaponOverwrite = ["missiles_DAGR", "gatling_20mm", "gatling_20mm", "gatling_30mm_VTOL_02", "gatling_30mm", "Laserdesignator_mounted"];
LEON_WeaponNeedLock = ["missiles_SCALPEL", "missiles_ASRAAM"];
LEON_AllWeapon = LEON_WeaponOverwrite + LEON_WeaponNeedLock;

LEON_LOCK =
{
	params ["", "_key", "", "_ctrl"];
	_handled = false;
	_veh = vehicle player;
	_currentWeapon = currentWeapon _veh;
	if (_key in [20] && _ctrl) then
	{
		if ({_veh isKindOf _x} count ["Heli_Attack_01_base_F","Heli_Attack_02_base_F","VTOL_02_base_F"] > 0 && isManualFire _veh && _currentWeapon in LEON_AllWeapon) then
		{
			_cameraLock = getPilotCameraTarget _veh;
			switch (_cameraLock select 0) do
			{
				case false:
				{
					LEON_lockedPos = call LEON_GetCursorPos;
					_possibleTarget = nearestObjects [ASLtoAGL LEON_lockedPos, ["AllVehicles", "LandVehicle", "Building"], (tan 5 * (_veh distance LEON_lockedPos)), false] select { !(_x isKindOf "Land_InvisibleBarrier_F") && !(_x isKindOf "Logic") && !(_x isKindOf "Ruins_F") && !(_x isKindOf "PowerLines_Small_base_F") && !(_x isKindOf "PowerLines_Wires_base_F") };
					if (count _possibleTarget > 0) then
					{
						_possibleTarget = [_possibleTarget, [], { getNumber (configfile >> "CfgVehicles" >> (typeOf _x) >> "cost") }, "DESCEND"] call BIS_fnc_sortBy;
						LEON_lockedObject = _possibleTarget select 0;
						LEON_lockedObjectOffset = LEON_lockedObject worldToModel (ASLtoAGL LEON_lockedPos);
						LEON_lockedPos = LEON_lockedObject modelToWorld [0,0,0];
					} else
					{
						LEON_lockedObject = objNull;
					};
					LEON_isLocked = true;
					if !(_currentWeapon in LEON_WeaponNeedLock) then
					{
						_veh setPilotCameraTarget (if (isNull LEON_lockedObject) then { LEON_lockedPos } else { LEON_lockedObject });
						if (cameraView == "GUNNER") then
						{
							_handled = true;
						} else
						{
							_veh setPilotCameraDirection (_veh vectorWorldToModelVisual (getCameraViewDirection player));
						};
						_veh call LEON_VehicleChat;
					};
					
				};
				case true;
				default
				{
					LEON_isLocked = false;
					LEON_lockedObject = objNull;
					if !(_currentWeapon in LEON_WeaponNeedLock) then
					{
						if (cameraView != "GUNNER") then
						{
							_veh setPilotCameraTarget objNull;
							_handled = true;
						};
						_veh call LEON_VehicleChat;
					};
				};
			};
		};
	} else
	{
		if (_key in [20] && LEON_isLocked && cameraView != "GUNNER") then
		{
			if ({_veh isKindOf _x} count ["Heli_Attack_01_base_F","Heli_Attack_02_base_F","VTOL_02_base_F"] > 0 && isManualFire _veh && _currentWeapon in LEON_AllWeapon && !(_currentWeapon in LEON_WeaponNeedLock)) then
			{
				LEON_lockedPos = call LEON_GetCursorPos;
				_possibleTarget = nearestObjects [ASLtoAGL LEON_lockedPos, ["AllVehicles", "LandVehicle", "Building"], (tan 5 * (_veh distance LEON_lockedPos)), false] select { !(_x isKindOf "Land_InvisibleBarrier_F") && !(_x isKindOf "Logic") && !(_x isKindOf "Ruins_F") && !(_x isKindOf "PowerLines_Small_base_F") && !(_x isKindOf "PowerLines_Wires_base_F") };
				if (count _possibleTarget > 0) then
				{
					_possibleTarget = [_possibleTarget, [], { getNumber (configfile >> "CfgVehicles" >> (typeOf _x) >> "cost") }, "DESCEND"] call BIS_fnc_sortBy;
					LEON_lockedObject = _possibleTarget select 0;
					LEON_lockedObjectOffset = LEON_lockedObject worldToModel (ASLtoAGL LEON_lockedPos);
					LEON_lockedPos = LEON_lockedObject modelToWorld [0,0,0];
				} else
				{
					LEON_lockedObject = objNull;
				};
				_veh setPilotCameraTarget (if (isNull LEON_lockedObject) then { LEON_lockedPos } else { LEON_lockedObject });
				if (cameraView != "GUNNER") then {
					_veh setPilotCameraDirection (_veh vectorWorldToModelVisual (getCameraViewDirection player));
				};
				_veh call LEON_VehicleChat;
				_handled = true;
			};
		};
	};
	_handled
};

LEON_GetCursorPos =
{
	private ["_start", "_toVector", "_end", "_pos"];
	_start = AGLToASL (if (cameraView == "GUNNER") then { _veh modelToWorld (getPilotCameraPosition _veh) } else { positionCameraToWorld [0,0,0] });
	_toVector = if (cameraView == "GUNNER") then { _veh vectorModelToWorld (getPilotCameraDirection _veh) } else { getCameraViewDirection player };
	_end = _start vectorAdd (_toVector vectorMultiply (viewDistance * 0.75));
	_pos = lineIntersectsSurfaces [_start, _end, _veh, LEON_tmpTarget, true, 2];
	if (count _pos == 0) then
	{
		if (count _this == 1) then {
			_pos = _this select 0;
		} else
		{
			_pos = _end;
		};
	} else
	{
		_pos = _pos select 0 select 0;
	};
	_pos
};

LEON_VehicleChat =
{
	params ["_veh"];
	if (LEON_isLocked) then
	{
		if (isNull LEON_lockedObject) then
		{
			_veh vehicleChat (format ["Locked on GRID %1", mapGridPosition LEON_lockedPos]);
		} else
		{
			_veh vehicleChat (format ["Locked on %1", getText (configfile >> "CfgVehicles" >> typeOf LEON_lockedObject >> "displayName")]);
		};
	} else
	{
		_veh vehicleChat "Unlock";
	};
};

LEON_GetPos = 
{
	private ["_veh", "_pos", "_cameraLock"];
	_veh = vehicle player;
	_pos = [0,0,0];
	if (!LEON_isLocked) then
	{
		_pos = _this call LEON_GetCursorPos;
	} else
	{
		if (!isNull LEON_lockedObject && {alive LEON_lockedObject}) then
		{
			_pos = AGLtoASL (LEON_lockedObject modelToWorld LEON_lockedObjectOffset);
		} else
		{
			_pos = LEON_lockedPos;
		};
		if (cameraView == "GUNNER") then
		{
			_cameraLock = getPilotCameraTarget _veh;
			if ((_cameraLock select 0) && (_cameraLock select 1) distance _pos > 1 && (_cameraLock select 1) findIf {_x != 0} != -1) then
			{
				_pos = _cameraLock select 1;
				LEON_lockedPos = _pos;
			};
			LEON_lockedObject = _cameraLock select 2;
			LEON_lockedObjectOffset = [0,0,0];
		};
	};
	_pos
};

waitUntil {!isNull findDisplay 46};
findDisplay 46 displayAddEventHandler ["KeyDown", "_this call LEON_LOCK;"];