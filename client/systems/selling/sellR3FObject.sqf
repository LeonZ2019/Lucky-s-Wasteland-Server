
#include "sellIncludesStart.sqf";

storeSellingHandle = _this spawn
{
	_object = missionNamespace getVariable ["R3F_LOG_joueur_deplace_objet", objNull];

	_class = typeOf _object;
	_objName = getText (configFile >> "CfgVehicles" >> _class >> "displayName");

	_price = ceil ((call allGenStoreVanillaItems select { _x select 1 == _class } select 0 select 2) * 0.75);

	if (!isNil "_price") then
	{
		_confirmMsg = format ["Selling object %1 will give you $%2<br/>", _objName, [_price] call fn_numbersText];
		if ([parseText _confirmMsg, "Confirm", "Sell", true] call BIS_fnc_guiMessage) then
		{
			// remove the object
			[_object, player, -1, false] execVM "addons\R3F_ARTY_AND_LOG\R3F_LOG\objet_deplacable\relacher.sqf";
			deleteVehicle _object;
			[player, _price] call A3W_fnc_setCMoney;
			[format ['The object %1 has been sold!', _objname], "Thank You"] call BIS_fnc_guiMessage;

			if (["A3W_playerSaving"] call isConfigOn) then
			{
				[] spawn fn_savePlayerData;
			};
		};
	};
};

#include "sellIncludesEnd.sqf";
