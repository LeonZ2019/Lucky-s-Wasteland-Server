/****** TOW WITH VEHICLE  ******/

/**
 * List of class names of vehicles which can tow towables objects.
 */
R3F_LOG_CFG_remorqueurs =
[
	"SUV_01_base_F",
	"Offroad_01_base_F",
	"Offroad_02_base_F",
	"Van_01_base_F",
	"Van_02_base_F",
	"LSV_01_base_F",
	"LSV_02_base_F",
	"MRAP_01_base_F",
	"MRAP_02_base_F",
	"MRAP_03_base_F",
	"LT_01_base_F",
	"Boat_Armed_01_base_F"
];

/**
 * List of class names of HEAVY vehicles which can tow heavy towables objects. Takes precedence over R3F_LOG_CFG_remorqueurs
 */
R3F_LOG_CFG_remorqueursH =
[
	"Tractor_01_base_F",
	"Truck_01_base_F",
	"Truck_02_base_F",
	"Truck_03_base_F",
	"Wheeled_APC_F",
	"APC_Tracked_01_base_F",
	"APC_Tracked_02_base_F",
	"APC_Tracked_03_base_F",
	"MBT_01_base_F",
	"MBT_02_base_F",
	"MBT_03_base_F",
	"MBT_04_base_F"
];

R3F_LOG_CFG_remorqueurs append R3F_LOG_CFG_remorqueursH;

/**
 * List of class names of towables objects.
 */
R3F_LOG_CFG_objets_remorquables =
[
	"Car_F",
	"Ship_F",
	"Plane",
	"LT_01_base_F",
	"UAV_03_base_F",
	"Heli_Light_01_base_F",
	"Heli_Light_02_base_F",
	"Heli_light_03_base_F",
	"Heli_Attack_01_base_F"
];

/**
 * List of class names of HEAVY towables objects. Takes precedence over R3F_LOG_CFG_objets_remorquables
 */
R3F_LOG_CFG_objets_remorquablesH =
[
	"Tractor_01_base_F",
	"Wheeled_APC_F",
	"APC_Tracked_01_base_F",
	"APC_Tracked_02_base_F",
	"APC_Tracked_03_base_F",
	"MBT_01_base_F",
	"MBT_02_base_F",
	"MBT_03_base_F",
	"MBT_04_base_F",
	"Heli_Attack_02_base_F",
	"Heli_Transport_01_base_F",
	"Heli_Transport_02_base_F",
	"Heli_Transport_03_base_F",
	"Heli_Transport_04_base_F",
	"VTOL_base_F",
	"UAV_05_Base_F",
	"Plane_Fighter_01_Base_F",
	"Plane_Fighter_02_Base_F",
	"Plane_CAS_01_base_F",
	"Plane_CAS_02_base_F"
];

R3F_LOG_CFG_objets_remorquables append R3F_LOG_CFG_objets_remorquablesH;

/****** LIFT WITH VEHICLE  ******/

/**
 * List of class names of air vehicles which can lift liftables objects.
 */
R3F_LOG_CFG_heliporteurs =
[
	//"Helicopter_Base_F"
	//"Heli_Light_01_base_F",
	"Heli_Light_02_base_F",
	"Heli_light_03_base_F",
	"Heli_Attack_01_base_F",
	"Heli_Attack_02_base_F",
	"Heli_Transport_01_base_F",
	"VTOL_base_F"
];

/**
 * List of class names of HEAVY air vehicles which can lift heavy liftables objects. Takes precedence over R3F_LOG_CFG_objets_remorquables
 */
R3F_LOG_CFG_heliporteursH =
[
	"Heli_Transport_02_base_F",
	"Heli_Transport_03_base_F",
	"Heli_Transport_04_base_F"
];

R3F_LOG_CFG_heliporteurs append R3F_LOG_CFG_heliporteursH;

/**
 * List of class names of liftables objects.
 */
R3F_LOG_CFG_objets_heliportables =
[
	"Car_F",
	"Ship_F",
	"Plane",
	"LT_01_base_F",
	"UAV_03_base_F",
	"Heli_Light_01_base_F",
	"Land_CargoBox_V1_F"
];

/**
 * List of class names of HEAVY liftables objects. Takes precedence over R3F_LOG_CFG_objets_heliportables
 */
