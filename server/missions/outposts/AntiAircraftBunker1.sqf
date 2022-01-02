[
	["B_Radar_System_01_F",[-0.181396,0.196289,-0.105731],360],
	["Land_HBarrier_Big_F",[-4.30627,0.175781,-0.00143909],90.2],
	["Land_HBarrier_Big_F",[4.79028,0.0078125,-0.00143909],90.2],
	["B_AAA_System_01_F",[-7.72876,0.612305,-0.116617],0],
	["B_AAA_System_01_F",[7.9906,0.64209,-0.116617],0],
	["Land_HBarrier_Big_F",[-7.67017,-4.77588,-0.00143909],0],
	["Land_HBarrier_Big_F",[-7.74072,4.68701,-0.00143909],0],
	["Land_HBarrier_Big_F",[8.04919,-4.74609,-0.00132751],0],
	["Land_HBarrier_Big_F",[7.97864,4.7168,-0.00132751],0],
	["Land_Mil_WallBig_4m_F",[-1.58887,-10.1626,-0.0133815],0],
	["Land_Mil_WallBig_4m_F",[2.26978,-10.1074,-0.0133815],0],
	["Land_Mil_WallBig_4m_F",[-1.65027,10.2617,-0.0133815],179.8],
	["Land_Mil_WallBig_4m_F",[2.19983,10.2739,-0.0133815],179.8],
	["Land_HBarrier_Big_F",[-10.9176,0.0444336,-0.00143909],90.2],
	["Land_Mil_WallBig_4m_F",[-5.60779,-10.1582,-0.0133815],0],
	["Land_Mil_WallBig_4m_F",[-5.64954,10.2544,-0.0133815],179.8],
	["Land_Mil_WallBig_4m_F",[6.1123,-10.1235,-0.0133815],0],
	["Land_HBarrier_Big_F",[11.4131,0.205566,-0.00132751],90.2],
	["Land_Mil_WallBig_4m_F",[6.0509,10.2769,-0.0133815],179.8],
	["Land_Mil_WallBig_4m_F",[-9.60706,-10.1533,-0.0133815],0],
	["Land_Mil_WallBig_4m_F",[-9.66846,10.2471,-0.0133815],179.8],
	["Land_Mil_WallBig_4m_F",[10.1116,-10.1284,-0.0133815],0],
	["Land_Mil_WallBig_4m_F",[10.0698,10.2842,-0.0133815],179.8],
	["Land_Mil_WallBig_4m_F",[-15.7249,-0.0175781,-0.0133815],89.7],
	["Land_Mil_WallBig_4m_F",[-15.7144,-4.03613,-0.0133815],89.7],
	["Land_Mil_WallBig_4m_F",[-15.735,3.98242,-0.0133815],89.7],
	["Land_Mil_WallBig_4m_F",[16.3845,-0.0424805,-0.0133815],270],
	["Land_Mil_WallBig_4m_F",[16.3929,3.95801,-0.0133815],270],
	["Land_Mil_WallBig_4m_F",[16.385,-4.04541,-0.0133815],270],
	["Land_Mil_WallBig_4m_F",[-13.4496,-10.1372,-0.0133815],0],
	["Land_Mil_WallBig_4m_F",[-13.5195,10.2441,-0.0133815],179.8],
	["Land_Mil_WallBig_4m_F",[14.1305,-10.1328,-0.0133815],0],
	["Land_Mil_WallBig_4m_F",[-15.6947,-7.87598,-0.0133815],89.7],
	["Land_Mil_WallBig_4m_F",[14.0691,10.2915,-0.0133815],179.8],
	["Land_Mil_WallBig_4m_F",[-15.7543,7.98584,-0.0133815],89.7],
	["Land_Mil_WallBig_4m_F",[16.3934,-7.88623,-0.0133815],270],
	["Land_Mil_WallBig_4m_F",[16.4012,7.97656,-0.0133815],270],
	["B_Heli_Transport_03_unarmed_F",[0.935425,-25.4038,0],270.2, { _this call fn_refilltruck }]
]

/*
_startPos = position player; // need to be center of the whole stuff
_base = nearestObjects [_startPos,  ["All"],  20]; // radius from center
_outpost = []; 
{ 
_outpost pushBack [typeOf _x, position _x vectorDiff _startPos,  (floor (getDir _x * 10)) / 10]; 
} forEach _base; 
_outpost;
*/