/*
 * Alternative to stringtable.csv which is simpler to install for the mission maker.
 * Alternative au stringtable.csv qui est plus simple à installer pour le créateur de mission.
 */

STR_R3F_LOG_action_heliporter = "Lift the object";
STR_R3F_LOG_action_heliporter_fait = "Object ""%1"" attached.";
STR_R3F_LOG_action_heliporter_UAV_group = "You must be in the same group as the UAV user to lift it.";
STR_R3F_LOG_action_heliporter_deja_transporte = "The object ""%1"" is already being transported by a vehicle.";
STR_R3F_LOG_action_heliporter_deplace_par_joueur = "The object ""%1"" is being moved by a player.";
STR_R3F_LOG_action_heliporter_joueur_dans_objet = "There is a player in the object ""%1"".";
STR_R3F_LOG_action_heliporter_objet_remorque = "Can't lift ""%1"" because it's towing another object.";
STR_R3F_LOG_action_heliport_larguer = "Drop the object";
STR_R3F_LOG_action_heliport_parachute = "Paradrop the object";
STR_R3F_LOG_action_heliport_larguer_fait = "Object ""%1"" dropped.";
STR_R3F_LOG_action_heliporter_empty_driver = "There is a player in the driver seat ""%1"".";

STR_R3F_LOG_action_deplacer_objet = "Move this object";
STR_R3F_LOG_action_deplacer_objet_UAV_group = "You must be in the same group as the UAV user to move it.";
STR_R3F_LOG_action_relacher_objet = "Release the object";
STR_R3F_LOG_ne_pas_monter_dans_vehicule = "You can't get in a vehicle while you're carrying this object !";
STR_R3F_LOG_courir_trop_vite = "Moving too fast! (Press C to slow down)";
STR_LOCK_OBJECT = "Lock this object";
STR_UNLOCK_OBJECT = "Unlock this object";
STR_RELEASE_HORIZONTAL = "Release the object horizontally";
STR_R3F_LOG_action_relacher_objet_collide = "Release the object as current position";
STR_R3F_LOG_action_objet_limit = "Object reach the elevation limit";

STR_R3F_LOG_action_selectionner_objet_charge = "Load in...";
STR_R3F_LOG_action_selectionner_objet_charge_fait = "Now select the vehicle in which to load ""%1""...";
STR_R3F_LOG_action_selectionner_objet_cancel = "... cancel loading";
STR_R3F_LOG_action_selectionner_objet_cancel_fait = "Deselect the load object ""%1""...";

STR_R3F_LOG_action_charger_selection = "... load the selected object in this vehicle";
STR_R3F_LOG_action_charger_selection_en_cours = "Loading in progress...";
STR_R3F_LOG_action_charger_selection_fait = "The object ""%1"" has been loaded in the vehicle.";
STR_R3F_LOG_action_charger_selection_trop_loin = "The object ""%1"" is too far from the vehicle to be loaded.";
STR_R3F_LOG_action_charger_selection_pas_assez_de_place = "There is not enough space in this vehicle. Space left: %1, Required: %2";
STR_R3F_LOG_action_charger_selection_objet_transporte = "The object ""%1"" is in transit.";

STR_R3F_LOG_action_charger_deplace = "Load in the vehicle";
STR_R3F_LOG_action_charger_deplace_en_cours = "Loading in progress...";
STR_R3F_LOG_action_charger_deplace_fait = "The object has been loaded in the vehicle ""%1"".";
STR_R3F_LOG_action_charger_deplace_pas_assez_de_place = "There is not enough space in this vehicle.";

STR_R3F_LOG_action_selectionner_objet_remorque = "Tow to a vehicle";
STR_R3F_LOG_action_selectionner_objet_remorque_UAV_group = "You must be in the same group as the UAV user to tow it.";
STR_R3F_LOG_action_selectionner_objet_remorque_fait = "Now select the vehicle which will tow ""%1""...";
STR_R3F_LOG_action_selectionner_objet_remorque_cancel_fait = "Deselect the tow vehicle ""%1""...";

STR_R3F_LOG_action_remorquer_selection = "... tow the selected object to this vehicle";
STR_R3F_LOG_action_cancel_remorquer = "... cancel towing";
STR_R3F_LOG_action_remorquer_selection_trop_loin = "The object ""%1"" is too far from the vehicle to be towed.";
STR_R3F_LOG_action_remorquer_selection_objet_transporte = "The object ""%1"" is in transit.";

STR_R3F_LOG_action_remorquer_deplace = "Tow the object";
STR_R3F_LOG_action_detacher = "Untow the object";
STR_R3F_LOG_action_detacher_fait = "Object untowed.";
STR_R3F_LOG_action_detacher_impossible_pour_ce_vehicule = "Only the pilot can detach this object.";

STR_R3F_LOG_action_contenu_vehicule = "View the vehicle content";
STR_R3F_LOG_action_decharger_en_cours = "Unloading in progress...";
STR_R3F_LOG_action_decharger_fait = "The object has been unloaded from the vehicle.";
STR_R3F_LOG_action_decharger_deja_fait = "The object has already been unloaded.";

STR_R3F_LOG_transport_en_cours = "This vehicle is being transported.";
STR_R3F_LOG_mutex_action_en_cours = "The current operation isn't finished.";

STR_R3F_LOG_dlg_CV_titre = "Vehicle contents";
STR_R3F_LOG_dlg_CV_capacite_vehicule = "Load : %1/%2";
STR_R3F_LOG_dlg_CV_btn_decharger = "Unload";
STR_R3F_LOG_dlg_CV_btn_fermer = "Cancel";

STR_R3F_LOG_nom_pc_arti = "Artillery CQ";

STR_R3F_LOG_action_install = "Install on vehicle";
STR_R3F_LOG_action_installing = "Installing in progress...";
STR_R3F_LOG_action_installed = "The object has been installed on vehicle.";
STR_R3F_LOG_action_install_empty_cargo = "The object's cargo is not empty.";
STR_R3F_LOG_action_install_cargo = "Vehicle's cargo is not empty.";
STR_R3F_LOG_action_install_exist = "Installed object exist, try uninstall it.";
STR_R3F_LOG_action_installing_in_progress = "Other player is installing.";
STR_R3F_LOG_action_install_locked = "Could not install on it, try unlock it.";
STR_R3F_LOG_action_install_damaged = "Could not install on it, vehicle destroyed!";
STR_R3F_LOG_action_install_empty = "Could not find any matched vehicle!";
STR_R3F_LOG_action_uninstall = "Uninstall object";
STR_R3F_LOG_action_uninstalling = "Uninstalling in progress...";
STR_R3F_LOG_action_uninstall_empty = "There is no object been installed on vehicle.";
STR_R3F_LOG_action_uninstall_empty_gunner = "Mortar gunner seat must be empty.";
STR_R3F_LOG_action_uninstall_empty_driver = "The driver seat of vehicle must be empty.";
STR_R3F_LOG_action_uninstalling_in_progress = "Other player is uninstalling.";