R3F_LOG_CFG_objets_heliportablesH =
[
	"Tractor_01_base_F",
	"Wheeled_APC_F",
	"APC_Tracked_01_base_F",
	"APC_Tracked_02_base_F",
	"APC_Tracked_03_base_F",
	"MBT_01_base_F",
	"MBT_02_base_F",
	"MBT_03_base_F",
	"MBT_04_base_F",
	"Heli_Light_02_base_F",
	"Heli_light_03_base_F",
	"Heli_Attack_01_base_F",
	"Heli_Attack_02_base_F",
	"Heli_Transport_01_base_F",
	"Heli_Transport_02_base_F",
	"Heli_Transport_03_base_F",
	"Heli_Transport_04_base_F",
	"Plane_CAS_01_base_F",
	"Plane_CAS_02_base_F",
	"Plane_Fighter_03_base_F",
	"VTOL_01_base_F",
	"VTOL_02_base_F"
];

R3F_LOG_CFG_objets_heliportables append R3F_LOG_CFG_objets_heliportablesH;


/****** LOAD IN VEHICLE / CHARGER DANS LE VEHICULE ******/


/**
 * List of class names of (ground or air) vehicles which can transport transportables objects.
 * The second element of the arrays is the load capacity (in relation with the capacity cost of the objects).
 */
R3F_LOG_CFG_transporteurs =
[
	["Quadbike_01_base_F", 5],
	["UGV_01_base_F", 10],
	["Hatchback_01_base_F", 10],
	["SUV_01_base_F", 20],
	["Offroad_01_base_F", 30],
	["Offroad_02_base_F", 20],
	["Van_01_base_F", 40],
	["Van_02_base_F", 50],
	["LSV_01_base_F", 15],
	["LSV_02_base_F", 15],
	["MRAP_01_base_F", 20],
	["MRAP_02_base_F", 20],
	["MRAP_03_base_F", 20],
	["Tractor_01_base_F", 20],
	["B_Truck_01_box_F", 150],
	["Truck_F", 75],
	["Wheeled_APC_F", 30],
	["UGV_02_Base_F", 3],
	["LT_01_base_F", 10],
	["Tank_F", 30],
	["Scooter_Transport_01_base_F", 5],
	["SDV_01_base_F", 10],
	["Rubber_duck_base_F", 10],
	["Boat_Civil_01_base_F", 10],
	["Boat_Transport_02_base_F", 15],
	["Boat_Armed_01_base_F", 20],
	["Heli_Light_01_base_F", 10],
	["Heli_Light_02_base_F", 20],
	["Heli_light_03_base_F", 20],
	["Heli_Transport_01_base_F", 25],
	["Heli_Transport_02_base_F", 30],
	["Heli_Transport_03_base_F", 30],
	["Heli_Transport_04_base_F", 30],
	["Heli_Attack_01_base_F", 10],
	["Heli_Attack_02_base_F", 20],
	["Plane_Civil_01_base_F", 5],
	["VTOL_01_base_F", 50],
	["VTOL_02_base_F", 30]
];


