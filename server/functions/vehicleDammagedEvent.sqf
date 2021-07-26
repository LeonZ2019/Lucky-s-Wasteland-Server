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
		/*_isTowing = _veh getVariable ["R3F_LOG_remorque", objNull];
		if (!isNull _isTowing) then
		{
			_veh setVariable ["R3F_LOG_remorque", objNull, true];
			_isTowing setVariable ["R3F_LOG_est_transporte_par", objNull, true];

			["enableDriving", _isTowing] call A3W_fnc_towingHelper;
			if (local _isTowing) then
			{
				[_isTowing] call detachTowedObject;
			} else
			{
				pvar_detachTowedObject = [netId _isTowing];
				publicVariable "pvar_detachTowedObject";
			};
		};*/
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
	};
};
