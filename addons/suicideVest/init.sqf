if (!hasInterface) exitWith {};

vest_detonate = false;
vest_detonate_fnc_key_press = "addons\suicideVest\key_press.sqf" call mf_compile;

waitUntil {!isNull findDisplay 46};
(findDisplay 46) displayAddEventHandler ["KeyDown", vest_detonate_fnc_key_press];
