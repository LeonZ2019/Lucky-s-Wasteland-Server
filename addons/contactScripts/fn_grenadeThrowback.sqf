if (!hasInterface) exitWith {};

LEON_PICKED_GRENADE = objNull;
LEON_PICKABLE_GRENADE = [];

LEON_GT_pickUp = {
	if (count LEON_PICKABLE_GRENADE > 0) then
	{
		LEON_PICKED_GRENADE = LEON_PICKABLE_GRENADE select 0;
		LEON_PICKED_GRENADE attachTo [player, [-0.06,-0.04,0.045], "righthand", true];
	};
};

LEON_GT_throw = {
	private ["_attachedGrenades", "_up", "_dir", "_velocity", "_handOffset", "_handPos"];
	_up = getCameraViewDirection player;
	_dir = direction player;
	_velocity = velocity player;
	_handOffset = player selectionPosition ["RightHand", "Memory"];
	_handPos = player modelToWorld (_handOffset vectorAdd [0,0,0.5]);
	if (!isNull LEON_PICKED_GRENADE) then {
		player playActionnow "ThrowGrenade";
		sleep 0.5;
		detach LEON_PICKED_GRENADE;
		LEON_PICKED_GRENADE setVectorUp _up;
		LEON_PICKED_GRENADE setDir _dir;
		LEON_PICKED_GRENADE setVelocity [(_velocity select 0) + (sin _dir * 16.5), (_velocity select 0) + (cos _dir * 16.5), (25.6623 * (_up select 2)) + 4.01847];
		LEON_PICKED_GRENADE = objNull;
	};
};

(findDisplay 46) displayAddEventHandler ["KeyDown",
{
	_handler = false;
	if ((_this select 1) in actionKeys "throw") then
	{
		// only when not setUnconscious
		if ((player getVariable ["FAR_isUnconscious", 0] == 0)) then
		{
			if (!isNull LEON_PICKED_GRENADE) then
			{
				[] spawn LEON_GT_throw;
				_handler = true;
			} else
			{
				if ((_this select 2) == true) then
				{
					call LEON_GT_pickUp;
					_handler = true;
				};
			};
		};
	};
	_handler
}];

LEON_PICKABLE_GRENADE = [];
while {true} do
{
	waitUntil {sleep 0.1; vehicle player == player && (nearestObjects [player, ["GrenadeHand", "IRStrobeBase"], 3]) findIf {isNull (attachedTo _x) && vectorMagnitude velocity _x <= 10} != -1};
	if (player getVariable ["FAR_isUnconscious", 0] == 0) then
	{
		_grenade = nearestObjects [player, ["GrenadeHand", "IRStrobeBase"], 3];
		_grenade = _grenade select { isNull (attachedTo _x) && vectorMagnitude velocity _x <= 5 && !lineIntersects [eyePos player, getPosASLVisual _x vectorAdd [0,0,(sizeOf (typeOf _x)) / 2], player, _x] };
		if (count _grenade > 0) then
		{
			LEON_PICKABLE_GRENADE = _grenade;
			[] execVM "addons\contactScripts\fn_grenadeCOD.sqf";
		};
	};
};