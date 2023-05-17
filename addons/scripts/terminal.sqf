TerminalSecured = false;
TerminalIntercepted = false;
TerminalRunning = false;
TerminalAction = -1;
TerminalConnected = 0;
TerminalConnectTime = 5 * 60;

// if (isDedicated) exitWith {};

Terminal_Initial =
{
	params ["_terminal", "_player"];
	if (!(_terminal getVariable ["startMission", false])) then { _terminal setVariable ["startMission", true, true]; };
	_player groupChat "Keep terminal secure from enemy with 5 minutes long.";
	_texts = ["Terminal has been disrupted by nearby Radio Operator, eliminate him and resume communicate", "No disruption found on terminal, can be re-initial again."];
	[_terminal, 3] call BIS_fnc_dataTerminalAnimate;
	TerminalRunning = true;
	publicVariable "TerminalRunning";
	while {!TerminalSecured && TerminalRunning} do
	{
		_interceptor = _terminal getVariable ["Radio_interceptor", []];
		if (_interceptor findIf { _x distance _terminal < 75 && alive _x } != -1) then // found someone
		{
			[_terminal, 2] call BIS_fnc_dataTerminalAnimate;
			TerminalIntercepted = true;
			publicVariable "TerminalIntercepted";
			TerminalRunning = false;
			publicVariable "TerminalRunning";
			if (!alive _player) then {
				[side _player, "Base"] sideChat (_texts select 0);
			} else
			{
				_player groupChat (_texts select 0);
			};
			waitUntil {sleep 2; (_interceptor findIf { _x distance _terminal < 120 && alive _x } == -1)};
			// [_terminal, 3] call BIS_fnc_dataTerminalAnimate;
			TerminalIntercepted = false;
			publicVariable "TerminalIntercepted";
			if (!alive _player) then {
				// maybe add certain area, so not just focus on 1 player
				[side _player, "Base"] sideChat (_texts select 1);
			} else
			{
				_player groupChat (_texts select 1);
			};
		};
		sleep 5;
		TerminalConnected = TerminalConnected + 5;
		if (TerminalConnected >= TerminalConnectTime) then
		{
			[_terminal, 0] call BIS_fnc_dataTerminalAnimate;
			_terminal setVariable ["secured", true, true];
			TerminalSecured = true;
			publicVariable "TerminalSecured";
			
			_endMessage = ["Good job, you have established communication with extraterrestrials", "Radio comms has secured, finish off any left behind enemy"];
			_enemy = _terminal getVariable ["enemy", []];

			_endMessage = _endMessage select ([0,1] select (_enemy findIf { alive _x } != -1));
			if (!alive _player) then {
				[side _player, "Base"] sideChat _endMessage;
			} else
			{
				_player groupChat _endMessage;
			};
		};
	};
};

"TerminalEHAdd" addPublicVariableEventHandler {
	_terminal = _this select 1;
	if (TerminalSecured) exitWith {};
	if(TerminalAction == -1) then {
		TerminalAction = _terminal addAction ["<img image='\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa'/> <t color='#ffd800'>Initial Communicate</t>", {[_this select 0, _this select 1] spawn Terminal_Initial;}, nil, 10, true, false, "", "alive _this && !TerminalSecured && !TerminalIntercepted && !TerminalRunning", 5];
	};
};

"TerminalEHRemove" addPublicVariableEventHandler
{
	private ["_terminal"];
	_terminal = _this select 1;
	if (TerminalAction != -1) then {
		_terminal removeAction TerminalAction;
		TerminalAction = -1;
	};
	if (!TerminalSecured) then
	{
		_failedMessage = "Enemy sabotaged the terminal, run before too late";
		if (!alive _player) then {
			[side _player, "Base"] sideChat _failedMessage;
		} else
		{
			_player groupChat _failedMessage;
		};
	};
	TerminalSecured = false;
	publicVariable "TerminalSecured";
	TerminalIntercepted = false;
	publicVariable "TerminalIntercepted";
	TerminalRunning = false;
	publicVariable "TerminalRunning";
	TerminalConnected = 0;
	publicVariable "TerminalConnected";
};

hostageSetupDone = true;