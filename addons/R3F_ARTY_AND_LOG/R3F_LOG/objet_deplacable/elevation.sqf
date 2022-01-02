
private ["_elevation", "_direction", "_limit", "_attachPos", "_currentLevel"];

_elevation = _this select 3;

if (R3F_LOG_mutex_local_verrou) then {
	player globalChat STR_R3F_LOG_mutex_action_en_cours; // French crap
} else {
	_limit = R3F_LOG_joueur_deplace_objet getVariable "elevationLimit";
	_currentLevel = R3F_LOG_joueur_deplace_objet getVariable ["elevationLevel", 0];
	_finalElevation = false;
	if (_elevation > 0) then
	{
		_finalElevation = (_currentLevel + _elevation) < (_limit * 0.9);
	} else
	{
		_finalElevation = abs (_currentLevel + _elevation) < (_limit * 0.9);
	};
	if (_finalElevation) then
	{
		R3F_LOG_joueur_deplace_objet setVariable ["elevationLevel", _currentLevel + _elevation, true];
		_attachPos = R3F_LOG_joueur_deplace_objet getVariable "attachPos" vectorAdd [0,0,_elevation];
		_direction = (getDir R3F_LOG_joueur_deplace_objet)- (getDir player);
		R3F_LOG_joueur_deplace_objet setVariable ["attachPos", _attachPos, true];

		detach R3F_LOG_joueur_deplace_objet;
		R3F_LOG_joueur_deplace_objet attachTo [player, _attachPos];

		R3F_LOG_joueur_deplace_objet setDir _direction;
		R3F_ARTY_AND_LOG_PUBVAR_setDir = [R3F_LOG_joueur_deplace_objet, _direction];
		publicVariable "R3F_ARTY_AND_LOG_PUBVAR_setDir";
	} else
	{
		player globalChat STR_R3F_LOG_action_objet_limit;
	};
	R3F_LOG_mutex_local_verrou = false;
};
