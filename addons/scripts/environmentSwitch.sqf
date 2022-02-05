if (environmentEnabled select 1) then
{
	enableEnvironment false;
} else
{
	enableEnvironment true;
};
[format ["Environmental effects %1", ["Disabled", "Enabled"] select (environmentEnabled select 1)], 5] call mf_notify_client;