if (R3F_LOG_mutex_local_verrou) then
{
	player globalChat STR_R3F_LOG_mutex_action_en_cours;
}
else
{
	R3F_LOG_mutex_local_verrou = true;
	R3F_LOG_objet_selectionne = objNull;
	player globalChat format [STR_R3F_LOG_action_selectionner_objet_cancel_fait, getText (configFile >> "CfgVehicles" >> (typeOf R3F_LOG_objet_selectionne) >> "displayName")];
	R3F_LOG_mutex_local_verrou = false;
};
