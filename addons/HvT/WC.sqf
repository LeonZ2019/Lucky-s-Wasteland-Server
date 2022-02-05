#define WCKC 3 // war crime committed
#define HINT_DELAY 180  // number of seconds between each WC reminder hint
#define MARKER_REFRESH 90  // number of seconds between each WC marker refresh

if (isServer) then
{
	["WC_deleteMarker", "onPlayerDisconnected", { deleteMarker ("WC_" + _uid) }] call BIS_fnc_addStackedEventHandler;
};

if (!hasInterface) exitWith {};

waitUntil {sleep 0.1; alive player && !(player getVariable ["playerSpawning", true])};

_lastHint = -HINT_DELAY;
_lastMarker = -MARKER_REFRESH;
_markerTarget = objNull;
_hasMarker = false;

while {true} do
{
	_isWC = (alive player && !(player call A3W_fnc_isUnconscious) && !(player getVariable ["playerSpawning", true]) && [player, "warCrimes"] call fn_getScore > 0);

	if (_isWC && diag_tickTime - _lastHint >= HINT_DELAY) then
	{
		hint parseText ([
			"<t color='#FF0000' size='1.5' align='center'>War Criminal</t>",
			"<t color='#FFFFFF' shadow='1' shadowColor='#000000' align='center'>You are on Wanted list!</t>"
		] joinString "<br/>");

		_lastHint = diag_tickTime;
	};

	if (diag_tickTime - _lastMarker >= MARKER_REFRESH || (!alive _markerTarget && _hasMarker)) then
	{
		_markerName = "WC_" + getPlayerUID player;

		if (_hasMarker) then
		{
			deleteMarker _markerName;
			_hasMarker = false;
		};

		if (_isWC) then
		{
			createMarker [_markerName, getPosWorld player];
			_markerName setMarkerColor "ColorRed";
			_markerName setMarkerText format ["WC: %1", profileName];
			_markerName setMarkerSize [0.75, 0.75];
			_markerName setMarkerShape "ICON";
			_markerName setMarkerType "hd_warning_noShadow";

			_lastMarker = diag_tickTime;
			_markerTarget = player;
			_hasMarker = true;
			playSound "Topic_Done";
		};
	};

	sleep 1;
};