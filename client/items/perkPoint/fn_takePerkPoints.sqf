params [["_player",objNull,[objNull]], ["_obj",objNull,[objNull]], ["_granted",false,[false]], ["_perkPts",0,[0]]];

if (!alive _player || !isRemoteExecuted) exitWith {};

if (_granted) then // client post-process
{
	systemChat format ["%1 : %2", _perkPts, "Got"];
	["perkPoint", _perkPts] call mf_inventory_add;
	[format["You have picked up %1 perk points.\n You can use it from the Workbench.", _perkPts], 5] call a3w_actions_notify;
}
else // server process
{
	if (!isServer || !alive _obj || remoteExecutedOwner != owner _player) exitWith {};

	private _leftPerkPts = _obj getVariable ["perkPoints", 0];
	if (_obj getVariable ["mf_item_id",""] == "perkPoint") then // dropped item
	{
		systemChat format ["Left %1 and take %2", _leftPerkPts, _perkPts];
		if (_leftPerkPts < _perkPts) then
		{
			_perkPts = _leftPerkPts;
			deleteVehicle _obj;
		} else
		{
			_obj setVariable ["perkPoints", _leftPerkPts - _perkPts, true];
		};
		_granted = true;
	}
	else
	{
		if (_leftPerkPts < 1) exitWith {};
		if (_leftPerkPts < _perkPts) then
		{
			_perkPts = _leftPerkPts;
		};
		_obj setVariable ["perkPoints", _leftPerkPts - _perkPts, true];

		if (_obj isKindOf "AllVehicles" && !(_obj isKindOf "StaticWeapon")) then
		{
			if (!isNil "fn_manualVehicleSave") then { _obj call fn_manualVehicleSave };
		}
		else
		{
			if (!isNil "fn_manualObjectSave") then { _obj call fn_manualObjectSave };
		};

		_granted = true;
	};

	if (_granted) then
	{
		systemChat format ["%1 : %2", _perkPts, "Granted"];
		[_player, _obj, _granted, _perkPts] remoteExecCall ["A3W_fnc_takePerkPoints", _player];
	};
};
