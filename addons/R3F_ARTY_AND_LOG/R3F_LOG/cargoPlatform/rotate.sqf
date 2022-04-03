private _object = _this select 0;
private _rotation = _object animationPhase (R3F_LOG_action_objet_platform_panel select 0);
_rotation = _rotation + (_this select 3);
_object animate [R3F_LOG_action_objet_platform_panel select 0, _rotation, 5];

/*
GPS
_display = (uiNamespace getVariable "RscUnitInfo");
_ctrlGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", 170];
[-0.409091,-0.409091,1.82386,1.81818]
CA_IGUI_elements_group
ctrlGPSActivated ctrlSetPosition [3.5 * (0.01875 * SafezoneH),21.5 * (0.025 * SafezoneH),12 * (0.01875 * SafezoneH),1.2 * (0.025 * SafezoneH)];
ctrlGPSActivated ctrlSetTextColor [0.0,0.0,0.0,1];
ctrlGPSActivated ctrlSetText "GPS MODE ОN";
ctrlGPSActivated ctrlCommit 0*/