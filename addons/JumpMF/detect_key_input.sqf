//////////////////////////////////////////////////////////////////
// Script File for [Arma 3] - detect_key_input.sqf
// Created by: Das Attorney
// Modified by: AgentRev
//////////////////////////////////////////////////////////////////

#define HORDE_JUMPMF_SLOWING_MULTIPLIER 0.9
#define HORDE_JUMPMF_IMPUSLE 2.5

private ["_pressedKey", "_handled", "_move", "_moveM", "_moveP"];
_pressedKey = _this select 1;
_handled = false;

if (_pressedKey in actionKeys "GetOver") then
{
	if (horde_jumpmf_var_jumping) exitWith
	{
		_handled = true;
	};

	if (vehicle player == player) then
	{
		_move = animationState player;
		_moveM = toLower (_move select [8,4]);
		_moveP = toLower (_move select [4,4]);

		if (_moveM in ["mrun","meva"] && _moveP in ["perc","pknl"] && isTouchingGround player && speed player >= 1) then
		{
			horde_jumpmf_var_jumping = true;

			private _prevVel = velocity player;

			[player, "AovrPercMrunSrasWrflDf"] call switchMoveGlobal;

			if (currentWeapon player == "") then
			{
				player playMoveNow "AovrPercMrunSrasWrflDf";
			};

			horde_jumpmf_var_prevVel = _prevVel;
			horde_jumpmf_var_vel1 = nil;
			horde_jumpmf_var_vel2 = _prevVel select 2;

			private _frameEvent = addMissionEventHandler ["EachFrame",
			{
				horde_jumpmf_var_vel1 = ((velocity player) select 2) + ([0,HORDE_JUMPMF_IMPUSLE] select isNil "horde_jumpmf_var_vel1");

				// Ignore very high downward accelerations caused by step transitions, otherwise this kills the player
				if (horde_jumpmf_var_vel1 - horde_jumpmf_var_vel2 < -7) then
				{
					horde_jumpmf_var_vel1 = horde_jumpmf_var_vel2;
				};

				player setVelocity
				[
					(horde_jumpmf_var_prevVel select 0) * HORDE_JUMPMF_SLOWING_MULTIPLIER,
					(horde_jumpmf_var_prevVel select 1) * HORDE_JUMPMF_SLOWING_MULTIPLIER,
					horde_jumpmf_var_vel1 min HORDE_JUMPMF_IMPUSLE
				];

				horde_jumpmf_var_vel2 = (velocity player) select 2;
			}];

			[_move, _prevVel, _frameEvent] spawn
			{
				params ["_prevMove", "_prevVel", "_frameEvent"];

				waitUntil
				{
					(animationState player != "AovrPercMrunSrasWrflDf")
				};

				removeMissionEventHandler ["EachFrame", _frameEvent];

				/*[player, _prevMove] call switchMoveGlobal;
				player setVelocity
				[
					_prevVel select 0,
					_prevVel select 1,
					(velocity player) select 2
				];*/

				sleep 0.5; // Cooldown
				horde_jumpmf_var_jumping = false;
			};

			_handled = true;
		} else { // run with speed less than 1 able to jump?
			if (_moveM in ["mrun","meva","mstp"] && _moveP in ["perc","pknl"] && isTouchingGround player && speed player < 1) then
			{
				_distance = player distance2D (ASLToAGL (lineIntersectsSurfaces [eyePos player, (ATLtoASL screenToWorld [0.5,0.5]), player, objNull, true,1] select 0 select 0));
				if (_distance < 1.2) then
				{
					_pPos = getPosASLVisual player;
					_dPos = AGLToASL (player getRelPos [1.2, 0]);
					_dPos set [2, _pPos select 2];
					_freeZ = 0;
					_safeZ = 0;
					for "_i" from 0.2 to 4.61 step (0.2) do // look for place
					{
    					_fromPos = _pPos vectorAdd [0,0,_i];
    					_toPos = _dPos vectorAdd [0,0,_i];
    					_blocked = lineIntersectsObjs [_fromPos, _toPos, player, objNull, true];
    					if (count _blocked > 0) then
    					{
        					_freeZ = 0;
    					} else
    					{
        					_freeZ = _freeZ + 1;
        					if (_freeZ == 8) then
        					{
            					_safeZ = (_toPos select 2) - (8 * 0.2);
        					};
    					};
					};
					if (_safeZ != 0) then // can climb?
					{
    					_pPos set [2, _safeZ + 0.5];
    					_blockWhenClimb = lineIntersectsSurfaces [getPosASLVisual player, _pPos, player, objNull, true];
    					_dPos set [2, _safeZ];
    					if (count _blockWhenClimb == 0) then
    					{
							horde_jumpmf_var_jumping = true;
							_handled = true;
							_move = "GetInHeli_Transport_02Cargo";
							if (2.8 / 2 > _distanceZ) then { _move = "GetInHemttBack"; };
							[player, _move] call switchMoveGlobal;
							player playMoveNow _move; // ?
							[_move, _dPos] spawn {
								params ["_move", "_dPos"];
								waitUntil {animationState player != _move};
								player setPosASL _dPos;
								horde_jumpmf_var_jumping = false;
							};
    					};
					};
				};
			};
		};
	};
};

_handled
