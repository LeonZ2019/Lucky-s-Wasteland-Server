params ["_target", "", "", "", "_text"];
private ["_stringtable", "_showerPosArray", "_action", "_value", "_pos", "_trigger"];
_stringtable = ["$STR_A3_C_CfgVehicles_DeconShower_01_base_F_UserActions_Deactivate0", "STR_A3_C_CfgVehicles_DeconShower_02_base_F_UserActions_Activate1"] apply { localize _x };
_action = _stringtable find _text;
switch (_action) do
{
	case 1: // activating shower
	{
		_maxWait = 5;
		waitUntil {_maxWait = _maxWait - 1; uiSleep 1; ((_target animationSourcePhase "Valve_Source" >= 1) || _maxWait <= 0)};
		//  (_target getVariable ["BIN_Shower_Stop", false])
		_showerPosArray = 
		[
			["DeconShower_01_F", [0.1, -0.45, -0.085], [0.68, 0.565, 0, true, 1.145]],
			["DeconShower_02_F", [0, 0, 1.75], [2.44, 1, 0, true, 2.025]]
		];
		_value = _target animationSourcePhase "Valve_Source";
		_pos = _showerPosArray select { _x select 0 == typeOf _target} select 0;
		if (_value == 1) then // run success
		{
			// make trigger
			_trigger = createTrigger ["EmptyDetector", _target modelToWorld (_pos select 1), true];
			_trigger setTriggerArea (_pos select 2);
			_trigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];
			_trigger setTriggerStatements ["thisList findIf { (_x isKindOf 'CAManBase') && ((_x getVariable ['CBRN_Contaminate', false]) || (_x getVariable ['CBRN_Exposure', 0] > 0))} != -1", "
			{
				_x setVariable ['CBRN_Contaminate', false];
				_x setVariable ['CBRN_Exposure', 0];
			} forEach (thisList select { ((_x getVariable ['CBRN_Contaminate', false]) || (_x getVariable ['CBRN_Exposure', 0] > 0)) })", ""];
			_trigger attachTo [_target, _pos select 1];
			_target setVariable ["CBRN_Shower_Trigger", _trigger];
		};
	};
	case 0: // deactivating shower
	{
		// remove trigger
		_trigger = _target getVariable ["CBRN_Shower_Trigger", objNull];
		if !(isNil "_trigger") then
		{
			detach _trigger;
			deleteVehicle _trigger;
		};
		_target setVariable ["CBRN_Shower_Trigger", nil, true];
	};
};

/*

 4:17:23 [16598728800# 620039: deconshower_01_f.p3d,B Alpha 1-1:1 (Lee),9,"UserType","啟動淋浴",1.4,true,true,"",false,"Action"]
 4:17:33 [16598728800# 620039: deconshower_01_f.p3d,B Alpha 1-1:1 (Lee),9,"UserType","關閉淋浴",1.399,true,true,"",false,"Action"]

// deactivate
localize  "$STR_A3_C_CfgVehicles_DeconShower_01_base_F_UserActions_Deactivate0"
// activate
localize  "$STR_A3_C_CfgVehicles_DeconShower_02_base_F_UserActions_Activate1"

poss = [];
for "_i" from 1 to 3 do
{
	_pos = shower selectionPosition format ["shower_%1_pos", _i];
	poss pushBack [_pos, (shower modelToWorldVisual _pos)];
};

//small
// top right, top left, front right middle, front left middle, behind left middle, behind right middle, front right bottom, front left bottom, behind left bottom, behind right bottom
[
	[[0.68168,0.0405674,1.06171],[4372.82,3748.5,2.29018]],
	[[-0.673886,0.0436077,1.06171],[4371.47,3748.5,2.28534]],
	[[0.685816,-0.521026,0.439685],[4372.84,3747.95,1.66666]],
	[[-0.673426,-0.518412,0.439685],[4371.48,3747.96,1.67212]],
	[[-0.668873,0.611374,0.439685],[4371.49,3749.09,1.66257]],
	[[0.673,0.611374,0.439685],[4372.83,3749.08,1.66771]],
	[[0.685816,-0.521026,-0.520797],[4372.86,3747.98,0.706207]],
	[[-0.673426,-0.518412,-0.520797],[4371.5,3747.98,0.710678]],
	[[-0.668873,0.611374,-0.520797],[4371.51,3749.11,0.701752]],
	[[0.673,0.611374,-0.520797],[4372.85,3749.11,0.706619]]
]
_center = [0.1, -0.45, -0.085];
_area = [0.68, 0.565, 0, true, 1.145];
// height 1.06
// ground = -1.23
// front = -0.52
// behind = 0.61
// left = -0.67
// right = 0.69

//large
[]
_center = [0, 0, -0.645];
_area = [2.44, 1, 2.025];
// right, top, left
[[-2.43828,-9.46767e-005,-2.58415],[-1.68186,-9.52835e-005,1.38141],[2.43807,-9.5103e-005,-2.58415]]
[[-2.43828,-9.48438e-005,-1.71269],[-0.636107,-9.50323e-005,1.38141],[2.43807,-9.52701e-005,-1.71269]]
[[-2.43828,-9.46609e-005,-2.66672],[-1.78094,-9.53073e-005,1.38141],[2.43807,-9.50872e-005,-2.66672]]
[[-2.43828,-9.46606e-005,-2.66814],[-1.78264,-9.53077e-005,1.38141],[2.43807,-9.50869e-005,-2.66814],[0.0254222,-9.49612e-005,-3.15173]]
[[-2.43828,-9.46606e-005,-2.66814],[-1.78264,-9.53077e-005,1.38141],[2.43807,-9.50869e-005,-2.66814],[0.0254222,-9.49612e-005,-3.15173]]
// height 1.38
// ground -2.67
// left 2.44
// right 2.44
*/