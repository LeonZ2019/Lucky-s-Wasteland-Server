// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Name: vehicleInvincible.sqf

if (isDedicated) exitWith {};

if ((getPlayerUID player) call isAdmin) then
{
	_veh = vehicle player;
	if (_veh != player) then
	{
		if !(player getVariable ["isAdminsVehicleInvincible", false]) then {
			[_veh, false] remoteExec ["allowDamage", -2];
			[_veh, 0] remoteExec ["setDamage", -2];
			player setVariable ["isAdminsVehicleInvincible", true, true];
			hint "Your vehicle are invincible now";
			vehicleId = _veh addEventHandler ["GetOut", { // get the admin only, not everyone
				if ((_this select 2) == player) then
				{
					[_this select 0, true] remoteExec ["allowDamage", -2];
					player setVariable ["isAdminsVehicleInvincible", false, true];
					hint "You have get out from vehicle, it is no longer invincible";
				};
			}];
		} else
		{
			[_this select 0, true] remoteExec ["allowDamage", -2];
			player setVariable ["isAdminsVehicleInvincible", false, true];
			_veh removeEventHandler ["GetOut", vehicleId];
			hint "Your vehicle are no longer invincible";
		};
	} else
	{
		hint "please get in to vehicle to enable this";
	};
};
