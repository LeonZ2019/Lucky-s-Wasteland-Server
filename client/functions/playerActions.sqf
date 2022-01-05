// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.2
//	@file Name: playerActions.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, [GoT] JoSchaap, AgentRev
//	@file Created: 20/11/2012 05:19

{ [player, _x] call fn_addManagedAction } forEach
[
	["Holster Weapon", { player action ["SwitchWeapon", player, player, 100] }, [], -11, false, false, "", "vehicle player == player && currentWeapon player != '' && stance player != 'UNDEFINED' && (stance player != 'CROUCH' || currentWeapon player != handgunWeapon player)"], // A3 v1.58 bug, holstering handgun while crouched causes infinite anim loop
	//["Unholster Primary Weapon", { player action ["SwitchWeapon", player, player, 0] }, [], -11, false, false, "", "vehicle player == player && currentWeapon player == '' && primaryWeapon player != ''"],

	["<img image='client\icons\flat_grass.paa'/> Flatten Grass", "client\actions\flat_grass.sqf", [], 1, false, false, "", "vehicle player == player && !surfaceIsWater position player && getPosATL player select 2 <= 0.15"],
	["<img image='client\icons\chop_tree.paa'/> Chop Tree", "client\actions\tree_cutter.sqf", [], 1, false, false, "", "vehicle player == player && alive player && cursorObject distance2D player <= 4 && (getModelInfo cursorObject select 0) in ['t_broussonetiap1s_f.p3d','t_ficusb1s_f.p3d','t_ficusb2s_f.p3d','t_fraxinusav2s_f.p3d','t_oleae1s_f.p3d','t_oleae2s_f.p3d','t_phoenixc1s_f.p3d','t_phoenixc3s_f.p3d','t_pinusp3s_f.p3d','t_pinuss1s_f.p3d','t_pinuss2s_b_f.p3d','t_pinuss2s_f.p3d','t_poplar2f_dead_f.p3d','t_populusn3s_f.p3d','t_quercusir2s_f.p3d'] && alive cursorObject"],

	[format ["<img image='client\icons\playerMenu.paa' color='%1'/> <t color='%1'>[</t>Player Menu<t color='%1'>]</t>", "#FF8000"], "client\systems\playerMenu\init.sqf", [], -10, false], //, false, "", ""],

	[format ["<img image='\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa' color='%1'/> <t color='%1'>[</t>Airdrop Menu<t color='%1'>]</t>", "#FF0000"],"addons\APOC_Airdrop_Assistance\APOC_cli_menu.sqf",[], -99, false, false, "","vehicle player == player"],
	["<img image='client\icons\radar.paa'/> Track Devices", "addons\beacondetector\beacondetector.sqf",0,-10,false,false,"","('MineDetector' in (items player)) && !BeaconScanInProgress"],
	["<img image='\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa'/> <t color='#FFFFFF'>Cancel tracking.</t>", "Beaconscanstop = true",0,-10,false,false,"","BeaconScanInProgress"],

	["<img image='client\icons\money.paa'/> Pickup Money", "client\actions\pickupMoney.sqf", [], 1, false, false, "", "{_x getVariable ['owner', ''] != 'mission'} count (player nearEntities ['Land_Money_F', 5]) > 0"],

	["<img image='\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa'/> <t color='#FFFFFF'>Cancel Action</t>", { doCancelAction = true }, [], 1, false, false, "", "mutexScriptInProgress"],

	["<img image='client\icons\repair.paa'/> Salvage", "client\actions\salvage.sqf", [], 1.1, false, false, "", "!isNull cursorTarget && !alive cursorTarget && {cursorTarget isKindOf 'AllVehicles' && !(cursorTarget isKindOf 'Man') && vehicle player == player && player distance cursorTarget <= (sizeOf typeOf cursorTarget / 3) max 3}"],

	// If you have a custom vehicle licence system, simply remove/comment the following action
	["<img image='client\icons\r3f_unlock.paa'/> Acquire Vehicle Ownership", "client\actions\takeOwnership.sqf", [], 1, false, false, "", "[] call fn_canTakeOwnership isEqualTo ''"],

	["[0]"] call getPushPlaneAction,
	["Push vehicle", "server\functions\pushVehicle.sqf", [4, true], 1, false, false, "", "[4] call canPushVehicleOnFoot"],
	["Push vehicle forward", "server\functions\pushVehicle.sqf", [2.5], 1, false, false, "", "[2.5] call canPushWatercraft"],
	["Push vehicle backward", "server\functions\pushVehicle.sqf", [-2.5], 1, false, false, "", "[-2.5] call canPushWatercraft"],

	["<img image='client\icons\driver.paa'/> Enable driver assist", fn_enableDriverAssist, [], 0.5, false, true, "", "_veh = objectParent player; alive _veh && !alive driver _veh && {effectiveCommander _veh == player && player in [gunner _veh, commander _veh] && {_veh isKindOf _x} count ['LandVehicle','Ship'] > 0 && !(_veh isKindOf 'StaticWeapon')}"],
	["<img image='client\icons\driver.paa'/> Disable driver assist", fn_disableDriverAssist, [], 0.5, false, true, "", "_driver = driver objectParent player; isAgent teamMember _driver && {(_driver getVariable ['A3W_driverAssistOwner', objNull]) in [player,objNull]}"],
	["<img image='\A3\ui_f\data\igui\cfg\VehicleToggles\EngineIconOn_ca.paa'/> Engine On", fn_driverAssistEngineOn, [], 0.5, false, true, "", "_driver = driver objectParent player; isAgent teamMember _driver && {(_driver getVariable ['A3W_driverAssistOwner', objNull]) in [player,objNull]} && !isEngineOn vehicle player"],
	["<img image='\A3\ui_f\data\igui\cfg\VehicleToggles\EngineIconOn_ca.paa'/> Engine Off", fn_driverAssistEngineOff, [], 0.5, false, true, "", "_driver = driver objectParent player; isAgent teamMember _driver && {(_driver getVariable ['A3W_driverAssistOwner', objNull]) in [player,objNull]} && isEngineOn vehicle player"],
	["<img image='\A3\ui_f\data\igui\cfg\VehicleToggles\LightsIconOn_ca.paa'/> Lights On", fn_driverAssistLightsOn, [], 0.5, false, true, "", "_driver = driver objectParent player; isAgent teamMember _driver && {(_driver getVariable ['A3W_driverAssistOwner', objNull]) in [player,objNull]} && !isLightOn vehicle player"],
	["<img image='\A3\ui_f\data\igui\cfg\VehicleToggles\LightsIconOn_ca.paa'/> Lights Off", fn_driverAssistLightsOff, [], 0.5, false, true, "", "_driver = driver objectParent player; isAgent teamMember _driver && {(_driver getVariable ['A3W_driverAssistOwner', objNull]) in [player,objNull]} && isLightOn vehicle player"],
	[format ["<t color='#FF0000'>Emergency eject (Ctrl+%1)</t>", (actionKeysNamesArray "GetOver") param [0,"<'Step over' keybind>"]],  { [[], fn_emergencyEject] execFSM "call.fsm" }, [], -9, false, true, "", "(vehicle player) isKindOf 'Air' && !((vehicle player) isKindOf 'ParachuteBase')"],
	[format ["<t color='#FF00FF'>Open magic parachute (%1)</t>", (actionKeysNamesArray "GetOver") param [0,"<'Step over' keybind>"]], A3W_fnc_openParachute, [], 20, true, true, "", "vehicle player == player && (getPos player) select 2 > 2.5"],

	["Take Uniform", "client\actions\takeUniform.sqf", [0], 100, true, true, "", "getItemCargo cursorObject select 0 findIf { _x isKindOf ['Uniform_Base', configfile >> 'CfgWeapons'] && !(player isUniformAllowed _x) } != -1 && cursorObject distance player <= 3 && (typeOf cursorObject == 'GroundWeaponHolder' || cursorObject isKindOf 'ReammoBox_F')"], // from ground or crate
	["Steal Uniform", "client\actions\takeUniform.sqf", [1], 100, true, true, "", "cursorObject isKindOf 'CAManBase' && !alive cursorObject && uniform cursorObject != '' && cursorObject distance player <= 3 && !(player isUniformAllowed (uniform cursorObject))"], // from dead body
	["<t color='#FF0000'>Look in gear</t>", "addons\surrender\surrender_actions.sqf", ["gear"], 1, false, false, "", "alive cursorObject && (cursorObject getVariable ['isSurrender',false]) && {(player distance cursorObject) < 5}"],
	["<t color='#FF0000'>Extort money</t>", "addons\surrender\surrender_actions.sqf", ["money"], 1, false, false, "", "alive cursorObject && (cursorObject getVariable ['isSurrender',false]) && {(player distance cursorObject) < 5}"],
	["<t color='#00FF7F'>Untie player</t>", "addons\surrender\surrender_actions.sqf", ["untie"], 1, false, false, "", "alive cursorObject && (cursorObject getVariable ['isSurrender',false]) && cursorObject getVariable ['isTied', false] && {(player distance cursorObject) < 5}"],
	["<t color='#00FF7F'>Tie player</t>", "addons\surrender\surrender_actions.sqf", ["tie"], 1, false, false, "", "alive cursorObject && (cursorObject getVariable ['isSurrender',false]) && !(cursorObject getVariable ['isTied', false]) && {(player distance cursorObject) < 5}"]

];

