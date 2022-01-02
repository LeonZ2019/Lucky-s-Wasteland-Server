if (!hasInterface) exitWith {};

surrender_key_press = "addons\surrender\key_press.sqf" call mf_compile;

waitUntil {!isNull findDisplay 46};
(findDisplay 46) displayAddEventHandler ["KeyDown", surrender_key_press];
