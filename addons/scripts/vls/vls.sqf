params ["_vls"];
[
	_vls,
	"Reload Cruise Missile Cluster",
	"addons\scripts\vls\reload.paa",
	"addons\scripts\vls\reload.paa",
	"alive _target && _this in (crew _target) && _target currentMagazineTurret [0] == 'magazine_Missiles_Cruise_01_x18' && _target getVariable ['VLS_CLUSTER', 18] > 0",
	"alive _target && _this in (crew _target) && _target currentMagazineTurret [0] == 'magazine_Missiles_Cruise_01_x18' && _target getVariable ['VLS_CLUSTER', 18] > 0",
	{ hint "Reloading..." },
	{},
	{
		params ["_target"];
        _target setVariable ["VLS_HE", weaponState [_target, [0]] select 4, true];
        _round = _target getVariable ["VLS_CLUSTER", 18];
		_target removeWeaponTurret ["weapon_VLS_01", [0]];
        _target removeMagazineTurret ["magazine_Missiles_Cruise_01_x18", [0]];
        _target addMagazineTurret ["magazine_Missiles_Cruise_01_Cluster_x18", [0], _round];
		_target addWeaponTurret ["weapon_VLS_01", [0]];
    },
	{},
	[],
	5,
	0,
	false,
	false
] call BIS_fnc_holdActionAdd;
[
	_vls,
	"Reload Cruise Missile HE",
	"addons\scripts\vls\reload.paa",
	"addons\scripts\vls\reload.paa",
	"alive _target && _this in (crew _target) && _target currentMagazineTurret [0] == 'magazine_Missiles_Cruise_01_Cluster_x18' && _target getVariable ['VLS_HE', 18] > 0",
	"alive _target && _this in (crew _target) && _target currentMagazineTurret [0] == 'magazine_Missiles_Cruise_01_Cluster_x18' && _target getVariable ['VLS_HE', 18] > 0",
	{ hint "Reloading..." },
	{},
	{
		params ["_target"];
        _target setVariable ["VLS_CLUSTER", weaponState [_target, [0]] select 4, true];
        _round = _target getVariable ["VLS_HE", 18];
		_target removeWeaponTurret ["weapon_VLS_01", [0]];
        _target removeMagazineTurret ["magazine_Missiles_Cruise_01_Cluster_x18", [0]];
        _target addMagazineTurret ["magazine_Missiles_Cruise_01_x18", [0], _round];
		_target addWeaponTurret ["weapon_VLS_01", [0]];
    },
	{},
	[],
	5,
	0,
	false,
	false
] call BIS_fnc_holdActionAdd;

/*
// remove
_vls removeMagazinesTurret ["magazine_Missiles_Cruise_01_Cluster_x18", [0]];
_vls removeMagazinesTurret ["magazine_Missiles_Cruise_01_x18", [0]];
*/