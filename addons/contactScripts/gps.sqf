disableSerialization;

#define GUI_GRID_OLD_OPTICS_W		(0.01875 * SafezoneH)
#define GUI_GRID_OLD_OPTICS_H		(0.025 * SafezoneH)
#define IDC_CTRL_GPS_STATIC 		30001
#define IDC_CTRL_GPS_TGT_GRID 		30002
#define IDC_IGUI_WEAPON_GPS_TARGET 	172

private _display = (uiNamespace getVariable "RscUnitInfo");
private _ctrlGroup = _display displayCtrl 170;

waitUntil {["playerSetupComplete", false] call getPublicVar};

while { true } do
{
	waitUntil {
		sleep 0.1;
		cameraView == "Gunner" &&
		currentWeapon player isKindOf ["Binocular", configFile >> "CfgWeapons"] && currentWeapon player != "Binocular"
	};
	if (isNull (_display displayCtrl IDC_CTRL_GPS_STATIC)) then
	{
		private _pos = switch (currentWeapon player) do
		{
			case "Rangefinder";
			case "Laserdesignator";
			case "Laserdesignator_01_khk_F";
			case "Laserdesignator_03":
			{
				[3.5, 8.5, 21.5, 23]
			};
			case "Laserdesignator_02";
			case "Laserdesignator_02_ghex_F":
			{
				[6.5, 11.5, 24.5, 26]
			};
		};

		// Create first line with static text "GPS MODE ON";
		_ctrlGPSActivated = _display ctrlCreate ["RscCtrlGPS_Static",IDC_CTRL_GPS_STATIC, _ctrlGroup];
		_ctrlGPSActivated ctrlSetPosition [(_pos select 0) * GUI_GRID_OLD_OPTICS_W,(_pos select 2) * GUI_GRID_OLD_OPTICS_H,12 * GUI_GRID_OLD_OPTICS_W,1.2 * GUI_GRID_OLD_OPTICS_H];
		_ctrlGPSActivated ctrlSetTextColor [0.0,0.0,0.0,1];
		_ctrlGPSActivated ctrlSetText "GPS MODE ОN";

		// Target grid control - controlled by engine
		_ctrlGrid = _display ctrlCreate ["RscCtrlGPS_Name",IDC_IGUI_WEAPON_GPS_TARGET, _ctrlGroup];
		_ctrlGrid ctrlSetPosition [(_pos select 1) * GUI_GRID_OLD_OPTICS_W,(_pos select 3) * GUI_GRID_OLD_OPTICS_H,6 * GUI_GRID_OLD_OPTICS_W,1.2 * GUI_GRID_OLD_OPTICS_H];
		_ctrlGrid ctrlSetTextColor [0.706,0.0745,0.0196,1];
		_ctrlGrid ctrlCommit 0;

		// Static text "TGT GRID:"
		_ctrlGridText = _display ctrlCreate ["RscCtrlGPS_Static",IDC_CTRL_GPS_TGT_GRID, _ctrlGroup];
		_ctrlGridText ctrlSetPosition [(_pos select 0) * GUI_GRID_OLD_OPTICS_W,(_pos select 3) * GUI_GRID_OLD_OPTICS_H,12 * GUI_GRID_OLD_OPTICS_W,1.2 * GUI_GRID_OLD_OPTICS_H];
		_ctrlGridText ctrlSetTextColor [0.0,0.0,0.0,1];
		_ctrlGridText ctrlSetText "TGT GRID:";
		_ctrlGridText ctrlCommit 0;

		{ _x ctrlCommit 0 } forEach [_ctrlGPSActivated, _ctrlGrid, _ctrlGridText];
	};
};
