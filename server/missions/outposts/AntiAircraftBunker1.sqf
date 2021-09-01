[
	["Land_HBarrier_Big_F", [-2.35852, -0.385742, -0.00143909], 90.2],
	["B_Radar_System_01_F", [1.77527, -0.364746, -0.103895], 0],
	["B_AAA_System_01_F", [-5.78101, 0.0507813, -0.116617], 0],
	["Land_HBarrier_Big_F", [6.73804, -0.553711, -0.00143909], 90.2],
	["Land_HBarrier_Big_F", [-5.79297, 4.12549, -0.00143909], 0],
	["Land_HBarrier_Big_F", [-5.72241, -5.3374, -0.00143909], 0],
	["Land_HBarrier_Big_F", [-8.96985, -0.51709, -0.00143909], 90.2],
	["Land_Mil_WallBig_4m_F", [0.297485, 9.7002, -0.0133815], 179.8],
	["Land_Mil_WallBig_4m_F", [-3.70178, 9.69287, -0.0133815], 179.8],
	["B_AAA_System_01_F", [9.93835, 0.0805664, -0.116617], 0],
	["Land_Mil_WallBig_4m_F", [4.14758, 9.7124, -0.0133815], 179.8],
	["Land_Mil_WallBig_4m_F", [0.358887, -10.7241, -0.0133815], 0],
	["Land_HBarrier_Big_F", [9.92639, 4.15527, -0.00132751], 0],
	["Land_Mil_WallBig_4m_F", [-3.66003, -10.7197, -0.0133815], 0],
	["Land_Mil_WallBig_4m_F", [4.21753, -10.6689, -0.0133815], 0],
	["Land_HBarrier_Big_F", [9.99695, -5.30762, -0.00132751], 0],
	["Land_Mil_WallBig_4m_F", [-7.7207, 9.68555, -0.0133815], 179.8],
	["Land_Mil_WallBig_4m_F", [7.99866, 9.71533, -0.0133815], 179.8],
	["Land_Mil_WallBig_4m_F", [-7.6593, -10.7148, -0.0133815], 0],
	["Land_Mil_WallBig_4m_F", [8.06006, -10.6851, -0.0133815], 0],
	["Land_Mil_WallBig_4m_F", [-13.7771, -0.579102, -0.0133815], 89.7],
	["Land_HBarrier_Big_F", [13.3608, -0.355957, -0.00132751], 90.2],
	["Land_Mil_WallBig_4m_F", [-13.7872, 3.4209, -0.0133815], 89.7],
	["Land_Mil_WallBig_4m_F", [-13.7666, -4.59766, -0.0133815], 89.7],
	["Land_Mil_WallBig_4m_F", [-11.5718, 9.68262, -0.0133815], 179.8],
	["Land_Mil_WallBig_4m_F", [12.0176, 9.72266, -0.0133815], 179.8],
	["Land_Mil_WallBig_4m_F", [-13.8065, 7.42432, -0.0133815], 89.7],
	["Land_Mil_WallBig_4m_F", [-11.5018, -10.6987, -0.0133815], 0],
	["Land_Mil_WallBig_4m_F", [-13.7469, -8.4375, -0.0133815], 89.7],
	["Land_Mil_WallBig_4m_F", [12.0593, -10.6899, -0.0133815], 0],
	["Land_Mil_WallBig_4m_F", [18.3323, -0.604004, -0.0133815], 270],
	["Land_Mil_WallBig_4m_F", [18.3407, 3.39648, -0.0133815], 270],
	["Land_Mil_WallBig_4m_F", [18.3328, -4.60693, -0.0133815], 270],
	["Land_Mil_WallBig_4m_F", [16.0168, 9.72998, -0.0133815], 179.8],
	["Land_Mil_WallBig_4m_F", [16.0782, -10.6943, -0.0133815], 0],
	["Land_Mil_WallBig_4m_F", [18.349, 7.41504, -0.0133815], 270],
	["Land_Mil_WallBig_4m_F", [18.3412, -8.44775, -0.0133815], 270]
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