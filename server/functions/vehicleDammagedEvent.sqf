// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: vehicleDammagedEvent.sqf
//	@file Author: AgentRev

params ["_veh"];

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
		if (count _items > 0) then {
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
			_veh setVariable ["R3F_LOG_objets_charges", [], false];
		};
	};
};
