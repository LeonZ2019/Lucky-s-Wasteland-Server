// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: optionSelect.sqf
//	@file Author: [404] Deadbeat
//	@file Created: 20/11/2012 05:19

#define debugMenu_option 50003
#define adminMenu_option 50001
disableSerialization;

private ["_panelType","_displayAdmin","_displayDebug","_adminSelect","_debugSelect","_money"];
_uid = getPlayerUID player;
if (_uid call isAdmin) then
{
	_panelType = _this select 0;

	_displayAdmin = uiNamespace getVariable ["AdminMenu", displayNull];
	_displayDebug = uiNamespace getVariable ["DebugMenu", displayNull];

	switch (true) do
	{
		case (!isNull _displayAdmin): //Admin panel
		{
			_adminSelect = _displayAdmin displayCtrl adminMenu_option;

			switch (lbCurSel _adminSelect) do
			{
				case 0: //Player Menu
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\playerMenu.sqf";
				};
				case 1: //Full Vehicle Management
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\vehicleManagement.sqf";
				};
				case 2: //Markers log
				{
					closeDialog 0;
					createDialog "MarkerLog";
				};
				case 3: //Unstuck player
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\unstuck.sqf";
					if (!isNil "notifyAdminMenu") then { ["UnstuckPlayer", "Used"] call notifyAdminMenu };
				};
				case 4: //Tags
				{
					execVM "client\systems\adminPanel\playerTags.sqf";
				};
				case 5: //Teleport me to player
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\tpmeto.sqf";
				};
				case 6: //Teleport player to me
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\tptome.sqf";
				};
				case 7: //Teleport
				{
					closeDialog 0;
					["A3W_teleport", "onMapSingleClick",
					{
						private ["_waterPos", "_oldVelocity", "_alt", "_top", "_buildings"];
						_oldVelocity = velocity (vehicle player);
						_alt = getPos (vehicle player) select 2;
						if (surfaceIsWater _pos) then
						{
							_top = +_pos;
							_top set [2, (_top select 2) + 1000];
							_buildings = (lineIntersectsSurfaces [_top, _pos, objNull, objNull, true, -1, "GEOM", "NONE"]) select {(_x select 2) isKindOf "Building"};

							if !(_buildings isEqualTo []) then
							{
								_waterPos = _buildings select 0 select 0;
							};
						};
						if (isNil "_waterPos") then
						{
							vehicle player setPos (_pos vectorAdd [0,0, (0 max _alt)]);
						} else
						{
							vehicle player setPosASL (_waterPos vectorAdd [0,0, (0 max _alt)]);
						};
						(vehicle player) setVelocity _oldVelocity;
						["A3W_teleport", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
						true
					}] call BIS_fnc_addStackedEventHandler;
					hint "Click on map to teleport";
					if (!visibleMap) then {openMap true;};
				};
				case 8: //Money
				{
					_money = 5000;
					[player, _money] call A3W_fnc_setCMoney;
					// if (!isNil "notifyAdminMenu") then { ["money", _money] call notifyAdminMenu };
				};
				case 9: //Debug Menu
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\loadDebugMenu.sqf";
				};
				case 10: //Object search menu
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\loadObjectSearch.sqf";
				};
				case 11: // toggle God mode
				{
					execVM "client\systems\adminPanel\toggleGodMode.sqf";
				};
				case 12: // vehicle invincible
				{
					execVM "client\systems\adminPanel\vehicleInvincible.sqf";
				};
				case 13: // infinite ammo
				{
					execVM "client\systems\adminPanel\infiniteAmmo.sqf";
				};
			};
		};
		case (!isNull _displayDebug): //Debug panel
		{
			_debugSelect = _displayDebug displayCtrl debugMenu_option;

			switch (lbCurSel _debugSelect) do
			{
				case 0: //Access Gun Store
				{
					closeDialog 0;
					[] call loadGunStore;
				};
				case 1: //Access General Store
				{
					closeDialog 0;
					[] call loadGeneralStore;
				};
				case 2: //Access Vehicle Store
				{
					closeDialog 0;
					[] call loadVehicleStore;
				};
				case 3: //Access ATM Dialog
				{
					closeDialog 0;
					call mf_items_atm_access;
				};
				case 4: //Access Respawn Dialog
				{
					closeDialog 0;
					true spawn client_respawnDialog;
				};
				case 5: //Access Proving Grounds
				{
					closeDialog 0;
					createDialog "balca_debug_main";
				};
				case 6: //Show server FPS function
				{
					hint format["Server FPS: %1",serverFPS];
				};
				case 7: // paint vehicle
				{
					closeDialog 0;
					createDialog "A3W_vehPaintMenu";
				};
				case 8:
				{
					closeDialog 0;
					call ps_access;
				};
			};
		};
	};
};
