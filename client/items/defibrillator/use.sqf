//	@file Name: use.sqf
//	@file Author: Leon

if (!alive player) exitWith {};
if (!(player call A3W_fnc_isUnconscious)) exitWith {};

if (["Are you sure you want to use defibrillator?", "Confirm", true, true] call BIS_fnc_guiMessage) then
{
	player setVariable ["FAR_isUnconscious", 0, true];
	["You bring back yourself from dead", 5] call mf_notify_client;
    ["defibrillator", 1] call mf_inventory_remove;
	player setDamage 0.5;
};
