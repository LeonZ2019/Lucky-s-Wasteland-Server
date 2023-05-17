//Client Function for Airdrop Assistance (not really a function, as it is called via ExecVM from command menu)
//This takes values from command menu, and some passed variables, and interacts with client and sends commands to server
//Author: Apoc
//Credits: Some methods taken from Cre4mpie's airdrop scripts, props for the idea!
//Starts off much the same as the client start.  This is to find information from config arrays

private ["_type","_selection","_player","_heliDirection"];
_type = _this select 0;
_selectionNumber = _this select 1;
_player = _this select 2;
_heliDirection = _this select 3;

diag_log format ["SERVER - Apoc's Airdrop Assistance - Player: %1, Drop Type: %2, Selection #: %3",name _player,_type,_selectionNumber];
_selectionArray = [];

switch (_type) do {
	case "vehicle": { _selectionArray = APOC_AA_VehOptions };
	case "supply";
	case "picnic";
	case "base";
	case "base1";
	case "base2": { _selectionArray = APOC_AA_SupOptions };
	default { _selectionArray = APOC_AA_VehOptions; diag_log "AAA - Default Array Selected - Something broke"; };
};
_option = _selectionArray select _selectionNumber;
_option params ["_selectionName", "_selectionClass", "_price", ["_variant", "", [""]]];

/////// Let's spawn us an AI helo to carry the cargo /////////////////////////////////////////////////

_heliType = "B_Heli_Transport_03_unarmed_F";
_center = createCenter civilian;
_grp = createGroup civilian;

_flyHeight = 150;
_dropSpot = _player getRelPos [30, abs (360 - _heliDirection)];
_dropSpot set [2, _flyHeight];

_flyHeight = 100;  //Distance from ground that heli will fly at
_heliStartDistance = 2000;
_spos = [(_dropSpot select 0) - (sin _heliDirection) * _heliStartDistance, (_dropSpot select 1) - (cos _heliDirection) * _heliStartDistance, (_flyHeight + 200)];

_heli = createVehicle [_heliType, _spos, [], 0, "FLY"];
_heli allowDamage false;
_heli setVariable ["R3F_LOG_disabled", true, true];
[_heli] call vehicleSetup;

_crew = [_grp, _spos] call createRandomPilot;
_crew moveInDriver _heli;
_crew allowDamage false;
_heli setCaptive true;
_heliDistance = 2000;

_dir = ((_dropSpot select 0) - (_spos select 0)) atan2 ((_dropSpot select 1) - (_spos select 1));
_flySpot = [(_dropSpot select 0) + (sin _dir) * _heliDistance, (_dropSpot select 1) + (cos _dir) * _heliDistance, _flyHeight];

_grp setCombatMode "BLUE";
_grp setBehaviour "CARELESS";
{_x disableAI "AUTOTARGET"; _x disableAI "TARGET"} forEach units _grp;

_wp0 = _grp addWaypoint [_dropSpot, 0, 1];
[_grp,1] setWaypointBehaviour "CARELESS";
[_grp,1] setWaypointCombatMode "BLUE";
[_grp,1] setWaypointCompletionRadius 20;
_wp1 = _grp addWaypoint [_flySpot, 0, 2];
[_grp,2] setWaypointBehaviour "CARELESS";
[_grp,2] setWaypointCombatMode "BLUE";
[_grp,2] setWaypointCompletionRadius 20;
_heli flyInHeight _flyHeight;

