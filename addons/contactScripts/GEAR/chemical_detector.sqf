params ["_unit"];
private ["_ui", "_obj", "_area", "_threatValue", "_threats", "_threats", "_threatLevelChanged", "_threatLevel", "_threatLevelCurrent", "_viewCondition", "_sfxType", "_sfx"];
// waitUntil { sleep 0.2; !(isNil "CBRN_contaminants")};
waitUntil {sleep 1; ((count contaminateArea > 0) || (!alive _unit))};

if (_unit getVariable ["CBRN_haveDetector", false] && alive _unit) then
{
	"CBRN_Detector" cutRsc ["RscWeaponChemicalDetector", "PLAIN", 1, false];
	_ui = uiNamespace getVariable ["RscWeaponChemicalDetector", displayNull];
	_obj = _ui displayCtrl 101;

	while {_unit getVariable ["CBRN_haveDetector", false] && alive _unit} do
	{
		_threatValue = 0;
		_threats = [];
		if (count contaminateArea >= 1) then
		{
			_mainThreat = contaminateArea select 0;
			_threatValue = _unit distance (markerPos _mainThreat);
			_min = 0.3; // mean inside 30% radius will get 100% detector

			_size = markerSize _mainThreat;
			_minRadius = selectMin _size;
			_maxRadius = selectMax _size;
			_threatValue = linearConversion [_maxRadius, _maxRadius * _min, _threatValue, 0, 1, true];
			/*_sizeX = _size select 0;
			_sizeY = _size select 1;
			_shape = _markerShape _mainThreat;
			_dir = markerDir _mainThreat;
			// _angle = getRelDir 
			switch (_shape) do
			{
				case "RECTANGLE":
				{

				};
				case "ELLIPSE":
				{
					_maxRadius = (_sizeX * _sizeY) / sqrt ((_sizeX^2 * sin) + ())
				};
			}; */
		};

		/*_area = CBRN_contaminants findIf {markerPos [_x, true] distance _unit <= 150};
		if (_area != -1) then // sort distance
		{
			_threats = CBRN_contaminants select {markerPos [_x, true] distance _unit <= 150};
			// _threats = [_threats, [_unit], { _input0 distance markerPos }, "ASCEND"] call BIS_fnc_sortBy;
			_threats = _threats apply {[(markerPos [_x, true]) distance _unit, _x]};
			_threats sort true;
			_threatValue = ((_threats # 0) # 0);
			_threatValue = linearConversion [150, 50, _threatValue, 0, 1, true]; // range from 150 to 50, less than 50 just simply put 1
		};*/
		// _threatLevelChanged = false;
		_threatLevel = 0;
		_threatLevelCurrent = _threatLevel;
		if (_threatValue > 0) then
		{
			_threatValue = ((_threatValue - 0.02 + (random 0.04)) max 0.005) min 1;
			if (_threatValue < 0.33) then
			{
				_threatLevel = 1;
			} else
			{
				if (_threatValue < 0.66) then
				{
					_threatLevel = 2;
				} else
				{
					_threatLevel = 3;
				};
			};
		};

		if (_threatLevel != _threatLevelCurrent) then
		{
			// _threatLevelCurrent = _threatLevel;
			// _threatLevelChanged = true;
			_sfxType = "";

			switch _threatLevel do
			{
				case 1: {_sfxType = "Sound_CBRN_Detector_Min"};
				case 2: {_sfxType = "Sound_CBRN_Detector_Mid"};
				case 3: {_sfxType = "Sound_CBRN_Detector_Max"};
			};

			_sfx = _unit getVariable ["CBRN_SFX_DETECTOR", objNull];
			if (!isNull _sfx) then
			{
				detach _sfx;
				deleteVehicle _sfx;
			};
			if (_sfxType != "") then
			{
				_sfx = createSoundSource [_sfxType, position _unit, [], 0]; // can other player heard this?
				_sfx attachTo [_unit, [0, 0, 0], "head"];
				_unit setVariable ["CBRN_SFX_DETECTOR", _sfx, true];
			};
		} else
		{
			_sfx = _unit getVariable ["CBRN_SFX_DETECTOR", objNull];
			if (!isNull _sfx) then
			{
				detach _sfx;
				deleteVehicle _sfx;
			};
		};

		_viewCondition = visibleWatch && (cameraView in ["INTERNAL", "EXTERNAL"]);
		_obj ctrlShow _viewCondition;
		if (_viewCondition) then
		{
			_obj ctrlAnimateModel ["Threat_Level_Source",[_threatValue, 2] call BIS_fnc_cutDecimals, true];
		};

		sleep 1; // 0.5
	};

	"CBRN_Detector" cutText ["", "PLAIN"];
	_sfx = _unit getVariable ["CBRN_SFX_DETECTOR", objNull];
	if (!isNull _sfx) then
	{
		detach _sfx;
		deleteVehicle _sfx;
	};
};