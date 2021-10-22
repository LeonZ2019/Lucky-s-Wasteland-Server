// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Name: toggleGodMode.sqf

if (isDedicated) exitWith {};

if ((getPlayerUID player) call isAdmin) then
{
	_curPlayerInvulnState = player getVariable ["isAdminInvulnerable", false];

	if (!_curPlayerInvulnState) then
	{
		thirstLevel = 100;
		hungerLevel = 100;
		player setDamage 0;
		player allowDamage false;
		player setVariable ["isAdminInvulnerable", true, true];

		if (player getVariable ["FAR_isUnconscious", 0] == 1) then
		{
			player setVariable ["FAR_isUnconscious", 0, true];
		};

		(findDisplay 27910) closeDisplay 0; // ReviveBlankGUI_IDD
		//(findDisplay 27911) closeDisplay 0; // ReviveGUI_IDD
		hint "You are now invulnerable";
		_curPlayerInvulnState = true;
		while ({_curPlayerInvulnState}) do
		{
			if (getOxygenRemaining player < 0.80) then
			{
				player setOxygenRemaining 1;
			};
			if (thirstLevel < 80) then
			{
				thirstLevel = 100;
			};
			if (hungerLevel < 80) then
			{
				hungerLevel = 100;
			};
			if (getDammage player > 0.20) then
			{
				player setDamage 0;
			};
			uiSleep 30;
			_curPlayerInvulnState = player getVariable ["isAdminInvulnerable", false];
		};
	}
	else
	{
		player allowDamage true;
		player setVariable ["isAdminInvulnerable", false, true];
		hint "You are no longer invulnerable";
	};
};
