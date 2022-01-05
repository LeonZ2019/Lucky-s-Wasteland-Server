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
		if (alive _veh) then
		{
			if !(player getVariable ["isAdminsVehicleInvincible", false]) then {
				_veh setDamage 0;
				_veh allowDamage false;
				player setVariable ["isAdminsVehicleInvincible", true, true];
				hint "Your vehicle are invincible now";
				vehicleId = _veh addEventHandler ["GetOut", { // get the admin only, not everyone
					if ((_this select 2) == player) then
					{
						(_this select 0) allowDamage true;
						player setVariable ["isAdminsVehicleInvincible", false, true];
						hint "You have get out from vehicle, it is no longer invincible";
					};
				}];
			} else
			{
				_veh allowDamage true;
				player setVariable ["isAdminsVehicleInvincible", false, true];
				_veh removeEventHandler ["GetOut", vehicleId];
				hint "Your vehicle are no longer invincible";
			};
		} else
		{
			hint "Your vehicle are destroyed";
		};
	} else
	{
		hint "please get in to vehicle to enable this";
	};
};