if (["A3W_vehicleLocking"] call isConfigOn) then
{
	[player, ["<img image='client\icons\r3f_unlock.paa'/> Pick Lock", "addons\scripts\lockPick.sqf", [cursorTarget], 1, false, false, "", "alive cursorTarget && player distance cursorTarget <= (sizeOf typeOf cursorTarget / 3) max 3 && {{cursorTarget isKindOf _x} count ['LandVehicle','Ship','Air'] > 0 && {locked cursorTarget == 2 && !(cursorTarget getVariable ['A3W_lockpickDisabled',false]) && cursorTarget getVariable ['ownerUID','0'] != getPlayerUID player && 'ToolKit' in items player}}"]] call fn_addManagedAction;
};

// Hehehe...
if (288520 in getDLCs 2) then
{
	[player, ["<t color='#00FFFF'>Get in as Driver</t>", "client\actions\moveInDriver.sqf", [], 6, true, true, "", "cursorTarget isKindOf 'Kart_01_Base_F' && player distance cursorTarget < 3.4 && isNull driver cursorTarget"]] call fn_addManagedAction;
};

if ((getDLCs 2) findIf { _x in [395180, 304380] } != -1) then
{
	[player, ["<t color='#00FFFF'>Get in as Passenger</t>", "client\actions\moveInCargo.sqf", [], 6, true, true, "", "['LandVehicle', 'Air', 'Ship'] findIf { cursorTarget isKindOf _x} != -1 && (getText (configfile >> 'CfgVehicles' >> typeOf cursorTarget >> 'DLC')) in ['Expansion', 'Heli'] && locked cursorTarget == 1 && (switch(getText (configfile >> 'CfgVehicles' >> typeOf cursorTarget >> 'DLC')) do {case'Expansion':{395180};case'Heli':{304380};}) in (getDLCs 2) && vehicle player == player && player distance cursorTarget < (3.4 max (sizeOf typeOf cursorTarget * 0.75)) && cursorTarget emptyPositions 'cargo' > 0"]] call fn_addManagedAction;
};