//////// Create Purchased Object //////////////////////////////////////////////
_object = switch (_type) do {
	case "vehicle":
	{
		_objectSpawnPos = _spos vectorAdd [0, 0, 300];
		_object = createVehicle [_selectionClass, _objectSpawnPos, [], 0, "None"];
		if (isNil "_variant") then
		{
			_object setVariable ["A3W_vehicleVariant", _variant, true];
		};
		_object setVariable ["A3W_purchasedStoreObject", true];
		_object setVariable ["A3W_purchasedVehicle", true, true];
		_object setVariable ["ownerUID", getPlayerUID _player, true];
		_object setVariable ["R3F_LOG_Disabled", true, true];
		_object lock 2;
		[_object] call vehicleSetup;
		if (_object getVariable ["A3W_purchasedVehicle", false] && !isNil "fn_manualVehicleSave") then
		{
			_object call fn_manualVehicleSave;
		};
		_object attachTo [_heli, [0,0,-5]];
		_object
	};
	case "supply":
	{
		_objectSpawnPos = [(_spos select 0), (_spos select 1), (_spos select 2) + 300];
		_object = createVehicle ["B_supplyCrate_F", _objectSpawnPos, [], 0, "None"];
		_object setVariable ["A3W_purchasedStoreObject", true];
		_object setVariable ["R3F_LOG_Disabled", false, true];
		[_object, _selectionClass] call fn_refillbox;
		_object setVariable ["A3W_inventoryLockR3F", false, true];
		_object attachTo [_heli, [0,0,-5]];
		_object
	};
	case "picnic":
	{
		_objectSpawnPos = [(_spos select 0), (_spos select 1), (_spos select 2) + 300];
		_object = createVehicle ["B_supplyCrate_F", _objectSpawnPos, [], 0, "None"];
		_object setVariable ["A3W_purchasedStoreObject", true];
		_object setVariable ["R3F_LOG_Disabled", false, true];
		_object attachTo [_heli, [0,0,-5]];
		_object
	};
	case "base":
	{
		_objectSpawnPos = [(_spos select 0), (_spos select 1), (_spos select 2) + 300];
		_object = createVehicle ["Land_CargoBox_V1_F", _objectSpawnPos, [], 0, "None"];
		_object AllowDamage false;
		_object setVariable ["A3W_purchasedStoreObject", true];
		_object setVariable ["R3F_LOG_Disabled", false, true];
		_object attachTo [_heli, [0,0,-5]];
		clearBackpackCargoGlobal _object;
		clearMagazineCargoGlobal _object;
		clearWeaponCargoGlobal _object;
		clearItemCargoGlobal _object;
		[_object, [["Land_Canal_Wall_Stairs_F", 2],["Land_BarGate_F", 2],["Land_Cargo_Patrol_V1_F", 2],["Land_HBarrier_3_F", 4],["Land_Canal_WallSmall_10m_F", 6],["Land_LampShabby_F", 10], ["Land_RampConcrete_F",1],["Land_Crash_barrier_F",4],["B_HMG_01_high_F",1]] ] execVM "addons\R3F_LOG\auto_load_in_vehicle.sqf";
		_object
	};
	case "base1":
	{
		_objectSpawnPos = [(_spos select 0), (_spos select 1), (_spos select 2) + 300];
		_object = createVehicle ["Land_Cargo20_yellow_F", _objectSpawnPos, [], 0, "None"];
		_object AllowDamage false;
		_object setVariable ["A3W_purchasedStoreObject", true];
		_object setVariable ["R3F_LOG_Disabled", false, true];
		_object attachTo [_heli, [0,0,-5]];
		clearBackpackCargoGlobal _object;
		clearMagazineCargoGlobal _object;
		clearWeaponCargoGlobal _object;
		clearItemCargoGlobal _object;
		[_object, ["Land_Cargo_Tower_V1_F", ["Land_Canal_Wall_Stairs_F", 4],["Land_BarGate_F", 2],["Land_Cargo_Patrol_V1_F", 2],["Land_HBarrierWall6_F", 4],["Land_Canal_WallSmall_10m_F", 10],["Land_LampShabby_F", 10], ["Land_RampConcreteHigh_F",2], ["Land_RampConcrete_F", 2],["Land_Crash_barrier_F",6],["B_HMG_01_high_F",2]] ] execVM "addons\R3F_LOG\auto_load_in_vehicle.sqf";
		_object
	};
		case "base2":
	{
		_objectSpawnPos = [(_spos select 0), (_spos select 1), (_spos select 2) + 300];
		_object = createVehicle ["Land_Cargo40_white_F", _objectSpawnPos, [], 0, "None"];
		_object AllowDamage false;
		_object setVariable ["A3W_purchasedStoreObject", true];
		_object setVariable ["R3F_LOG_Disabled", false, true];
		_object attachTo [_heli, [0,0,-5]];
		clearBackpackCargoGlobal _object;
		clearMagazineCargoGlobal _object;
		clearWeaponCargoGlobal _object;
		clearItemCargoGlobal _object;
		[_object, ["Land_Cargo_Tower_V1_F", ["Land_Canal_Wall_Stairs_F", 4],["Land_BarGate_F", 2],["Land_Cargo_Patrol_V1_F", 2],["Land_HBarrierWall6_F", 4],["Land_Canal_WallSmall_10m_F", 10],["Land_LampShabby_F", 10], ["Land_RampConcreteHigh_F",2], ["Land_RampConcrete_F", 2],["Land_Crash_barrier_F",6],["B_HMG_01_high_F",2]] ] execVM "addons\R3F_LOG\auto_load_in_vehicle.sqf";
		_object
	};
	default {
		_objectSpawnPos = [(_spos select 0), (_spos select 1), (_spos select 2) - 5];
		_object = createVehicle ["B_supplyCrate_F", _objectSpawnPos, [], 0, "None"];
		_object setVariable ["A3W_purchasedStoreObject", true];
		_object setVariable ["R3F_LOG_Disabled", false, true];
		[_object, "mission_USSpecial"] call fn_refillbox;
		_object setVariable ["A3W_inventoryLockR3F", false, true];
		_object attachTo [_heli, [0,0,-5]];
		_object
		};
};
_object allowDamage false;

