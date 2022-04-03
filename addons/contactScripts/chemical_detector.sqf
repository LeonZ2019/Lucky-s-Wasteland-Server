private ["_ui", "_obj", "_level"];
waitUntil {["playerSetupComplete", false] call getPublicVar};

while {true} do
{
	waitUntil {
		sleep 0.2;
		_ui = uiNamespace getVariable ["RscWeaponChemicalDetector", displayNull];
		!isNull _ui
	};
	_obj = _ui displayCtrl 101;
	_target = ; // spawn beacon included friendly side
	_level = [ ((position player) distance (position _target)) / 4 , 2] call BIS_fnc_cutDecimals;
	_obj ctrlAnimateModel ["Threat_Level_Source", _level, true];
};