if (["A3W_savingMethod", "profile"] call getPublicVar == "extDB") then
{
	if (["A3W_vehicleSaving"] call isConfigOn) then
	{
		[player, ["<img image='client\icons\save.paa'/> Enable Vehicle Saving", { cursorTarget call fn_forceSaveVehicle }, [], -9.5, false, true, "", "cursorTarget call canForceSaveVehicle && (cursorTarget getVariable ['A3W_skipAutoSave', false])"]] call fn_addManagedAction;
		[player, ["<img image='client\icons\save.paa'/> Force Save Vehicle", { cursorTarget call fn_forceSaveVehicle }, [], -9.5, false, true, "", "cursorTarget call canForceSaveVehicle && !(cursorTarget getVariable ['A3W_skipAutoSave', false])"]] call fn_addManagedAction;
	};

	if (["A3W_staticWeaponSaving"] call isConfigOn) then
	{
		[player, ["<img image='client\icons\save.paa'/> Enable Turret Saving", { cursorTarget call fn_forceSaveObject }, [], -9.5, false, true, "", "cursorTarget call canForceSaveStaticWeapon && (cursorTarget getVariable ['A3W_skipAutoSave', false])"]] call fn_addManagedAction;
		[player, ["<img image='client\icons\save.paa'/> Force Save Turret", { cursorTarget call fn_forceSaveObject }, [], -9.5, false, true, "", "cursorTarget call canForceSaveStaticWeapon && !(cursorTarget getVariable ['A3W_skipAutoSave', false])"]] call fn_addManagedAction;
	};
};