R3F_LOG_CFG_objets_transportables =
[
	["Static_Designator_01_base_F", 2],
	["Static_Designator_02_base_F", 2],
	["StaticWeapon", 5],
	["Box_NATO_AmmoVeh_F", 10],
	["B_supplyCrate_F", 5],
	["ReammoBox_F", 3],
	["Kart_01_Base_F", 5],
	["Quadbike_01_base_F", 10],
	["Rubber_duck_base_F", 10],
	["UAV_01_base_F", 2],
	["UAV_06_base_F", 2],
	["UGV_02_Base_F", 2],
	["Land_PierLadder_F", 3],
	["Land_BagBunker_Large_F", 10],
	["Land_BagBunker_Small_F", 5],
	["Land_BagBunker_Tower_F", 7],
	["Land_BagBunker_01_large_green_F", 10],
	["Land_BagBunker_01_small_green_F", 5],
	["Land_HBarrier_01_tower_green_F", 7],
	["Land_Bunker_02_light_double_F", 10],
	["Land_Bunker_01_small_F", 15],
	["Land_BagFence_Corner_F", 2],
	["Land_BagFence_End_F", 2],
	["Land_BagFence_Long_F", 3],
	["Land_BagFence_Round_F", 2],
	["Land_BagFence_Short_F", 2],
	["Land_BagFence_01_corner_green_F", 2],
	["Land_BagFence_01_end_green_F", 2],
	["Land_BagFence_01_long_green_F", 3],
	["Land_BagFence_01_round_green_F", 2],
	["Land_BagFence_01_short_green_F", 2],
	["Land_BarGate_F", 3],
	["Land_Canal_WallSmall_10m_F", 4],
	["Land_Canal_Wall_Stairs_F", 3],
	["Land_CargoBox_V1_F", 5],
	["Land_Cargo_House_V1_F", 5],
	["Land_Cargo_Patrol_V1_F", 7],
	["Land_Cargo_HQ_V1_F", 10],
	["Land_Cargo_Tower_V1_F", 20],
	["Land_Cargo_House_V2_F", 5],
	["Land_Cargo_Patrol_V2_F", 7],
	["Land_Cargo_HQ_V2_F", 10],
	["Land_Cargo_Tower_V2_F", 20],
	["Land_Cargo_House_V3_F", 5],
	["Land_Cargo_Patrol_V3_F", 7],
	["Land_Cargo_HQ_V3_F", 10],
	["Land_Cargo_Tower_V3_F", 20],
	["Land_Cargo_House_V4_F", 5],
	["Land_Cargo_Patrol_V4_F", 7],
	["Land_Cargo_HQ_V4_F", 10],
	["Land_Cargo_Tower_V4_F", 20],
	["Land_CncBarrier_F", 4],
	["Land_CncBarrier_stripes_F", 4],
	["Land_CncBarrierMedium_F", 4],
	["Land_CncBarrierMedium4_F", 4],
	["Land_CncShelter_F", 2],
	["Land_CncWall1_F", 3],
	["Land_CncWall4_F", 5],
	["Land_Crash_barrier_F", 5],
	["Land_Bunker_01_blocks_1_F", 2],
	["Land_HBarrierBig_F", 5],
	["Land_HBarrier_01_big_4_green_F", 5],
	["Land_HBarrierTower_F", 8],
	["Land_HBarrier_01_big_tower_green_F", 8],
	["Land_HBarrierWall4_F", 4],
	["Land_HBarrierWall6_F", 6],
	["Land_HBarrierWall_corner_F", 3],
	["Land_HBarrierWall_corridor_F", 4],
	["Land_HBarrier_01_wall_4_green_F", 4],
	["Land_HBarrier_01_wall_6_green_F", 6],
	["Land_HBarrier_01_wall_corner_green_F", 3],
	["Land_HBarrier_01_wall_corridor_green_F", 4],
	["Land_HBarrier_1_F", 3],
	["Land_HBarrier_3_F", 4],
	["Land_HBarrier_5_F", 5],
	["Land_HBarrier_01_line_1_green_F", 3],
	["Land_HBarrier_01_line_3_green_F", 4],
	["Land_HBarrier_01_line_5_green_F", 5],
	["Land_LampHarbour_F", 2],
	["Land_LampShabby_F", 2],
	["Land_MetalBarrel_F", 2],
	["Land_Mil_ConcreteWall_F", 5],
	["Land_Mil_WallBig_4m_F", 5],
	["Land_Obstacle_Ramp_F", 5],
	["Land_Pipes_large_F", 5],
	["Land_RampConcreteHigh_F", 6],
	["Land_RampConcrete_F", 5],
	["Land_Razorwire_F", 5],
	["Land_Sacks_goods_F", 2],
	["Land_Scaffolding_F", 5],
	["Land_Shoot_House_Wall_F", 3],
	["Land_Stone_8m_F", 5],
	["Land_ToiletBox_F", 2],
	["Land_BarrelWater_F", 2],
	["Land_cargo_addon02_V1_F", 2],
	["Land_cargo_addon02_V2_F", 2],
	["Land_Slum_House01_F", 3],
	["Land_Slum_House02_F", 3],
	["Land_Slum_House03_F", 3],
	["Land_cargo_house_slum_F", 3],
	["Land_Metal_Shed_F", 3],
	["Land_Shed_Small_F", 3],
	["Land_Shed_Big_F", 6],
	["Land_Cargo20_blue_F", 10],
	["Land_Cargo20_brick_red_F", 10],
	["Land_Cargo20_cyan_F", 10],
	["Land_Cargo20_grey_F", 10],
	["Land_Cargo20_light_blue_F", 10],
	["Land_Cargo20_light_green_F", 10],
	["Land_Cargo20_military_green_F", 10],
	["Land_Cargo20_orange_F", 10],
	["Land_Cargo20_red_F", 10],
	["Land_Cargo20_sand_F", 10],
	["Land_Cargo20_white_F", 10],
	["Land_Cargo20_yellow_F", 10],
	["Land_Cargo40_blue_F", 15],
	["Land_Cargo40_brick_red_F", 15],
	["Land_Cargo40_cyan_F", 15],
	["Land_Cargo40_grey_F", 15],
	["Land_Cargo40_light_blue_F", 15],
	["Land_Cargo40_light_green_F", 15],
	["Land_Cargo40_military_green_F", 15],
	["Land_Cargo40_orange_F", 15],
	["Land_Cargo40_red_F", 15],
	["Land_Cargo40_sand_F", 15],
	["Land_Cargo40_white_F", 15],
	["Land_Cargo40_yellow_F", 15],
	["Land_GuardTower_01_F", 2],
	["Land_GuardTower_02_F", 2],
	["Land_DragonsTeeth_01_1x1_new_F", 1],
	["Land_DragonsTeeth_01_1x1_new_redwhite_F", 1],
	["Land_New_WiredFence_5m_F", 2],
	["Land_New_WiredFence_10m_F", 2],
	["Land_Mil_WiredFence_F", 2],
	["Land_Razorwire_F", 2],
	["Land_ConnectorTent_01_NATO_open_F", 2],
	["Land_ConnectorTent_01_NATO_cross_F", 2],
	["Land_MedicalTent_01_NATO_generic_outer_F", 5],
	["Land_MedicalTent_01_NATO_generic_inner_F", 5],
	["Land_ConnectorTent_01_NATO_tropic_open_F", 2],
	["Land_ConnectorTent_01_NATO_tropic_cross_F", 2],
	["Land_MedicalTent_01_NATO_tropic_generic_outer_F", 5],
	["Land_MedicalTent_01_NATO_tropic_generic_inner_F", 5],
	["Land_ConnectorTent_01_CSAT_brownhex_open_F", 2],
	["Land_ConnectorTent_01_CSAT_brownhex_cross_F", 2],
	["Land_MedicalTent_01_CSAT_brownhex_generic_outer_F", 5],
	["Land_MedicalTent_01_CSAT_brownhex_generic_inner_F", 5],
	["Land_ConnectorTent_01_CSAT_greenhex_open_F", 2],
	["Land_ConnectorTent_01_CSAT_greenhex_cross_F", 2],
	["Land_MedicalTent_01_CSAT_greenhex_generic_outer_F", 5],
	["Land_MedicalTent_01_CSAT_greenhex_generic_inner_F", 5],
	["Land_ConnectorTent_01_AAF_open_F", 2],
	["Land_ConnectorTent_01_AAF_cross_F", 2],
	["Land_MedicalTent_01_aaf_generic_outer_F", 5],
	["Land_MedicalTent_01_aaf_generic_inner_F", 5],
	["Land_ConnectorTent_01_wdl_open_F", 2],
	["Land_ConnectorTent_01_wdl_cross_F", 2],
	["Land_MedicalTent_01_wdl_generic_outer_F", 5],
	["Land_MedicalTent_01_wdl_generic_inner_F", 5],
	["DeconShower_02_F", 9],
	["Land_Mil_WiredFence_Gate_F", 8],
	["Land_EntranceGate_01_narrow_F", 10],
	["Land_ConcreteHedgehog_01_F", 1],
	["Land_CzechHedgehog_01_new_F", 1],
	["Land_CzechHedgehog_01_old_F", 1],
	["Land_FuelStation_01_pump_malevil_F", 3],
	["Land_FuelStation_01_pump_F", 3],
	["Land_FuelStation_03_pump_F", 3],
	["Land_fs_feed_F", 3],
	["Land_FuelStation_Feed_F", 3],
	["WaterPump_01_forest_F", 5],
	["WaterPump_01_sand_F", 5],
	["Land_LampHalogen_F", 2],
	["Land_LampStreet_02_F", 2],
	["Land_LampStreet_02_double_F", 2],
	["Land_LampStreet_02_triple_F", 2],
	["Land_LampAirport_F", 3],
	["Land_FieldToilet_F", 2],
	["Land_Walkover_01_F", 3],
	["Land_Scaffolding_New_F", 5],
	["Land_FirePlace_F", 1],
	["Land_Campfire_F", 1],
	["Land_LifeguardTower_01_F", 6],
	["Land_SandbagBarricade_01_half_F", 2],
	["Land_SandbagBarricade_01_hole_F", 3],
	["Land_SandbagBarricade_01_F", 3],
	["Land_Cargo10_red_F", 5],
	["TargetBootcampHuman_F", 1],
	["Land_MysteriousBell_01_F", 1],
	["Land_Shoot_House_Wall_F", 2],
	["Land_Shoot_House_Wall_Stand_F", 2],
	["Land_Shoot_House_Wall_Crouch_F", 2],
	["Land_Shoot_House_Wall_Prone_F", 2],
	["Land_Shoot_House_Corner_F", 2],
	["Land_Shoot_House_Corner_Stand_F", 2],
	["Land_Shoot_House_Corner_Crouch_F", 2],
	["Land_Shoot_House_Corner_Prone_F", 2],
	["Land_Shoot_House_Panels_F", 2],
	["Land_Shoot_House_Panels_Crouch_F", 2],
	["Land_Shoot_House_Panels_Prone_F", 2],
	["Land_Shoot_House_Panels_Vault_F", 2],
	["Land_Shoot_House_Panels_Window_F", 2],
	["Land_Shoot_House_Tunnel_F", 2],
	["Land_Shoot_House_Tunnel_Stand_F", 2],
	["Land_Shoot_House_Tunnel_Crouch_F", 2],
	["Land_Shoot_House_Tunnel_Prone_F", 2],
	["CargoPlaftorm_01_green_F", 2],
	["CargoPlaftorm_01_rusty_F", 2],
	["CargoPlaftorm_01_brown_F", 2],
	["CargoPlaftorm_01_jungle_F", 2]
];

