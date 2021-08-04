IsHostageRescued = false;
HostageAction = -1;
if (isDedicated) exitWith {};

"HostageEHAdd" addPublicVariableEventHandler {
	_hostage = _this select 1 select 0;
	_enemy = _this select 1 select 1;
	if (IsHostageRescued) exitWith {};
	if(HostageAction == -1) then {
		HostageAction = _hostage addAction ["Untie Hostage", {call Hostage_Release}, [_enemy], 10, true, false, "", "alive _this", 5];
	};
};

"HostageEHRemove" addPublicVariableEventHandler
{
	private ["_hostage"];
	_hostage = _this select 1;
	if (HostageAction != -1) then {
		_hostage removeAction HostageAction;
		HostageAction = -1;
	};
	IsHostageRescued = false;
};

Hostage_Release =
{
	private ["_hostage", "_rescuer", "_enemy", "_enemyAlive"];
	_hostage = _this select 0;
	_rescuer = _this select 1;
	_enemy = _this select 3 select 0;
	_enemyAlive = {alive _x} count units _enemy;
	if (_enemyAlive > 0) then
	{
		_rescuer groupChat format["Still have %1 enemy alive.", _enemyAlive];
	} else
	{
		IsHostageRescued = true;
		[_hostage, "Acts_ExecutionVictim_Unbow"] call switchMoveGlobal;
	};
};


hostageSetupDone = true;