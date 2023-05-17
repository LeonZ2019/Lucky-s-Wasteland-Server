params ["_veh", "_bob"];

LEON_tmpTarget = createVehicle ["Land_InvisibleBarrier_F", screenToWorld [0.5, 0.5]];
LEON_tmpTarget hideObjectGlobal true; // incase it block something
LEON_tmpTarget enableSimulationGlobal false; // block all shit stuff

while {(isManualFire _veh) && (alive _veh)} do
{
	if (!isNull LEON_lockedObject && !isNull (getPilotCameraTarget _veh select 2) && LEON_lockedObject == (getPilotCameraTarget _veh select 2)) then
	{
		if !((currentWeapon _veh) in LEON_WeaponNeedLock) then
		{
			_veh lockCameraTo [LEON_lockedObject, [0], false];
			gunner _veh doTarget LEON_lockedObject;
		};
	} else
	{
		_pos = call LEON_GetPos;
		if (currentWeapon _veh in ["gatling_30mm_VTOL_02", "gatling_30mm", "gatling_20mm"]) then
		{
			_distance = _veh distance _pos;
			_magazine = currentMagazine _veh;
			if (_magazine != "") then
			{
				_speed = getNumber (configfile >> "CfgMagazines" >> _magazine >> "initSpeed");
				_velocity = velocity LEON_lockedObject; // m/s
				_timeNeed = _distance / _speed; // time in seconds
				_final = _velocity vectorMultiply _timeNeed;
				_pos = _pos vectorAdd _final;
			};
		};
    	LEON_tmpTarget setPosASL _pos;
		if !((currentWeapon _veh) in LEON_WeaponNeedLock) then
		{
			_veh lockCameraTo [LEON_tmpTarget, [0], false];
			gunner _veh doTarget LEON_tmpTarget;
		};
	};
	//_modelPos = [0,0,0] vectorDiff (LEON_tmpTarget worldToModelVisual (ASLtoAGL _pos));
	//_pos = AGLtoASL (LEON_tmpTarget modelToWorldVisual _modelPos);
	// LEON_tmpTarget setPosASL _pos;

    uiSleep 0.067;
};
// _veh lockCameraTo [objNull, [0]];
if (cameraView != "GUNNER") then
{
	_veh setPilotCameraDirection [0,1,0];
};
_veh setPilotCameraTarget objNull;

deleteVehicle LEON_tmpTarget;
deleteVehicle _bob;

LEON_tmpTarget = objNull;
LEON_lockedObject = objNull;
LEON_isLocked = false;
LEON_lockedPos = [0,0,0];

/*

"missiles_DAGR" // follow cursor
"missiles_SCALPEL" // need radar lock
"missiles_DAR" // direct fire
"gatling_20mm" // follow cursor
"Laserdesignator_mounted" // follow cursor
"missiles_ASRAAM" // need radar lock

"gatling_30mm_VTOL_02" // follow cursor
"rockets_Skyfire" // direct fire

"gatling_30mm" // follow curosr

*/