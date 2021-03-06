/**
 * Remorque l'objet déplacé par le joueur avec un remorqueur
 *
 * Copyright (C) 2010 madbull ~R3F~
 *
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#define VEHICLE_UNLOCKED(VEH) (locked (VEH) < 2 || (VEH) getVariable ["ownerUID","0"] isEqualTo getPlayerUID player)

if (R3F_LOG_mutex_local_verrou) then
{
	player globalChat STR_R3F_LOG_mutex_action_en_cours;
}
else
{
	R3F_LOG_mutex_local_verrou = true;

	private ["_objet", "_remorqueur"];

	_objet = R3F_LOG_joueur_deplace_objet;

	_remorqueur = nearestObjects [_objet, R3F_LOG_CFG_remorqueurs, 22];
	// Parce que le remorqueur peut être un objet remorquable
	_remorqueur = _remorqueur - [_objet];

	if (count _remorqueur > 0) then
	{
		_remorqueur = _remorqueur select 0;

		if (alive _remorqueur && isNull (_remorqueur getVariable "R3F_LOG_remorque") && (vectorMagnitude velocity _remorqueur < 6) && (getPos _remorqueur select 2 < 2) && VEHICLE_UNLOCKED(_remorqueur) && !(_remorqueur getVariable "R3F_LOG_disabled")) then
		{
			// On mémorise sur le réseau que le véhicule remorque quelque chose
			_remorqueur setVariable ["R3F_LOG_remorque", _objet, true];
			// On mémorise aussi sur le réseau que le canon est attaché en remorque
			_objet setVariable ["R3F_LOG_est_transporte_par", _remorqueur, true];

			["disableDriving", _objet] call A3W_fnc_towingHelper;

			_towerBB = _remorqueur call fn_boundingBoxReal;
			_towerMinBB = _towerBB select 0;
			_towerMaxBB = _towerBB select 1;

			_objectBB = _objet call fn_boundingBoxReal;
			_objectMinBB = _objectBB select 0;
			_objectMaxBB = _objectBB select 1;

			_towerCenterX = (_towerMinBB select 0) + (((_towerMaxBB select 0) - (_towerMinBB select 0)) / 2);
			_objectCenterX = (_objectMinBB select 0) + (((_objectMaxBB select 0) - (_objectMinBB select 0)) / 2);

			_towerGroundPos = _remorqueur worldToModel (_remorqueur call fn_getPos3D);

			if ((getPosASL player) select 2 > 0) then
			{
				// On place le joueur sur le côté du véhicule, ce qui permet d'éviter les blessure et rend l'animation plus réaliste
				player attachTo [_remorqueur,
				[
					(_towerMinBB select 0) - 0.25,
					(_towerMinBB select 1) - 0.25,
					_towerMinBB select 2
				]];

				player setDir 90;
				player setPos (getPos player);
				sleep 0.05;
				detach player;
			};

			[player, "AinvPknlMstpSlayWrflDnon_medic"] call switchMoveGlobal;
			sleep 2;

			// Attacher à l'arrière du véhicule au ras du sol
			[_remorqueur, true] call fn_enableSimulationGlobal;
			[_objet, true] call fn_enableSimulationGlobal;
			_objet attachTo [_remorqueur,
			[
				_towerCenterX - _objectCenterX,
				(_towerMinBB select 1) - (_objectMaxBB select 1) - 0.5,
				(_towerGroundPos select 2) - (_objectMinBB select 2) + 0.1
			]];

			// Faire relacher l'objet au joueur (si il l'a dans "les mains")
			R3F_LOG_joueur_deplace_objet = objNull;
			detach player;

			sleep 5;

			if (isNull objectParent player) then
			{
				[player, ""] call switchMoveGlobal;
			};
		};
	};

	R3F_LOG_mutex_local_verrou = false;
};