/****** MOVABLE-BY-PLAYER OBJECTS / OBJETS DEPLACABLES PAR LE JOUEUR ******/

R3F_LOG_CFG_objets_deplacables =
[
	"StaticWeapon",
	"ReammoBox_F",
	"Kart_01_Base_F",
	"Quadbike_01_base_F",
	"Rubber_duck_base_F",
	"SDV_01_base_F",
	"UAV_01_base_F",
	"UAV_06_base_F",
	"UGV_02_Base_F",
	"Land_PierLadder_F",
	"Land_BagBunker_Large_F",
	"Land_BagBunker_Small_F",
	"Land_BagBunker_Tower_F",
	"Land_BagBunker_01_small_green_F",
	"Land_BagBunker_01_large_green_F",
	"Land_HBarrier_01_tower_green_F",
	"Land_Bunker_02_light_double_F",
	"Land_Bunker_01_small_F",
	"Land_BagFence_Corner_F",
	"Land_BagFence_End_F",
	"Land_BagFence_Long_F",
	"Land_BagFence_Round_F",
	"Land_BagFence_Short_F",
	"Land_BagFence_01_corner_green_F",
	"Land_BagFence_01_end_green_F",
	"Land_BagFence_01_long_green_F",
	"Land_BagFence_01_round_green_F",
	"Land_BagFence_01_short_green_F",
	"Land_BarGate_F",
	"Land_Canal_WallSmall_10m_F",
	"Land_Canal_Wall_Stairs_F",
	"Land_CargoBox_V1_F",
	"Land_Cargo_House_V1_F",
	"Land_Cargo_Patrol_V1_F",
	"Land_Cargo_HQ_V1_F",
	"Land_Cargo_Tower_V1_F",
	"Land_Cargo_House_V2_F",
	"Land_Cargo_Patrol_V2_F",
	"Land_Cargo_HQ_V2_F",
	"Land_Cargo_Tower_V2_F",
	"Land_Cargo_House_V3_F",
	"Land_Cargo_Patrol_V3_F",
	"Land_Cargo_HQ_V3_F",
	"Land_Cargo_Tower_V3_F",
	"Land_Cargo_House_V4_F",
	"Land_Cargo_Patrol_V4_F",
	"Land_Cargo_HQ_V4_F",
	"Land_Cargo_Tower_V4_F",
	"Land_CncBarrier_F",
	"Land_CncBarrier_stripes_F",
	"Land_CncBarrierMedium_F",
	"Land_CncBarrierMedium4_F",
	"Land_CncShelter_F",
	"Land_CncWall1_F",
	"Land_CncWall4_F",
	"Land_Crash_barrier_F",
	"Land_Bunker_01_blocks_1_F",
	"Land_HBarrierBig_F",
	"Land_HBarrier_01_big_4_green_F",
	"Land_HBarrierTower_F",
	"Land_HBarrier_01_big_tower_green_F",
	"Land_HBarrierWall4_F",
	"Land_HBarrierWall6_F",
	"Land_HBarrierWall_corner_F",
	"Land_HBarrierWall_corridor_F",
	"Land_HBarrier_01_wall_4_green_F",
	"Land_HBarrier_01_wall_6_green_F",
	"Land_HBarrier_01_wall_corner_green_F",
	"Land_HBarrier_01_wall_corridor_green_F",
	"Land_HBarrier_1_F",
	"Land_HBarrier_3_F",
	"Land_HBarrier_5_F",
	"Land_HBarrier_01_line_1_green_F",
	"Land_HBarrier_01_line_3_green_F",
	"Land_HBarrier_01_line_5_green_F",
	"Land_LampHarbour_F",
	"Land_LampShabby_F",
	"Land_MetalBarrel_F",
	"Land_Mil_ConcreteWall_F",
	"Land_Mil_WallBig_4m_F",
	"Land_Obstacle_Ramp_F",
	"Land_Pipes_large_F",
	"Land_RampConcreteHigh_F",
	"Land_RampConcrete_F",
	"Land_Razorwire_F",
	"Land_Sacks_goods_F",
	"Land_Scaffolding_F",
	"Land_Shoot_House_Wall_F",
	"Land_Stone_8m_F",
	"Land_ToiletBox_F",
	"Land_BarrelWater_F",
	"Land_cargo_addon02_V1_F",
	"Land_cargo_addon02_V2_F",
	"Land_Slum_House01_F",
	"Land_Slum_House02_F",
	"Land_Slum_House03_F",
	"Land_cargo_house_slum_F",
	"Land_Metal_Shed_F",
	"Land_Shed_Small_F",
	"Land_Shed_Big_F",
	"Land_Cargo20_blue_F",
	"Land_Cargo20_brick_red_F",
	"Land_Cargo20_cyan_F",
	"Land_Cargo20_grey_F",
	"Land_Cargo20_light_blue_F",
	"Land_Cargo20_light_green_F",
	"Land_Cargo20_military_green_F",
	"Land_Cargo20_orange_F",
	"Land_Cargo20_red_F",
	"Land_Cargo20_sand_F",
	"Land_Cargo20_white_F",
	"Land_Cargo20_yellow_F",
	"Land_Cargo40_blue_F",
	"Land_Cargo40_brick_red_F",
	"Land_Cargo40_cyan_F",
	"Land_Cargo40_grey_F",
	"Land_Cargo40_light_blue_F",
	"Land_Cargo40_light_green_F",
	"Land_Cargo40_military_green_F",
	"Land_Cargo40_orange_F",
	"Land_Cargo40_red_F",
	"Land_Cargo40_sand_F",
	"Land_Cargo40_white_F",
	"Land_Cargo40_yellow_F",
	"Land_GuardTower_01_F",
	"Land_GuardTower_02_F",
	"Land_DragonsTeeth_01_1x1_new_F",
	"Land_DragonsTeeth_01_1x1_new_redwhite_F",
	"Land_New_WiredFence_5m_F",
	"Land_New_WiredFence_10m_F",
	"Land_Mil_WiredFence_F",
	"Land_Razorwire_F",
	"Land_ConnectorTent_01_NATO_open_F",
	"Land_ConnectorTent_01_NATO_cross_F",
	"Land_MedicalTent_01_NATO_generic_outer_F",
	"Land_MedicalTent_01_NATO_generic_inner_F",
	"Land_ConnectorTent_01_NATO_tropic_open_F",
	"Land_ConnectorTent_01_NATO_tropic_cross_F",
	"Land_MedicalTent_01_NATO_tropic_generic_outer_F",
	"Land_MedicalTent_01_NATO_tropic_generic_inner_F",
	"Land_ConnectorTent_01_CSAT_brownhex_open_F",
	"Land_ConnectorTent_01_CSAT_brownhex_cross_F",
	"Land_MedicalTent_01_CSAT_brownhex_generic_outer_F",
	"Land_MedicalTent_01_CSAT_brownhex_generic_inner_F",
	"Land_ConnectorTent_01_CSAT_greenhex_open_F",
	"Land_ConnectorTent_01_CSAT_greenhex_cross_F",
	"Land_MedicalTent_01_CSAT_greenhex_generic_outer_F",
	"Land_MedicalTent_01_CSAT_greenhex_generic_inner_F",
	"Land_ConnectorTent_01_AAF_open_F",
	"Land_ConnectorTent_01_AAF_cross_F",
	"Land_MedicalTent_01_aaf_generic_outer_F",
	"Land_MedicalTent_01_aaf_generic_inner_F",
	"Land_ConnectorTent_01_wdl_open_F",
	"Land_ConnectorTent_01_wdl_cross_F",
	"Land_MedicalTent_01_wdl_generic_outer_F",
	"Land_MedicalTent_01_wdl_generic_inner_F",
	"DeconShower_02_F",
	"Land_Mil_WiredFence_Gate_F",
	"Land_EntranceGate_01_narrow_F",
	"Land_ConcreteHedgehog_01_F",
	"Land_CzechHedgehog_01_new_F",
	"Land_CzechHedgehog_01_old_F",
	"Land_FuelStation_01_pump_malevil_F",
	"Land_FuelStation_01_pump_F",
	"Land_FuelStation_03_pump_F",
	"Land_fs_feed_F",
	"Land_FuelStation_Feed_F",
	"WaterPump_01_forest_F",
	"WaterPump_01_sand_F",
	"Land_LampHalogen_F",
	"Land_LampStreet_02_F",
	"Land_LampStreet_02_double_F",
	"Land_LampStreet_02_triple_F",
	"Land_LampAirport_F",
	"Land_FieldToilet_F",
	"Land_Walkover_01_F",
	"Land_Scaffolding_New_F",
	"Land_FirePlace_F",
	"Land_Campfire_F",
	"Land_LifeguardTower_01_F",
	"Land_SandbagBarricade_01_half_F",
	"Land_SandbagBarricade_01_hole_F",
	"Land_SandbagBarricade_01_F",
	"Land_Cargo10_red_F",
	"TargetBootcampHuman_F",
	"Land_MysteriousBell_01_F",
	"Land_Shoot_House_Wall_F",
	"Land_Shoot_House_Wall_Stand_F",
	"Land_Shoot_House_Wall_Crouch_F",
	"Land_Shoot_House_Wall_Prone_F",
	"Land_Shoot_House_Corner_F",
	"Land_Shoot_House_Corner_Stand_F",
	"Land_Shoot_House_Corner_Crouch_F",
	"Land_Shoot_House_Corner_Prone_F",
	"Land_Shoot_House_Panels_F",
	"Land_Shoot_House_Panels_Crouch_F",
	"Land_Shoot_House_Panels_Prone_F",
	"Land_Shoot_House_Panels_Vault_F",
	"Land_Shoot_House_Panels_Window_F",
	"Land_Shoot_House_Tunnel_F",
	"Land_Shoot_House_Tunnel_Stand_F",
	"Land_Shoot_House_Tunnel_Crouch_F",
	"Land_Shoot_House_Tunnel_Prone_F",
	"CargoPlaftorm_01_green_F",
	"CargoPlaftorm_01_rusty_F",
	"CargoPlaftorm_01_brown_F",
	"CargoPlaftorm_01_jungle_F"
];
