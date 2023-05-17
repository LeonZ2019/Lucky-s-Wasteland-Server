params ["_unit", "_healer"];

_success = false;
_isFinish = false;
_failedMessage = "";
_useTime = 5;
_startTime = time;

_healer playActionNow "Medic";

while {!_isFinish} do
{
	sleep 0.5;
	if !(alive _healer) exitWith
	{
		_isFinish = true;
	};
	if !(alive _unit) exitWith
	{
		_failedMessage = "The unit has dead.";
		_isFinish = true;
	};
	if (_unit distance _healer > 3) exitWith
	{
		_failedMessage = "The unit is too far from you.";
		_isFinish = true;
	};
	if ([["Aswm","Assw","Absw","Adve","Asdv","Abdv"], animationState _healer] call fn_startsWith) exitWith
	{
		_failedMessage = "You can not give decontaminate while swimming";
		_isFinish = true;
	};
	if (vehicle _healer != _healer) exitWith
	{
		_failedMessage = "You can not give decontaminate while you are in vehicle.";
		_isFinish = true;
	};
	if (vehicle _unit != _unit) exitWith
	{
		_failedMessage = "You can not give decontaminate while unit are in vehicle.";
		_isFinish = true;
	};
	if !('Item_DeconKit_01_F' in (items _healer)) exitWith
	{
		_failedMessage = "You no longer have decon kit.";
		_isFinish = true;
	};
	if !(_unit getVariable ["CBRN_Contaminate", false]) exitWith
	{
		_failedMessage = "The unit have been decontaminated";
		_isFinish = true;
	};
	if (_startTime + _useTime <= time) then
	{
		_success = true;
		_isFinish = true;
	};
	if ((toLower animationState _healer) find "_medic" == -1) then
	{
		_healer playActionNow "Medic";
	};
};
_healer playActionNow "";
if (_success) then
{
	_healer removeItem "Item_DeconKit_01_F";
	_unit setVariable ["CBRN_Contaminate", false, true];
	_healer groupChat "Done decontaminated."
} else
{
	if (_failedMessage != "") then
	{
		_healer groupChat _failedMessage;
	};
};