// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: serverPlayerDied.sqf
//	@file Author: [404] Pulse, AgentRev
//	@file Created: 20/11/2012 05:19

if (!isServer) exitWith {};

params [["_unit",objNull,[objNull]], "", "", ["_deathCause",[],[[]]]]; // _unit, _killer, _presumedKiller, _deathCause

_unit call A3W_fnc_setItemCleanup;
_unit setVariable ["A3W_deathCause_local", _deathCause];

private _killer = (_this select [0,3]) call A3W_fnc_registerKillScore;

// Remove player save on death
if (isPlayer _unit && {["A3W_playerSaving"] call isConfigOn}) then
{
	_remarks = format["%2 - %1", name _killer, side _killer];
	if (side _killer == UNKNOWN) then
	{
		_remarks = "";
	} else
	{
		if (isPlayer _killer) then
		{
			_remarks = format["%3 - %2[%1]", getPlayerUID _killer, name _killer, side _killer];
		};
	};
	[getPlayerUID _unit, name _unit, side _unit, "Player Killed", netId _killer, 1, position _unit, _deathCause, _remarks] call fn_logPlayerAction;
	(getPlayerUID _unit) call fn_deletePlayerSave;
};

private _backpack = unitBackpack _unit;
private _uav = getConnectedUAV _unit;
if(!isnull _uav) then
{
	_unit connectTerminalToUAV objNull;
};
if (!isNull _backpack) then
{
	_backpack call A3W_fnc_setItemCleanup;
};

// Eject corpse from vehicle once stopped
if (vehicle _unit != _unit) then
{
	if (local _unit) then
	{
		_unit spawn fn_ejectCorpse;
	}
	else
	{
		_unit remoteExec ["fn_ejectCorpse", _unit];
	};
};