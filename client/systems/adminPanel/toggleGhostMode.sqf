if (isDedicated) exitWith {};

if ((getPlayerUID player) call isAdmin) then
{
	_ghostMode = player getVariable ["isAdminGhost", false];

	if (!_ghostMode) then
	{
        player setCaptive true;
        player hideObject true;
        player hideObjectGlobal true;
		player setVariable ["isAdminGhost", true, true];
		hint "You are ghost now";
	}
	else
	{
        player setCaptive false;
        player hideObject false;
        player hideObjectGlobal false;
		player setVariable ["isAdminGhost", false, true];
		hint "You are no longer ghost";
	};
};
