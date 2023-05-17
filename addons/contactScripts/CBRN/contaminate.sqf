params ["_unit", "_ppBlur", "_ppColor"];
_unit setVariable ["inArea", true, true];
_ppBlur = -1;
_ppColor = -1;
_exposureLevel = 0;
_exposure = _unit getVariable ["CBRN_Exposure", 0];
// get level
switch true do
{
	case (_exposure < 10 && _exposure != 0):
	{
		_exposureLevel = 1;
	};
	case (_exposure >= 10 && _exposure < 20):
	{
		_exposureLevel = 2;
	};
	case (_exposure >= 20 && _exposure < 30):
	{
		_exposureLevel = 3; // unconscious?
	};
};
_exposureLevelCurrent = _exposureLevel;

while {(_unit getVariable ["CBRN_Exposure", 0] > 0 || count contaminateArea >= 1) && alive _unit} do
{
	_exposure = _unit getVariable ["CBRN_Exposure", 0];
	_mask = _unit getVariable ["CBRN_haveMask", false];
	_uniform = _unit getVariable ["CBRN_haveUniform", false];
	if ((!_mask || !_uniform) && (vehicle _unit == _unit) && !(_unit getVariable ["CBRN_Contaminate", false]) && count contaminateArea >= 1) then
	{
		_unit setVariable ["CBRN_Contaminate", true, true]; // need decon
	};
	if (((!_mask || !_uniform) && (vehicle _unit == _unit)) && (count contaminateArea >= 1) || _unit getVariable ["CBRN_Contaminate", false]) then
	{
		_exposure = _exposure + 0.1;
		_unit setVariable ["CBRN_Exposure", _exposure, true];
	};
	// shake and blur
	if (!_mask && count contaminateArea >= 1) then // check if is zone
	{
		_ppBlur = ppEffectCreate ["dynamicBlur", 831];
		_ppBlur ppEffectEnable true;
		_blur = linearConversion [0, 30, _exposure, 0, 3, true];
		_ppBlur ppEffectAdjust [_blur];
		_ppBlur ppEffectCommit 0.1;
		_ppColor = ppEffectCreate ["colorCorrections", 832];
		_ppColor ppEffectEnable true;
		_blend1 = linearConversion [0, 30, _exposure, 0, 1, true];
		_blend2 = linearConversion [0, 30, _exposure, 1, 0, true];
		_ppColor ppEffectAdjust 
		[
			1, 
			1, 
			0, 
			[1, 1, 1, 0], 
			[1, 1, 1, _blend2], 
			[_blend1, _blend1, _blend1, 0]
		];
		_ppColor ppEffectCommit 0.1;
		enableCamShake true;
		switch _exposureLevel do 
		{
			case 1: 
			{
				resetCamShake;
				addCamShake [0.5, 10000, 5];
			};
			case 2: 
			{
				resetCamShake;
				addCamShake [0.7, 10000, 8];
			};
			case 3: 
			{
				resetCamShake;
				addCamShake [1, 10000, 10];
			};
		};
	} else
	{
		resetCamShake;
		ppEffectDestroy ([_ppBlur, _ppColor] select { _x != -1 });
	};

	// check CBRN_Contaminate if true continue damage _unit
	if (_unit getVariable ["CBRN_Exposure", 0] == 0) then
	{
		_unit allowSprint true;
		_unit forceWalk false;
		_unit setMimic "";
		_exposure = 0;
		resetCamShake;
		ppEffectDestroy ([_ppBlur, _ppColor] select { _x != -1 });
		_sfx = _unit getVariable ["CBRN_SFX_Exposure", objNull];
		if (!isNull _sfx) then
		{
			detach _sfx;
			deleteVehicle _sfx;
		};
	};
	
	if (_exposure != 0) then
	{
		switch true do
		{
			case (_exposure < 10):
			{
				_exposureLevel = 1;
			};
			case (_exposure >= 10 && _exposure < 20):
			{
				_exposureLevel = 2;
			};
			case (_exposure >= 20 && _exposure < 30):
			{
				_exposureLevel = 3;
			};
		};
		if (_exposureLevelCurrent != _exposureLevel) then
		{
			_messages = ["You are exposure from harmful chemical.", "You are having symptoms of a chemical!", "You are suffering from exposured chemical!"];
			hint parseText format["<t size='2' color='#ff0000'>Warning</t><br/>%1", _messages select (_exposureLevel - 1)];
			_exposureLevelCurrent = _exposureLevel;
			_sfxTypes = "";
			switch _exposureLevel do 
			{

				case 1: 
				{
					_sfxTypes = "Sound_CBRN_Choke_Min";
					// resetCamShake;
					// addCamShake [0.5, 10000, 5];
				};
				case 2: 
				{
					_sfxTypes = "Sound_CBRN_Choke_Mid";
					// resetCamShake;
					// addCamShake [0.7, 10000, 8];
					_unit allowSprint false;
					_unit setMimic "hurt";
				};
				case 3: 
				{
					_sfxTypes = "Sound_CBRN_Heart_Max";
					// resetCamShake;
					// addCamShake [1, 10000, 10];
					_unit forceWalk true;
					_unit setMimic "dead";
				};
			};
			_sfx = _unit getVariable ["CBRN_SFX_Exposure", objNull];
			if (!isNull _sfx) then
			{
				detach _sfx;
				deleteVehicle _sfx;
				_unit setVariable ["CBRN_SFX_Exposure", objNull, true];
			};
			if (_sfxTypes != "") then
			{
				_sfx = createSoundSource [_sfxTypes, position _unit, [], 0];
				_sfx attachTo [_unit, [0, 0, 0], "head"];
				_unit setVariable ["CBRN_SFX_Exposure", _sfx, true];
			};
		};
		_damage = damage _unit + (_exposure * 0.00015);
		if (_damage >= 1 || _exposure >= 30) then { _unit setVariable ["killByChemical", true, true]; };
		if (_exposure >= 30) exitWith {_unit setDamage 1;};
		_unit setDamage _damage;
	};
	sleep 1;
};
_unit setVariable ["inArea", false, true];
if (alive _unit && _unit getVariable ["CBRN_Exposure", 0] == 0) then
{
	_unit groupChat "You are no longer contaminate and exposure to chemical.";
	_unit allowSprint true;
	_unit forceWalk false;
	_unit setMimic "";
	resetCamShake;
	ppEffectDestroy ([_ppBlur, _ppColor] select { _x != -1 });
	_sfx = _unit getVariable ["CBRN_SFX_Exposure", objNull];
	if (!isNull _sfx) then
	{
		detach _sfx;
		deleteVehicle _sfx;
	};
};

/*

// no uniform = direct damage, keep damage until decon
// no mask = direct damage, only in comtaminant area

// mask = no fuzzy view
// mask + backpack = normal
*/