// pass mission description
A3W_RunningMission = missionNamespace getVariable ["A3W_RunningMission", []];
["A3W_MissionDescription", "onMapSingleClick",
{
	private ["_marker", "_hint", "_distance", "_message"];
	_marker = "";
	_hint = [];
	_distance = worldSize;
	{
		_markerName = _x select 0;
		if (markerType _markerName == "mil_destroy" && str (markerSize _markerName) == "[0.8,0.8]") then
		{
			if (_pos distance2D (markerPos _markerName) < _distance) then
			{
				_marker = _markerName;
				_hint = _x select 1;
				_distance = _pos distance2D (markerPos _markerName);
			};
		};
	} forEach A3W_RunningMission;
	if (_marker != "" && _distance <= 100) then
	{
		_message = (format
		[
			"<t color='%5' shadow='2' size='1.75'>%1</t><br/>" +
			"<t color='%5'>--------------------------------</t><br/>" +
			(if ((_hint select 1) != "") then { "<t size='1.25'>%2</t><br/>" } else { "" }) +
			(if ((_hint select 2) != "") then { "<img size='5' image='%3'/><br/>" } else { "" }) +
			"%4",
			_hint select 0,
			_hint select 1,
			_hint select 2,
			_hint select 3,
			_hint select 4
		]);
		if (_message isEqualType "") then { _message = parseText _message };
		playSound "addItemOK";
		hint _message;
	};
}] call BIS_fnc_addStackedEventHandler;