While {true} do {
	sleep 0.1;
	if (currentWaypoint _grp >= 2) exitWith {};
};

// Let's handle the money after this tricky spot - This way players won't be charged for non-delivered goods!
_playerMoney = _player getVariable ["bmoney", 0];
if (_price > _playerMoney) exitWith
{
	{ _x setDamage 1; } forEach units _grp;
	_heli setDamage 1;
	_object setDamage 1;
};

//Server Style Money handling
["atm", _player, -_price] call A3W_fnc_processTransaction;
_cmoney = _player getVariable ["cmoney", 0];
_player setVariable ["cmoney", _cmoney - _price, true];

playSound3D ["a3\sounds_f\air\sfx\SL_rope_break.wss", _heli, false, getPosASL _heli , 3, 1, 500];
detach _object;
_heli fire "CMFlareLauncher";
_heli fire "CMFlareLauncher";

sleep 0.7;
playSound3D ["a3\sounds_f\sfx\radio\ambient_radio22.wss", _player ,false ,getPosASL _player ,3 ,1 ,25];

//Delete heli once it has proceeded to end point
[_heli, _grp, _flySpot, _dropSpot, _heliDistance] spawn {
	params ["_heli", "_grp", "_flySpot", "_dropSpot", "_heliDistance"];
	while{ [_heli, _flySpot] call BIS_fnc_distance2D > 200 } do
	{
		if(!alive _heli || !canMove _heli) exitWith {};
		uiSleep 5;
	};
	waitUntil{ [_heli, _dropSpot] call BIS_fnc_distance2D > (_heliDistance * .5) };
	{ deleteVehicle _x } forEach units _grp;
	deleteVehicle _heli;
};

//Time based deletion of the heli, in case it gets distracted
[_heli, _grp] spawn {
	params ["_heli","_grp"];
	uiSleep 30;
	if (alive _heli) then
	{
		{ deleteVehicle _x } forEach units _grp;
		deleteVehicle _heli;
	};
};

pvar_parachuteLiftedVehicle = netId _object;
publicVariableServer "pvar_parachuteLiftedVehicle";
waitUntil {isNull attachedTo _object};
if (_type == "picnic") then
{
	_objectLandPos = position _object;
	deleteVehicle _object;
	_object2 = switch (_selectionClass) do
	{
		case "Land_Sacks_goods_F":
		{
			_object2 = createVehicle [_selectionClass, _objectLandPos, [], 0, "None"];
			_object2 setVariable ["food", 50, true];
			_object2 setVariable ["R3F_LOG_Disabled", false, true];
			_object2 setVariable ["allowDamage", true, true];
			_object2 allowDamage true;
		};
		case "Land_BarrelWater_F":
		{
			_object2 = createVehicle [_selectionClass, _objectLandPos, [], 0, "None"];
			_object2 setVariable ["water",50, true];
			_object2 setVariable ["R3F_LOG_Disabled", false, true];
			_object2 setVariable ["allowDamage", true, true];
			_object2 allowDamage true;
		};
	};
};
if (_type == "vehicle") then { _object allowDamage true };
_heli fire "CMFlareLauncher";
