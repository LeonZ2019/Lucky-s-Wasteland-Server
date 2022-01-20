while {true} do
{
	waitUntil {count (allDisplays select {!(isNull (_x displayCtrl 510))}) == 1};
	private _eh = (findDisplay -1 displayCtrl 500) ctrlAddEventHandler ["mouseButtonDown","
		if (_this select 1 == 0) then
		{
			_minDist = ['A3W_remoteBombStoreRadius', 100] call getPublicVar;
			_targetPos = (_this select 0) ctrlMapScreenToWorld [_this select 2,_this select 3];
			_restricted = ((call storeOwnerConfig) select {_targetPos distance2D (call compile (_x select 0)) <= (_minDist * 1.25)});
			_button = findDisplay -1 displayCtrl 501;
			if (count _restricted > 0) then
			{
				systemChat 'RESTRICTED AREA';
				_button ctrlEnable false;
				_button ctrlSetText 'DENY';
				_button
			} else
			{
				_button ctrlEnable true;
				_button ctrlSetText 'FIRE';
			};
		};
	"];
	waitUntil {count (allDisplays select {!(isNull (_x displayCtrl 510))}) == 0};
};