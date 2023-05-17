_loopStopper = false;
while {!_loopStopper} do
{
    waitUntil {sleep 1; true};
    _messageBeforeRestart = [20*60, 10*60, 5*60, 1*60, 30, 10, 5];
    _timeToRestart = [[5,0,0]]; // hours, minutes, seconds
    {
        _currentTime = systemTime;
        _hours = _currentTime select 3;
        _minutes = _currentTime select 4;
        _seconds = _currentTime select 5;
        _timeleft = (((_x select 0) - _hours) * 3600) + (((_x select 1) - _minutes) * 60) + ((_x select 2) - _seconds);
        if (_timeleft in _messageBeforeRestart) then
        {
            for "_i" from 0 to (count _messageBeforeRestart) do
            {
                if ((_messageBeforeRestart select _i) == _timeleft) exitWith
                {
                    _messageBeforeRestart deleteAt _i;
                };
            };
            _timeunit = "SECONDS";
            if (_timeleft > 59) then
            {
                _timeleft = _timeleft / 60;
                _timeunit = "MINUTES";
            };
            systemChat format ["THE SERVER WILL RESTART IN %1 %2", _timeleft, _timeunit];
        };
    } forEach _timeToRestart;
};