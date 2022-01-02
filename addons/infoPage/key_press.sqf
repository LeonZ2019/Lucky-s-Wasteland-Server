if (!hasInterface) exitWith {};

waitUntil {!isNull findDisplay 46};
(findDisplay 46) displayAddEventHandler ["KeyDown", {
	params[ "_display", "_keyCode", "_shft", "_ctr", "_alt" ];
	_handled = false;
	if (_keyCode == 199 && !_shft && !_ctr && !_alt) then
	{
		[] execVM "addons\infoPage\infoPage.sqf";
		_handled = true;
	};
	_handled
}];
