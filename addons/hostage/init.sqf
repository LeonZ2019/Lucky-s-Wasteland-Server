enableSaving [ false, false ];
call compile preprocessFile "addons\hostage\hostage.sqf";

waitUntil { !isNil "hostageSetupDone" };
