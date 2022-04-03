if (!hasInterface) exitWith {};

LEON_GT_isAttached = {
	private ["_attachedGrenades"];
	_attachedGrenades = call LEON_GT_getAttached;
	if (count _attachedGrenades > 0) then
	{
		true
	} else
	{
		false
	};
};

LEON_GT_getAttached = {
	private ["_attachedGrenades"];
	_attachedGrenades = (attachedObjects player) select {
		!isNull _x && {(typeOf _x) isKindOf ["Grenade", configfile >> "CfgAmmo"]}
	};
	_attachedGrenades
};

LEON_GT_pickUp = {
	private ["_grenades", "_pickUpGrenade"];
	systemChat "pick up";
	_grenades = player nearObjects ["Grenade", 4.5];
	if (count _grenades > 0) then
	{
		_pickUpGrenade = _grenades select 0;
		_pickUpGrenade attachTo [player, [0, 0, 0.1], "RightHand"];
	};
};

LEON_GT_throw = {
	private ["_attachedGrenades", "_grenade", "_up", "_dir", "_velocity", "_handOffset", "_handPos"];
	systemChat "throw";
	_attachedGrenades = call LEON_GT_getAttached;
	_grenade = _attachedGrenades select 0;
	_up = getCameraViewDirection player;
	_dir = direction player;
	_velocity = velocity player;
	_handOffset = player selectionPosition ["RightHand", "Memory"];
	_handPos = player modelToWorld (_handOffset vectorAdd [0,0,0.5]);
	player playActionnow "ThrowGrenade";
	sleep 0.5;
	detach _grenade;
	_grenade setVectorUp _up;
	_grenade setDir _dir;
	_grenade setVelocity [(_velocity select 0) + (sin _dir * 16.5), (_velocity select 0) + (cos _dir * 16.5), (25.6623 * (_up select 2)) + 4.01847];
};

waitUntil {!isNull findDisplay 46};
(findDisplay 46) displayAddEventHandler ["KeyDown",
{
	if ((_this select 1) == 21) then
	{
		if (call LEON_GT_isAttached) then
		{
			[] spawn LEON_GT_throw;
		} else
		{
			call LEON_GT_pickUp;
		};
	};
}];