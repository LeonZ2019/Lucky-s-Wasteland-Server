params ["_unit"];
private ["_gear", "_isPlaying", "_sfxType", "_sfx"];

while {_unit getVariable ["CBRN_haveMask", false] && alive _unit} do
{
	_sfx = _unit getVariable ["CBRN_SFX_FACEWEAR", objNull];
	if (isNull _sfx) then
	{
		_gear = goggles _unit;
		_sfxType = "";
		switch (_gear select [0, 27]) do
		{
			case "G_AirPurifyingRespirator_01":
			{
				_sfxType = "Sound_CBRN_APR";
			};
			case "G_AirPurifyingRespirator_02":
			{
				_sfxType = "Sound_CBRN_APR_02";
			};
			case "G_RegulatorMask_F":
			{
				_sfxType = "Sound_CBRN_Regulator";
			};
		};

		if (_sfxType != "") then
		{
			_sfx = createSoundSource [_sfxType, position _unit, [], 0];
			_sfx attachTo [_unit, [0, 0, 0], "head"];
			_unit setVariable ["CBRN_SFX_FACEWEAR", _sfx, true];
		};
	};
	sleep 1;
};

_sfx = _unit getVariable ["CBRN_SFX_FACEWEAR", objNull];
if (!isNull _sfx) then
{
	detach _sfx;
	deleteVehicle _sfx;
};