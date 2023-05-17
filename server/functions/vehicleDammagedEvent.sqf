// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: vehicleDammagedEvent.sqf
//	@file Author: AgentRev

params ["_veh"];
private ["_engine1", "_engine2", "_items", "_dimension_max", "_safePos", "_isLifting", "_airdrop", "_isInstalled", "_isInstalledOn", "_installed", "_transport", "_cargos", "_cargo"];
if (local _veh) then
{
	_engine1 = _veh getHitPointDamage "HitEngine";
	_engine2 = _veh getHitPointDamage "HitEngine2";

	if (!isNil "_engine1" && {_engine1 > 0.9 && (isNil "_engine2" || {_engine2 > 0.9})}) then
	{
		_veh engineOn false;
	};
	if (!alive _veh) then
	{
		_items = _veh getVariable "R3F_LOG_objets_charges";
		if (count _items > 0) then
		{
			{
				if (!isNull attachedTo _x) then
				{
					detach _x;
					_x setVariable ["R3F_LOG_est_transporte_par", objNull, true];
					[_x, true] call fn_enableSimulationGlobal;
					if (unitIsUAV _x) then
					{
						[_x, 1] call A3W_fnc_setLockState;
						["enableDriving", _x] call A3W_fnc_towingHelper;
					};
					_dimension_max = (((boundingBox _x select 1 select 1) max (-(boundingBox _x select 0 select 1))) max ((boundingBox _x select 1 select 0) max (-(boundingBox _x select 0 select 0))));
					_safePos = [
						(getPos _veh select 0) - ((_dimension_max+5+(random 10)-(boundingBox _veh select 0 select 1))*sin (getDir _veh - 90+random 180)),
						(getPos _veh select 1) - ((_dimension_max+5+(random 10)-(boundingBox _veh select 0 select 1))*cos (getDir _veh - 90+random 180)),
						0
					];
					_x setPos _safePos;
					_x setVelocity [0,0,0];
				};
			} forEach _items;
			_veh setVariable ["R3F_LOG_objets_charges", [], true];
		};
		_isLifting = _veh getVariable "R3F_LOG_heliporte";
		if (!isNull _isLifting) then
		{
			_veh setVariable ["R3F_LOG_heliporte", objNull, true];
			_isLifting setVariable ["R3F_LOG_est_transporte_par", objNull, true];
			["enableDriving", _isLifting] call A3W_fnc_towingHelper;

			_airdrop = (vectorMagnitude velocity _veh > 15 || (getPos _veh) select 2 > 40);
			if (local _isLifting) then
			{
				[_isLifting, _airdrop] call detachTowedObject;
				if ((getPos _veh) select 2 <= 1) then
				{
					_isLifting setPos (_veh modelToWorld [0,-10,0]); //AGL
				};
			} else
			{
				pvar_detachTowedObject = [netId _isLifting, _airdrop];
				publicVariable "pvar_detachTowedObject";
			};
		};
		_isInstalled = _veh getVariable ["R3F_LOG_installed_object", objNull];
		_isInstalledOn = _veh getVariable ["R3F_LOG_transport_installed", objNull];
		if (!(isNull _isInstalled) || !(isNull _isInstalledOn)) then
		{
			_installed = if (!isNull _isInstalled) then { _isInstalled } else { _veh };
			_transport = if (!isNull _isInstalled) then { _veh } else { _isInstalledOn };
			_transport setVariable ["R3F_LOG_installed_object", objNull, true];
			_installed setVariable ["R3F_LOG_transport_installed", objNull, true];
			_dimension_max = (((boundingBox _installed select 1 select 1) max (-(boundingBox _installed select 0 select 1))) max ((boundingBox _installed select 1 select 0) max (-(boundingBox _installed select 0 select 0))));
			_safePos = [
				(getPos _transport select 0) - ((_dimension_max+5+(random 10)-(boundingBox _transport select 0 select 1))*sin (getDir _transport - 90+random 180)),
				(getPos _transport select 1) - ((_dimension_max+5+(random 10)-(boundingBox _transport select 0 select 1))*cos (getDir _transport - 90+random 180)),
				0
			];
			_texture = _installed getVariable "R3F_Install_texture";
			if (!isNil "_texture") then
			{
				_installed setObjectTextureGlobal [0, _texture];
			};
			detach _installed;
			_installed setPos _safePos;
			if (typeOf _transport in ["B_Truck_01_cargo_F", "B_Truck_01_flatbed_F"]) then
			{
				_transport enableVehicleCargo true;
			} else
			{
				_cargos = [
					["B_Truck_01_transport_F",[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]],
					["O_Truck_03_transport_F",[1,2,3,4,5,6,7,8,9,10,11,12]],
					["I_Truck_02_transport_F",[2,3,4,5,6,7,8,9,10,11,12,13,14,15]],
					["C_Offroad_01_F",[1,2,3,4]],
					["C_Van_01_transport_F",[2,3,4,5,6,7,8,9,10,11]]
				];
				_cargo = _cargos select (_cargos findIf {_x select 0 == (typeOf _transport)});
				{ _transport lockCargo [_x, false]; } forEach (_cargo select 1);
			};
		};
	};
};
