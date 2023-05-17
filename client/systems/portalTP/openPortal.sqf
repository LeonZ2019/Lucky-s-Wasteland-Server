private ["_portalNum", "_portals", "_town", "_playerMoney", "_price", "_towns", "_isCurrentSafe", "_territories", "_territoryText", "_territoryMarker", "_enemyPlayers", "_isSameSide", "_side"];

_portalNum = _this select 3 select 0;
_portals = call compile preprocessFileLineNumbers "mapConfig\portals.sqf";
_town = "";
{
	if (_x select 0 == _portalNum) exitWith
	{
		_town = _x select 1;
	};
} forEach _portals;
_playerMoney = player getVariable ["cmoney", 0];
_price = ["A3W_portalAmount", 1000] call getPublicVar;
if (_price > _playerMoney) exitWith
{
	hint format["You need $%1 money for using teleport", _price];
	playSound "FD_CP_Not_Clear_F";
	_price = -1;
};
_towns = call compile preprocessFileLineNumbers "mapConfig\towns.sqf";
{
	if (_x select 2 == _town) exitWith
	{
		_town = _x;
	};
} forEach _towns;
_isCurrentSafe = true;
{
	if (alive _x && {_x isKindOf "CAManBase" && {!(_x call A3W_fnc_isUnconscious)}}) then
	{
		if (!([_x, player] call A3W_fnc_isFriendly) && isPlayer _x && (position _x) inArea [markerPos (_town select 0), _town select 1, _town select 1, 0, false]) exitWith
		{
			_isCurrentSafe = false;
		};
	};
} forEach allUnits;
if (!_isCurrentSafe) exitWith
{
	hint "Enemy nearby town, portal has been closed!";
};
["A3W_Portal", "onMapSingleClick",
{
	_territories = call compile preprocessFileLineNumbers "mapConfig\territories.sqf";
	{
		if (_pos inArea (_x select 0)) exitWith
		{
			_territoryText = _x select 1;
			_territoryMarker = _x select 0;
			_enemyPlayers = 0;
			_isSameSide = false;
			_side = str (missionNamespace getVariable [format['%1_team',_x select 0], sideUnknown]);
			{
				if (isPlayer _x && alive _x && _x isKindOf "CAManBase" && !(_x call A3W_fnc_isUnconscious) && (position _x) inArea _territoryMarker) then
				{
					if (_side == "WEST" || _side == "EAST") then
					{
						if (str (side _x) != _side) then
						{
							_enemyPlayers = _enemyPlayers + 1;
						};
					} else
					{
						if (str (group _x) != _side) then
						{
							_enemyPlayers = _enemyPlayers + 1;
						};
					};
				};
			} forEach allUnits;
			if (str playerSide == "GUER") then
			{
				if (str (group player) == _side) then
				{
					_isSameSide = true;
				};
			} else
			{
				if (str playerSide == _side) then
				{
					_isSameSide = true;
				};
			};
			cutText [format["Teleporting from %1 to %2...", _this select 4 select 2 ,_territoryText], "BLACK", -0.25];
			if (_enemyPlayers == 0 && _isSameSide) then
			{
				private _price = _this select 5;
				[_pos, _price] spawn {
					params ["_pos", "_price"];
					private ["_top", "_buildings"];
					[player, -_price] call A3W_fnc_setCMoney;
					uiSleep 3;
					openMap false;
					_pos set [2, 500];
					player setPos _pos;
					["A3W_Portal", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
					cutText ["Teleported finish.", "BLACK IN", 2.5];
				};
			} else
			{
				[] spawn {
					uiSleep 1;
					openMap false;
					cutText ["Teleport failed, try on captured territory", "BLACK IN", 2.5];
				};
			};
		};
	} forEach _territories;
	true
}, [_town, _price]] call BIS_fnc_addStackedEventHandler;
if (!visibleMap) then {openMap true};
hint "Click on any territory your side captured to teleport.";

[] spawn {
	addMissionEventHandler ["Map",
	{
		params ["_isOpened","_isForced"];
		_isOpened = _this select 0;
		if (!_isOpened) then
		{
			["A3W_Portal", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
		};
	}];
};
